# EtcPot OS

基于 **AOSP 12 (Android 12)** 的自定义安卓 ROM，品牌为 **EtcPot OS**，内置 root。

> 仓库：https://github.com/ETQWFD/etcpot-os
> 官网：https://etqwfd.github.io/etcpot-os
> Release：https://github.com/ETQWFD/etcpot-os/releases/tag/v1.0

## 定制内容

| 模块 | 说明 |
|---|---|
| 开机动画 | 120fps、600 帧二次元逐帧动画，按图片顺序循环播放（bootanimation.zip，637MB，已上传 Release） |
| 系统名称 | 全局替换为 **EtcPot OS**（ro.product.model、framework-res、Settings） |
| Root 模式 | 设置 → 开发者选项 → Root 模式开关，开启即获 root，无需单独刷 Magisk |
| 鼠标指针 | 15 个定制光标（.cur/.ani 已转 PNG，替换 framework 指针） |
| 音量面板 | 新圆角半透明设计，HarmonyOS 风格滑块 |
| 桌面 | 移除 Launcher3，替换为 **C/C++ NDK 自渲染桌面**，仿 HarmonyOS NEXT |
| 动态壁纸 | GLSL 极光流动渐变；默认壁纸为猫耳少女图 |
| 安装程序 | `installer/install.sh` / `install.bat`，一键 fastboot 刷写 |

## 目录结构

```
etcpot-os/
├── build.sh                  # 本地 AOSP 12 一键构建脚本
├── vendorsetup.sh
├── vendor/etcpot/
│   ├── etcpot.mk
│   ├── config/common.mk
│   ├── overlay/              # framework-res / Settings 文案 + root 开关 XML
│   ├── bootanimation/        # bootanimation.zip（Release 附件，git 不存）
│   ├── volumes/              # 新音量面板样式
│   ├── cursors/              # 15 个定制光标 PNG
│   ├── wallpaper/            # 默认猫耳少女壁纸
│   └── root/                 # su 二进制 + init.etcpot.rc
├── launcher/                 # C/C++ NDK 桌面源码
├── installer/                # 一键刷写脚本
├── patches/                  # 对 AOSP 12 源码的 patch
├── tools/mp4_to_bootanim.sh  # 视频 → bootanimation.zip
└── docs/
    ├── BUILD.md
    └── FLASHING.md
```

## 快速开始（在你自己的 Linux 构建机上）

```bash
mkdir -p ~/aosp && cd ~/aosp
repo init -u https://android.googlesource.com/platform/manifest -b android-12.0.0_r3
repo sync -c -j$(nproc)
git clone https://github.com/ETQWFD/etcpot-os.git vendor/etcpot-src
ln -sfn vendor/etcpot-src vendor/etcpot
bash vendor/etcpot/build.sh
```

产出 `out/target/product/etcpot/etcpot-1.0-rom.zip`（≤5GB），刷写见 `docs/FLASHING.md`。

## 许可

Apache License 2.0
