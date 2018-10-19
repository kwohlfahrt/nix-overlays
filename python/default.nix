self: super: {
  python3 = super.python3.override {
    packageOverrides = self: super: {
      dotmap = super.callPackage ./dotmap.nix {};
      tensorboardX = super.callPackage ./tensorboardX.nix {};
      hyperopt = super.callPackage ./hyperopt.nix {};
    };
  };
}
