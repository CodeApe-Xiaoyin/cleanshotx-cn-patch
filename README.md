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
- 安装后自动重新签名应用，并重置旧的权限记录，方便重新授权。

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
chmod +x install.sh uninstall.sh
./install.sh
```

如果 CleanShot X 不在默认路径：

```zsh
./install.sh "/你的路径/CleanShot X.app"
```

## 权限说明

安装后，macOS 可能会要求重新授权 CleanShot X：

- 屏幕与系统音频录制
- 辅助功能
- 输入监听

这是正常现象。安装脚本会重新签名 CleanShot X，macOS 会把它视为新的代码身份。请在系统设置中重新允许 CleanShot X。

## 卸载

```zsh
./uninstall.sh
```

卸载脚本会移除动态库注入配置和汉化动态库，并重新签名应用。

## 换设备或重装后使用

将本仓库复制或克隆到新设备，然后重新运行：

```zsh
chmod +x install.sh uninstall.sh
./install.sh
```

如果 CleanShot X 官方更新后汉化部分失效，也可以重新运行安装脚本；如果新版本改了界面文本，需要补充 `CleanShotCN.m` 中的翻译表。

## 目录结构

```text
.
├── CleanShotCN.m   # 运行时汉化源码和翻译表
├── install.sh      # 安装脚本
├── uninstall.sh    # 卸载脚本
├── VERSION.txt     # 已验证版本信息
└── README.md       # 项目说明
```

## 免责声明

本项目仅用于个人学习和本地自用，不包含、分发或破解 CleanShot X 官方软件。本项目与 CleanShot X、Make The Web 或其开发团队没有任何关联。

请在拥有正版 CleanShot X 授权的前提下使用。本项目不保证兼容所有 CleanShot X 版本，使用前建议自行备份应用。
