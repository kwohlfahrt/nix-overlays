{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/pimostat.git";
    rev = "03759f9468f01845e61a5a50fef12b73c3c067c0";
  };
in callPackage (import "${src}/pimostat.nix") {}
