{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/unstick.git";
    rev = "effee9aa242ca12dc94cc6e96bc073f4cc9e8657";
  };
in callPackage (import "${src}/unstick.nix") {}
