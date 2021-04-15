self: super: let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dt-overlays.git";
    rev = "3d97c215d337a9dc0dfbcabafdedcd6f13bc658a";
  };
in {
  dt-overlays = super.callPackage (import "${src}/dt-overlays.nix") {};
  dt-modules = super.callPackage (import "${src}/dt-modules.nix") {};
}
