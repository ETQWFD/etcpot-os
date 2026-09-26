# EtcPot OS — product makefile
# Inherited by the lunch target `etcpot_arm64-userdebug`.

$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_arm64.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony.mk)

# EtcPot branding + resources
$(call inherit-product, vendor/etcpot/etcpot.mk)

PRODUCT_NAME := etcpot_arm64
PRODUCT_DEVICE := etcpot_arm64
PRODUCT_BRAND := EtcPot
PRODUCT_MODEL := EtcPot OS 1.0
PRODUCT_MANUFACTURER := EtcPot

PRODUCT_GMS_CLIENTID_BASE := android-etcpot

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=etcpot_arm64 \
    PRODUCT_DEVICE=etcpot_arm64 \
    PRIVATE_BUILD_DESC="etcpot_arm64-user 12 SP1A.220120.001 etcpot-1.0"

BUILD_FINGERPRINT := EtcPot/etcpot_arm64/etcpot_arm64:12/SP1A.220120.001/etcpot1000:user/release-keys
