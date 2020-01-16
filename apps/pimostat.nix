{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/pimostat.git";
    rev = "8657232b2f1d20e5759f415c180092558e35ad86";
  };
in callPackage (import "${src}/pimostat.nix") {}
