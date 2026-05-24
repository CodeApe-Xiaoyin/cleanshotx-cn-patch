# CleanShot X 中文汉化补丁

一个面向 macOS 的 CleanShot X 运行时中文汉化补丁。它不修改 CleanShot X 的主程序机器码，也不分发任何 CleanShot X 官方文件，只在本机编译一个轻量动态库，在应用运行时把设置页、快捷键页、菜单、按钮、表格等可见英文文本替换为中文。

已验证版本：CleanShot X 4.8.8。

## 功能

- 汉化 CleanShot X 设置窗口中的主要页面：
  - 通用
  - 壁纸
  - 快捷键
  - 快速访问
  - 录制
  - 截图
  - 标注
  - 云
  - 高级
  - 关于
- 汉化快捷键列表中的大部分项目。
- 提供一键安装和卸载脚本。
- 安装时自动备份 `Info.plist`。
- 安装后自动重新签名应用，默认保留已有系统权限记录。
- 提供设置修复脚本，用于处理快捷键或设置保存后又丢失的问题。
- 提供设置快照保存/恢复脚本，避免快捷键被重置后需要手工重配。
- 提供快捷键权限修复脚本，用于处理快捷键设置仍在但按下无效的问题。

## 原理

补丁会执行以下操作：

1. 使用 `clang` 编译 `CleanShotCN.m`，生成 `libCleanShotCN.dylib`。
2. 将动态库复制到 `CleanShot X.app/Contents/MacOS/`。
3. 在 `Info.plist` 的 `LSEnvironment` 中写入 `DYLD_INSERT_LIBRARIES`。
4. CleanShot X 启动后，动态库会扫描当前窗口、菜单、按钮、表格、标签页等可见文字，并按翻译表替换成中文。
5. 使用 ad-hoc 签名重新签名应用，使 macOS 可以启动修改后的 App。

这种方式比直接改二进制字符串更稳，也更容易维护。CleanShot X 更新或重装后，重新运行安装脚本即可再次应用汉化。

## 安装

先安装 Xcode Command Line Tools：

```zsh
xcode-select --install
```

然后运行：

```zsh
chmod +x scripts/install.sh scripts/uninstall.sh
./scripts/install.sh
```

如果 CleanShot X 不在默认路径：

```zsh
./scripts/install.sh "/你的路径/CleanShot X.app"
```

如果权限记录已经正常，安装脚本默认不会重置权限。只有在权限确实异常时，才建议手动重置：

```zsh
RESET_TCC=1 ./scripts/install.sh
```

## 修复设置或快捷键丢失

如果出现快捷键、截图后动作、保存位置等设置过一段时间丢失的情况，运行：

```zsh
chmod +x scripts/repair-preferences.sh
./scripts/repair-preferences.sh
```

脚本会先备份退出前设置文件，再退出 CleanShot X、备份退出后设置文件、清理设置文件上的异常隔离属性、修复权限位，并重启 macOS 偏好设置缓存。它不会删除你的设置，也不会重置屏幕录制、辅助功能或输入监听权限。

如果你已经重新设置好快捷键，建议立刻保存一份设置快照：

```zsh
./scripts/save-preferences-snapshot.sh
```

以后如果快捷键再次被 CleanShot 写空，可以直接恢复：

```zsh
./scripts/restore-preferences-snapshot.sh
```

如果快捷键设置还在，但按下后没有任何反应，先让 CleanShot 重新注册快捷键：

```zsh
./scripts/restart-shortcuts.sh
```

如果仍然无效，修复全局快捷键相关权限：

```zsh
./scripts/fix-shortcut-permissions.sh
```

这个脚本只重置“辅助功能”和“输入监听”，不重置屏幕录制权限。运行后需要到系统设置里重新允许 CleanShot X。

## 权限说明

安装后，macOS 可能会要求重新授权 CleanShot X：

- 屏幕与系统音频录制
- 辅助功能
- 输入监听

安装脚本会重新签名 CleanShot X，macOS 有时会把它视为新的代码身份。新版脚本默认不主动重置权限；如果系统仍提示重新授权，请在系统设置中重新允许 CleanShot X。

## 卸载

```zsh
./scripts/uninstall.sh
```

卸载脚本会移除动态库注入配置和汉化动态库，并重新签名应用。

如果你希望卸载时一并清掉旧权限记录：

```zsh
RESET_TCC=1 ./scripts/uninstall.sh
```

## 换设备或重装后使用

将本仓库复制或克隆到新设备，然后重新运行：

```zsh
chmod +x scripts/install.sh scripts/uninstall.sh
./scripts/install.sh
```

如果 CleanShot X 官方更新后汉化部分失效，也可以重新运行安装脚本；如果新版本改了界面文本，需要补充 `CleanShotCN.m` 中的翻译表。

## 目录结构

```text
.
├── README.md              # 项目说明
├── LICENSE                # 开源协议
├── src/
│   └── CleanShotCN.m      # 运行时汉化源码和翻译表
├── scripts/
│   ├── install.sh         # 安装脚本
│   ├── repair-preferences.sh # 修复设置保存异常
│   ├── restart-shortcuts.sh # 重启快捷键注册
│   ├── fix-shortcut-permissions.sh # 修复快捷键监听权限
│   ├── save-preferences-snapshot.sh # 保存当前设置快照
│   ├── restore-preferences-snapshot.sh # 恢复设置快照
│   └── uninstall.sh       # 卸载脚本
└── docs/
    └── VERSION.txt        # 已验证版本信息
```

## 免责声明

本项目仅用于个人学习和本地自用，不包含、分发或破解 CleanShot X 官方软件。本项目与 CleanShot X、Make The Web 或其开发团队没有任何关联。

请在拥有正版 CleanShot X 授权的前提下使用。本项目不保证兼容所有 CleanShot X 版本，使用前建议自行备份应用。
