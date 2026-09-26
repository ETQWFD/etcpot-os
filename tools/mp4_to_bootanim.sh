#!/usr/bin/env bash
#
# tools/mp4_to_bootanim.sh
# Convert a boot video (mp4) to AOSP bootanimation.zip.
#
# Usage:
#   bash tools/mp4_to_bootanim.sh path/to/bootvideo.mp4 [width] [height] [fps]
#
set -euo pipefail

MP4="${1:?usage: $0 video.mp4 [W] [H] [fps]}"
W="${2:-1080}"
H="${3:-2400}"
FPS="${4:-30}"

WORK="$(mktemp -d)"
OUT="$(dirname "$0")/../vendor/etcpot/bootanimation"

echo "==> Extracting frames @ ${W}x${H} ${FPS}fps"
mkdir -p "$WORK/part0"
ffmpeg -y -i "$MP4" -vf "scale=${W}:${H}:force_original_aspect_ratio=decrease,pad=${W}:${H}:(ow-iw)/2:(oh-ih)/2:black,fps=${FPS}" "$WORK/part0/frame%04d.png"

cat > "$WORK/desc.txt" <<EOF
${W} ${H} ${FPS}
p 1 0 part0
EOF

echo "==> Zipping into bootanimation.zip"
( cd "$WORK" && zip -0 -r "$OUT/bootanimation.zip" desc.txt part0 )

echo "==> Done: $OUT/bootanimation.zip"
ls -lh "$OUT/bootanimation.zip"
