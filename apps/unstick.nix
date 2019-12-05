{ callPackage }:

# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/unstick.git";
    rev = "5691ace9d210f506571bb1312ffca79216e4dfff";
  };
in callPackage (import "${src}/unstick.nix") {}
