{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://pi.home/git/pimostat.git";
    rev = "1765436e401751e94dac8683927a89473a27584f";
  };
in callPackage (import "${src}/pimostat.nix") {}
