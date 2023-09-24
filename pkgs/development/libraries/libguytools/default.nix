{ lib, fetchsvn, stdenv, qtbase, wrapQtAppsHook }:

stdenv.mkDerivation (finalAttrs: {
  name = "libguytools";
  version = "2.1.0-1";
  src = fetchsvn {
    url = "svn://svn.code.sf.net/p/libguytools/code";
    rev = "14";
    hash = "sha256-ZjVeAOTm0ZN6BDpeqmQ1kxoy79fsBe6NHxqSfbm0i1I=";
  };
  buildInputs = [ wrapQtAppsHook qtbase ];
  sourceRoot = "${finalAttrs.src.name}/tags/tools-2.1.0";
  buildPhase = ''
    ls -la
    # ./create_version_file.sh
    qmake trunk.pro
    make

    qmake toolsstatic.pro
    make
  '';
  installPhase = ''
    mkdir -p $out
    cp -R lib $out/
    cp -R include $out/
  '';
})
