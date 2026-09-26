# 刷写指南（FLASHING.md）

## 准备

- 已解锁 bootloader 的 Android 设备（推荐 Pixel 系列开发版）
- USB 数据线
- `android-platform-tools`（adb / fastboot）

## 步骤

1. 手机进入 fastboot：关机后按住 `音量下 + 电源`。
2. 连接电脑，确认：
   ```bash
   fastboot devices
   ```
3. 一键刷写：
   ```bash
   bash installer/install.sh out/target/product/etcpot/etcpot-1.0-image.zip
   ```
4. 设备自动重启，首次开机 2-3 分钟。

## 验证

开机后进入「设置 → 关于 EtcPot」，应看到：

- 设备名称：EtcPot OS
- 版本：EtcPot-1.0
- Android 安全补丁：随 AOSP 16
- 桌面为 EtcPotLauncher（C++ 自渲染）
- 音量面板为新圆角半透明样式
- 开机动画为你提供的视频
