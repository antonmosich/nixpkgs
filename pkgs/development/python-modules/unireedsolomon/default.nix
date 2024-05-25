{ lib
, fetchPypi
, buildPythonPackage
, reedsolo2
}:

buildPythonPackage rec {
  pname = "unireedsolomon";
  version = "1.0.6";

  src = fetchPypi {
    inherit version pname;
    hash = "sha256-nJ8jGO+4U7bhU1t1fi9PIyRGx8X3FV6z+WfvY3Qct0g=";
  };

  dependencies = [ reedsolo2 ];
}
