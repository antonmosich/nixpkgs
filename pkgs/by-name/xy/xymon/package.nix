{
  lib,
  fetchFromGitHub,
  fetchurl,
  stdenv,
  pcre,
  openssl,
  rrdtool,
  c-ares,
  libtirpc,
  fping,
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
    (rrdtool.overrideAttrs rec {
      version = "1.4.9";
      src = fetchFromGitHub {
        owner = "oetiker";
        repo = "rrdtool-1.x";
        rev = "v${version}";
        hash = "sha256-+OSMea2/y6roWpFgZP51HtlXZCH0Y3NnNwR5WObK7b4=";
      };
    })
    c-ares
  ];

  env = {
    ENABLESSL = "y";
    XYMONTOPDIR = "$out";
    USERFPING = lib.getExe fping;
  };

  patchPhase = ''
    runHook prePatch
    substituteInPlace build/Makefile.Linux --replace-fail \
    /usr/include/tirpc ${libtirpc.dev}/include/tirpc
    runHook postPatch
  '';

  configurePhase = ''
    runHook preConfigure
    ./configure
    runHook postConfigure
  '';

})
