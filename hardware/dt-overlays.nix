# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dt-overlays.git";
    rev = "e5fb9ff46facd986d01d61c59d1a39627b07b05e";
  };
in import "${src}/dt-overlays.nix"
