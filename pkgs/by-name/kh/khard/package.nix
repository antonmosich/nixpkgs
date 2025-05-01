{
  lib,
  python3Packages,
  fetchFromGitHub,
  versionCheckHook,
  khard,
  testers,
  nix-update-script,
}:

python3Packages.buildPythonApplication rec {
  version = "0.19.1";
  pname = "khard";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lucc";
    repo = "khard";
    tag = "v${version}";
    hash = "sha256-5+28p1yPkdfnARvNQSfHWvj746u4mONaUBW1xAPXfM4=";
  };

  build-system = [ python3Packages.setuptools-scm ];

  nativeBuildInputs = with python3Packages; [
    sphinxHook
    sphinx-autoapi
    sphinx-autodoc-typehints
    sphinx-argparse
  ];

  sphinxBuilders = [ "man" ];

  dependencies = with python3Packages; [
    atomicwrites
    configobj
    ruamel-yaml
    unidecode
    vobject
  ];

  postInstall = ''
    installShellCompletion --zsh misc/zsh/_khard
  '';

  preCheck = ''
    # see https://github.com/scheibler/khard/issues/263
    export COLUMNS=80
  '';

  pythonImportsCheck = [ "khard" ];

  nativeCheckInputs = [ versionCheckHook ];

  passthru = {
    tests.version = testers.testVersion { package = khard; };
    updateScript = nix-update-script { };
  };

  meta = {
    homepage = "https://github.com/lucc/khard";
    description = "Console carddav client";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [
      matthiasbeyer
      antonmosich
    ];
    mainProgram = "khard";
  };
}
