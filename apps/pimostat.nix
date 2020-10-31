{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://pi.home/git/pimostat.git";
    rev = "d69867b49461aba00f2c5063a4568bc2f0a6347f";
  };
in callPackage (import "${src}/pimostat.nix") {}
