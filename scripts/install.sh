#!/bin/zsh
set -euo pipefail

APP_PATH="${1:-/Applications/CleanShot X.app}"
BUNDLE_ID="pl.maketheweb.cleanshotx"
SCRIPT_DIR="${0:A:h}"
PROJECT_DIR="${SCRIPT_DIR:h}"
SRC="$PROJECT_DIR/src/CleanShotCN.m"
BUILD_DIR="$PROJECT_DIR/build"
DYLIB_NAME="libCleanShotCN.dylib"

if [[ ! -d "$APP_PATH" ]]; then
  echo "找不到 CleanShot X：$APP_PATH"
  echo "用法: ./scripts/install.sh [CleanShot X.app 路径]"
  exit 1
fi

if [[ ! -f "$SRC" ]]; then
  echo "找不到源码文件：$SRC"
  exit 1
fi

if ! command -v clang >/dev/null 2>&1; then
  echo "找不到 clang。请先安装 Xcode Command Line Tools：xcode-select --install"
  exit 1
fi

INFO_PLIST="$APP_PATH/Contents/Info.plist"
MACOS_DIR="$APP_PATH/Contents/MacOS"
TARGET_DYLIB="$MACOS_DIR/$DYLIB_NAME"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$PROJECT_DIR/backups/$STAMP"

echo "正在退出 CleanShot X..."
osascript -e 'tell application "CleanShot X" to quit' >/dev/null 2>&1 || true
pkill -x "CleanShot X" >/dev/null 2>&1 || true
sleep 1

mkdir -p "$BUILD_DIR" "$BACKUP_DIR"

echo "正在备份 Info.plist..."
cp -p "$INFO_PLIST" "$BACKUP_DIR/Info.plist"
if [[ -f "$TARGET_DYLIB" ]]; then
  cp -p "$TARGET_DYLIB" "$BACKUP_DIR/$DYLIB_NAME"
fi

ARCH_FLAGS=()
case "$(uname -m)" in
  arm64) ARCH_FLAGS=(-arch arm64) ;;
  x86_64) ARCH_FLAGS=(-arch x86_64) ;;
esac

echo "正在编译汉化动态库..."
clang -dynamiclib -fobjc-arc -fblocks "${ARCH_FLAGS[@]}" \
  -framework AppKit -framework Foundation \
  "$SRC" -o "$BUILD_DIR/$DYLIB_NAME"

echo "正在安装动态库..."
cp -p "$BUILD_DIR/$DYLIB_NAME" "$TARGET_DYLIB"

echo "正在写入启动注入配置..."
/usr/libexec/PlistBuddy -c 'Delete :LSEnvironment' "$INFO_PLIST" >/dev/null 2>&1 || true
/usr/libexec/PlistBuddy -c 'Add :LSEnvironment dict' "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Add :LSEnvironment:DYLD_INSERT_LIBRARIES string $TARGET_DYLIB" "$INFO_PLIST"

echo "正在重新签名..."
codesign --force --deep --sign - "$APP_PATH"
codesign --verify --deep --strict --verbose=1 "$APP_PATH"

echo "正在重置旧权限记录，稍后请在系统设置里重新允许 CleanShot X..."
tccutil reset ScreenCapture "$BUNDLE_ID" >/dev/null 2>&1 || true
tccutil reset Accessibility "$BUNDLE_ID" >/dev/null 2>&1 || true
tccutil reset ListenEvent "$BUNDLE_ID" >/dev/null 2>&1 || true

echo "正在启动 CleanShot X..."
open -a "CleanShot X"

echo
echo "安装完成。"
echo "如果系统提示权限，请重新允许 CleanShot X 的屏幕录制/辅助功能权限。"
echo "备份位置：$BACKUP_DIR"
