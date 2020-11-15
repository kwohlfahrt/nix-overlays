self: super: let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dt-overlays.git";
    rev = "d922be1a7bf4db1975b93cfc81c8cfc9ee7a52d5";
  };
in {
  dt-overlays = super.callPackage (import "${src}/dt-overlays.nix") {};
  dt-modules = super.callPackage (import "${src}/dt-modules.nix") {};
}
