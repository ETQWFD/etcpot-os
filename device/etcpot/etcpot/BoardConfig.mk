# EtcPot OS — BoardConfig
# Generic arm64 (Cuttlefish / Goldfish base). For a real phone, override
# BOARD_KERNEL / BOARD partitions with that device's kernel and fstab.

PRODUCT_IS_AUTOMOTIVE := false

TARGET_BOARD_PLATFORM := generic_arm64
TARGET_BOARD_ARCH := arm64
TARGET_BOARD_ARCH_VARIANT := armv8-a
TARGET_BOARD_ABI := arm64-v8a

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false

BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true

# System as root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Partitions (generic sizes; adjust per device)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 21474836480
BOARD_CACHEIMAGE_PARTITION_SIZE := 100663296
BOARD_FLASH_BLOCK_SIZE := 131072

# Root / dm-verity: we ship pre-rooted, disable verity by default
BOARD_BUILD_DISABLED_VBMETAIMAGE := true
BOARD_AVB_ENABLE := false

# Sepolicy: permissive for bring-up
BOARD_SEPOLICY_DIRS += vendor/etcpot/sepolicy
