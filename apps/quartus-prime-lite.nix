{ stdenv, lib, requireFile, makeWrapper,
  unstick, file, freetype, fontconfig, glib, xorg, zlib,
  cycloneVSupport ? true }:

let
  libPath = stdenv.lib.makeLibraryPath [
    stdenv.cc.cc
    freetype
    fontconfig
    glib
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    zlib
  ];
  homepage = https://fpgasoftware.intel.com;
  require = {name, sha256}: requireFile rec {
    inherit name sha256;

    message = ''
      This nix expression requires that ${name} is already part of the store.
      Download it from ${homepage} and add it to the nix store with:

          nix-prefetch-url <URL>

      This can't be done automatically because you need to create an account on
      their website and agree to their license terms before you can download
      it. That's what you get for using proprietary software.
    '';
  };

in stdenv.mkDerivation rec {
  version = "19.1.0.670";
  pname = "quartus-prime-lite";

  src = map require ([{
    name = "QuartusLiteSetup-${version}-linux.run";
    sha256 = "15vxvqxqdk29ahlw3lkm1nzxyhzy4626wb9s5f2h6sjgq64r8m7f";
  }] ++ lib.optional cycloneVSupport {
    name = "cyclonev-${version}.qdz";
    sha256 = "0bqxpvjgph0y6slk0jq75mcqzglmqkm0jsx10y9xz5llm6zxzqab";
  });

  dontUnpack = true;

  nativeBuildInputs = [ unstick file makeWrapper ];

  installPhase = let
    installer = builtins.head src;
    components = builtins.tail src;
    copyComponent = component: "cp ${component} $TEMP/${component.name}";
    # leaves the following: quartus, modelsim_ae, modelsim_ase, devinfo
    disabledComponents = [
      "quartus_help"
      "arria_lite"
      "cyclone"
      "cyclone10lp"
      "max"
      "max10"
      "quartus_update"
    ] ++ lib.optional (!cycloneVSupport) "cyclonev";
  in ''
    # `$(cat $NIX_CC/nix-support/dynamic-linker) $src[0]` often segfaults, so cp + patchelf
    cp ${installer} $TEMP/${installer.name}
    chmod u+w,+x $TEMP/${installer.name}

    ${lib.concatMapStringsSep "\n" copyComponent components}

    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $TEMP/${installer.name}
    unstick $TEMP/${installer.name} \
      --disable-components ${lib.concatStringsSep "," disabledComponents} \
      --mode unattended --installdir $out --accept_eula 1
    rm -r $out/uninstall $out/logs
  '';

  postFixup = ''
    for f in $(find $out/quartus/linux64/ -type f); do
      FILETYPE=$(file $f)
      if echo $FILETYPE | grep -q "ELF 64-bit LSB shared object"; then
        patchelf --set-rpath $out/quartus/linux64:${libPath} $f
      elif echo $FILETYPE | grep -q "ELF 64-bit LSB executable"; then
        patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
          --set-rpath $out/quartus/linux64:${libPath} $f
      fi
    done

    mkdir -p $out/share
    mv $out/licenses $out/share

    mkdir -p $out/bin
    makeWrapper $out/quartus/bin/quartus $out/bin/quartus
  '';

  meta = {
    inherit homepage;
    description = "FPGA design and simulation software";
    license = stdenv.lib.licenses.unfree;
    platforms = stdenv.lib.platforms.linux;
  };
}
