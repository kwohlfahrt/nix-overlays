{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/pimostat.git";
    rev = "c2a485e4641b575d72f7a2a792327fe6a97acf91";
  };
in callPackage (import "${src}/pimostat.nix") {}
