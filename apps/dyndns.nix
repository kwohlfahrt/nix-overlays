{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dyndns.git";
    rev = "ecb5fc1f7453688add410310853bb01eced35f3d";
  };
in callPackage (import "${src}/dyndns.nix") {}
