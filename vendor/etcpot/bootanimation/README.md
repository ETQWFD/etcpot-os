# EtcPot Boot Animation
#
# AOSP boot animation is loaded from /system/media/bootanimation.zip.
# It is a zip containing:
#   desc.txt            — timeline + resolution
#   part0/, part1/...   — numbered frames (PNG)
#
# We ship a *placeholder* animation here. When you upload the boot video,
# drop it at vendor/etcpot/bootanimation/bootvideo.mp4 and run:
#
#   ./tools/mp4_to_bootanim.sh vendor/etcpot/bootanimation/bootvideo.mp4
#
# That script extracts frames, sizes them to the device resolution, and
# rebuilds bootanimation.zip with the desc.txt below.
#
# desc.txt format:
#   <width> <height> <fps>
#   p <count> <pause> <path>
#   p 0 0 part0
#
# Default: 1080x2400 @ 30fps, one looped part.
width=1080
height=2400
fps=30
part_count=1
loop=0
pause=0
