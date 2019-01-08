{ stdenv, fetchFromGitHub, fetchurl, cmake, boost, sqlite, catch2, rapidjson, python, unzip, numpy, pillow }:

let
  maeparser_src = fetchFromGitHub {
    owner = "schrodinger";
    repo = "maeparser";
    rev = "v1.0.1";
    sha256="1n72x87rz5w7w1qnhib0djjrgixa0rimav5q8wv8zjzi8scahsw8";
  };
  coordgen_src = fetchFromGitHub {
    owner = "schrodinger";
    repo = "coordgenlibs";
    rev = "v1.1";
    sha256="022nyk1bcqsnfpfx5032844x7qkc0rgcz30acq5h9a35vf18i44y";
  };
  catch2_src = fetchFromGitHub {
    owner = "catchorg";
    repo = "Catch2";
    # This specific version is required, the one in nixpkgs has moved files
    rev = "v2.1.2";
    sha256="14vcckqmbydjsg40ngi6iv999zimysh2l7fmrqj1d7xl990qz233";
  };
in stdenv.mkDerivation rec {
  pname = "rdkit";
  version = "2018.09.1";

  srcs = fetchFromGitHub {
    owner = "rdkit";
    repo = pname;
    rev = "Release_2018_09_1";
    sha256 = "1nfkmzqdmdfgjwqvxj4vn42kr06fblmx09qwy8knhqqn24f1y383";
  };

  buildInputs = [ cmake boost sqlite catch2 unzip ];
  propagatedBuildInputs = [ numpy pillow ];

  postUnpack = ''
    # Hack rapidjson into the right place, since no RAPIDJSON_DIR flag exists
    ln -s ${rapidjson.src} source/External/rapidjson-1.1.0
    # _DIR flags don't seem to work either... (#includes are broken)
    ln -s ${maeparser_src} source/External/CoordGen/maeparser
    ln -s ${coordgen_src} source/External/CoordGen/coordgenlibs
    ln -s ${catch2_src} source/External/catch/catch
  '';

  cmakeFlags = [
    "-DRDK_INSTALL_INTREE=OFF"
    "-DRDK_BUILD_PYTHON_WRAPPERS=ON"

    # Disable unnecessary bits
    "-DRDK_INSTALL_STATIC_LIBS=OFF"
    "-DRDK_BUILD_SWIG_WRAPPERS=OFF"
    "-DRDK_SWIG_STATIC=OFF"
  ];

  doInstallCheck = false;
  installCheckPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH ctest
  '';
}
