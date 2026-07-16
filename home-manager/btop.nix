{ pkgs, ... }:
{
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

      custom_cpu_name = "Intel Core i7-11700";

      swap_disk = false;

      nvmi_measure_pcie_speeds = true;
      custom_gpu_name0 = "NVIDIA GeForce RTX 3050";
      custom_gpu_name1 = "Intel Graphics UHD 750";
    };
  };
}
