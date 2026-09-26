# EtcPot Launcher

仿华为 HarmonyOS NEXT 桌面，使用 **C/C++ NDK** 编写，无 Java/Kotlin 启动器代码。

## 架构

```
launcher/
├── Android.bp              # Soong 构建脚本
└── jni/
    ├── main.cpp            # NativeActivity 入口 + EGL/GL 上下文
    ├── workspace.{h,cpp}   # 分页主屏、5×6 图标网格
    ├── app_drawer.{h,cpp}  # 上滑应用列表
    └── dynamic_wallpaper.{h,cpp}  # 极光动态壁纸（GLSL 着色器）
```

## 特性

- 5×6 圆角图标网格，HarmonyOS 风格软阴影
- 上滑呼出应用抽屉
- 极光渐变动态壁纸（流动青蓝色）
- 长按图标进入编辑模式
- 完全 OpenGL ES 3.x 自渲染，不依赖 Launcher3

## 构建

随 AOSP 整体编译时自动打包为 `EtcPotLauncher.apk`，并被声明为默认 HOME。
