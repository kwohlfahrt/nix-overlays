{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/pimostat.git";
    rev = "c6b40021cb7b91d23e83bc28e111c86404f60776";
  };
in callPackage (import "${src}/pimostat.nix") {}
