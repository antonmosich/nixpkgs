{ lib
, stdenv
, fetchurl
}:
stdenv.mkDerivation (prev: {
  pname = "uniutils";
  version = "2.28";
  src = fetchurl {
    url = "http://billposer.org/Software/Downloads/${prev.pname}-${prev.version}.tar.gz";
    hash = "sha256-QcFMAiM3by2WyAwrobFJT8dM2JgtVhYw5ojiJFqvM2Q=";
  };

  meta = {
    description = "A set of programs for manipulating and analyzing Unicode text";
    homepage = "http://billposer.org/Software/unidesc.html";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ antonmosich ];
    platforms = lib.platforms.all;
  };
})
