# EtcPot OS

基于 **AOSP 16** 的自定义 Android ROM，品牌为 **EtcPot OS**。

> 仓库地址：https://github.com/ETQWFD/etcpot-os
> 官网：https://etqwfd.github.io/etcpot-os（即将上线）

## 定制内容

| 模块 | 说明 |
|---|---|
| 开机动画 | 占位工程；后续用你上传的视频经 `tools/mp4_to_bootanim.sh` 转成 `bootanimation.zip` |
| 系统名称 | 全局替换为 **EtcPot OS**（`ro.product.model`、framework-res、Settings） |
| 音量面板 | 新圆角半透明设计（`vendor/etcpot/volumes/volume_panel_style.xml`） |
| 桌面 | 移除 AOSP Launcher3，替换为 **C/C++ NDK 自渲染桌面**，仿 HarmonyOS NEXT |
| 动态壁纸 | GLSL 极光流动渐变 |
| 安装程序 | `installer/install.sh` / `install.bat`，一键 fastboot 刷写 |

## 目录结构

```
etcpot-os/
├── build.sh                  # 本地 AOSP 一键构建脚本
├── vendorsetup.sh
├── vendor/etcpot/           # 品牌资源 + overlay
│   ├── etcpot.mk
│   ├── config/common.mk
│   ├── overlay/              # framework-res / Settings 文案覆盖
│   ├── bootanimation/        # 开机动画（desc.txt + 待上传视频）
│   ├── volumes/              # 新音量面板样式
│   └── removePackages.mk     # 移除 Launcher3
├── launcher/                 # C/C++ NDK 桌面源码
│   ├── Android.bp
│   └── jni/
├── installer/                # 一键刷写脚本
├── patches/                  # 对 AOSP 源码的 patch
├── tools/mp4_to_bootanim.sh  # 视频 → bootanimation.zip
└── docs/
    ├── BUILD.md              # 本地构建指南
    └── FLASHING.md           # 刷写指南
```

## 快速开始

完整编译必须在本地 Linux 构建机（≥250GB 磁盘 / ≥16GB 内存）执行：

```bash
mkdir -p ~/aosp && cd ~/aosp
repo init -u https://android.googlesource.com/platform/manifest -b android-16.0.0_r1
repo sync -c -j$(nproc)
git clone https://github.com/ETQWFD/etcpot-os.git vendor/etcpot-src
ln -sfn vendor/etcpot-src vendor/etcpot
bash vendor/etcpot/build.sh
```

## Release

镜像产出后会上传到：
- GitHub Releases：https://github.com/ETQWFD/etcpot-os/releases
- Pages 官网：https://etqwfd.github.io/etcpot-os

## 许可

Apache License 2.0
