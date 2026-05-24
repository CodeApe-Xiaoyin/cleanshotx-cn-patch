#!/bin/zsh
set -euo pipefail

BUNDLE_ID="pl.maketheweb.cleanshotx"
APP_NAME="CleanShot X"
SCRIPT_DIR="${0:A:h}"
PROJECT_DIR="${SCRIPT_DIR:h}"
PREF_PLIST="$HOME/Library/Preferences/$BUNDLE_ID.plist"
SNAPSHOT_PLIST="$PROJECT_DIR/snapshots/$BUNDLE_ID.saved.plist"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$PROJECT_DIR/backups/restore-$STAMP"

if [[ ! -f "$SNAPSHOT_PLIST" ]]; then
  echo "没有找到设置快照：$SNAPSHOT_PLIST"
  echo "请先在快捷键正常时运行 scripts/save-preferences-snapshot.sh"
  exit 1
fi

echo "正在退出 $APP_NAME..."
osascript -e "tell application \"$APP_NAME\" to quit" >/dev/null 2>&1 || true
sleep 1
pkill -x "$APP_NAME" >/dev/null 2>&1 || true

mkdir -p "$BACKUP_DIR"
if [[ -f "$PREF_PLIST" ]]; then
  cp -p "$PREF_PLIST" "$BACKUP_DIR/$BUNDLE_ID.before-restore.plist"
fi

echo "正在恢复设置快照..."
cp -p "$SNAPSHOT_PLIST" "$PREF_PLIST"
chmod 600 "$PREF_PLIST" >/dev/null 2>&1 || true
chown "$(id -un)":staff "$PREF_PLIST" >/dev/null 2>&1 || true
killall cfprefsd >/dev/null 2>&1 || true
sleep 1

echo "正在重新打开 $APP_NAME..."
open -a "$APP_NAME"

echo
echo "恢复完成。"
echo "恢复前备份位置：$BACKUP_DIR"
