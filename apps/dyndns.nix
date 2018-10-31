{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dyndns.git";
    rev = "5e30e68591f6c00460e99e88f8eb74ce7c2d8494";
  };
in callPackage (import "${src}/dyndns.nix") {}
