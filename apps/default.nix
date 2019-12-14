self: super: {
  gomod2nix = super.callPackage ./gomod2nix.nix {};
  quartus-prime = super.callPackage ./quartus-prime {};
  oath = super.callPackage ./oath.nix {};
  vipaccess = super.callPackage ./vipaccess.nix {};
  dyndns = super.callPackage ./dyndns.nix {};
  unstick = super.callPackage ./unstick.nix {};
  pimostat = super.callPackage ./pimostat.nix {};
  plz-cli = super.callPackage ./plz-cli.nix {};
}
