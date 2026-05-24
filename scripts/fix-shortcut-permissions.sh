#!/bin/zsh
set -euo pipefail

BUNDLE_ID="pl.maketheweb.cleanshotx"
APP_NAME="CleanShot X"

echo "正在退出 $APP_NAME..."
osascript -e "tell application \"$APP_NAME\" to quit" >/dev/null 2>&1 || true
sleep 1
pkill -x "$APP_NAME" >/dev/null 2>&1 || true

echo "正在重置全局快捷键相关权限..."
tccutil reset Accessibility "$BUNDLE_ID" >/dev/null 2>&1 || true
tccutil reset ListenEvent "$BUNDLE_ID" >/dev/null 2>&1 || true

echo "正在打开系统设置，请重新允许 $APP_NAME 的辅助功能和输入监听权限..."
open 'x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility'
open 'x-apple.systempreferences:com.apple.preference.security?Privacy_ListenEvent'

echo
echo "权限记录已重置。"
echo "请在系统设置中重新打开 $APP_NAME 的“辅助功能”和“输入监听”，然后重新打开 $APP_NAME。"
