{ buildPythonPackage, fetchPypi, pyyaml }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "yacs";
  version = "0.1.4";
  src = fetchPypi {
    inherit pname version;
    sha256 = "0mqg5lz4jsg5b94nnxq89976d4pq0b589l6pfgxd1l14jbc8pr1a";
  };

  propagatedBuildInputs = [ pyyaml ];

  # Issue 7
  doCheck = false;
  checkPhase = ''
    python yacs/tests.py
  '';
}