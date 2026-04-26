{
  alsa-lib,
  fetchFromGitHub,
  lib,
  openssl,
  glib,
  cairo,
  gdk-pixbuf,
  pango,
  graphene,
  gtk4,
  libsoup_3,
  webkitgtk_6_0,
  pkg-config,
  protobuf,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "qobuz-player";
  version = "0.10.2";

  src = fetchFromGitHub {
    owner = "SofusA";
    repo = "qobuz-player";
    tag = "v${finalAttrs.version}";
    hash = "sha256-XrPgqtondZCOMB5TDXhz4rqdVn5JzLrs9+KfHOasSKA=";
  };

  cargoHash = "sha256-XPJVf0ycVceVd5cuXFyZQCrZ+e1Ak+1V6EIu2uCJtAs=";

  nativeBuildInputs = [
    pkg-config
    protobuf
  ];

  buildInputs = [
    alsa-lib
    openssl
    glib
    cairo
    gdk-pixbuf
    pango
    graphene
    gtk4
    libsoup_3
    webkitgtk_6_0
  ];

  meta = {
    description = "Tui, web and rfid player for Qobuz";
    homepage = "https://github.com/SofusA/qobuz-player";
    changelog = "https://github.com/SofusA/qobuz-player/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [
      felixsinger
    ];
    platforms = lib.platforms.linux;
    mainProgram = "qobuz-player";
  };
})
