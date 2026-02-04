{
  stdenv,
  fetchFromGitHub,

  meson,
  ninja,

  dbus,
  wineWowPackages,
  libgbm,
  libdrm,
  vulkan-loader,
}:
stdenv.mkDerivation {
  name = "spout2pw";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "hoshinolina";
    repo = "spout2pw";
    rev = "85e4469c5b406fbeabb667a73a9106f09a976852";
    hash = "";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  buildInputs = [
    dbus.dev
    wineWowPackages.minimal
    libgbm
    libdrm
    vulkan-loader
  ];
}
