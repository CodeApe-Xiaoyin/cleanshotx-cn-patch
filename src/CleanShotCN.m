#import <AppKit/AppKit.h>

static NSString *CNLookup(NSString *s) {
    if (s.length == 0) return nil;

    static NSDictionary<NSString *, NSString *> *map;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{
            @"General": @"通用",
            @"Wallpaper": @"壁纸",
            @"Shortcuts": @"快捷键",
            @"Quick Access": @"快速访问",
            @"Recording": @"录制",
            @"Screenshots": @"截图",
            @"Annotate": @"标注",
            @"Cloud": @"云",
            @"Advanced": @"高级",
            @"About": @"关于",

            @"Startup:": @"启动:",
            @"Start at login": @"登录时启动",
            @"Sounds:": @"声音:",
            @"Play sounds": @"播放声音",
            @"Shutter sound:": @"快门声:",
            @"Menu bar:": @"菜单栏:",
            @"Show icon": @"显示图标",
            @"Export location:": @"导出位置:",
            @"Desktop icons:": @"桌面图标:",
            @"Hide while capturing": @"截图时隐藏",
            @"After capture:": @"截图后:",
            @"Here you can decide what should happen after taking a screenshot or recording a video.": @"在这里设置截图或录屏完成后的后续操作。",
            @"Screenshot": @"截图",
            @"Action": @"操作",
            @"Show Quick Access Overlay": @"显示快速访问浮层",
            @"Copy file to clipboard": @"复制文件到剪贴板",
            @"Save": @"保存",
            @"Upload to Cloud & copy link": @"上传到云并复制链接",
            @"Open Annotate tool": @"打开标注工具",
            @"Pin to the screen": @"钉到屏幕",
            @"Open Video Editor": @"打开视频编辑器",
            @"Default": @"默认",
            @"Desktop": @"桌面",
            @"Choose...": @"选择...",
            @"None": @"无",
            @"Choose a wallpaper to display when desktop icons are hidden:": @"选择隐藏桌面图标时显示的壁纸:",
            @"Desktop wallpaper": @"桌面壁纸",
            @"Don't change the wallpaper when switching spaces": @"切换空间时不更换壁纸",
            @"Custom wallpaper:": @"自定义壁纸:",
            @"Plain color:": @"纯色:",
            @"Window screenshots:": @"窗口截图:",
            @"Transparent": @"透明",
            @"With wallpaper": @"带壁纸",
            @"Padding:": @"边距:",
            @"Min": @"最小",
            @"Max": @"最大",
            @"Shadow:": @"阴影:",
            @"Capture window shadow": @"捕捉窗口阴影",
            @"Hold ⌥ (option) while taking a screenshot to disable shadow.": @"截图时按住 ⌥ (option) 可临时关闭阴影。",

            @"Position on screen:": @"屏幕位置:",
            @"Left": @"左侧",
            @"Multi-display:": @"多显示器:",
            @"Move to active screen": @"移动到当前屏幕",
            @"Active screen is the screen where your cursor is pointing.": @"当前屏幕是鼠标指针所在的屏幕。",
            @"Overlay size:": @"浮层大小:",
            @"Auto-close:": @"自动关闭:",
            @"Enable": @"启用",
            @"Action:": @"操作:",
            @"Save and Close": @"保存并关闭",
            @"Interval:": @"间隔:",
            @"30 seconds": @"30 秒",
            @"Drag & drop:": @"拖放:",
            @"Close after dragging": @"拖放后关闭",
            @"Cloud upload:": @"云上传:",
            @"Close after uploading": @"上传后关闭",
            @"Save button behavior:": @"保存按钮行为:",
            @"Save to \"Export location\"": @"保存到“导出位置”",

            @"Video": @"视频",
            @"GIF": @"GIF",
            @"Retina:": @"Retina:",
            @"Scale Retina videos to 1x": @"将 Retina 视频缩放为 1x",
            @"Notifications:": @"通知:",
            @"\"Do Not Disturb\" while recording": @"录制时开启“勿扰”",
            @"Cursor:": @"光标:",
            @"Highlight clicks": @"高亮点击",
            @"Display recording time": @"显示录制时长",
            @"Controls:": @"控制项:",
            @"Show controls while recording": @"录制时显示控制项",
            @"Options...": @"选项...",
            @"Keyboard:": @"键盘:",
            @"Show keystrokes": @"显示按键",
            @"Show cursor": @"显示光标",
            @"Recording area:": @"录制区域:",
            @"Remember last selection": @"记住上次选择",
            @"Dim screen while recording": @"录制时调暗屏幕",
            @"Show countdown": @"显示倒计时",
            @"Max resolution:": @"最大分辨率:",
            @"Original": @"原始",
            @"Set maximum resolution to reduce file size and upload time.": @"设置最大分辨率以减小文件大小和上传时间。",
            @"Video FPS:": @"视频帧率:",
            @"Audio:": @"音频:",
            @"Computer Audio Settings...": @"电脑音频设置...",
            @"Record audio in mono": @"以单声道录制音频",
            @"Video Encoder:": @"视频编码器:",
            @"Open Video Editor after recording": @"录制后打开视频编辑器",
            @"Use Video Editor to change the recording quality, resolution and adjust audio settings.": @"使用视频编辑器更改录制质量、分辨率并调整音频设置。",
            @"GIF FPS:": @"GIF 帧率:",
            @"GIF quality:": @"GIF 质量:",
            @"Optimize GIFs": @"优化 GIF",
            @"Low": @"低",
            @"High": @"高",
            @"GIF size:": @"GIF 尺寸:",
            @"800 x auto (default)": @"800 x 自动（默认）",
            @"Set maximum resolution of your GIFs. Changing it will affect file size and quality. CleanShot will only downscale the GIF if needed.": @"设置 GIF 的最大分辨率。更改此项会影响文件大小和质量。CleanShot 只会在需要时缩小 GIF。",
            @"Setting the quality to maximum can speed up the processing time, but it will increase file size.": @"将质量设为最高可加快处理速度，但会增加文件大小。",

            @"Self-Timer interval:": @"延时截图间隔:",
            @"5 Seconds": @"5 秒",
            @"Crosshair mode:": @"十字准星模式:",
            @"Show on screenshots": @"在截图中显示",
            @"Scale Retina screenshots to 1x": @"将 Retina 截图缩放为 1x",
            @"Color management:": @"色彩管理:",
            @"Convert to sRGB profile": @"转换为 sRGB 色彩配置",
            @"Frame:": @"边框:",
            @"Add 1px border to all screenshots": @"为所有截图添加 1px 边框",
            @"Background:": @"背景:",
            @"Freeze screen:": @"冻结屏幕:",
            @"Freeze screen when taking a screenshot": @"截图时冻结屏幕",
            @"Show magnifier": @"显示放大镜",
            @"Disabled": @"关闭",
            @"File format:": @"文件格式:",
            @"Need more precision?": @"需要更精确？",
            @"Automagically select objects to capture with PixelSnap.": @"使用 PixelSnap 自动选择要捕捉的对象。",
            @"Learn more": @"了解更多",
            @"Learn more...": @"了解更多...",
            @"This works in Fullscreen or Self-Timer modes only.": @"仅适用于全屏或延时截图模式。",
            @"Apply Background Tool preset to all screenshots. Create presets in Annotate. Hold ⇧ Shift while taking a screenshot to disable.": @"将背景工具预设应用到所有截图。可在标注中创建预设。截图时按住 ⇧ Shift 可临时关闭。",
            @"Use this option to capture hover states, animations, or fast-moving content.": @"用此选项捕捉悬停状态、动画或快速变化的内容。",

            @"Arrow tool:": @"箭头工具:",
            @"Inverse arrow direction": @"反转箭头方向",
            @"Press ⌥ (option) when drawing to invert the behavior.": @"绘制时按住 ⌥ (option) 可反转此行为。",
            @"Pencil tool:": @"铅笔工具:",
            @"Smooth drawing": @"平滑绘制",
            @"Background tool:": @"背景工具:",
            @"Remember if tool was opened": @"记住工具是否已打开",
            @"Draw shadow on objects": @"为对象绘制阴影",
            @"Canvas:": @"画布:",
            @"Automatically expand": @"自动扩展",
            @"Ensures all annotations fit by dynamically resizing canvas.": @"通过动态调整画布大小，确保所有标注都能放下。",
            @"Accessibility:": @"辅助功能:",
            @"Show color names": @"显示颜色名称",
            @"Window:": @"窗口:",
            @"Always on top": @"始终置顶",
            @"Show Dock icon": @"显示 Dock 图标",

            @"Sign In...": @"登录...",
            @"Create an Account...": @"创建账户...",
            @"Sign in to CleanShot Cloud": @"登录 CleanShot Cloud",
            @"Create a free account to upload your screenshots or screen recordings from the app.": @"创建免费账户，即可从应用上传截图或屏幕录制。",

            @"File name:": @"文件名:",
            @"Edit": @"编辑",
            @"Ask for name after every capture": @"每次捕捉后询问文件名",
            @"Add \"@2x\" suffix to Retina screenshots": @"为 Retina 截图添加“@2x”后缀",
            @"This option improves compatibility with displaying Retina screenshots in third-party apps.": @"此选项可提升 Retina 截图在第三方应用中的显示兼容性。",
            @"Copy to clipboard:": @"复制到剪贴板:",
            @"File & Image (default)": @"文件和图像（默认）",
            @"Adjust this option if you've encountered any issues with pasting from clipboard or clipboard managers.": @"如果从剪贴板或剪贴板管理器粘贴时遇到问题，可调整此选项。",
            @"Pinned screenshots:": @"钉图:",
            @"Rounded corners": @"圆角",
            @"Shadow": @"阴影",
            @"Border": @"边框",
            @"Keep history:": @"保留历史:",
            @"Never": @"永不",
            @"1 day": @"1 天",
            @"3 days": @"3 天",
            @"1 week": @"1 周",
            @"1 month": @"1 个月",
            @"You can restore old files with \"Capture History\" option from the menu bar.": @"可通过菜单栏中的“截图历史”恢复旧文件。",
            @"Text recognition:": @"文字识别:",
            @"Language:": @"语言:",
            @"Keep line breaks": @"保留换行",
            @"Detect links": @"检测链接",
            @"API:": @"API:",
            @"Allow applications to control CleanShot": @"允许应用控制 CleanShot",
            @"Dialogs:": @"对话框:",
            @"Reset All Warning Dialogs": @"重置所有警告对话框",

            @"⚙️  General": @"⚙️  通用",
            @"All-In-One:": @"全能截图:",
            @"Toggle Desktop Icons:": @"切换桌面图标:",
            @"Open Capture History:": @"打开截图历史:",
            @"Restore Last Capture:": @"恢复上次截图:",
            @"📸  Screenshots": @"📸  截图",
            @"Capture Area:": @"区域截图:",
            @"Capture Previous Area:": @"截取上一区域:",
            @"Capture Fullscreen:": @"全屏截图:",
            @"Capture Window:": @"窗口截图:",
            @"Self-Timer:": @"延时截图:",
            @"Capture Area & Copy to Clipboard:": @"区域截图并复制到剪贴板:",
            @"Capture Area & Save:": @"区域截图并保存:",
            @"Capture Area & Upload to Cloud:": @"区域截图并上传到云:",
            @"Capture Area & Annotate:": @"区域截图并标注:",
            @"Capture Area & Pin to the Screen:": @"区域截图并钉到屏幕:",
            @"🎥  Screen Recording": @"🎥  屏幕录制",
            @"Record Screen / Stop Recording:": @"录屏 / 停止录制:",
            @"Select Window:": @"选择窗口:",
            @"Start Video Recording:": @"开始视频录制:",
            @"Start GIF Recording:": @"开始 GIF 录制:",
            @"Pause/Resume Recording:": @"暂停 / 继续录制:",
            @"Restart Recording:": @"重新录制:",
            @"Toggle Camera Fullscreen:": @"切换摄像头全屏:",
            @"🖱  Scrolling Capture": @"🖱  滚动截图",
            @"Scrolling Capture:": @"滚动截图:",
            @"Start/Stop Capturing:": @"开始 / 停止捕捉:",
            @"🔤  OCR": @"🔤  文字识别",
            @"Capture Text:": @"文字识别:",
            @"Capture Text With Line Breaks:": @"文字识别并保留换行:",
            @"Capture Text Without Line Breaks:": @"文字识别不保留换行:",
            @"🖼️  Quick Access Overlay": @"🖼️  快速访问浮层",
            @"Hide/Show Overlays:": @"显示 / 隐藏浮层:",
            @"Save All Overlays:": @"保存所有浮层:",
            @"Close All Overlays:": @"关闭所有浮层:",
            @"📌  Pin": @"📌  钉图",
            @"Choose and Pin an Image:": @"选择并钉住图片:",
            @"Toggle Pins Visibility:": @"显示 / 隐藏钉图:",
            @"Close All Pins:": @"关闭所有钉图:",
            @"Pin Last Screenshot:": @"钉住上一张截图:",
            @"📝  Annotate": @"📝  标注",
            @"Open File:": @"打开文件:",
            @"Open From Clipboard:": @"从剪贴板打开:",
            @"Annotate Last Screenshot:": @"标注上一张截图:",
            @"Copy Object to Clipboard:": @"复制对象到剪贴板:",
            @"Duplicate Object:": @"复制对象:",
            @"Save:": @"保存:",
            @"Save as:": @"另存为:",
            @"Copy Screenshot to Clipboard:": @"复制截图到剪贴板:",
            @"Upload to Cloud:": @"上传到云:",
            @"Print:": @"打印:",
            @"Pin to the Screen:": @"钉到屏幕:",
            @"Add New Screenshot:": @"新增截图:",
            @"Add Screenshot From File:": @"从文件添加截图:",
            @"✏️  Annotate tools": @"✏️  标注工具",
            @"Increase Tool Size:": @"增大工具尺寸:",
            @"Decrease Tool Size:": @"减小工具尺寸:",
            @"Background Tool:": @"背景工具:",
            @"Move Tool:": @"移动工具:",
            @"Crop & Resize Tool:": @"裁剪和调整大小工具:",
            @"Draw Tool:": @"绘制工具:",
            @"Highlighter Tool:": @"高亮工具:",
            @"Line Tool:": @"直线工具:",
            @"Text Tool:": @"文本工具:",
            @"Arrow Tool:": @"箭头工具:",
            @"Counter Tool:": @"编号工具:",
            @"Ellipse Tool:": @"椭圆工具:",
            @"Redaction Tool:": @"遮盖工具:",
            @"Spotlight Tool:": @"聚光灯工具:",
            @"Rectangle Tool:": @"矩形工具:",
            @"Filled Rectangle Tool:": @"实心矩形工具:",
            @"Record shortcut": @"记录快捷键",
            @"Restore Defaults": @"恢复默认",
            @"Use System Default Shortcuts...": @"使用系统默认快捷键...",

            @"Check for Updates": @"检查更新",
            @"Visit our Website": @"访问网站",
            @"Contact Us": @"联系我们",
            @"Share my usage statistics": @"分享使用统计",
            @"Help us improve CleanShot by allowing us to collect completely anonymous usage data.": @"允许收集完全匿名的使用数据，帮助改进 CleanShot。",
            @"License Manager": @"许可证管理",
            @"Acknowledgments": @"致谢",
            @"Unlink Device": @"解绑设备",
            @"What's New": @"更新内容",
            @"Automatically check for updates": @"自动检查更新",

            @"Automatically Detect Language": @"自动检测语言",
            @"Hold ⇧ Shift while taking a screenshot to get a transparent background.": @"截图时按住 ⇧ Shift 可获得透明背景。",
            @"Hold ⌥ (option) to keep the item on Overlay after dragging.": @"拖放后按住 ⌥ (option) 可将项目保留在浮层中。",
            @"Press with ⌥ (option) to choose the destination.": @"按住 ⌥ (option) 点击可选择保存位置。",
            @"Disable this option to prevent external apps from controlling CleanShot via URL scheme API.": @"关闭此选项可阻止外部应用通过 URL scheme API 控制 CleanShot。",
        };
    });

    return map[s];
}

