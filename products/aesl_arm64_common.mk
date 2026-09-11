# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

# Policy shared by every AESL host-managed ARM64 Waydroid product. Board
# products must set AESL_BOARD_FAMILY, AESL_GPU_STACK and AESL_MEDIA_STACK
# before inheriting this file.
ifeq ($(strip $(AESL_BOARD_FAMILY)),)
$(error AESL_BOARD_FAMILY must be set by the board product)
endif
ifeq ($(strip $(AESL_GPU_STACK)),)
$(error AESL_GPU_STACK must be set by the board product)
endif
ifeq ($(strip $(AESL_MEDIA_STACK)),)
$(error AESL_MEDIA_STACK must be set by the board product)
endif

AESL_HOST_MANAGED_UPDATE := true
ANDROID_USE_GAPPS := false
ANDROID_USE_WIDEVINE := false
ANDROID_USE_NDK_TRANSLATION := false
ANDROID_USE_INTEL_HOUDINI := false

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(LOCAL_PATH)/../device.mk)

# Host and Android images are signed, released and rolled back as one tested
# board bundle. The in-container generic updater is intentionally excluded.
PRODUCT_VENDOR_PROPERTIES += \
    ro.active_esl.board_family=$(AESL_BOARD_FAMILY) \
    ro.active_esl.gpu_stack=$(AESL_GPU_STACK) \
    ro.active_esl.media_stack=$(AESL_MEDIA_STACK)

