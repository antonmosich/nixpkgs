{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  flit-core,
  mutagen,
  pytestCheckHook,
  pythonOlder,
  six,
  nix-update-script,
}:

buildPythonPackage rec {
  pname = "mediafile";
  version = "0.13.0";
  pyproject = true;

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "beetbox";
    repo = "mediafile";
    rev = "v${version}";
    hash = "sha256-Knp91nVPFkE2qYSZoWcOsMBNY+OBfWCPPNn+T1L8v0o=";
  };

  build-system = [ flit-core ];

  dependencies = [
    mutagen
    six
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "mediafile" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Python interface to the metadata tags for many audio file formats";
    homepage = "https://github.com/beetbox/mediafile";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ lovesegfault ];
  };
}
