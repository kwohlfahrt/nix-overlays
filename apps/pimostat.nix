{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/pimostat.git";
    rev = "6dbab5e4a0eb8b7d8bd012ebd33997e487baab20";
  };
in callPackage (import "${src}/pimostat.nix") {}
