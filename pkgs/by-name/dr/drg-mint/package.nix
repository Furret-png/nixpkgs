{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wrapGAppsHook,
  atk,
  cairo,
  gdk-pixbuf,
  glib,
  gtk3,
  libxkbcommon,
  openssl,
  pango,
  zstd,
  stdenv,
  darwin,
  wayland,
}:

rustPlatform.buildRustPackage rec {
  pname = "drg-mint";
  version = "0.2.10";

  src = fetchFromGitHub {
    owner = "trumank";
    repo = "mint";
    rev = "v${version}";
    hash = "sha256-iVDSQ/TyxrgNmJYwK/UgZCU/iUOeYrHyBaqcXgvkCnY=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "egui_dnd-0.5.0" = "sha256-zJQaq5/dfiY/d8l+IwgKgJvXJhtvKf+1cTC2hzhodiA=";
      "modio-0.7.1" = "sha256-/hlTSsKbSyDcQVTu5DSEHVcupOHrcmE3HHcMNKUgsCY=";
      "patternsleuth_scanner-0.1.0" = "sha256-kKX2AiVrVxdJu6gtBZVYS4LwMHR1tEXdSO727+ObUEw=";
      "repak-0.1.7" = "sha256-bimhmsJ+RpwXbSmXUB710v1hsBZeN4RiEEnkbeQdGK4=";
      "uasset_utils-0.1.0" = "sha256-HlQLA3Wjh2Zep+xiyAb9iHftICoTWoWTXPLth6GH2wo=";
      "unreal_asset-0.1.16" = "sha256-3sJKM45txARjYIXYkEj/NrnfQUuDC2ybQoaBwVYNGVI=";
    };
  };

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook
  ];

  buildInputs = [
    atk
    cairo
    gdk-pixbuf
    glib
    gtk3
    libxkbcommon
    openssl
    pango
    zstd
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.CoreGraphics
    darwin.apple_sdk.frameworks.CoreServices
    darwin.apple_sdk.frameworks.Foundation
    darwin.apple_sdk.frameworks.Security
  ] ++ lib.optionals stdenv.isLinux [
    wayland
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "Deep Rock Galactic mod loader and integration";
    homepage = "https://github.com/trumank/mint";
    changelog = "https://github.com/trumank/mint/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "drg-mint";
  };
}
