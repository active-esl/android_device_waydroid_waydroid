# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

# Set before including the shared configuration so it selects the dedicated
# system property file rather than the upstream 4 GB profile.
AESL_WAYDROID_2GB := true

include device/waydroid/waydroid/waydroid_arm64_only/BoardConfig.mk
