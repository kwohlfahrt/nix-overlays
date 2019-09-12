{ buildPythonPackage, fetchgit, tifffile, numpy, click, scipy, pytest, matplotlib }:

buildPythonPackage rec {
  version = "0.6";
  pname = "glob2";

  src = fetchgit {
    url = "https://github.com/kwohlfahrt/tiffutil.git";
    rev = "5d3980f80e7a723066a9d29d8afe957753a51bb4";
    sha256 = "1gm2srhr60ra5ihmpkh5sbkd359m2mz4g203jjgbmvia615vg7il";
  };

  propagatedBuildInputs = [ tifffile numpy click scipy matplotlib ];

  checkInputs = [ pytest ];
  doCheck = true;
}
