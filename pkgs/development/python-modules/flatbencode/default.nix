{ python3,
  lib,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "flatbencode";
  version = "0.2.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-dzl9XQEIg1QE9vfK1kDUA8cCWhGBKvx+HfSw+SWJunc=";
  };

  build-system = [ python3.pkgs.setuptools ];
}
