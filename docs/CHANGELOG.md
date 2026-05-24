# 更新日志

## v4.8.8-cn.3

- 运行时汉化跳过 CleanShot 的快捷键输入/识别控件，避免翻译逻辑影响快捷键保存。
- 新增 `scripts/save-preferences-snapshot.sh` 和 `scripts/restore-preferences-snapshot.sh`，可在快捷键正常时保存设置快照，并在配置被写空后恢复。

## v4.8.8-cn.2

- 新增 `scripts/repair-preferences.sh`，用于修复快捷键或设置保存后又丢失的问题，并保留退出前/退出后两份偏好快照。
- 安装和卸载脚本默认不再重置 macOS 权限记录，避免屏幕录制、辅助功能、输入监听权限反复失效。
- 安装时会同步备份 CleanShot X 偏好设置文件，并清理偏好设置文件上的异常隔离属性。

## v4.8.8-cn.1

- 支持 CleanShot X 4.8.8。
- 使用运行时动态库汉化设置页、快捷键页、菜单和常见按钮。
- 提供安装和卸载脚本。
- 安装时自动重新签名并重置相关权限记录。
- 仓库结构调整为 `src/`、`scripts/`、`docs/`，发布包通过 GitHub Releases 提供。
