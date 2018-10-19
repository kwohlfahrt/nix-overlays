{ python3, fetchgit, oath }:

let
  pkgs = python3.pkgs;
in pkgs.buildPythonApplication rec {
  name = "${pname}-${version}";
  pname = "vipaccess";
  version = "0.9.0";

  src = fetchgit {
    url = "https://github.com/dlenski/python-vipaccess.git";
    rev = "v0.9.0";
    sha256 = "1gi97ni91hp2yvknhap9bjn59glw6pxzdfyya2zf81naymy47xr1";
  };

  propagatedBuildInputs = [ oath ] ++ (with pkgs; [ lxml pycryptodome requests ]);
  checkInputs = with pkgs; [ nose ];
  doCheck = false; # FIXME: some tests require network access
}
