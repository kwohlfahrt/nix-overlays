self: super: {
  python3 = super.python3.override {
    packageOverrides = import ./python/default.nix;
  };
}
