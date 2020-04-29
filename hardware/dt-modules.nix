# I expect this to be a common pattern, might need factoring out
let
  src = builtins.fetchGit {
    url = "https://github.com/kwohlfahrt/dt-overlays.git";
    rev = "b60ba5c821a1e226ea056b69b0e25b34a0356dc4";
  };
in import "${src}/dt-modules.nix"
