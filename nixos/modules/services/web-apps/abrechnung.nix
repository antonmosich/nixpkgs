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

    hostname = lib.mkOption {
      type = lib.types.str;
      default = "localhost";
      description = "";
    };

    settings = lib.mkOption {
      type = yaml.type;
      default = { };
      description = "";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.abrechnung = {
      group = "abrechnung";
      isSystemUser = true;
    };
    users.groups.abrechnung = { };
    systemd.services = {
      abrechnung-api = {
        description = "Abrechnung API Service";
        after = [ "postgresql.service" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          # DynamicUser = true;
          ExecStart = "${lib.getExe pkg} --config-path ${configFile} api";
          ExecStartPre = "${lib.getExe pkg} --config-path ${configFile} db migrate";
          User = "abrechnung";
          Group = "abrechnung";
        };
      };
    };

    services.nginx.enable = true;
    services.nginx.upstreams.abrechnungApi.servers."localhost:${toString cfg.settings.api.port}" = { };
    services.nginx.virtualHosts."${cfg.hostname}" = {
      default = true;
      root = pkg.frontend;
      locations."/api" = {
        proxyPass = "http://abrechnungApi";
        recommendedProxySettings = true;
      };
    };

    services.postgresql = lib.mkIf (cfg.settings.database.host or "localhost" == "localhost") {
      ensureUsers = lib.singleton {
        name = cfg.settings.database.user;
        ensureDBOwnership = true;
      };
      ensureDatabases = lib.singleton cfg.settings.database.dbname;
    };
  };
}