static NSString *CNTranslate(NSString *s) {
    if (s.length == 0) return s;

    NSString *direct = CNLookup(s);
    if (direct) return direct;

    NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [s stringByTrimmingCharactersInSet:ws];
    NSString *trimmedTranslation = CNLookup(trimmed);
    if (!trimmedTranslation) return s;

    NSRange trimRange = [s rangeOfString:trimmed];
    if (trimRange.location == NSNotFound) return trimmedTranslation;

    NSMutableString *result = [s mutableCopy];
    [result replaceCharactersInRange:trimRange withString:trimmedTranslation];
    return result;
}

static void CNTranslateMenu(NSMenu *menu) {
    for (NSMenuItem *item in menu.itemArray) {
        NSString *translated = CNTranslate(item.title);
        if (translated && ![translated isEqualToString:item.title]) {
            item.title = translated;
        }
        if (item.submenu) CNTranslateMenu(item.submenu);
    }
}

static BOOL CNSkipMutableOrShortcutView(NSView *view) {
    NSString *className = NSStringFromClass(view.class);
    NSArray<NSString *> *blocked = @[
        @"KeyboardShortcut",
        @"TokenField",
        @"SecureTextField",
        @"SearchField",
        @"ComboBox",
        @"TextView"
    ];

    for (NSString *part in blocked) {
        if ([className rangeOfString:part options:NSCaseInsensitiveSearch].location != NSNotFound) {
            return YES;
        }
    }

    if (view.identifier.length > 0) {
        NSString *identifier = view.identifier;
        if ([identifier rangeOfString:@"shortcut" options:NSCaseInsensitiveSearch].location != NSNotFound ||
            [identifier rangeOfString:@"hotkey" options:NSCaseInsensitiveSearch].location != NSNotFound) {
            return YES;
        }
    }

    return NO;
}

