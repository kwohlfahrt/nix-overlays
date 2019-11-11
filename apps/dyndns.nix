{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dyndns.git";
    rev = "314ea6939668320176850bea9de5a3b5eb82cd60";
  };
in callPackage (import "${src}/dyndns.nix") {}
