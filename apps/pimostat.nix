{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/pimostat.git";
    rev = "b8b1322297fb96ea680cdcc3e3036a9c9abfd5b6";
  };
in callPackage (import "${src}/pimostat.nix") {}
