self: super: {
  python3 = super.python3.override {
    packageOverrides = self: super: {
      dotmap = self.callPackage ./dotmap.nix {};
      tensorboardX = self.callPackage ./tensorboardX.nix {};
      hyperopt = self.callPackage ./hyperopt.nix {};
    };
  };
}
