# Copyright (C) 2026 Active ESL
# SPDX-License-Identifier: Apache-2.0

# The 2 GB profile applies only where Linux, graphics and Android share 2 GB.
AESL_WAYDROID_2GB := true

# Select Android's current PSI-based low-memory behaviour. Do not use the
# legacy minfree strategy from the generic Waydroid profile.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.low_ram=true

WITH_DEXPREOPT := true
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI \
    Trebuchet \
    TrebuchetQuickStep

# Remove non-kiosk applications and radios that otherwise retain background
# processes. Trebuchet remains until the AESL kiosk controller is ported.
PRODUCT_PACKAGES += AESL2GBRemovePackages

