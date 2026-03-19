{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  uv-build,
  fastapi,
  typer,
  uvicorn,
  asyncpg,
  pydantic,
}:

buildPythonPackage (finalAttrs: {
  pname = "sftkit";
  version = "0.4.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "SFTtech";
    repo = "sftkit";
    tag = "sftkit-${finalAttrs.version}";
    hash = "sha256-Qo/TLBqVJM4E/ZuQLDtfNNe7aJexPN+1+YZ1p+xYuSA=";
    rootDir = "sftkit";
  };

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail ",<0.10.0" ""
  '';

  build-system = [
    uv-build
  ];

  dependencies = [
    fastapi
    typer
    uvicorn
    asyncpg
    pydantic
  ]
  ++ pydantic.optional-dependencies.email;
})
