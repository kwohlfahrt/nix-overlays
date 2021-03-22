{
  asciidoctor = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1gjk9v83vw0pz4x0xqqnw231z9sgscm6vnacjw7hy5njkw8fskj9";
      type = "gem";
    };
    version = "2.0.12";
  };
  asciidoctor-multipage = {
    dependencies = ["asciidoctor"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1r7q2wkjnq2lnhg396hvpc9g3j6ylzy5f25g4cwdcr63p2h3b8xn";
      type = "gem";
    };
    version = "0.0.9";
  };
}
