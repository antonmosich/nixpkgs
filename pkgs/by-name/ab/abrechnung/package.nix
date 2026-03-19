{
  lib,
  python3,
  fetchFromGitHub,
  sphinxHook,
  stdenv,
  # Frontend
  nodejs,
  pnpmConfigHook,
  pnpm,
  fetchPnpmDeps,
  tree,
}:

python3.pkgs.buildPythonApplication (finalAttrs: {
  pname = "abrechnung";
  version = "1.8.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "SFTtech";
    repo = "abrechnung";
    tag = "v${finalAttrs.version}";
    hash = "sha256-6/kV04s8WNNG9/3zpEsM01XLzo8bGpm7n/pTniF8BCE=";
  };

  build-system = [
    python3.pkgs.setuptools
  ];

  dependencies = with python3.pkgs; [
    bcrypt
    httpx
    prometheus-fastapi-instrumentator
    pydantic
    pydantic-settings
    python-jose
    python-multipart
    pyyaml
    sftkit
  ];

  nativeBuildInputs = with python3.pkgs; [
    sphinxHook
    sphinx-copybutton
    myst-parser
    sphinxcontrib-openapi
    sphinx-rtd-theme
  ];

  pythonRelaxDeps = [ "prometheus-fastapi-instrumentator" ];

  pythonImportsCheck = [
    "abrechnung"
  ];

  passthru.frontend = stdenv.mkDerivation {
    pname = "abrechnung-frontend";
    inherit (finalAttrs) src version;

    nativeBuildInputs = [
      nodejs
      pnpmConfigHook
      pnpm
      tree
    ];

    buildPhase = ''
      pushd apps/web
      pnpm run build
      popd
    '';

    installPhase = ''
      mkdir -p $out
      cp dist/apps/web/* $out -r
    '';

    pnpmDeps = fetchPnpmDeps {
      pname = "abrechnung-frontend-deps";
      inherit (finalAttrs) src version;
      fetcherVersion = 3;
      hash = "sha256-aLp6d/iPTOXusZbtXNJp2yokxe6Nh8Dup3C3ZX3Hv38=";
    };
    pnpmRoot = "apps/web";
  };

  meta = {
    description = "Payment tracking and money splitting for groups";
    homepage = "https://github.com/SFTtech/abrechnung";
    changelog = "https://github.com/SFTtech/abrechnung/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.agpl3Only;
    maintainers = [ ];
    mainProgram = "abrechnung";
  };
})
