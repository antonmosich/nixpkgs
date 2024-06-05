{ python3,
  lib,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "torf";
  version = "4.2.6";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-dWOnfPiEicdvcKL+FvIH1VS1PJhNQaIQ+dswFicNMtQ=";
  };

  build-system = [ python3.pkgs.setuptools ];

  dependencies = with python3.pkgs; [
    flatbencode
  ];
}
