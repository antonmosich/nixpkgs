{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, sqlite
, fuse
, libcue
, libchardet
, ffmpeg
, autoreconfHook
, asciidoc-full
, unixtools
, w3m-nographics
, libbluray
, libdvdread
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "ffmpegfs";
  version = "2.15";
  src = fetchFromGitHub {
    owner = "nschlia";
    repo = "ffmpegfs";
    rev = "v${finalAttrs.version}";
    hash = "sha256-UgxzPTqt8sD2L8f+KFq3e+ZzDDXj40L5o2skccWJx8M=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
    sqlite
    fuse
    libcue
    libchardet
    ffmpeg
    asciidoc-full
    w3m-nographics
    unixtools.xxd
    libbluray
    libdvdread
  ];
})
