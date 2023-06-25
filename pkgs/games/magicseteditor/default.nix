{ lib
, stdenv
, fetchFromGitHub
, gcc
, pkg-config
, cmake
, wxGTK32
, boost
, hunspell
}:

stdenv.mkDerivation rec {
  pname = "magicseteditor";
  version = "2021-07-06";
  srcs = [
    (fetchFromGitHub {
      name = "main";
      owner = "twanvl";
      rev = "f9d9356d51f28210ccf0c0dda508502f222e1def";
      repo = "MagicSetEditor2";
      hash = "sha256-c1FkurEWo3xswDxyI7wM6QcqA4AiIB9Wqe2PqFm+3jc=";
    })
    (fetchFromGitHub {
      name = "data";
      owner = "MagicSetEditorPacks";
      repo = "Full-Magic-Pack";
      rev = "4e312793d83c26de63a61c4cc9230e604275c2d5";
      hash = "sha256-ss1udPSshwwqVz/4hv1VB5ZwTpiAs1kmBp0QxxjUHnM=";
    })
  ];
  sourceRoot = "main";

  nativeBuildInputs = [ gcc cmake pkg-config wxGTK32 boost hunspell ];

  installPhase = ''
    install -D magicseteditor -t $out/bin
    mkdir -p $out/share/${pname}
    cp -R ../../data/data $out/share/${pname}
    cp -R ../../data/resource $out/share/${pname}
  '';

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];
}

