self: super: {
  gomod2nix = super.callPackage ./gomod2nix.nix {};
  oath = super.callPackage ./oath.nix {};
  vipaccess = super.callPackage ./vipaccess.nix {};
  dyndns = super.callPackage ./dyndns.nix {};
  plz-cli = super.callPackage ./plz-cli.nix {};
  dtc_git = super.dtc.overrideAttrs (o: rec {
    version = "git";
    src = o.src.overrideAttrs (o: {
      rev = "b8d6eca78210952c6d93235c38ebd5836d6409c4";
      sha256 = "0a8rxw5xkm9jb3lh53sqk7d0yxir4mwf3m8rs9bl6ibdw2z5ivmy";
    });
  });
}
