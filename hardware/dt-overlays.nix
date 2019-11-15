# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dt-overlays.git";
    rev = "9e3749d1bd3dbda3a54c1206954018819b0a2312";
  };
in import "${src}/dt-overlays.nix"
