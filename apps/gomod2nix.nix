{ callPackage, fetchgit }:

# I expect this to be a common pattern, might need factoring out
let
  src = fetchgit {
    url = "https://github.com/kwohlfahrt/gomod2nix.git";
    rev = "7a7b43a48b637a9ed94ee505c8bc2fb1a331a842";
    sha256 = "1x4nq7idk9qhifd1f6c8xjw4g5li4ldfg2i9ddmm7gk3l8lhxarl";
  };
in callPackage (import "${src.out}/gomod2nix.nix") {}
