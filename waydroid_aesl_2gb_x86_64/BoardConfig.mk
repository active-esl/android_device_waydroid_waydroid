# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

# Framework compatibility target for exercising the same Android memory
# profile as the 2 GB i.MX8MM product. Architecture and graphics remain x86.
AESL_WAYDROID_2GB := true
AESL_MEMORY_PROFILE := 2gb

include device/waydroid/waydroid/waydroid_x86_64/BoardConfig.mk
