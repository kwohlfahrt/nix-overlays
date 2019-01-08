self: super:

let
  empty = self: super: {};
in {
  # nixpkgs#44426
  pythonOverrides = super.lib.composeExtensions (self: super: {
    dotmap = super.callPackage ./dotmap {};
    tensorboardX = super.callPackage ./tensorboardX {};
    hyperopt = super.callPackage ./hyperopt {};
    yacs = super.callPackage ./yacs {};
    glob2 = super.callPackage ./glob2 {};
    rdkit = self.toPythonModule (super.callPackage ./rdkit {});
  }) (super.pythonOverrides or empty);

  python3 = super.python3.override {
    packageOverrides = self.pythonOverrides;
  };
}
