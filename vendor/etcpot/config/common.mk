#
# EtcPot OS — common product configuration (Android 12)
#

PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.mode=OPTIONAL \
    persist.sys.locale=zh-CN \
    persist.sys.timezone=Asia/Shanghai

# Enable zygote preload for EtcPotLauncher
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER := true

# Install volume panel style
PRODUCT_COPY_FILES += \
    vendor/etcpot/volumes/volume_panel_style.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/vol/volume_panel_style.xml

# Install boot animation (downloaded from Release if not present in tree)
PRODUCT_COPY_FILES += \
    vendor/etcpot/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip

# Install default wallpaper (anime catgirl, 888x1920)
PRODUCT_COPY_FILES += \
    vendor/etcpot/wallpaper/default_wallpaper.png:$(TARGET_COPY_OUT_SYSTEM)/media/wallpaper/default_wallpaper.png

# Install custom cursors
PRODUCT_COPY_FILES += \
    vendor/etcpot/cursors/pointer.png:$(TARGET_COPY_OUT_SYSTEM)/etc/cursor/pointer.png \
    vendor/etcpot/cursors/hand.png:$(TARGET_COPY_OUT_SYSTEM)/etc/cursor/hand.png \
    vendor/etcpot/cursors/link.png:$(TARGET_COPY_OUT_SYSTEM)/etc/cursor/link.png \
    vendor/etcpot/cursors/help.png:$(TARGET_COPY_OUT_SYSTEM)/etc/cursor/help.png \
    vendor/etcpot/cursors/text.png:$(TARGET_COPY_OUT_SYSTEM)/etc/cursor/text.png \
    vendor/etcpot/cursors/busy.png:$(TARGET_COPY_OUT_SYSTEM)/etc/cursor/busy.png \
    vendor/etcpot/cursors/work.png:$(TARGET_COPY_OUT_SYSTEM)/etc/cursor/work.png

# Root: su binary + init script that gates su on persist.sys.root_mode
PRODUCT_COPY_FILES += \
    vendor/etcpot/root/etcpot_su:$(TARGET_COPY_OUT_SYSTEM)/bin/su \
    vendor/etcpot/root/init.etcpot.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.etcpot.rc
