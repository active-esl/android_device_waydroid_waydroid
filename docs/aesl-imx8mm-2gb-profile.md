# AESL i.MX8MM 2 GB Waydroid profile

Build target:

```text
lineage_waydroid_aesl_2gb_arm64_only-userdebug
```

Production target:

```text
lineage_waydroid_aesl_2gb_arm64_only-user
```

The profile is 64-bit-only and Vanilla. It enables Android's low-RAM mode and
PSI-based `lmkd`, uses the AOSP 2 GB Dalvik parameters, pre-optimises resident
UI applications, disables background blur, and removes non-kiosk applications.

The host must provide `CONFIG_MEMCG`, `CONFIG_PSI`, `CONFIG_SWAP` and
`CONFIG_ZRAM`. Linux 6.6 integrates swap accounting with `CONFIG_MEMCG` and no
longer exposes the older `CONFIG_MEMCG_SWAP` option. Runtime acceptance
requires measurements on the shipping kernel and display configuration;
configuration alone is not evidence that the workload fits.

Release thresholds under the intended kiosk workload:

- green: Android cgroup peak below 70% of its limit and host available memory
  remains above 30%;
- amber: either reaches 70%;
- red: either reaches 85%, or the kernel OOM killer is invoked.

The AESL vendor branch removes the upstream `SELINUX_IGNORE_NEVERALLOWS`
bypass. SELinux neverallow violations are therefore blocking build failures for
both development and production targets. A successful build is required
evidence; this statement alone is not a production-security attestation.

## Acceleration contract

The i.MX8MM target deliberately exposes OpenGL ES 3.1 through Mesa Etnaviv and
the Mesa GBM minigbm allocator. It does not advertise Vulkan, ANGLE, Lavapipe,
VirGL or another software/virtual fallback. The host runtime must pass through
only the selected Etnaviv render node, the explicitly configured DMA heaps and
the VSI decoder node. The Android image registers only
`c2.v4l2.avc.decoder`, limited to one concurrent 1080p stream.

On the shipping board, run `/usr/libexec/waydroid-acceleration-check` after a
cold start, a container restart and a suspend/resume cycle. Preserve all three
reports with the release evidence. Each run must prove the Etnaviv/GC7000
renderer, absence of Vulkan exposure, exact device mounts and Codec2 hardware
decoder registration.

Run `/usr/libexec/waydroid-memory-headroom` during the intended kiosk workload
and preserve the idle, steady-state and peak reports. Tune CMA, the Android
cgroup, zram, CPU policy or frame rate only from those measurements, then rerun
the same workload against the release thresholds above.