static void CNTranslateView(NSView *view) {
    if (CNSkipMutableOrShortcutView(view)) {
        return;
    }

    if ([view isKindOfClass:[NSTextField class]]) {
        NSTextField *field = (NSTextField *)view;
        if (!field.isEditable && [field isMemberOfClass:[NSTextField class]]) {
            NSString *translated = CNTranslate(field.stringValue);
            if (translated && ![translated isEqualToString:field.stringValue]) {
                field.stringValue = translated;
            }
        }
    }

    if ([view isKindOfClass:[NSButton class]]) {
        NSButton *button = (NSButton *)view;
        NSString *translated = CNTranslate(button.title);
        if (translated && ![translated isEqualToString:button.title]) {
            button.title = translated;
        }
    }

    if ([view isKindOfClass:[NSPopUpButton class]]) {
        NSPopUpButton *popup = (NSPopUpButton *)view;
        CNTranslateMenu(popup.menu);
    }

    if ([view isKindOfClass:[NSTabView class]]) {
        NSTabView *tabView = (NSTabView *)view;
        for (NSTabViewItem *item in tabView.tabViewItems) {
            NSString *translated = CNTranslate(item.label);
            if (translated && ![translated isEqualToString:item.label]) {
                item.label = translated;
            }
        }
    }

    if ([view isKindOfClass:[NSTableView class]]) {
        NSTableView *table = (NSTableView *)view;
        for (NSTableColumn *column in table.tableColumns) {
            NSString *translated = CNTranslate(column.headerCell.stringValue);
            if (translated && ![translated isEqualToString:column.headerCell.stringValue]) {
                column.headerCell.stringValue = translated;
            }
        }

        NSRange visibleRows = [table rowsInRect:table.visibleRect];
        if (visibleRows.location != NSNotFound) {
            NSUInteger end = NSMaxRange(visibleRows);
            for (NSUInteger row = visibleRows.location; row < end; row++) {
                for (NSUInteger col = 0; col < table.numberOfColumns; col++) {
                    NSView *cellView = [table viewAtColumn:col row:row makeIfNecessary:NO];
                    if (cellView) CNTranslateView(cellView);
                }
            }
        }
    }

    for (NSView *subview in view.subviews) {
        CNTranslateView(subview);
    }
}

