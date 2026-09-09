#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
products="${repo_root}/AndroidProducts.mk"
product="${repo_root}/waydroid_aesl_2gb_arm64_only/lineage_waydroid_aesl_2gb_arm64_only.mk"
properties="${repo_root}/configs/system-2gb.prop"
media_codecs="${repo_root}/configs/media_codecs_c2_imx8mm.xml"
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
require_text "${product}" 'AESL_IMX8MM_GPU := true'
require_text "${board}" 'waydroid_arm64_only/BoardConfig.mk'
require_text "${board}" 'AESL_IMX8MM_GPU := true'
require_text "${android_mk}" 'waydroid_aesl_2gb_arm64_only'
require_text "${repo_root}/BoardConfig.mk" 'BOARD_MESA3D_GALLIUM_DRIVERS := etnaviv'
require_text "${repo_root}/BoardConfig.mk" 'BOARD_MESA3D_VULKAN_DRIVERS :='
require_text "${properties}" 'ro.hardware.egl=mesa'
require_text "${properties}" 'ro.hardware.gralloc=minigbm_gbm_mesa'
require_text "${properties}" 'ro.hardware.hwcomposer=waydroid'
require_text "${properties}" 'ro.opengles.version=196609'
require_text "${repo_root}/device.mk" 'android.hardware.media.c2-service-v4l2'
require_text "${repo_root}/device.mk" 'android.hardware.camera.provider-V1-external-service'
require_text "${repo_root}/manifest.xml" '<hal format="aidl">'
require_text "${repo_root}/manifest.xml" '<name>android.hardware.graphics.allocator</name>'
require_text "${repo_root}/manifest.xml" '<name>IAllocator</name>'
require_text "${repo_root}/device.mk" 'android.hardware.graphics.allocator-service.minigbm_gbm_mesa'
require_text "${repo_root}/device.mk" 'mapper.minigbm_gbm_mesa'
require_text "${repo_root}/manifest.xml" '<fqname>ICameraProvider/external/0</fqname>'
require_text "${repo_root}/device.mk" 'ro.vendor.v4l2_codec2.decoder.supported.h264=true'
require_text "${repo_root}/device.mk" 'ro.vendor.v4l2_codec2.decode_concurrent_instances=1'
require_text "${media_codecs}" 'c2.v4l2.avc.decoder'
require_text "${media_codecs}" 'performance-point-1920x1080'
require_text "${properties}" 'ro.lmk.use_psi=true'
require_text "${properties}" 'ro.lmk.use_minfree_levels=false'
require_text "${properties}" 'ro.surface_flinger.supports_background_blur=0'

if grep -Fq 'persist.sys.disable_rescue=true' "${properties}"; then
    echo "2 GB profile must not disable Android RescueParty" >&2
    exit 1
fi

if grep -Fq 'android.hardware.camera.provider@2.7-external-service' "${repo_root}/device.mk"; then
    echo "obsolete HIDL external-camera provider must not be packaged" >&2
    exit 1
fi

# Evaluate the AESL GPU conditional while treating unrelated product
# conditionals conservatively. None of these fallback packages or feature
# declarations may remain active for this product.
awk '
BEGIN { depth = 0; active[0] = 1 }
/^ifeq \(\$\(AESL_IMX8MM_GPU\),true\)$/ {
    depth++; known[depth] = 1; condition[depth] = 1
    active[depth] = active[depth - 1] && condition[depth]; next
}
/^ifneq \(\$\(AESL_IMX8MM_GPU\),true\)$/ {
    depth++; known[depth] = 1; condition[depth] = 0
    active[depth] = active[depth - 1] && condition[depth]; next
}
/^ifn?eq / {
    depth++; known[depth] = 0; condition[depth] = 1
    active[depth] = active[depth - 1]; next
}
/^else$/ {
    if (known[depth]) condition[depth] = !condition[depth]
    active[depth] = active[depth - 1] && condition[depth]; next
}
/^endif$/ {
    delete active[depth]; delete known[depth]; delete condition[depth]
    depth--; next
}
active[depth] && /vulkan\.|android\.hardware\.opengles\.aep|lib(EGL|GLESv1_CM|GLESv2)_angle|gralloc\.minigbm_dmabuf|android\.hardware\.graphics\.(allocator|mapper).*minigbm_dmabuf/ {
    print "forbidden i.MX8MM fallback remains active: " $0 > "/dev/stderr"
    failed = 1
}
END { exit failed }
' "${repo_root}/device.mk"

echo "AESL Android 16 i.MX8MM 2 GB profile: static validation passed"
