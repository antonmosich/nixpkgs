{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  cython,
  setuptools,

  # tests
  pytestCheckHook,
  pytest-cov,
}:

buildPythonPackage rec {
  pname = "reedsolo";
  version = "2.1.1b1";
  format = "pyproject";

  # Pypi does not have the tests
  src = fetchFromGitHub {
    owner = "tomerfiliba";
    repo = "reedsolomon";
    rev = "refs/tags/v${version}";
    hash = "sha256-+TV1wbbZsEc/sNjqIyYRW1+YxPtFxGvhQCVYh2JSHC8=";
  };

  nativeBuildInputs = [
    cython
    setuptools
  ];

  nativeCheckInputs = [ pytestCheckHook pytest-cov ];

  disabledTestPaths = [
    "tests/test_creedsolo.py" # TODO: package creedsolo
  ];

  meta = with lib; {
    description = "Pure-python universal errors-and-erasures Reed-Solomon Codec";
    homepage = "https://github.com/tomerfiliba/reedsolomon";
    license = licenses.publicDomain;
    maintainers = with maintainers; [ yorickvp ];
  };
}
