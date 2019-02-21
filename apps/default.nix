self: super: {
  gomod2nix = super.callPackage ./gomod2nix.nix {};
  oath = super.callPackage ./oath.nix {};
  vipaccess = super.callPackage ./vipaccess.nix {};
  dyndns = super.callPackage ./dyndns.nix {};
  plz-cli = super.callPackage ./plz-cli.nix {};
}
