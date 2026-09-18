# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

AESL_BOARD_FAMILY := imx95
AESL_GPU_STACK := nxp-mali
AESL_MEDIA_STACK := nxp-wave6-v4l2

# The shipping LmP BSP currently exposes NXP's Mali kbase ABI. Do not compile
# Mesa or advertise Panfrost until the host kernel is deliberately migrated to
# and validated with Panthor.
TARGET_USE_MESA := false

include device/waydroid/waydroid/waydroid_arm64_only/BoardConfig.mk

# NXP Codec2's Soong defaults require the i.MX platform identity. The
# Waydroid base keeps TARGET_BOARD_PLATFORM=waydroid for its own build rules.
SOONG_CONFIG_NAMESPACES += IMXPLUGIN
SOONG_CONFIG_IMXPLUGIN += \
    BOARD_PLATFORM \
    BOARD_SOC_CLASS \
    BOARD_SOC_TYPE \
    BOARD_HAVE_VPU \
    BOARD_VPU_TYPE \
    HAVE_FSL_IMX_GPU3D \
    ENABLE_DMABUF_HEAP
SOONG_CONFIG_IMXPLUGIN_BOARD_PLATFORM := imx9
SOONG_CONFIG_IMXPLUGIN_BOARD_SOC_CLASS := IMX9
SOONG_CONFIG_IMXPLUGIN_BOARD_SOC_TYPE := IMX95
SOONG_CONFIG_IMXPLUGIN_BOARD_HAVE_VPU := true
SOONG_CONFIG_IMXPLUGIN_BOARD_VPU_TYPE := wave6
SOONG_CONFIG_IMXPLUGIN_HAVE_FSL_IMX_GPU3D := true
SOONG_CONFIG_IMXPLUGIN_ENABLE_DMABUF_HEAP := true
