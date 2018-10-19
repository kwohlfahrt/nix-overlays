{ buildPythonPackage, fetchgit, numpy, scipy, pymongo, six, networkx, future, nose }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "hyperopt";
  version = "0.1.1";
  src = fetchgit {
    url = "https://www.github.com/${pname}/${pname}.git";
    rev = version;
    sha256 = "0kmni077634z9bj4wk689s03ymz8ymc866rh06pg4h6pih366mll";
  };

  propagatedBuildInputs = [ numpy scipy pymongo six networkx future ];
  checkInputs = [ nose ];

  doCheck = false; # FIXME: tries to use mongod
}
