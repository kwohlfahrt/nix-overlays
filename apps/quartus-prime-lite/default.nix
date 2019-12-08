{ buildFHSUserEnv, stdenv, lib, requireFile, unstick, cycloneVSupport ? true }:

let
  quartus = stdenv.mkDerivation rec {
    version = "19.1.0.670";
    pname = "quartus-prime-lite";

    src = let
      require = {name, sha256}: requireFile {
        inherit name sha256;

        message = ''
          This nix expression requires that ${name} is already part of the store.
          Download it from ${meta.homepage} and add it to the nix store with:

              nix-prefetch-url <URL>

          This can't be done automatically because you need to create an account on
          their website and agree to their license terms before you can download
          it. That's what you get for using proprietary software.
        '';
      };
    in map require ([{
      name = "QuartusLiteSetup-${version}-linux.run";
      sha256 = "15vxvqxqdk29ahlw3lkm1nzxyhzy4626wb9s5f2h6sjgq64r8m7f";
    } {
      name = "ModelSimSetup-${version}-linux.run";
      sha256 = "0j1vfr91jclv88nam2plx68arxmz4g50sqb840i60wqd5b0l3y6r";
    }] ++ lib.optional cycloneVSupport {
      name = "cyclonev-${version}.qdz";
      sha256 = "0bqxpvjgph0y6slk0jq75mcqzglmqkm0jsx10y9xz5llm6zxzqab";
    });

    nativeBuildInputs = [ unstick ];

    buildCommand = let
      installers = lib.sublist 0 2 src;
      components = lib.sublist 2 ((lib.length src) - 2) src;
      copyInstaller = installer: ''
      # `$(cat $NIX_CC/nix-support/dynamic-linker) $src[0]` often segfaults, so cp + patchelf
      cp ${installer} $TEMP/${installer.name}
      chmod u+w,+x $TEMP/${installer.name}
      patchelf --interpreter $(cat $NIX_CC/nix-support/dynamic-linker) $TEMP/${installer.name}
    '';
      copyComponent = component: "cp ${component} $TEMP/${component.name}";
      # leaves enabled: quartus, modelsim_ase, devinfo
      disabledComponents = [
        "quartus_help"
        "quartus_update"
        "modelsim_ae"
        # Devices
        "arria_lite"
        "cyclone"
        "cyclone10lp"
        "max"
        "max10"
      ] ++ lib.optional (!cycloneVSupport) "cyclonev";
    in ''
    ${lib.concatMapStringsSep "\n" copyInstaller installers}
    ${lib.concatMapStringsSep "\n" copyComponent components}

    unstick $TEMP/${(builtins.head installers).name} \
      --disable-components ${lib.concatStringsSep "," disabledComponents} \
      --mode unattended --installdir $out --accept_eula 1

    # This patch is from https://wiki.archlinux.org/index.php/Altera_Design_Software
    patch --force --strip 0 --directory $out < ${./vsim.patch}

    rm -r $out/uninstall $out/logs
  '';

    meta = {
      homepage = https://fpgasoftware.intel.com;
      description = "FPGA design and simulation software";
      license = lib.licenses.unfree;
      platforms = lib.platforms.linux;
    };
  };

# I think modelsim_ase/linux/vlm checksums itself, so use FHSUserEnv instead of `patchelf`
in buildFHSUserEnv {
  name = "quartus";

  targetPkgs = pkgs: with pkgs; [
    quartus
    # quartus requirements
    glib
    xorg.libICE
    xorg.libSM
    zlib
  ];
  multiPkgs = pkgs: with pkgs; [
    # modelsim requirements
    libxml2
    ncurses5
    unixODBC
    xorg.libXft
    # common requirements
    freetype
    fontconfig
    xorg.libX11
    xorg.libXext
    xorg.libXrender
  ];

  runScript = "${quartus}/quartus/bin/quartus";
}
