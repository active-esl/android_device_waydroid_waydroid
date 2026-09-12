# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

# This is a compatibility-test product, not an i.MX8MM substitute. It applies
# the identical Android low-memory/kiosk policy to the native x86_64 Waydroid
# stack so the Framework can exercise it under a 2 GB container cgroup limit.
ANDROID_USE_GAPPS := false
ANDROID_USE_NDK_TRANSLATION := false
ANDROID_USE_WIDEVINE := false
ANDROID_USE_INTEL_HOUDINI := false
AESL_MEMORY_PROFILE := 2gb

$(call inherit-product, $(LOCAL_PATH)/../waydroid_x86_64/lineage_waydroid_x86_64.mk)
$(call inherit-product, $(LOCAL_PATH)/../products/aesl_2gb_kiosk.mk)

PRODUCT_VENDOR_PROPERTIES += \
    ro.active_esl.board_family=framework-x86_64-validation \
    ro.active_esl.memory_profile=2gb \
    ro.active_esl.validation_only=true

PRODUCT_BRAND := active_esl
PRODUCT_DEVICE := waydroid_aesl_2gb_x86_64
PRODUCT_MANUFACTURER := Active ESL
PRODUCT_NAME := lineage_waydroid_aesl_2gb_x86_64
PRODUCT_MODEL := Active ESL Waydroid Framework 2GB Validation
