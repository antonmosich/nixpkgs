{
  lib,
  stdenv,
  fetchFromSourcehut,

  hare,
  writableTmpDirAsHomeHook,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "ab-tidy";
  version = "0.1.0";

  src = fetchFromSourcehut {
    owner = "~whynothugo";
    repo = "ab-tidy";
    rev = "v${finalAttrs.version}";
    hash = "sha256-HMcWQ+nTRFqo3fBSqbZcZtwDeG+PmFTNuemfXxc0xMw=";
  };

  buildInputs = [
    writableTmpDirAsHomeHook
    hare
  ];

  installFlags = [
    "PREFIX=$(out)"
  ];

  meta = {
    description = "Tidy up a vdir address book";
    homepage = "https://git.sr.ht/~whynothugo/ab-tidy";
    license = lib.licenses.isc;
    maintainers = [ lib.maintainers.antonmosich ];
  };
})
