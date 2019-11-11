{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/pimostat.git";
    rev = "d209093a8f41bb1417c161d8dc1f592117161a9c";
  };
in callPackage (import "${src}/pimostat.nix") {}
