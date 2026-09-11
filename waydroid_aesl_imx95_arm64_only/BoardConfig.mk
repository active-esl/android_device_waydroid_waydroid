# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

AESL_BOARD_FAMILY := imx95
AESL_GPU_STACK := nxp-mali
AESL_MEDIA_STACK := nxp-hantro

# The shipping LmP BSP currently exposes NXP's Mali kbase ABI. Do not compile
# Mesa or advertise Panfrost until the host kernel is deliberately migrated to
# and validated with Panthor.
TARGET_USE_MESA := false

include device/waydroid/waydroid/waydroid_arm64_only/BoardConfig.mk

