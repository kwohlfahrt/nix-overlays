{
  description = "Kai's Nix Overlays";

  outputs = { ... }: {
    overlay = self: super: let
      overlays = map import [ ./python ./apps ./hardware ./lib ./ruby ];
      empty = self: super: {};
    in (super.lib.foldl' super.lib.composeExtensions empty overlays) self super;
  };
}
