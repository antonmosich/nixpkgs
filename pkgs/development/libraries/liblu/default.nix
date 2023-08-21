{ lib, stdenv, fetchFromGitHub, libtool, autoconf, automake, pkg-config, autoreconfHook, check }:

stdenv.mkDerivation rec {
  pname = "liblu";
  version = "2018-01-16";

  src = fetchFromGitHub {
    owner = "andrewcooke";
    repo = "liblu";
    rev = "e85fa3169916e84720feab05c02f82859d72f241";
    hash = "sha256-43xl7cGqWqixIPI3XZaxrN0nNsKcRUFSmXqyBbbys9Q=";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config check ];

  # preConfigure = "";

  meta = {
    description = "Helper Library";
    longDescription = ''
      Library was meant to be an alternative to the official libmatroska library.
      It is written in plain C, and intended to be very portable.
    '';
    homepage = "https://github.com/andrewcooke/liblu";
    license = lib.licenses.gpl2;
    maintainers = with lib.maintainers; [ antonmosich ];
    platforms = lib.platforms.unix;
  };
}
