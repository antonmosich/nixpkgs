{ rustPlatform
, fetchFromGitHub
, linux-pam
}:

rustPlatform.buildRustPackage rec {
  pname = "lemurs";
  version = "2023-07-29";

  src = fetchFromGitHub {
    owner = "coastalwhite";
    repo = "lemurs";
    rev = "d8fe49931798dd054d79e17f9fb3371168d800ca";
    sha256  = "sha256-9yK9cIqX4Tl+9JRGfRgdMZO5JkDKeTU2VAWbOK/8f3c=";
  };

  buildInputs = [ linux-pam ];

  cargoHash = "sha256-01ATkkWj+uGQ4WiRs6me1o6Rl/a/yq7QG8Lh1EY2xAk=";

  meta = {
    description = "A customizable TUI display/login manager written in Rust";
    homepage = "https://github.com/coastalwhite/lemurs";
    changelog = "https://github.com/coastalwhite/lemurs/releases";
    license = with lib.licenses; [ mit asl20 ];
    maintainers = with lib.maintainers; [ antonmosich ];
  };
}
