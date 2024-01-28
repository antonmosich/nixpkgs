import ./make-test-python.nix ({ pkgs, ... }: {
  name = "ffmpegfs-test";
  nodes.machine = { config, pkgs, ... }: {
    system.fsPackages = [ pkgs.ffmpegfs ];
      virtualisation.fileSystems."ffmpegfs-MP3" = {
      fsType = "fuse.ffmpegfs";
      device = "path1";
      mountPoint = "/mnt/MP3";
      options = [ "audiobitrate=320K" "desttype=mp3" "ro" "allow_other" ];
      noCheck = true;
    };
  };
  testScript = ''
    machine.wait_until_succeeds("mountpoint -q /mnt/MP3")
  '';
})
