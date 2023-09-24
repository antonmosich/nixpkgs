{ fetchurl, fetchpatch, lib, stdenv, zlib, openssl, libuuid, pkg-config, bzip2 }:

stdenv.mkDerivation rec {
  version = "20140814";
  pname = "libewf";

  src = fetchurl {
    url = "https://github.com/libyal/libewf-legacy/releases/download/${version}/libewf-${version}.tar.gz";
    hash = "sha256-OM3QXwnaIDeo66UNjzmu6to53SxgCMn/rE9VTPlX5BQ=";
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
