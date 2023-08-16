{ lib
, buildPythonPackage
, fetchPypi
, pkgs
, python
}:

buildPythonPackage rec {
  pname = "berkeleydb";
  version = "18.1.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-bUEt0aW3Aq7to8v6ENM5mxaoBNAW3ghyNPhXn8phPsk=";
  };

  buildInputs = [ pkgs.db ];

  checkPhase = ''
    ${python.interpreter} test.py
  '';

  # Path to database need to be set.
  # Somehow the setup.py flag is not propagated.
  # setupPyBuildFlags = [ "--berkeley-db=${pkgs.db}" ];
  # We can also use a variable
  preConfigure = ''
    export BERKELEYDB_DIR=${pkgs.db.dev};
  '';

  meta = {
    description = "Python bindings for Oracle Berkeley DB";
    homepage = "https://www.jcea.es/programacion/pybsddb.htm";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ antonmosich ];
  };

}
