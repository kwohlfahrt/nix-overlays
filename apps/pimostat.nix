{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://pi.home/git/pimostat.git";
    rev = "a3913e7dcc5ea7860939a4ce8700abcdc5385ae5";
  };
in callPackage (import "${src}/pimostat.nix") {}
