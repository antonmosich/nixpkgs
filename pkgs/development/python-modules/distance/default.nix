{ lib
, fetchPypi
, buildPythonPackage
, setuptools
}:

buildPythonPackage rec {
  pname = "distance";
  version = "0.1.3";
  pyproject = true;

  src = fetchPypi {
    pname = "Distance";
    inherit version;
    hash = "sha256-YIB1hPW2AD9cUhqnPzn1H2Md475czMWh1nFm/L8NRVE=";
  };

  build-system = [ setuptools ];
}
