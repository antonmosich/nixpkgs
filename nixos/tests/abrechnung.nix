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
            };
            database = {
              dbname = "abrechnung";
            };
            service = {
              name = "Test";
            };
          };
        };
      };
    };

    testScript = ''
      start_all()
      server.wait_for_unit("abrechnung-api.service")
      server.wait_for_open_port(8080)
      server.succeed("curl --fail http://localhost:8080")
    '';
  }
)
