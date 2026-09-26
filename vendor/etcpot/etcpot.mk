#
# EtcPot OS — top-level vendor makefile
# Inherited by device config via:
#   $(call inherit-product, vendor/etcpot/etcpot.mk)
#

# Branding ------------------------------------------------------------------
PRODUCT_BRAND := EtcPot
PRODUCT_MANUFACTURER := EtcPot
PRODUCT_MODEL := EtcPot OS
PRODUCT_NAME := etcpot
PRODUCT_DEVICE := generic_arm64

# User-visible system identity (Settings -> About phone)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.brand=EtcPot \
    ro.product.manufacturer=EtcPot \
    ro.product.model=EtcPot OS \
    ro.product.name=etcpot \
    ro.product.system.brand=EtcPot \
    ro.product.system.model=EtcPot OS \
    ro.product.system.name=etcpot \
    ro.product.vendor.brand=EtcPot \
    ro.product.vendor.model=EtcPot OS \
    ro.build.product=etcpot \
    ro.build.display.id=EtcPot-1.0 \
    ro.build.version.release=16 \
    ro.etcpot.version=1.0 \
    ro.etcpot.build.type=user

# Overlays (framework-res rebrand, Settings labels) --------------------------
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/etcpot/overlay/frameworks/base \
    vendor/etcpot/overlay/packages/apps/Settings

# Custom resources -----------------------------------------------------------
PRODUCT_PACKAGES += \
    EtcPotBootAnimation \
    EtcPotVolumePanel \
    EtcPotLauncher

# Remove stock launcher and any preinstalled bloat ---------------------------
PRODUCT_PACKAGES += \
    RemoveLauncher3 \
    RemoveStockWallpaper

# SELinux: permissive during bring-up (optional) ----------------------------
# PRODUCT_PROPERTY_OVERRIDES += ro.boot.selinux=permissive

# Inherit common config -----------------------------------------------------
$(call inherit-product, vendor/etcpot/config/common.mk)
