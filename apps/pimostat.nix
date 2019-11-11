{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/pimostat.git";
    ref = "wip";
    rev = "964e5af3cc5284f04dfb84d88a81d7a0b3036399";
  };
in callPackage (import "${src}/pimostat.nix") {}
