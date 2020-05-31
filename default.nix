self: super:

let
  overlays = map import [ ./python ./apps ./hardware ./lib ];
  empty = self: super: {};
in (super.lib.foldl' super.lib.composeExtensions empty overlays) self super
