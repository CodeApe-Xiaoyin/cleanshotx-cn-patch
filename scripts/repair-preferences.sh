#!/bin/zsh
set -euo pipefail

BUNDLE_ID="pl.maketheweb.cleanshotx"
APP_NAME="CleanShot X"
SCRIPT_DIR="${0:A:h}"
PROJECT_DIR="${SCRIPT_DIR:h}"
PREF_PLIST="$HOME/Library/Preferences/$BUNDLE_ID.plist"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$PROJECT_DIR/backups/preferences-$STAMP"
REOPEN="${REOPEN:-1}"

mkdir -p "$BACKUP_DIR"

if [[ -f "$PREF_PLIST" ]]; then
  echo "正在备份退出前设置文件..."
  cp -p "$PREF_PLIST" "$BACKUP_DIR/$BUNDLE_ID.pre-quit.plist"
fi

echo "正在同步 CleanShot 设置缓存..."
defaults read "$BUNDLE_ID" >/dev/null 2>&1 || true

echo "正在退出 $APP_NAME..."
osascript -e "tell application \"$APP_NAME\" to quit" >/dev/null 2>&1 || true
sleep 1
pkill -x "$APP_NAME" >/dev/null 2>&1 || true

if [[ -f "$PREF_PLIST" ]]; then
  echo "正在备份退出后设置文件..."
  cp -p "$PREF_PLIST" "$BACKUP_DIR/$BUNDLE_ID.post-quit.plist"

  echo "正在修复设置文件属性..."
  xattr -d com.apple.quarantine "$PREF_PLIST" >/dev/null 2>&1 || true
  chmod 600 "$PREF_PLIST" >/dev/null 2>&1 || true
  chown "$(id -un)":staff "$PREF_PLIST" >/dev/null 2>&1 || true
else
  echo "没有找到设置文件，CleanShot 会在下次保存设置时重新创建。"
fi

echo "正在重启 macOS 偏好设置缓存..."
killall cfprefsd >/dev/null 2>&1 || true
sleep 1

if [[ "$REOPEN" == "1" ]]; then
  echo "正在重新打开 $APP_NAME..."
  open -a "$APP_NAME"
fi

echo
echo "修复完成。"
echo "备份位置：$BACKUP_DIR"
echo "如果你刚改过快捷键，请重新打开设置页确认一次，然后正常退出 CleanShot X。"
