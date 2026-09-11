# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

# Board products declare capabilities; shared policy lives under products/.
# This keeps board enablement thin and prevents one SoC's vendor stack leaking
# into another board family.
AESL_BOARD_FAMILY := imx8mm
AESL_MEMORY_PROFILE := 2gb
AESL_GPU_STACK := mesa-etnaviv
AESL_MEDIA_STACK := v4l2-codec2

$(call inherit-product, $(LOCAL_PATH)/../products/aesl_arm64_common.mk)
$(call inherit-product, $(LOCAL_PATH)/../products/aesl_2gb_kiosk.mk)

PRODUCT_BRAND := active_esl
PRODUCT_DEVICE := waydroid_aesl_2gb_arm64_only
PRODUCT_MANUFACTURER := Active ESL
PRODUCT_NAME := lineage_waydroid_aesl_2gb_arm64_only
PRODUCT_MODEL := Active ESL Waydroid i.MX8MM 2GB
