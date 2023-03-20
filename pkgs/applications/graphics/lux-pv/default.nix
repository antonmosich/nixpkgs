{ lib
, stdenv
, fetchgit
, cmake
, exiv2
, sfml
, vigra
, libhwy
}:

stdenv.mkDerivation rec {
  pname = "lux-pv";
  version = "1.1.8";

  src = fetchgit {
    url = "https://bitbucket.org/kfj/pv";
    rev = "refs/tags/${version}";
    sha256 = "sha256-vnetq6ueVyVOqn2YinJJxNCY/1n8NUG85Bs4hZT4j/M=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    sfml
    exiv2
    vigra
    libhwy
  ];

  meta = with lib; {
    description = "lux - a free panorama and image viewer";
    homepage = "https://bitbucket.org/kfj/pv";
    license = licenses.gpl3;
    maintainers = with maintainers; [ paperdigits ];
    platforms = platforms.linux;
  };
}
