{ lib, fetchFromGitHub
, pkg-config, meson ,ninja
, python3Packages
, gdk-pixbuf, glib, gobject-introspection, gtk3
, libnotify
, wrapGAppsHook3 }:

python3Packages.buildPythonApplication rec {
  pname = "mpdevil";
  version = "1.11.0";

  src = fetchFromGitHub {
    owner = "SoongNoonien";
    repo = pname;
    rev = "refs/tags/v${version}";
    sha256 = "sha256-ooNZSsVtIeueqgj9hR9OZp08qm8gGokiq8IU3U/ZV5w=";
  };

  format = "other";

  nativeBuildInputs = [
    glib.dev gobject-introspection gtk3 pkg-config meson ninja wrapGAppsHook3
  ];

  buildInputs = [
    gdk-pixbuf glib libnotify
  ];

  propagatedBuildInputs = with python3Packages; [
    beautifulsoup4 distutils-extra mpd2 notify-py pygobject3 requests
  ];

  postInstall = ''
    glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  # Prevent double wrapping.
  dontWrapGApps = true;
  # Otherwise wrapGAppsHook3 do not pick up the dependencies correctly.
  strictDeps = false;
  # There aren't any checks.
  doCheck = false;

  meta = with lib; {
    description = "A simple music browser for MPD";
    homepage = "https://github.com/SoongNoonien/mpdevil";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ apfelkuchen6 ];
    mainProgram = "mpdevil";
  };
}
