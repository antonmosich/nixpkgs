{ lib
, stdenv
, fetchFromGitHub
, cmake
, curlWithGnuTls
, freetype
, SDL2
, libvorbis
, libtheora
, openal
, zip
, unzip
, zlib
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "warfork-qfusion";
  version = "2023-09-24";
  src = fetchFromGitHub {
    repo = "warfork-qfusion";
    owner = "TeamForbiddenLLC";
    rev = "a4b403430fc8801b2e46780378da2976f4af35e9";
    hash = "sha256-u1HF+baUP996gb8FjU8JJ3fKi1CPsXWus3NFrosGOMo=";
  };
  patches = [
    ./libz.patch
  ];
  buildInputs = [
    zlib
  ];
  nativeBuildInputs = [
    cmake
    curlWithGnuTls
    freetype
    SDL2
    libvorbis
    libtheora
    openal
    zip
    unzip
  ];
  preConfigure = "cd source";
  installPhase = ''
    mkdir -p $out/bin
    cp {warfork,wf_server,wftv_server}.x86_64 $out/bin
    '';
    meta = {
      mainProgram = "warfork.x86_64";
    };
})
