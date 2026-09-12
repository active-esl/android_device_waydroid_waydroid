# Framework 2 GB validation product

`lineage_waydroid_aesl_2gb_x86_64-userdebug` applies the same
`products/aesl_2gb_kiosk.mk` policy and `configs/system-2gb.prop` settings as
the i.MX8MM product while retaining the Framework laptop's native x86_64 and
Mesa graphics stack.

This product validates Android behaviour under memory pressure; it does not
replace testing the ARM64 i.MX8MM image on its real GPU, VPU, kernel and board.
Run its Waydroid container with a 2 GiB cgroup memory limit and verify:

- `ro.config.low_ram=true`;
- `ro.active_esl.memory_profile=2gb`;
- `ro.product.cpu.abi=x86_64`;
- the container cgroup `memory.max` is `2147483648`;
- UI, graphics and memory-pressure acceptance tests pass without software
  rendering fallback.
