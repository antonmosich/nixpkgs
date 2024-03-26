import ./make-test-python.nix ({ pkgs, lib, ... }: {
  name = "ffmpegfs-test";
  nodes.machine = { config, pkgs, ... }: {
    environment.systemPackages = [ pkgs.tree ];
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
      # mountConfig = {
      #   Environment = "PATH='${lib.makeBinPath [ pkgs.ffmpegfs ]}'";
      # };
      # after = [ "systemd-tmpfiles-setup.service" ];
    }];
  };
  testScript = ''
    machine.wait_until_succeeds("mountpoint /media/MP3")
    machine.succeed("cat /etc/fstab >&2")
    machine.succeed("ls -la /media/MP3 >&2")
    machine.succeed("file /media/MP3/testfile.mp3 >&2")
    machine.shell_interact()
  '';
})
