# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

TARGET_SUPPORTS_OMX_SERVICE := true
AESL_MEMORY_PROFILE := 2gb

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(LOCAL_PATH)/../device.mk)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.low_ram=true

WITH_DEXPREOPT := true
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI \
    Trebuchet \
    TrebuchetQuickStep

PRODUCT_PACKAGES += AESL2GBRemovePackages

PRODUCT_VENDOR_PROPERTIES += \
    ro.active_esl.android_release=r13 \
    ro.active_esl.memory_profile=2gb

PRODUCT_BRAND := active_esl
PRODUCT_DEVICE := waydroid_aesl_2gb_arm64_only
PRODUCT_MANUFACTURER := Active ESL
PRODUCT_NAME := lineage_waydroid_aesl_2gb_arm64_only
PRODUCT_MODEL := Active ESL Waydroid R13 2GB
