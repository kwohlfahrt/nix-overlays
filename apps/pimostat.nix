{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://pi.home/git/pimostat.git";
    rev = "7248d20f8eccde5c74fb04f2d67921e359b615e7";
  };
in callPackage (import "${src}/pimostat.nix") {}
