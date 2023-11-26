{ lib
, python3
, fetchFromGitHub
}:
python3.pkgs.buildPythonApplication {
  pname = "geo-activity-playground";
  version = "0.16.4";
  format = "pyproject";
  src = fetchFromGitHub {
    repo = "geo-activity-playground";
    owner = "martin-ueding";
    rev = "0.16.4";
    hash = "sha256-YbLsklDjQYjc5gIDODDnVa30uDpdMRUwHiaWVoB0ssA=";
  };
  propagatedBuildInputs = with python3.pkgs; [
    poetry-core
    coloredlogs
    geojson
    matplotlib
    pandas
    scipy
    tqdm
    requests
    fitdecode
    gpxpy
    stravalib
    flask
    altair
    tcxreader
    pyarrow
    vegafusion
    vl-convert-python
    xmltodict
  ];
}
