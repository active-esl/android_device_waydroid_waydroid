# AESL Android 16 board support matrix

Updated: 2026-09-11

This file is the device-tree view of the maintained board contracts. Release,
support-period and CRA evidence ownership lives in the product-manifest repo.

| Board family | Product | Memory policy | GPU contract | Media contract | Status |
| --- | --- | --- | --- | --- | --- |
| i.MX8MM custom 2 GB | `lineage_waydroid_aesl_2gb_arm64_only` | low-RAM, PSI/lmkd, 64-bit only | Mesa Etnaviv; no Vulkan fallback | Android V4L2 Codec2, H.264 decode | Integration build available; board acceptance required |
| i.MX95 / FRDM i.MX95 | `lineage_waydroid_aesl_imx95_arm64_only` | board allocation to be measured | NXP Mali Bionic userspace matched to host kbase ABI | NXP i.MX Codec2/Hantro, pending integration | Target scaffolded; intentionally fails closed until the reviewed NXP overlay is staged |

## Adding a custom board

1. Add a thin product directory declaring `AESL_BOARD_FAMILY`,
   `AESL_MEMORY_PROFILE`, `AESL_GPU_STACK` and `AESL_MEDIA_STACK`.
2. Inherit `products/aesl_arm64_common.mk`; add a separate memory profile only
   when measurements justify it.
3. Pin every BSP/vendor input in the immutable source lock. Never reuse another
   SoC's `vendor.img` merely because both boards are ARM64.
4. Add CI build, boot, GPU, video, memory, suspend/resume and rollback evidence
   gates before changing the status to supported.
5. Record the product's market lifetime and support end date. Five years is a
   floor, not a universal ceiling for longer-lived industrial products.

The i.MX95 candidate is pinned to NXP `android-16.0.0_2.0.0`. NXP also exposes
a Mesa/Panthor option in that release, but the current LmP host contract is the
NXP Mali kbase stack. Changing that contract is a coordinated host-kernel and
Android-vendor migration, not a product makefile toggle.
