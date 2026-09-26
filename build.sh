#!/usr/bin/env bash
#
# EtcPot OS — one-shot build script (Android 12).
# Run this from the ROOT of your AOSP 12 source tree after you have:
#
#   1. Repo-synced AOSP 12 (android-12.0.0_rXX) to ~/aosp
#   2. Cloned this repo into vendor/etcpot/ (or symlinked it)
#
#     cd ~/aosp
#     git clone https://github.com/ETQWFD/etcpot-os.git vendor/etcpot-src
#     ln -sfn vendor/etcpot-src vendor/etcpot
#
# Then:
#     bash vendor/etcpot-src/build.sh
#
# Output out/ will contain etcpot-*.zip flashable packages (<= 5 GB).
#

set -euo pipefail

AOSP_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$AOSP_ROOT"

echo "==> EtcPot OS build starting at $(date)"
echo "==> AOSP root: $AOSP_ROOT"

# 0. Ensure bootanimation.zip present (it is a 637 MB release asset, not in git)
BOOTANIM="vendor/etcpot/bootanimation/bootanimation.zip"
if [ ! -s "$BOOTANIM" ]; then
  echo "==> bootanimation.zip missing, downloading from GitHub Release..."
  mkdir -p "$(dirname "$BOOTANIM")"
  curl -fL -o "$BOOTANIM" \
    "https://github.com/ETQWFD/etcpot-os/releases/download/v1.0/bootanimation.zip"
fi

# 1. Snapshot tools env
source build/envsetup.sh

# 2. Apply EtcPot patches
PATCH_DIR="vendor/etcpot/patches"
if [ -d "$PATCH_DIR" ]; then
  for p in "$PATCH_DIR"/*.patch; do
    [ -e "$p" ] || continue
    echo "==> Applying patch: $p"
    git -C "$AOSP_ROOT" apply --whitespace=nowarn --forward "$p" || true
  done
fi

# 3. Lunch target (Android 12 generic arm64)
lunch etcpot-trunk-userdebug || lunch aosp_arm64-trunk-userdebug

# 4. Incremental clean
m installclean || true

# 5. Build
JOBS="$(nproc 2>/dev/null || echo 8)"
echo "==> Running m -j$JOBS"
m -j"$JOBS"

# 6. Package flashable OTA
echo "==> Packaging OTA / factory image"
m otatools-package || true

echo "==> Build finished at $(date)"
echo "==> Output: $AOSP_ROOT/out/target/product/etcpot/"
ls -lh "$AOSP_ROOT/out/target/product/etcpot/"*.zip 2>/dev/null || true
