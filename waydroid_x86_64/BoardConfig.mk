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

-include device/waydroid/waydroid/BoardConfig.mk

# Architecture
TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64

TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86_64

# Native bridge architecture
TARGET_NATIVE_BRIDGE_ABI := arm64-v8a
TARGET_NATIVE_BRIDGE_ARCH := arm64
TARGET_NATIVE_BRIDGE_ARCH_VARIANT := armv8-a
TARGET_NATIVE_BRIDGE_CPU_VARIANT := generic

# Fingerprint spoof for GApps
BUILD_FINGERPRINT := google/tangorpro/tangorpro:16/BP4A.260205.001/14624666:user/release-keys

ifneq ($(TARGET_USE_MESA),false)
BOARD_MESA3D_GALLIUM_DRIVERS += i915 iris crocus
# Framework systems use Intel or AMD graphics. Do not enable Nouveau here:
# Mesa's NVK path requires extra Rust build tooling and does not serve this lane.
BOARD_MESA3D_VULKAN_DRIVERS += intel intel_hasvk
BOARD_MESA3D_GALLIUM_VA := enabled
BOARD_MESA3D_VIDEO_CODECS := all
endif
