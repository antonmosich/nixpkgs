{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.abrechnung;
  pkg = cfg.package;
  yaml = pkgs.formats.yaml { };
  configFile = yaml.generate "abrechnung.yaml" cfg.settings;
in
{
  options.services.abrechnung = {
    enable = lib.mkEnableOption "Abrechnung";

    package = lib.mkPackageOption pkgs "abrechnung" { };

    settings = lib.mkOption {
      type = yaml.type;
      default = { };
      description = "";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services = {
      abrechnung-api = {
        description = "Abrechnung API Service";
        after = [ "postgresql.service" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          DynamicUser = true;
          ExecStart = "${lib.getExe pkg} --config-path ${configFile} api";
          User = "abrechnung";
          Group = "abrechnung";
        };
      };
    };
  };
}
