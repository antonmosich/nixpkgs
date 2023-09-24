{ lib
, fetchsvn
, stdenv
, qtbase
, wrapQtAppsHook
, libguytools
, libewf-legacy
, parted
, qttools
, dpkg
, installShellFiles
, polkit
}:

let
  libewf = libewf-legacy.overrideAttrs { configureFlags = [ "--enable-shared=no" ]; };
in
stdenv.mkDerivation (finalAttrs: {
  name = "guymager";
  version = "0.8.13-2";
  src = fetchsvn {
    url = "svn://svn.code.sf.net/p/guymager/code";
    rev = "45";
    hash = "sha256-n/PLrQyzUTITWj8hKhcDd06MkDhc3csvJE/MkCaOzqI=";
  };
  nativeBuildInputs = [
    installShellFiles
    qttools
    dpkg
    wrapQtAppsHook
  ];
  buildInputs = [
    qtbase
    libguytools
    libewf
    parted
    polkit
  ];
  sourceRoot = "${finalAttrs.src.name}/tags/guymager-0.8.13";
  postPatch = ''
    substituteInPlace guymager.pro \
      --replace "/usr/local/lib/libguytools.a" "${libguytools}/lib/libguytools.a" \
      --replace "/usr/local/lib/libewf.a" "${libewf}/lib/libewf.a"
    '';

  configurePhase = ''
    qmake
    substituteInPlace Makefile --replace "./compileinfo.sh" "sh compileinfo.sh"
    '';
  postBuild = ''
    pushd manuals
    bash rebuild.sh
    popd

    lrelease guymager.pro

    substituteInPlace org.freedesktop.guymager.policy \
      --replace "/usr/bin/guymager" "$out/bin/guymager"
    '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/{applications,guymager,pixmaps,polkit-1/actions}

    cp guymager $out/bin
    cp guymager.desktop $out/share/applications
    cp splash.png guymager_{cn,de,en,fr,it,nl}.qm guymager.cfg $out/share/guymager
    cp guymager_128.png $out/share/pixmaps

    cp org.freedesktop.guymager.policy $out/share/polkit-1/actions

    installManPage manuals/guymager.1
    '';

    meta = {
      mainProgram = "guymager";
    };
})
