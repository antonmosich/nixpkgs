{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "stun-go";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "pion";
    repo = "stun";
    tag = "v${finalAttrs.version}";
    hash = "sha256-F0//f3oSy0P2jFWunaKHVSCg8/9T+OXJpwsM0DDnF00=";
  };

  vendorHash = "sha256-0mcyeKPrflp7DI1UlZXaB0XYRocN0rpsFFII1KoTNFQ=";

  ldflags = [ "-s" ];

  meta = {
    description = "A Go implementation of STUN";
    homepage = "https://github.com/pion/stun";
    license = with lib.licenses; [
      bsd3
      cc0
      mit
    ];
    maintainers = with lib.maintainers; [ ];
    mainProgram = "stun-go";
  };
})
