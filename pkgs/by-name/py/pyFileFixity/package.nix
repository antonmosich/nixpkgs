{ lib
, fetchFromGitHub
, python3
}:

python3.pkgs.buildPythonApplication rec {
  pname = "pyFileFixity";
  version = "3.1.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lrq3000";
    repo = "pyFileFixity";
    rev = "v${version}";
    hash = "sha256-Q8IjR6a5ApBZMxKl6llWNGXeQpfYxJwM7EIb7cdtoiQ=";
  };

  build-system = with python3.pkgs; [
    setuptools-scm
  ];

  nativeBuildInputs = with python3.pkgs; [ pythonRelaxDepsHook ];

  pythonRemoveDeps = [ "argparse" ];

  dependencies = with python3.pkgs; [
    pathlib2
    sortedcontainers
    tqdm
    reedsolo2
    unireedsolomon
    distance
  ];

  meta = {
    description = "Suite of tools for file fixity (data protection for long term storage)";
    homepage = "https://github.com/lrq3000/pyFileFixity";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ antonmosich ];
    mainProgram = "pff";
  };
}
