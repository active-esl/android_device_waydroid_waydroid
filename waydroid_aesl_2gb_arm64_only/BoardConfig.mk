# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

# Set before including the shared configuration so it selects the dedicated
# system property file rather than the upstream 4 GB profile.
AESL_WAYDROID_2GB := true
AESL_BOARD_FAMILY := imx8mm
AESL_MEMORY_PROFILE := 2gb
AESL_GPU_STACK := mesa-etnaviv
AESL_MEDIA_STACK := v4l2-codec2

include device/waydroid/waydroid/waydroid_arm64_only/BoardConfig.mk
