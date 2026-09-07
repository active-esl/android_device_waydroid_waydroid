#
# Copyright (C) 2021 The Waydroid Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BOARD_VENDOR := waydroid

DEVICE_PATH := device/waydroid/waydroid

# APEX
TARGET_FLATTEN_APEX := true

# Platform
TARGET_BOARD_PLATFORM := waydroid

# Kernel
TARGET_NO_KERNEL := true

# Audio
USE_XML_AUDIO_POLICY_CONF := 1

# Bootloader
TARGET_NO_BOOTLOADER := true

# Display
TARGET_USES_HWC2 := true
ifneq ($(TARGET_USE_MESA),false)
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_MESON_ARGS := -Dallow-kcmp=enabled -Dmesa-clc=system -Dprecomp-compiler=system
BOARD_MESA3D_BUILD_LIBGBM := true
ifeq ($(AESL_IMX8MM_GPU),true)
# The i.MX8MM GC7000Lite has a Mesa Etnaviv OpenGL ES path but no supported
# Vulkan driver. Keep this product exact: no llvmpipe or software Vulkan
# fallback may make an unaccelerated image appear healthy.
BOARD_MESA3D_GALLIUM_DRIVERS := etnaviv
BOARD_MESA3D_VULKAN_DRIVERS :=
BOARD_MESA3D_GALLIUM_VA := disabled
BOARD_MESA3D_VIDEO_CODECS := all
else
BOARD_MESA3D_GALLIUM_DRIVERS := llvmpipe svga virgl radeonsi zink
BOARD_MESA3D_VULKAN_DRIVERS := swrast virtio amd
endif
endif

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true

# WiFi
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION := VER_0_8_X
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_FEATURE_AWARE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/manifest_framework.xml

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
ifeq ($(AESL_WAYDROID_2GB),true)
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/configs/system-2gb.prop
else
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
endif

# Partitions
TARGET_COPY_OUT_VENDOR := vendor
BOARD_BUILD_GKI_BOOT_IMAGE_WITHOUT_RAMDISK := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USES_METADATA_PARTITION := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

# Offending entries:
# /system/etc/libnfc-nci.conf
BUILD_BROKEN_DUP_RULES := true

BUILD_BROKEN_VINTF_PRODUCT_COPY_FILES := true
BUILD_BROKEN_PLUGIN_VALIDATION := soong-llvm18 soong-llvm21 soong-llvm22
