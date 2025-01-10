{
  fetchFromGitHub,
  python3,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "abrechnung";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "SFTtech";
    repo = "abrechnung";
    tag = "v${version}";
    hash = "sha256-dQKBOSDfMcwFnxb666G2xgv7iNXBLTPYZqUezhXZLG0=";
  };

  pyproject = true;

  build-system = [ python3.pkgs.setuptools ];

  dependencies = with python3.pkgs; [
    pythonRelaxDepsHook

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
