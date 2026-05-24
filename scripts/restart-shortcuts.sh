#!/bin/zsh
set -euo pipefail

APP_NAME="CleanShot X"

echo "正在退出 $APP_NAME..."
osascript -e "tell application \"$APP_NAME\" to quit" >/dev/null 2>&1 || true
sleep 1
pkill -x "$APP_NAME" >/dev/null 2>&1 || true

echo "正在重启偏好设置缓存..."
killall cfprefsd >/dev/null 2>&1 || true
sleep 1

echo "正在重新打开 $APP_NAME..."
open -a "$APP_NAME"

echo "完成。请测试全局快捷键是否恢复。"
