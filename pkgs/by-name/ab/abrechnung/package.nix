{
  fetchFromGitHub,
  python3,
  callPackage,
}:
let
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "SFTtech";
    repo = "abrechnung";
    tag = "v${version}";
    hash = "sha256-dQKBOSDfMcwFnxb666G2xgv7iNXBLTPYZqUezhXZLG0=";
  };
  frontend = callPackage (import ./frontend.nix src version) { };
in
python3.pkgs.buildPythonApplication rec {
  inherit version src;
  pname = "abrechnung";

  pyproject = true;

  build-system = [ python3.pkgs.setuptools ];

  dependencies = with python3.pkgs; [
    pythonRelaxDepsHook
    frontend

    pyyaml
    websockets
    passlib
    pydantic
    python-jose
    python-multipart
    pydantic-settings
    sftkit
  ];

  pythonRelaxDeps = [
    "pydantic-settings"
    "websockets"
  ];
}
