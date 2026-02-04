{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  obs-studio,
  pipewire,
  libdrm,
  libGL,
}:

stdenv.mkDerivation rec {
  pname = "obs-pwvideo";
  version = "unstable-2025-02-04";

  src = fetchFromGitHub {
    owner = "raslen131";
    repo = "obs-pwvideo";
    rev = "8d9dc12d951ba4002c3a44b193ad445808f3c927";
    sha256 = "sha256-gdoH5n7jKlIjcgteLC9VegwGqpc0+fA7YYJp/BYBPyU=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    obs-studio
    pipewire
    libdrm
    libGL
  ];

  env.NIX_CFLAGS_COMPILE = toString [
    "-Wno-error=unused-variable"
    "-Wno-error=unused-parameter"
  ];

  meta = {
    description = "Stream video from pipewire sources effortlessly";
    homepage = "https://github.com/raslen131/obs-pwvideo";
    maintainers = with lib.maintainers; [ ];
    license = lib.licenses.gpl2Only;
    inherit (obs-studio.meta) platforms;
  };
}
