{ buildPythonPackage, fetchPypi, numpy, protobuf, six, pytest, matplotlib }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "tensorboardX";
  version = "1.4";
  src = fetchPypi {
    inherit pname version;
    sha256 = "1bkg9c1sscy9sxx3np2zzw8vzrdgqippjl1claz4177vr0jjikxs";
  };

  propagatedBuildInputs = [ numpy protobuf six ];
  checkInputs = [ pytest matplotlib ];

  doCheck = false; # FIXME
}