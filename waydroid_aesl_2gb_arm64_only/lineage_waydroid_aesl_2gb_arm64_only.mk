# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

# The i.MX8MM board has 2 GB shared by Linux, graphics and Android. A single
# 64-bit ABI avoids carrying a second userspace while retaining arm64 app
# compatibility.
AESL_WAYDROID_2GB := true
# Product makefiles are evaluated before BoardConfig.mk.  Set this here as
# well so device.mk selects only the i.MX8MM Etnaviv/minigbm package set.
AESL_IMX8MM_GPU := true
ANDROID_USE_GAPPS := false
ANDROID_USE_WIDEVINE := false
ANDROID_USE_NDK_TRANSLATION := false
ANDROID_USE_INTEL_HOUDINI := false

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(LOCAL_PATH)/../device.mk)

# Select Android's current PSI-based low-memory behaviour. Do not use the
# legacy minfree strategy from the generic Waydroid profile.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.low_ram=true

# Precompile the resident UI processes. Shipping user builds also enable the
# platform's normal dexpreopt path; this list makes the critical set explicit.
WITH_DEXPREOPT := true
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI \
    Trebuchet \
    TrebuchetQuickStep

# Remove non-kiosk applications and radios that otherwise retain background
# processes. Trebuchet remains until the AESL kiosk controller is ported.
PRODUCT_PACKAGES += AESL2GBRemovePackages

PRODUCT_BRAND := active_esl
PRODUCT_DEVICE := waydroid_aesl_2gb_arm64_only
PRODUCT_MANUFACTURER := Active ESL
PRODUCT_NAME := lineage_waydroid_aesl_2gb_arm64_only
PRODUCT_MODEL := Active ESL Waydroid i.MX8MM 2GB
