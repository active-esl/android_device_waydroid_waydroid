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

The generic upstream `SELINUX_IGNORE_NEVERALLOWS` setting remains a blocking
production-security issue. This profile does not weaken it further and must not
be described as production-ready until it is removed and policy violations are
resolved.
