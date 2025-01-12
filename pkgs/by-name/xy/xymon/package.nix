{
  lib,
  fetchurl,
  stdenv,
  pcre,
  openssl,
  rrdtool,
  c-ares,
  openldap,
  libtirpc,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "xymon";
  version = "4.3.30";
  src = fetchurl {
    url = "mirror://sourceforge/xymon/xymon-${finalAttrs.version}.tar.gz";
    hash = "sha256-jtUXccjh4V35ZyUHLGGiEoarDmEFoOHtrJViJSAb9fU=";
  };

  buildInputs = [
    libtirpc
    pcre
    openssl
    rrdtool
    openldap
    c-ares
  ];

  ENABLESSL="y";
  XYMONTOPDIR="$out";

  configurePhase = ''
    runHook preConfigure
    ./configure
    runHook postConfigure
  '';

})
