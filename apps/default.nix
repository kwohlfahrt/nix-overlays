self: super: {
  gomod2nix = super.callPackage ./gomod2nix.nix {};
  quartus-prime-lite = super.callPackage ./quartus-prime-lite {};
  oath = super.callPackage ./oath.nix {};
  vipaccess = super.callPackage ./vipaccess.nix {};
  dyndns = super.callPackage ./dyndns.nix {};
  unstick = super.callPackage ./unstick.nix {};
  pimostat = super.callPackage ./pimostat.nix {};
  plz-cli = super.callPackage ./plz-cli.nix {};
}
