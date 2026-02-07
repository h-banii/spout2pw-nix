{
  lib,
  stdenv,
  fetchzip,
  autoPatchelfHook,

  vulkan-loader,
  libgbm,
  libdrm,
  pkg-config,
  wineWowPackages,
}:
stdenv.mkDerivation {
  pname = "spout2pw-bin";
  version = "0.1.4";

  src = fetchzip {
    url = "https://github.com/hoshinolina/spout2pw/releases/download/0.1.5/spout2pw-0.1.5-bin.tar.gz";
    hash = "sha256-IxR3gs9EhtZ3X/r9FexfQtKiKY9xXb9UWS4fLh+wEkw=";
  };

  dontPatchShebangs = true;

  nativeBuildInputs = [
    autoPatchelfHook
    pkg-config
  ];

  buildInputs = [
    vulkan-loader
    libgbm
    libdrm
  ];

  installPhase = ''
    runHook preInstall
    install -m755 -D spout2pw.sh $out/bin/spout2pw
    cp -r spout2pw.inf spoutdxtoc.dll wine $out/bin
    runHook postInstall
  '';

  postFixup = ''
    file=$out/bin/wine/x86_64-unix/spout2pw.so
    patchelf \
      --set-rpath "$(patchelf --print-rpath $file):${lib.makeLibraryPath [ wineWowPackages.minimal ]}" \
      $file

    substituteInPlace $out/bin/spout2pw \
      --replace /bin/bash '/usr/bin/env bash' \
      --replace 'gbm_steamrt_workaround() {' $'gbm_steamrt_workaround() {\nreturn' \
      --replace 'gbm_backend_paths="' 'gbm_backend_paths="/run/opengl-driver/lib'
  '';

  meta = {
    mainProgram = "spout2pw";
  };
}
