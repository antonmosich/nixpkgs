{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
, pkg-config
, taglib
, zlib
}:

buildGoModule rec {
  pname = "SheetAble";
  version = "0.8.1";
  src = fetchFromGitHub
    {
      owner = "SheetAble";
      repo = "SheetAble";
      rev = "v${version}";
      hash = "sha256-iZjxdC/qcOiBG7WEpTOynb/jeWCHDmvdaneQIeY2Zco=";
    } + "/backend";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ taglib zlib ];
  vendorHash = "sha256-y31RSxGCDgeCIaxDWKfZSE/FKIFWD4lyWPIbIvfBpT0=";
  proxyVendor = true;

  meta = {
    homepage = "https://github.com/SheetAble/SheetAble";
    description = "Self-hosted music-sheet organzing software";
    license = lib.licenses.agpl3Plus;
    maintainers = with lib.maintainers; [ antonmosich ];
    mainProgram = "backend";
    platforms = lib.platforms.linux;
  };
}
