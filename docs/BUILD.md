# 本地构建指南（BUILD.md）

## 0. 硬件要求

| 资源 | 最低 | 推荐 |
|---|---|---|
| 磁盘 | 250 GB SSD | 500 GB NVMe |
| 内存 | 16 GB | 32 GB |
| CPU | 8 核 | 16 核+ |
| 系统 | Ubuntu 22.04 LTS | Ubuntu 24.04 LTS |

> 沙箱 / 临时容器无法完成完整 AOSP 编译，必须在本地 Linux 构建机执行。

## 1. 同步 AOSP 16 源码

```bash
mkdir -p ~/aosp && cd ~/aosp
repo init -u https://android.googlesource.com/platform/manifest -b android-16.0.0_r1
repo sync -c -j$(nproc)
```

## 2. 拉取 EtcPot 定制工程

```bash
cd ~/aosp
git clone https://github.com/ETQWFD/etcpot-os.git vendor/etcpot-src
ln -sfn vendor/etcpot-src vendor/etcpot
```

## 3. （可选）替换开机动画

把你准备好的开机视频放到 `vendor/etcpot/bootanimation/bootvideo.mp4`，然后：

```bash
bash vendor/etcpot/tools/mp4_to_bootanim.sh \
     vendor/etcpot/bootanimation/bootvideo.mp4 1080 2400 30
```

## 4. 一键构建

```bash
bash vendor/etcpot/build.sh
```

输出镜像位于：
```
out/target/product/etcpot/etcpot-1.0-image.zip
```

## 5. 刷写

参见 `installer/README.md` 或 `docs/FLASHING.md`。
