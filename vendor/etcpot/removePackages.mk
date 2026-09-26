#
# EtcPot OS — packages to REMOVE from the build
# Stock Launcher3 is replaced by EtcPotLauncher (C/C++ NDK).
# This makefile uses the standard AOSP "remove package" mechanism:
#   PRODUCT_PACKAGES += RemovedPackageName
# plus a PRODUCT_DEXPREOPT_SPEED / override to block the APK from
# being copied into system image.
#

# Block Launcher3 from shipping
PRODUCT_PACKAGES := $(filter-out Launcher3 Launcher3QuickStep,$(PRODUCT_PACKAGES))

# Overlay / package removal map
PRODUCT_DEXPREOPT_SPEED_OVERRIDES += \
    Launcher3 \
    Launcher3QuickStep \
    Launcher3GoQuickStep

# Remove stock live-wallpicker (we ship EtcPot dynamic wallpaper engine)
PRODUCT_PACKAGES := $(filter-out WallpaperPicker,$(PRODUCT_PACKAGES))
