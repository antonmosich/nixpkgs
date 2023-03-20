{ lib
, stdenv
, fetchgit
, cmake
, exiv2
, sfml
, vigra
, libhwy
, openimageio
, imath
, libGL
}:

stdenv.mkDerivation rec {
  pname = "lux-pv";
  version = "1.2.2";

  src = fetchgit {
    url = "https://bitbucket.org/kfj/pv";
    rev = "refs/tags/${version}";
    sha256 = "sha256-rdoOAJya7NkzZcWY6S0uurmAfW7XSkKcy5r8hbTJYJg=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    imath
    sfml
    openimageio
    exiv2
    vigra
    libhwy
    libGL
  ];

  meta = with lib; {
    description = "lux - a free panorama and image viewer";
    homepage = "https://bitbucket.org/kfj/pv";
    license = licenses.gpl3;
    maintainers = with maintainers; [ paperdigits ];
    platforms = platforms.linux;
  };
}
