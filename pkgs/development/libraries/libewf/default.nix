{ fetchurl, fetchpatch, lib, stdenv, zlib, openssl, libuuid, pkg-config, bzip2 }:

stdenv.mkDerivation rec {
  version = "20230212";
  pname = "libewf";

  src = fetchurl {
    url = "https://github.com/libyal/libewf/releases/download/${version}/libewf-experimental-${version}.tar.gz";
    hash = "sha256-0i7svZYsPX1kbM+6Ex/DwH5qB9o33BY7bsuxNI2xYQE=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ zlib openssl libuuid ]
    ++ lib.optionals stdenv.isDarwin [ bzip2 ];

  meta = {
    description = "Library for support of the Expert Witness Compression Format";
    homepage = "https://sourceforge.net/projects/libewf/";
    license = lib.licenses.lgpl3;
    maintainers = [ lib.maintainers.raskin ] ;
    platforms = lib.platforms.unix;
  };
}
