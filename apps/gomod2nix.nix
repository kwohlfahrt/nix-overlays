{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/gomod2nix.git";
    rev = "7a7b43a48b637a9ed94ee505c8bc2fb1a331a842";
  };
in callPackage (import "${src}/gomod2nix.nix") {}
