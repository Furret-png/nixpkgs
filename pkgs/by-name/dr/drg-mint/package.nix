{
  lib,
  stdenv,
  fetchurl,
}:

stdenv.mkDerivation rec {
  pname = "drg-mint";
  version = "0.2.10";

  src = fetchurl {
    url = "https://github.com/trumank/mint/releases/download/v${version}/drg_mod_integration-x86_64-unknown-linux-gnu.tar.xz";
    sha256 = "sha256-Ukpa/tvFUXZNvRPUo6CPwQiIt/yWLREdvAu1S8b/eyw=";
  };

  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp drg_mod_integration $out/bin/drg-mint
  '';

  meta = with lib; {
    description = "Deep Rock Galactic mod loader and integration (MINT)";
    homepage = "https://github.com/trumank/mint";
    license = licenses.mit;
    maintainers = with maintainers; [ Furret-png ];
    platforms = platforms.linux;
  };
}
