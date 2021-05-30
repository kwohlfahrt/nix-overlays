{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://pi.home/git/pimostat.git";
    rev = "6d72a40a33bc7e991a6cead50dcd1493e6cff692";
  };
in callPackage (import "${src}/pimostat.nix") {}
