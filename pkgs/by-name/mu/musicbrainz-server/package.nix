{
  lib,
  fetchFromGitHub,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "musicbrainz-server";
  version = "2024-12-09.0";
  src = fetchFromGitHub {
    owner = "metabrainz";
    repo = "musicbrainz-server";
    tag = "v-${finalAttrs.version}";
    hash = "sha256-dKP3WgSTm99g3bOCyvKggnvVq1chhPZ8b8ODRbVIHD0=";
  };

  buildPhase = ''
    ls script
    ./script/compile_resources.sh
  '';
})
