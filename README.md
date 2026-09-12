Device configuration for waydroid images
==================================

Repository role
---------------

This repository is the Android **device and product-definition layer** for the
AESL Waydroid platform. Its Android-standard name follows
`android_device_<vendor>_<device>`; the repeated `waydroid` is intentional.

It owns product inheritance, architecture selection, Android resource policy,
low-memory profiles and the declarations that distinguish supported board
targets. It does not own the complete Android source lock, generic Waydroid
vendor patches, or NXP kernel, bootloader and firmware integration.

The complete source graph, CI release gates and release evidence are controlled
by [`active-esl/waydroid-product-manifest`](https://github.com/active-esl/waydroid-product-manifest).
Generic Waydroid vendor integration is maintained in
[`active-esl/android_vendor_waydroid`](https://github.com/active-esl/android_vendor_waydroid).
Board-side Linux and proprietary-component handling remain in the Dynamic
Devices BSP and Yocto repositories.

AESL board products inherit shared ARM64 policy from `products/` and declare
their hardware stack explicitly. The maintained targets are documented in
`docs/board-support-matrix.md`; a successful build is not hardware acceptance.

The maintained AESL Android 16 integration line is `lineage-23.2-aesl`.
Version and board names belong to branches and product targets rather than the
repository name. A branch or build does not itself establish a support-period
or CRA-conformity claim; that requires an approved release record and the
evidence controlled by the product-manifest repository.
