{
  description = "Kai's Nix Overlays";

  outputs = { ... }: {
    lib = import ./lib;
    overlay = self: super: let
      libOverlay = self: super: { lib = super.lib // (import ./lib); };
      pkgOverlays = (map import [ ./python ./apps ./ruby ]);
    in (super.lib.foldl' super.lib.composeExtensions libOverlay pkgOverlays) self super;
  };
}
