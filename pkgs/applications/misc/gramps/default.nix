{ lib, fetchFromGitHub, gtk3, pythonPackages, intltool, gexiv2,
  pango, gobject-introspection, wrapGAppsHook, gettext, glibcLocales,
# Optional packages:
 enableOSM ? true, osm-gps-map, glib-networking,
 enableGraphviz ? true, graphviz,
 enableGhostscript ? true, ghostscript
 }:

let
  inherit (pythonPackages) python buildPythonApplication;
in buildPythonApplication rec {
  version = "5.1.6";
  pname = "gramps";

  nativeBuildInputs = [ wrapGAppsHook intltool gettext gobject-introspection ];
  buildInputs = [ gtk3 pango gexiv2 ]
    # Map support
    ++ lib.optionals enableOSM [ osm-gps-map glib-networking ]
    # Graphviz support
    ++ lib.optional enableGraphviz graphviz
    # Ghostscript support
    ++ lib.optional enableGhostscript ghostscript
  ;

  src = fetchFromGitHub {
    owner = "gramps-project";
    repo = "gramps";
    rev = "v${version}";
    sha256 = "sha256-BerkDXdFYfZ3rV5AeMo/uk53IN2U5z4GFs757Ar26v0=";
  };

  pythonPath = with pythonPackages; [ berkeleydb pyicu pygobject3 pycairo ];

  # Same installPhase as in buildPythonApplication but without --old-and-unmanageble
  # install flag.
  installPhase = ''
    runHook preInstall

    mkdir -p "$out/lib/${python.libPrefix}/site-packages"

    export PYTHONPATH="$out/lib/${python.libPrefix}/site-packages:$PYTHONPATH"

    ${python}/bin/${python.executable} setup.py install \
      --install-lib=$out/lib/${python.libPrefix}/site-packages \
      --prefix="$out"

    eapth="$out/lib/${python.libPrefix}"/site-packages/easy-install.pth
    if [ -e "$eapth" ]; then
        # move colliding easy_install.pth to specifically named one
        mv "$eapth" $(dirname "$eapth")/${pname}-${version}.pth
    fi

    rm -f "$out/lib/${python.libPrefix}"/site-packages/site.py*

    runHook postInstall
  '';

  nativeCheckInputs = (with pythonPackages; [
  lxml
  jsonschema
  pytestCheckHook
  ]);

  preCheck = ''
    # Test failing due to missing locale
    export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
    # Many tests failing trying to write to $HOME
    export HOME=$(mktemp -d)
    '';

  # https://github.com/NixOS/nixpkgs/issues/149812
  # https://nixos.org/manual/nixpkgs/stable/#ssec-gnome-hooks-gobject-introspection
  strictDeps = false;

  meta = {
    description = "Genealogy software";
    homepage = "https://gramps-project.org";
    license = lib.licenses.gpl2;
    mainProgram = "gramps";
    maintainers = with lib.maintainers; [ antonmosich ];
  };
}
