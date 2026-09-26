# 刷写指南（GSI）

EtcPot OS 以 **GSI（通用系统镜像）** 形式发布：一个 `system.img`，
刷进任意 **Android 8+、支持 Treble 的 arm64 手机**（Pixel、小米、一加、三星
新款等），保留手机原厂内核和基带，只替换 system 分区。

## 兼容性自检
手机需满足：
- arm64 架构
- 已解锁 bootloader
- 支持 Project Treble（`adb shell getprop ro.treble.enabled` 返回 true）

## 方式一：fastboot 直刷（推荐）

```bash
# 1. 手机进 fastboot（关机后 音量下+电源）
fastboot devices

# 2. 进入 fastbootd（动态分区机型）
fastboot reboot fastboot
# 3. 刷 GSI system
fastboot flash system system.img
fastboot reboot
```

首次开机 5-10 分钟（DEX 优化）。

## 方式二：Recovery sideload
把 `etcpot-gsi-arm64.zip` 拷到手机，TWRP/Recovery 里选「Apply update」刷入。

## 虚拟机 / 模拟器
```bash
emulator -system system.img -partition-size 4096
```

## 不会变砖的前提
- 刷 GSI 不动 boot/modem/vendor，出问题 `fastboot flash system 原厂镜像` 即可救回。
- 建议先备份原厂 system。
- 少数深度定制机型（vivo/OPPO）需先刷 TWRP，不保证全部可用。

## 验证
开机后「设置 → 关于 EtcPot」应显示 EtcPot OS 1.0，开机动画为猫耳少女，
桌面为 C++ 自渲染桌面；开发者选项开「Root 模式」重启即 root。
