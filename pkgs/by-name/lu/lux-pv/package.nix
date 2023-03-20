{
  lib,
  clangStdenv,
  fetchFromBitbucket,
  cmake,
  exiv2,
  sfml,
  vigra,
  libhwy,
  openimageio,
  imath,
  libGL,
}:

clangStdenv.mkDerivation (finalAttrs: {
  pname = "lux-pv";
  version = "1.2.2";

  src = fetchFromBitbucket {
    owner = "kfj";
    repo = "pv";
    rev = finalAttrs.version;
    hash = "sha256-rdoOAJya7NkzZcWY6S0uurmAfW7XSkKcy5r8hbTJYJg=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    imath
    sfml
    openimageio
    exiv2
    vigra
    libhwy
    libGL
  ];

  meta = {
    description = "Panorama and image viewer";
    homepage = "https://bitbucket.org/kfj/pv";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ antonmosich ];
    mainProgram = "lux";
  };
})
