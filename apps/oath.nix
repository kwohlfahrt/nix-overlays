{ python3 }:

let
  pkgs = python3.pkgs;
in pkgs.buildPythonApplication rec {
  pname = "${name}-${version}";
  name = "oath";
  version = "1.4.1";

  src = pkgs.fetchPypi {
    inherit version;
    pname = name;
    sha256 = "1nrhpv025cv0pgpbzlspnrjzwqhvmfmx9r5ck2gc8mpygnnrxxb0";
  };
}
