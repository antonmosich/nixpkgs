{ lib
, fetchFromGitHub
, rustPlatform
, testers
, clink
}:
rustPlatform.buildRustPackage rec {
  pname = "clink";
  version = "0.7.0";
  src = fetchFromGitHub {
    owner = "Lurk";
    repo = "clink";
    rev = version;
    hash = "sha256-xRrhmKhxOd50pH7xw6aBTVuABGBLsAemLlY25zfBjyQ=";
  };
  cargoHash = "sha256-Ln2OFl3LyTdSFxt0LpYXf5XPZX0cVg5bvllMhNHzs5Y=";

  meta = {
    description = "URL cleaner for URLs copied to the clipboard";
    homepage = "https://github.com/Lurk/clink";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ antonmosich ];
    mainProgram = "clink";
  };
}