static void CNTranslateWindow(NSWindow *window) {
    NSString *translatedTitle = CNTranslate(window.title);
    if (translatedTitle && ![translatedTitle isEqualToString:window.title]) {
        window.title = translatedTitle;
    }

    for (NSToolbarItem *item in window.toolbar.items) {
        NSString *label = CNTranslate(item.label);
        if (label && ![label isEqualToString:item.label]) item.label = label;

        NSString *palette = CNTranslate(item.paletteLabel);
        if (palette && ![palette isEqualToString:item.paletteLabel]) item.paletteLabel = palette;

        if (item.toolTip.length > 0) {
            NSString *tip = CNTranslate(item.toolTip);
            if (tip && ![tip isEqualToString:item.toolTip]) item.toolTip = tip;
        }
    }

    if (window.contentView) CNTranslateView(window.contentView);
}

static void CNTranslateVisibleUI(void) {
    if (NSApp.mainMenu) CNTranslateMenu(NSApp.mainMenu);
    for (NSWindow *window in NSApp.windows) {
        CNTranslateWindow(window);
    }
}

__attribute__((constructor))
static void CleanShotCNInit(void) {
    @autoreleasepool {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowDidBecomeKeyNotification
                                                              object:nil
                                                               queue:[NSOperationQueue mainQueue]
                                                          usingBlock:^(__unused NSNotification *note) {
                CNTranslateVisibleUI();
            }];

            [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowDidUpdateNotification
                                                              object:nil
                                                               queue:[NSOperationQueue mainQueue]
                                                          usingBlock:^(__unused NSNotification *note) {
                CNTranslateVisibleUI();
            }];

            [NSTimer scheduledTimerWithTimeInterval:0.5
                                            repeats:YES
                                              block:^(__unused NSTimer *timer) {
                CNTranslateVisibleUI();
            }];

            [@"CleanShotCN runtime translator loaded\n" writeToFile:@"/tmp/cleanshot-cn.log"
                                                         atomically:YES
                                                           encoding:NSUTF8StringEncoding
                                                              error:nil];
        });
    }
}
