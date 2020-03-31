# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dt-overlays.git";
    rev = "8369f0f04f83a56bf9fec04e6a411c2e55165754";
  };
in import "${src}/dt-overlays.nix"
