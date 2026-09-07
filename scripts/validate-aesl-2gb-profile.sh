#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
products="${repo_root}/AndroidProducts.mk"
product="${repo_root}/waydroid_aesl_2gb_arm64_only/lineage_waydroid_aesl_2gb_arm64_only.mk"
properties="${repo_root}/configs/system-2gb.prop"
board="${repo_root}/waydroid_aesl_2gb_arm64_only/BoardConfig.mk"
android_mk="${repo_root}/Android.mk"

require_text() {
    local file="$1" text="$2"
    grep -Fq -- "${text}" "${file}" || {
        echo "missing required setting in ${file}: ${text}" >&2
        exit 1
    }
}

require_text "${products}" '$(VENDOR_NAME)_waydroid_aesl_2gb_arm64_only-user'
require_text "${products}" '$(VENDOR_NAME)_waydroid_aesl_2gb_arm64_only-userdebug'
require_text "${product}" 'ANDROID_USE_GAPPS := false'
require_text "${product}" 'ANDROID_USE_WIDEVINE := false'
require_text "${product}" 'ANDROID_USE_NDK_TRANSLATION := false'
require_text "${product}" 'ro.config.low_ram=true'
require_text "${board}" 'waydroid_arm64_only/BoardConfig.mk'
require_text "${android_mk}" 'waydroid_aesl_2gb_arm64_only'
require_text "${properties}" 'ro.lmk.use_psi=true'
require_text "${properties}" 'ro.lmk.use_minfree_levels=false'
require_text "${properties}" 'ro.surface_flinger.supports_background_blur=0'

if grep -Fq 'persist.sys.disable_rescue=true' "${properties}"; then
    echo "2 GB profile must not disable Android RescueParty" >&2
    exit 1
fi

echo "AESL Android 16 i.MX8MM 2 GB profile: static validation passed"
