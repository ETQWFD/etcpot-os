#!/usr/bin/env bash
#
# EtcPot OS — one-shot build script.
# Run this from the ROOT of your AOSP 16 source tree after you have:
#
#   1. Repo-synced AOSP 16 (android-16.0.0_rXX) to ~/aosp
#   2. Cloned this repo into vendor/etcpot/ (or symlinked it)
#
#     cd ~/aosp
#     git clone https://github.com/ETQWFD/etcpot-os.git vendor/etcpot-src
#     ln -sfn vendor/etcpot-src vendor/etcpot
#
# Then:
#     bash vendor/etcpot-src/build.sh
#
# Output out/ will contain etcpot-*.zip flashable packages.
#

set -euo pipefail

AOSP_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$AOSP_ROOT"

echo "==> EtcPot OS build starting at $(date)"
echo "==> AOSP root: $AOSP_ROOT"

# 1. Snapshot tools env
source build/envsetup.sh

# 2. Apply EtcPot patches (rebrand, remove Launcher3, volume panel)
PATCH_DIR="vendor/etcpot/patches"
if [ -d "$PATCH_DIR" ]; then
  for p in "$PATCH_DIR"/*.patch; do
    [ -e "$p" ] || continue
    echo "==> Applying patch: $p"
    # --forward skips patches that are already applied
    git -C "$AOSP_ROOT" apply --whitespace=nowarn --forward "$p" || true
  done
fi

# 3. Lunch target
# For Pixel devices use e.g. aosp_redfin-trunk-userdebug; for generic arm64:
lunch etcpot-trunk-userdebug || lunch aosp_arm64-trunk-userdebug

# 4. Clean incremental objects only for our packages
m installclean || true

# 5. Build
JOBS="$(nproc 2>/dev/null || echo 8)"
echo "==> Running m -j$JOBS"
m -j"$JOBS"

# 6. Package flashable image
echo "==> Packaging OTA / factory image"
m otatools-package || true

echo "==> Build finished at $(date)"
echo "==> Output: $AOSP_ROOT/out/target/product/etcpot/"
ls -lh "$AOSP_ROOT/out/target/product/etcpot/"*.zip 2>/dev/null || true
