{ lib,
  stdenv,
  fetchFromGitHub,
  libpng,
  cmake,
  pkg-config
}:
stdenv.mkDerivation (finalAttrs:{
  pname = "ripcheck";
  version = "1.0.2";
  src = fetchFromGitHub {
    owner = "panzi";
    repo = "ripcheck";
    rev = "v${finalAttrs.version}";
    hash = "sha256-Rw4XTHFCbilZ+78BjXE/W6qYbPCKpg8h/pBoYPKBWpI=";
  };

  nativeBuildInputs = [ pkg-config libpng cmake ];

  meta = {
    maintainers = with lib.maintainers; [ antonmosich ];
  };
})
