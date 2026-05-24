#!/bin/zsh
set -euo pipefail

BUNDLE_ID="pl.maketheweb.cleanshotx"
APP_NAME="CleanShot X"
SCRIPT_DIR="${0:A:h}"
PROJECT_DIR="${SCRIPT_DIR:h}"
PREF_PLIST="$HOME/Library/Preferences/$BUNDLE_ID.plist"
SNAPSHOT_DIR="$PROJECT_DIR/snapshots"
SNAPSHOT_PLIST="$SNAPSHOT_DIR/$BUNDLE_ID.saved.plist"

mkdir -p "$SNAPSHOT_DIR"

echo "正在退出 $APP_NAME，让设置写入磁盘..."
osascript -e "tell application \"$APP_NAME\" to quit" >/dev/null 2>&1 || true
sleep 1
killall cfprefsd >/dev/null 2>&1 || true
sleep 1

if [[ ! -f "$PREF_PLIST" ]]; then
  echo "没有找到设置文件：$PREF_PLIST"
  exit 1
fi

cp -p "$PREF_PLIST" "$SNAPSHOT_PLIST"

echo "设置快照已保存：$SNAPSHOT_PLIST"
echo "正在重新打开 $APP_NAME..."
open -a "$APP_NAME"

