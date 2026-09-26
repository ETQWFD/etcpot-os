# EtcPot OS — GSI product (Generic System Image)
# Builds a single system.img that flashes onto ANY Treble-compliant
# arm64 device (Android 8+). No per-phone kernel/driver needed; it
# replaces only the system partition and keeps the stock kernel.

$(call inherit-product, $(SRC_TARGET_DIR)/product/mainline_system.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# EtcPot branding + resources
$(call inherit-product, vendor/etcpot/etcpot.mk)

# Mark as a GSI
PRODUCT_NAME := etcpot_gsi_arm64
PRODUCT_DEVICE := phhusson_arm64
PRODUCT_BRAND := EtcPot
PRODUCT_MODEL := EtcPot OS 1.0 GSI
PRODUCT_MANUFACTURER := EtcPot

# GSI needs to be able to boot on device kernels
PRODUCT_PROPERTY_OVERRIDES += ro.product.first_api_level=28

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=etcpot_gsi_arm64 \
    PRODUCT_DEVICE=phhusson_arm64 \
    BUILD_FINGERPRINT="EtcPot/etcpot_gsi_arm64:12/SP1A.220120.001/etcpot1000:userdebug/release-keys" \
    PRIVATE_BUILD_DESC="etcpot_gsi_arm64-userdebug 12 SP1A.220120.001 etcpot-1.0"
