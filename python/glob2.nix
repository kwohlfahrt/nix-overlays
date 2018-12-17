{ buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  version = "0.6";
  pname = "glob2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1miyz0pjyji4gqrzl04xsxcylk3h2v9fvi7hsg221y11zy3adc7m";
  };
}
