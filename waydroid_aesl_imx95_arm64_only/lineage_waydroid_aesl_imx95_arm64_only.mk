# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

AESL_BOARD_FAMILY := imx95
AESL_GPU_STACK := nxp-mali
AESL_MEDIA_STACK := nxp-hantro
AESL_NXP_ANDROID_RELEASE := android-16.0.0_2.0.0

$(call inherit-product, $(LOCAL_PATH)/../products/aesl_arm64_common.mk)

# This is a deliberate, fail-closed vendor boundary. The NXP release overlay
# is licence-controlled and must be staged by CI at the exact reviewed release;
# silently producing a software-rendered image would create false evidence.
ifeq ($(wildcard device/nxp/imx9/gpu/gpu_mali.mk),)
$(error i.MX95 requires NXP $(AESL_NXP_ANDROID_RELEASE): missing device/nxp/imx9/gpu/gpu_mali.mk)
endif
ifeq ($(wildcard vendor/nxp/fsl-proprietary/gpu-mali/Android.mk),)
$(error i.MX95 requires the reviewed NXP proprietary release overlay: missing gpu-mali)
endif
ifeq ($(wildcard vendor/nxp/wsialloc/android/gralloc.device.mk),)
$(error i.MX95 requires the reviewed NXP proprietary release overlay: missing wsialloc)
endif
ifeq ($(wildcard vendor/nxp/imx-vpu-hantro/Android.bp),)
$(error i.MX95 requires the reviewed NXP proprietary release overlay: missing imx-vpu-hantro)
endif
ifeq ($(wildcard vendor/nxp-opensource/imx_android_mm/codec2/Android.bp),)
$(error i.MX95 requires NXP $(AESL_NXP_ANDROID_RELEASE): missing imx_android_mm)
endif

CONFIG_REPO_PATH := device/nxp
IMX_WSI_ALLOC_PATH := vendor/nxp/wsialloc
include device/nxp/imx9/gpu/gpu_mali.mk

PRODUCT_VENDOR_PROPERTIES += \
    ro.active_esl.nxp_android_release=$(AESL_NXP_ANDROID_RELEASE) \
    ro.active_esl.hardware_status=integration

PRODUCT_BRAND := active_esl
PRODUCT_DEVICE := waydroid_aesl_imx95_arm64_only
PRODUCT_MANUFACTURER := Active ESL
PRODUCT_NAME := lineage_waydroid_aesl_imx95_arm64_only
PRODUCT_MODEL := Active ESL Waydroid i.MX95
