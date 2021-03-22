{ lib, bundlerEnv, ruby }:

bundlerEnv rec {
  name = "asciidoctor-multipage-${version}";
  version = "0.0.10";

  inherit ruby;
  gemdir = ./.;
}
