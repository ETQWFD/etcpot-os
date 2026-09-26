#
# EtcPot OS — top-level vendor makefile (Android 12)
#

# Branding ------------------------------------------------------------------
PRODUCT_BRAND := EtcPot
PRODUCT_MANUFACTURER := EtcPot
PRODUCT_MODEL := EtcPot OS
PRODUCT_NAME := etcpot
PRODUCT_DEVICE := generic_arm64

# User-visible system identity
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
    ro.build.version.release=12 \
    ro.etcpot.version=1.0 \
    ro.etcpot.build.type=user \
    ro.etcpot.arch=arm64 \
    ro.etcpot.developer=ETC

# Root mode: shipped pre-rooted, gated by a Developer-options toggle.
# persist.sys.root_mode = 1 -> su available
# persist.sys.root_mode = 0 -> su hidden (default)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_mode=0 \
    ro.adb.secure=1 \
    ro.secure=1

# Overlays (framework-res rebrand, Settings labels, cursors, wallpaper) -------
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/etcpot/overlay/frameworks/base \
    vendor/etcpot/overlay/packages/apps/Settings

# Custom resources -----------------------------------------------------------
PRODUCT_PACKAGES += \
    EtcPotBootAnimation \
    EtcPotVolumePanel \
    EtcPotLauncher \
    EtcPotWallpaper \
    EtcPotCursors \
    EtcPotRootControl

# Pre-root: su + init script gated by root_mode property --------------------
PRODUCT_PACKAGES += \
    EtcPotSu \
    EtcPotInitRoot

# System apps: ETCAS screen-casting tool (com.etc.cas) ----------------------
PRODUCT_PACKAGES += \
    ETCASCast

# Remove stock launcher ------------------------------------------------------
PRODUCT_PACKAGES += \
    RemoveLauncher3

# Inherit common config -----------------------------------------------------
$(call inherit-product, vendor/etcpot/config/common.mk)
