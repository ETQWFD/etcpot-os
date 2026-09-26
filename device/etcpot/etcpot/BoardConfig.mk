# EtcPot OS — BoardConfig (GSI)
# A GSI ships ONLY a system.img. It does NOT ship a kernel or bootloader;
# the phone keeps its stock kernel/bootloader. This is why one GSI boots
# on many Treble-compliant arm64 devices.

PRODUCT_IS_AUTOMOTIVE := false

TARGET_BOARD_PLATFORM := generic_arm64
TARGET_BOARD_ARCH := arm64
TARGET_BOARD_ARCH_VARIANT := armv8-a
TARGET_BOARD_ABI := arm64-v8a

# GSI: no bootloader, no kernel, no recovery — we only produce system.img
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true
TARGET_NO_RECOVERY := true
TARGET_NO_RADIOIMAGE := true

BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true

# System image only (dynamically sized on real devices)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 4294967296
BOARD_FLASH_BLOCK_SIZE := 4096

# Root / dm-verity: pre-rooted, verity off so it boots on locked/unlocked
# vendor partitions without verity mismatch.
BOARD_BUILD_DISABLED_VBMETAIMAGE := true
BOARD_AVB_ENABLE := false

# Build as system-as-root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

BOARD_SEPOLICY_DIRS += vendor/etcpot/sepolicy
