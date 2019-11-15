# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dt-overlays.git";
    rev = "e6a5eea656a26134e76eee2f2e53f40c2911aa31";
  };
in import "${src}/dt-overlays.nix"
