{ buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "dotmap";
  version = "1.2.20";
  src = fetchPypi {
    inherit pname version;
    sha256 = "10gzakmbb0mpv8kl2lii062z6m3hachz3wx5iawxqadjqxzsj4ac";
  };
}