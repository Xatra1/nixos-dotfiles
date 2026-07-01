{
  fileSystems = {
    "/".options = [ "compress=zstd:3" ];

    "/home" = {
      device = "/dev/disk/by-uuid/5f96abe4-3d47-4e88-a237-77988b131879";
      fsType = "btrfs";
      options = [ "compress=zstd:3" ];
    };

    "/media" = {
      device = "/dev/disk/by-uuid/131a45e1-79c7-4a9b-a426-d04d8bea0a39";
      fsType = "btrfs";
    };

    "/media/jellyfin-data" = {
      device = "/dev/disk/by-uuid/9f10f71c-40bc-4b7a-bc77-46e6b44fee28";
      fsType = "btrfs";
      options = [ "compress=zstd:3" ];
    };

    "/media/backup-data" = {
      device = "/dev/disk/by-uuid/dec78277-1b28-40cc-8dd1-56db72db9e4b";
      fsType = "btrfs";
      options = [ "compress=zstd:3" ];
    };
  };
}
