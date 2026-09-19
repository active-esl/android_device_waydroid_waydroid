#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
products="${repo_root}/AndroidProducts.mk"
common="${repo_root}/products/aesl_arm64_common.mk"
imx8="${repo_root}/waydroid_aesl_2gb_arm64_only/lineage_waydroid_aesl_2gb_arm64_only.mk"
imx95="${repo_root}/waydroid_aesl_imx95_arm64_only/lineage_waydroid_aesl_imx95_arm64_only.mk"
imx95_board="${repo_root}/waydroid_aesl_imx95_arm64_only/BoardConfig.mk"

require_text() {
    local file="$1" text="$2"
    grep -Fq -- "${text}" "${file}" || {
        echo "missing required board contract in ${file}: ${text}" >&2
        exit 1
    }
}

require_text "${common}" 'AESL_HOST_MANAGED_UPDATE := true'
require_text "${common}" 'ro.active_esl.board_family=$(AESL_BOARD_FAMILY)'
require_text "${products}" '$(VENDOR_NAME)_waydroid_aesl_imx95_arm64_only-user'
require_text "${products}" '$(VENDOR_NAME)_waydroid_aesl_imx95_arm64_only-userdebug'
require_text "${imx8}" 'AESL_BOARD_FAMILY := imx8mm'
require_text "${imx8}" 'AESL_GPU_STACK := mesa-etnaviv'
require_text "${imx8}" 'AESL_MEDIA_STACK := v4l2-codec2'
require_text "${imx95}" 'AESL_BOARD_FAMILY := imx95'
require_text "${imx95}" 'AESL_GPU_STACK := nxp-mali'
require_text "${imx95}" 'AESL_MEDIA_STACK := nxp-wave6-v4l2'
require_text "${imx95}" 'AESL_NXP_PUBLIC_SOURCE_RELEASE := android-16.0.0_2.0.0'
require_text "${imx95}" 'AESL_NXP_GPU_BLOB_RELEASE := android-16.0.0_1.2.0'
require_text "${imx95}" 'BOARD_SOC_TYPE := IMX95'
require_text "${imx95}" 'TARGET_USE_MESA := false'
require_text "${imx95}" 'PRODUCT_PACKAGES := $(filter-out gpu-top,$(PRODUCT_PACKAGES))'
require_text "${imx95}" 'ro.active_esl.gpu_driver_revision=r54p1-11eac0'
require_text "${imx95}" 'missing device/nxp/imx9/gpu/gpu_mali.mk'
require_text "${imx95}" 'missing gpu-mali'
require_text "${imx95}" 'missing wsialloc'
require_text "${imx95}" 'Wave6 V4L2 Codec2 decoder source'
require_text "${imx95}" 'Wave6 V4L2 Codec2 encoder source'
require_text "${imx95}" 'missing imx_android_mm'
require_text "${imx95_board}" 'TARGET_USE_MESA := false'
require_text "${imx95_board}" 'BOARD_SOC_TYPE := IMX95'
require_text "${imx95_board}" 'DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml'
require_text "${repo_root}/BoardConfig.mk" '$(DEVICE_PATH)/manifest_allocator_aidl.xml'
require_text "${imx95_board}" 'SOONG_CONFIG_IMXPLUGIN_BOARD_PLATFORM := imx9'
require_text "${imx95_board}" 'SOONG_CONFIG_IMXPLUGIN_BOARD_SOC_TYPE := IMX95'
require_text "${imx95_board}" 'SOONG_CONFIG_IMXPLUGIN_BOARD_HAVE_VPU := true'
require_text "${imx95_board}" 'SOONG_CONFIG_IMXPLUGIN_BOARD_VPU_ONLY := true'
require_text "${imx95_board}" 'SOONG_CONFIG_IMXPLUGIN_BOARD_VPU_TYPE := wave6'
require_text "${imx95_board}" 'SOONG_CONFIG_IMXPLUGIN_HAVE_FSL_IMX_GPU3D := true'
require_text "${repo_root}/device.mk" 'android.hardware.media.c2.service.imx'
require_text "${repo_root}/device.mk" 'c2_component_register_95'
require_text "${repo_root}/device.mk" 'lib_imx_c2_v4l2_dec'
require_text "${repo_root}/device.mk" 'lib_imx_c2_v4l2_enc'

# Allocator service packages install their own VINTF fragments.  Repeating the
# AIDL allocator in the common device manifest makes libvintf reject the whole
# device manifest and causes keystore2 to abort before boot completion.
python3 - "${repo_root}/manifest.xml" <<'PY'
import sys
import xml.etree.ElementTree as ET

manifest = ET.parse(sys.argv[1]).getroot()
aidl_allocator = [
    hal for hal in manifest.findall("hal")
    if hal.get("format") == "aidl"
    and hal.findtext("name") == "android.hardware.graphics.allocator"
]
if aidl_allocator:
    raise SystemExit(
        "common manifest must not duplicate allocator service AIDL VINTF fragments"
    )
PY

if grep -R -Fq 'AESL_IMX8MM_GPU' \
    "${repo_root}/BoardConfig.mk" \
    "${repo_root}/device.mk" \
    "${repo_root}/products" \
    "${repo_root}/waydroid_aesl_2gb_arm64_only" \
    "${repo_root}/waydroid_aesl_imx95_arm64_only"; then
    echo "legacy SoC boolean remains in shared product configuration" >&2
    exit 1
fi

echo "AESL Android 16 board product contracts: static validation passed"
