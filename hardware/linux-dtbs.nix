{ stdenv, linux, dtc, bison, flex }:

stdenv.mkDerivation {
  inherit (linux) version src makeFlags nativeBuildInputs;
  name = "${linux.name}-dtbs";

  configurePhase = ''
    export buildRoot="$(pwd)/build"
    mkdir -p $buildRoot
    ln -sv ${linux.configfile} $buildRoot/.config
  '';

  buildPhase = ''
    make $makeFlags "''${makeFlagsArray[@]}" dtbs DTC_FLAGS="-@"
  '';

  installPhase = ''
    make $makeFlags "''${makeFlagsArray[@]}" dtbs_install INSTALL_DTBS_PATH=$out/dtbs
  '';
}
