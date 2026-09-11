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
require_text "${imx95}" 'AESL_MEDIA_STACK := nxp-hantro'
require_text "${imx95}" 'AESL_NXP_ANDROID_RELEASE := android-16.0.0_2.0.0'
require_text "${imx95}" 'missing device/nxp/imx9/gpu/gpu_mali.mk'
require_text "${imx95}" 'missing gpu-mali'
require_text "${imx95}" 'missing wsialloc'
require_text "${imx95}" 'missing imx-vpu-hantro'
require_text "${imx95}" 'missing imx_android_mm'
require_text "${imx95_board}" 'TARGET_USE_MESA := false'
require_text "${repo_root}/device.mk" 'android.hardware.media.c2.service.imx'
require_text "${repo_root}/device.mk" 'c2_component_register_95'

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
