self: super: {
  dotmap = self.callPackage ./dotmap.nix {};
  tensorboardX = self.callPackage ./tensorboardX.nix {};
  hyperopt = self.callPackage ./hyperopt.nix {};
}
