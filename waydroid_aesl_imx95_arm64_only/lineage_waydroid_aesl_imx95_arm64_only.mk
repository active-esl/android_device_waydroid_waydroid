# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

AESL_BOARD_FAMILY := imx95
AESL_GPU_STACK := nxp-mali
AESL_MEDIA_STACK := nxp-wave6-v4l2
AESL_NXP_PUBLIC_SOURCE_RELEASE := android-16.0.0_2.0.0
AESL_NXP_GPU_BLOB_RELEASE := android-16.0.0_1.2.0

$(call inherit-product, $(LOCAL_PATH)/../products/aesl_arm64_common.mk)

# Keep the GPU boundary fail-closed. The CI input gate verifies the exact
# r54p1 GPU and allocator trees staged for this development host. Wave6 V4L2
# Codec2 comes from the separately pinned public source release.
ifeq ($(wildcard device/nxp/imx9/gpu/gpu_mali.mk),)
$(error i.MX95 requires NXP $(AESL_NXP_PUBLIC_SOURCE_RELEASE): missing device/nxp/imx9/gpu/gpu_mali.mk)
endif
ifeq ($(wildcard vendor/nxp/fsl-proprietary/gpu-mali/Android.mk),)
$(error i.MX95 requires NXP $(AESL_NXP_GPU_BLOB_RELEASE) GPU input: missing gpu-mali)
endif
ifeq ($(wildcard vendor/nxp/wsialloc/android/gralloc.device.mk),)
$(error i.MX95 requires NXP $(AESL_NXP_GPU_BLOB_RELEASE) allocator input: missing wsialloc)
endif
ifeq ($(wildcard vendor/nxp-opensource/imx_android_mm/codec2/Android.bp),)
$(error i.MX95 requires NXP $(AESL_NXP_PUBLIC_SOURCE_RELEASE): missing imx_android_mm)
endif
ifeq ($(wildcard vendor/nxp-opensource/imx_android_mm/codec2/video_dec/v4l2_dec/Android.bp),)
$(error i.MX95 requires the Wave6 V4L2 Codec2 decoder source)
endif
ifeq ($(wildcard vendor/nxp-opensource/imx_android_mm/codec2/video_enc/v4l2_enc/Android.bp),)
$(error i.MX95 requires the Wave6 V4L2 Codec2 encoder source)
endif

CONFIG_REPO_PATH := device/nxp
IMX_WSI_ALLOC_PATH := vendor/nxp/wsialloc
include device/nxp/imx9/gpu/gpu_mali.mk

PRODUCT_VENDOR_PROPERTIES += \
    ro.active_esl.nxp_public_source_release=$(AESL_NXP_PUBLIC_SOURCE_RELEASE) \
    ro.active_esl.gpu_blob_release=$(AESL_NXP_GPU_BLOB_RELEASE) \
    ro.active_esl.gpu_driver_revision=r54p1-11eac0 \
    ro.active_esl.vpu_driver=wave6-v4l2 \
    ro.active_esl.hardware_status=integration

PRODUCT_BRAND := active_esl
PRODUCT_DEVICE := waydroid_aesl_imx95_arm64_only
PRODUCT_MANUFACTURER := Active ESL
PRODUCT_NAME := lineage_waydroid_aesl_imx95_arm64_only
PRODUCT_MODEL := Active ESL Waydroid i.MX95
