# AESL Android 16 board support matrix

Updated: 2026-09-11

This file is the device-tree view of the maintained board contracts. Release,
support-period and CRA evidence ownership lives in the product-manifest repo.

| Board family | Product | Memory policy | GPU contract | Media contract | Status |
| --- | --- | --- | --- | --- | --- |
| i.MX8MM custom 2 GB | `lineage_waydroid_aesl_2gb_arm64_only` | low-RAM, PSI/lmkd, 64-bit only | Mesa Etnaviv; no Vulkan fallback | Android V4L2 Codec2, H.264 decode | Integration build available; board acceptance required |
| i.MX95 / FRDM i.MX95 | `lineage_waydroid_aesl_imx95_arm64_only` | board allocation to be measured | NXP Mali Bionic userspace matched to host kbase ABI | NXP i.MX Codec2 through Wave6 V4L2; match the host VPU driver and firmware | Target scaffolded; GPU input fails closed until the reviewed overlay is staged; video runtime acceptance pending |

The R16 Waydroid products select flattened APEX and raw ext4 `system.img`
output (`TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true`). The controlled
manifest's [R16 2 GB run 35076252596](https://github.com/active-esl/waydroid-product-manifest/actions/runs/35076252596)
built the i.MX8MM pair from device commit
[`e9d3eda`](https://github.com/active-esl/android_device_waydroid_waydroid/commit/e9d3eda4e658e37c9c116ae3dccb55e7728c18a5).
Its `system.img` SHA-256 is
`b2bca3abd5993ad88cb032aa99d0eff2246b2ad8754df1ed6c2bae86e2a68b17`;
the manifest's image gate checked raw ext4 geometry and content. The current
device revision additionally restores the explicit flattened-APEX fallback
and needs its own Android build evidence. Physical-board acceptance is pending.

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
