{
  config,
  pkgs,
  ...
}:
{
  imports = [ ../reused-strings.nix ];

  home-manager.users.solarfire.programs.btop = {
    enable = true;

    settings = {
      color_theme = "${pkgs.btop}/share/btop/themes/tokyo-night.theme";
      shown_boxes = "mem proc gpu0 cpu";
      update_ms = 100;

      proc_sorting = "memory";
      proc_per_core = true;
      proc_cpu_graphs = false;
      proc_filter_kernel = true;

      custom_cpu_name = config.hardwareInfo.cpuName;

      swap_disk = false;
      disks_filter = "exclude=/nix";

      nvmi_measure_pcie_speeds = true;
      custom_gpu_name0 = builtins.elemAt config.hardwareInfo.gpuNames 1;
      custom_gpu_name1 = builtins.elemAt config.hardwareInfo.gpuNames 0;
    };
  };
}
