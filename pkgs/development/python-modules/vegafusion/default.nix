{ lib
, buildPythonPackage
, fetchFromGitHub
, vegafusion-embed
, setuptools
, setuptools-scm
, pytestCheckHook
, pandas
, psutil
, pyarrow
, protobuf
, altair
, duckdb
, polars
, vl-convert-python
, vega_datasets
, scikit-image
}:
buildPythonPackage {
  pname = "vegafusion";
  version = "1.5.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "hex-inc";
    repo = "vegafusion";
    rev = "v1.5.1";
    hash = "sha256-ZpFF2AjSHJGxTwsM7tl5YP8xF/RGPWm8+nVMoz/U4Ds=";
  };

  sourceRoot = "source/python/vegafusion";

  patchPhase = ''
    substituteInPlace pyproject.toml \
      --replace "setuptools_scm >= 2.0.0, <3" "setuptools_scm >= 2.0.0"
  '';

  propagatedBuildInputs = [
    vegafusion-embed
    setuptools
    setuptools-scm
    protobuf
    # Needed for pythonImportsCheck
    pandas
    psutil
    pyarrow
    altair
  ];

  doCheck = false;

  pythonImportsCheck = [
    "vegafusion"
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pandas
    psutil
    pyarrow
    protobuf
    altair
    duckdb
    polars
    vl-convert-python
    vega_datasets
    scikit-image
  ];
}
