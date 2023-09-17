{ lib
, fetchFromGitLab
, rustPlatform
, python3
}:

let
  gitLab = fetchFromGitLab {
    owner = "coolercontrol";
    repo = "coolercontrol";
    rev = "0.17.1";
    hash = "sha256-44YSFlq6HnRXCJVG75FfWhb/FG01vws+nBJCvvrJ5oQ=";
  };
  coolercontrold = rustPlatform.buildRustPackage {
    pname = "coolercontrold";
    version = "0.17.1";
    src = gitLab + "/coolercontrold";
    cargoHash = "sha256-tFmFv2+cnKPK6vcDzkpUDEaQrwKJdKUnioLuoE4Eej4=";
  };

  coolercontrol-gui = python3.pkgs.buildPythonApplication {
    pname = "coolercontrol";
    version = "0.17.1";
    format = "pyproject";
    propagatedBuildInputs = with python3.pkgs; [
      poetry-core
      setproctitle
      pyside6
      dateutil
      dataclass-wizard
      pillow
      numpy
      matplotlib
      apscheduler
      requests
      jeepney
    ];
    src = gitLab + "/coolercontrol-gui";
  };
in
  python3.pkgs.buildPythonApplication {
    pname = "coolercontrol-liqctld";
    version = "0.17.1";
    format = "pyproject";
    src = gitLab + "/coolercontrol-liqctld";
    propagatedBuildInputs = with python3.pkgs; [
      poetry-core
      colorlog
      setproctitle
      uvicorn
      fastapi
      liquidctl
    ];
  }
