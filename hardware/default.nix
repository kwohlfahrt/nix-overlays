self: super: {
  dt-overlays = super.callPackage ./dt-overlays.nix {};
  dt-modules = super.callPackage ./dt-modules.nix {};
}
