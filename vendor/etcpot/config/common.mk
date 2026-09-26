#
# EtcPot OS — common product configuration
#

# Default Linux kernel modules / APEX hints are left to the device tree.
# Here we only lock down EtcPot-specific behaviour.

# No AOSP stock wallpaper picker (we ship our own dynamic wallpaper engine)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.mode=OPTIONAL \
    persist.sys.locale=zh-CN \
    persist.sys.timezone=Asia/Shanghai

# Enable zygote preload for EtcPotLauncher
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER := true

# Allow /system/etc/init scripts to start EtcPot services
PRODUCT_COPY_FILES += \
    vendor/etcpot/volumes/volume_panel_style.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/vol/volume_panel_style.xml
