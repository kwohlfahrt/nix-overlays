self: super:

let
  empty = self: super: {};
in {
  # nixpkgs#44426
  pythonOverrides = super.lib.composeExtensions (self: super: {
    dotmap = super.callPackage ./dotmap.nix {};
    tensorboardX = super.callPackage ./tensorboardX.nix {};
    hyperopt = super.callPackage ./hyperopt.nix {};
    yacs = super.callPackage ./yacs.nix {};
    glob2 = super.callPackage ./glob2.nix {};
    rdkit = self.toPythonModule (super.callPackage ./rdkit.nix {});
  }) (super.pythonOverrides or empty);

  python3 = super.python3.override {
    packageOverrides = self.pythonOverrides;
  };
}
