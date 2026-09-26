# 本地构建指南（BUILD.md）

## 0. 硬件要求

| 资源 | 最低 | 推荐 |
|---|---|---|
| 磁盘 | 250 GB SSD | 500 GB NVMe |
| 内存 | 16 GB | 32 GB |
| CPU | 8 核 | 16 核+ |
| 系统 | Ubuntu 22.04 LTS | Ubuntu 24.04 LTS |

> 沙箱 / 临时容器无法完成完整 AOSP 编译，必须在本地 Linux 构建机执行。

## 1. 同步 AOSP 12 源码

```bash
mkdir -p ~/aosp && cd ~/aosp
repo init -u https://android.googlesource.com/platform/manifest -b android-12.0.0_r3
repo sync -c -j$(nproc)
```

## 2. 拉取 EtcPot 定制工程

```bash
cd ~/aosp
git clone https://github.com/ETQWFD/etcpot-os.git vendor/etcpot-src
ln -sfn vendor/etcpot-src vendor/etcpot
```

## 3. 开机动画

开机动画（120fps、600 帧、1080×1920）已打包为 `bootanimation.zip` 并上传到 v1.0 Release。`build.sh` 会自动下载到 `vendor/etcpot/bootanimation/bootanimation.zip`，无需手动操作。

如需替换为新视频：
```bash
bash vendor/etcpot/tools/mp4_to_bootanim.sh new_video.mp4 1080 1920 120
```

## 4. 一键构建

```bash
bash vendor/etcpot/build.sh
```

输出 ROM 位于：
```
out/target/product/etcpot/etcpot-1.0-rom.zip
```
（≤5 GB，可直接 fastboot 刷入）

## 5. Root

刷机后进入 设置 → 关于手机 → 连续点版本号开启开发者选项 → 开发者选项 → 打开「Root 模式」→ 重启，即获得 root（su）。

## 6. 刷写

参见 `installer/README.md` 或 `docs/FLASHING.md`。
