{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dyndns.git";
    rev = "2f57c05b54dec8fe98cddfd81c125d4e2b20918b";
  };
in callPackage (import "${src}/dyndns.nix") {}
