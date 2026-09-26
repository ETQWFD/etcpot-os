#!/usr/bin/env bash
#
# EtcPot OS — one-click installer (Linux / macOS).
# Detects a connected device via fastboot, unlocks, flashes the image,
# and reboots. No manual step required.
#
# Usage:
#   bash install.sh [path/to/etcpot-image.zip]
#
set -euo pipefail

IMAGE="${1:-out/target/product/etcpot/etcpot-1.0-image.zip}"

echo "=============================================="
echo "  EtcPot OS 一键安装程序 (Linux/macOS)"
echo "=============================================="

# 1. Check fastboot
if ! command -v fastboot >/dev/null; then
  echo "[!] 未找到 fastboot，请先安装 android-platform-tools。"
  exit 1
fi

# 2. Detect device
echo "[1/6] 检测设备..."
DEVICE="$(fastboot devices | awk 'NR==1{print $1}')"
if [ -z "$DEVICE" ]; then
  echo "[!] 未检测到设备。请手机进入 fastboot 模式（关机后按住 音量下+电源）。"
  exit 1
fi
echo "    已连接: $DEVICE"

# 3. Unlock bootloader (warn)
echo "[2/6] 解锁 bootloader（会清除用户数据）..."
fastboot flashing unlock || echo "    设备已解锁或需要手动确认，继续..."

# 4. Wipe
echo "[3/6] 清空 userdata / cache..."
fastboot -w || true

# 5. Flash
echo "[4/6] 刷写 EtcPot 镜像: $IMAGE"
if [ -f "$IMAGE" ]; then
  fastboot update "$IMAGE"
else
  echo "    [!] 镜像未找到，刷写 boot/system/vendor 占位..."
  fastboot flash boot    boot.img
  fastboot flash system  system.img
  fastboot flash vendor   vendor.img
fi

# 6. Reboot
echo "[5/6] 重启设备..."
fastboot reboot

echo "[6/6] 完成。首次开机约 2-3 分钟，请耐心等待。"
