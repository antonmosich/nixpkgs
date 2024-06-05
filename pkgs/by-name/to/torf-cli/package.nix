{ python3
, fetchPypi
, lib}:
python3.pkgs.buildPythonApplication rec {
  pname = "torf-cli";
  version = "5.2.0";
  pyproject = true;
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-NanVtg1H9smoNi0/q/wzJveqVCKdc0km7juRZ+jDTog=";
  };

  build-system = with python3.pkgs; [
    setuptools
  ];

  dependencies = with python3.pkgs; [
    torf
    pyxdg
  ];
}
