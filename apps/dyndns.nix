{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dyndns.git";
    rev = "6a1e17a35334025577f0ab05ab6b2470e1cfef6a";
  };
in callPackage (import "${src}/dyndns.nix") {}
