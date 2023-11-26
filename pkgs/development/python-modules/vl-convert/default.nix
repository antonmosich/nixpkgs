{ lib
, buildPythonPackage
, fetchFromGitHub
, rustPlatform
, cmakeMinimal
, protobuf
, fetchurl
, stdenv
}:
buildPythonPackage rec {
  pname = "vl-convert-python";
  version = "1.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "vega";
    repo = "vl-convert";
    rev = "v${version}";
    hash = "sha256-OgaNMRfTVvWOSZmFk0KrpLepxf/uYS2Qu5fGULdHbBA=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-WZkaikxAQEOWpNhhDkBbFuEcz7HymgqJrGBRr5xAuGY=";
  };

  buildAndTestSubdir = "vl-convert-python";

  RUSTY_V8_ARCHIVE =
      let
        fetch_librusty_v8 = args:
          fetchurl {
            name = "librusty_v8-${args.version}";
            url = "https://github.com/denoland/rusty_v8/releases/download/v${args.version}/librusty_v8_release_${stdenv.hostPlatform.rust.rustcTarget}.a";
            sha256 = args.shas.${stdenv.hostPlatform.system} or (throw "Unsupported platform ${stdenv.hostPlatform.system}");
            meta = { inherit (args) version; };
          };
      in
      fetch_librusty_v8 {
        version = "0.81.0";
        shas = {
          x86_64-linux = "sha256-e77LYm/sus7EY4eiRuEp6G25djDaT4wSD4FBCxy4vcE=";
          aarch64-linux = "";
          x86_64-darwin = "";
          aarch64-darwin = "";
        };
      };

  nativeBuildInputs = with rustPlatform; [
    cargoSetupHook
    maturinBuildHook
    cmakeMinimal
    protobuf
  ];
  dontUseCmakeConfigure = true;
}
