{ lib, stdenv, fetchFromGitHub, libtool, autoconf, automake, pkg-config, autoreconfHook, check, liblu, cairo, gsl }:

stdenv.mkDerivation rec {
  pname = "spokes";
  version = "2021-03-16";

  src = fetchFromGitHub {
    owner = "andrewcooke";
    repo = pname;
    rev = "8ae11a9377ab641bc7d2ec7c33a04230081ad546";
    sha256 = "sha256-X4o/2qLYk3yQgANveLB7uZT/4gEve80GShR5t6wfp6U=";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config check liblu cairo gsl ];

  buildInputs = [ liblu cairo gsl ];

  # preConfigure = "";

  meta = {
    description = "Helper Library";
    longDescription = ''
      Library was meant to be an alternative to the official libmatroska library.
      It is written in plain C, and intended to be very portable.
    '';
    homepage = "https://github.com/andrewcooke/liblu";
    license = lib.licenses.gpl2;
    maintainers = [ lib.maintainers.wmertens ];
    platforms = lib.platforms.unix;
  };
}
