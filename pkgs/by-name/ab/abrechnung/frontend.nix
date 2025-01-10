src: version:
{
  buildNpmPackage,
}:
buildNpmPackage {
  pname = "abrechnung-frontend";
  inherit version;
  src = "${src}/frontend";

  npmDepsHash = "sha256-7ICHXDNmDl6e5XUP2Bbf/BP03NZg6aUajI3gXq03eRo=";

  # configurePhase = ''
  #   runHook preConfigure

  #   export HOME=$(mktemp -d)
  #   npm install
  #   npx nx build web
  #   patchShebangs node_modules/

  #   runHook postConfigure
  # '';
  # buildPhase = ''
  #   runHook preBuild

  #   export NUXT_TELEMETRY_DISABLED=1
  #   yarn --offline build
  #   yarn --offline generate

  #   runHook postBuild
  # '';

  # installPhase = ''
  #   runHook preInstall
  #   mv dist $out
  #   runHook postInstall
  # '';
}
