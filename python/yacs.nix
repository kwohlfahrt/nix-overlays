{ buildPythonPackage, fetchFromGitHub, pyyaml }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "yacs";
  version = "0.1.5";
  src = fetchFromGitHub {
    owner = "rbgirshick";
    repo = pname;
    rev = "v${version}";
    sha256 = "0h6cgya3i10vqnzzd8xvzwz9x86zgfpgdw8isq45psbp7l516yi9";
  };

  propagatedBuildInputs = [ pyyaml ];

  installCheckPhase = ''
    python yacs/tests.py
  '';
}
