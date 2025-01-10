{
  fetchPypi,
  buildPythonPackage,
  pdm-backend,
  fastapi,
  typer,
  uvicorn,
  asyncpg,
  pydantic,
  pythonRelaxDepsHook,
}:

buildPythonPackage rec {
  pname = "sftkit";
  version = "0.3.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-fzFnSi237Er3aIh67HwBqKq7U7UOwBtLBd0tx73RLTo=";
  };

  build-system = [ pdm-backend ];

  dependencies = [
    fastapi
    typer
    uvicorn
    asyncpg
    pydantic

    pythonRelaxDepsHook
  ] ++ pydantic.optional-dependencies.email;
  pythonRelaxDeps = [
    "typer"
    "uvicorn"
    "pydantic"
  ];
}
