import ./make-test-python.nix ({ pkgs, lib, ... }: {
  name = "ffmpegfs-test";
  nodes.machine = { config, pkgs, ... }: {
    # environment.systemPackages = [ pkgs.ffmpegfs ];
    system.fsPackages = [ pkgs.ffmpegfs ];
    # virtualisation.fileSystems."ffmpegfs-MP3" = {
    #   fsType = "fuse.ffmpegfs";
    #   device = "path1";
    #   mountPoint = "/mnt/MP3";
    #   options = [ "audiobitrate=320K" "desttype=mp3" "ro" "allow_other" ];
    #   noCheck = true;
    # };
    environment.etc."media/testfile.flac".source = pkgs.fetchurl {
      url = "https://filesamples.com/samples/audio/flac/sample1.flac";
      hash = "sha256-KGXHDAY3rE6snlnBAquHhS65iN+09MCnIVMTTeh2j3o=";
    };
    systemd.tmpfiles.rules = [
      "d /media/ 1777 root root 0"
    ];
    systemd.mounts = [{
      type = "fuse.ffmpegfs";
      options = lib.strings.concatStringsSep "," [ "audiobitrate=320K" "desttype=mp3" "ro" "allow_other" ];
      wantedBy = [ "default.target" ];
      where = "/media/MP3";
      what = "/etc/media";
      # after = [ "systemd-tmpfiles-setup.service" ];
    }];
  };
  testScript = ''
    machine.wait_until_succeeds("mountpoint -q /media/MP3")
    machine.succeed("ls /media/")
    machine.shell_interact()
  '';
})
