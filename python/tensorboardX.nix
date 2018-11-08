{ buildPythonPackage, fetchgit, numpy, protobuf, six, pytest, matplotlib, pytorch, torchvision, flake8 }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "tensorboardX";
  version = "1.4";
  # tests are not packaged on pypi
  src = fetchgit {
    url = "https://github.com/lanpa/tensorboardX.git";
    # No git tag for v1.4, see github issue #221
    rev = "6a80f7b7afece5cebaceb5985217478129e6aa5b";
    sha256 = "0378k95pb6nymamszwrjgh6bv9bf3x7xj4fqg7rj3fcy43bgjd77";
  };

  propagatedBuildInputs = [ numpy protobuf six ];
  checkInputs = [ pytest matplotlib pytorch torchvision flake8 ];

  checkPhase = ''
    flake8 tensorboardX/
    # test_test makes HTTP requests
    pytest -k "not test_test"
  '';
}
