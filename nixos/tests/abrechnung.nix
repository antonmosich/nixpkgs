import ./make-test-python.nix (
  { pkgs, ... }:

  {
    name = "abrechnung";

    nodes = {
      server = {
        services.postgresql = {
          enable = true;
        };
        services.abrechnung = {
          enable = true;
          settings = {
            email = {
              address = "test@example.com";
              host = "";
              port = 1234;
            };
            api = {
              secret_key = "";
              base_url = "";
              host = "";
              port = 1337;
              id = "default";
            };
            registration = {
              enabled = true;
              require_email_confirmation = false;
            };
            database = {
              user = "abrechnung";
              dbname = "abrechnung";
            };
            service = {
              name = "Test";
            };
          };
        };
      };
    };

    interactive.nodes.server = {
      networking.firewall.enable = false;
      virtualisation.forwardPorts = [
        {
          from = "host";
          host.port = 8080;
          guest.port = 80;
        }
      ];
    };

    testScript = ''
      start_all()
      server.wait_for_unit("abrechnung-api.service")
      server.wait_for_open_port(1337)
      server.succeed("curl --fail http://localhost")
    '';
  }
)
