{ stdenv, fetchFromGitHub, fetchurl, cmake, boost, sqlite, catch2, rapidjson, python, unzip, numpy, pillow }:

let
  maeparser_src = fetchFromGitHub {
    owner = "schrodinger";
    repo = "maeparser";
    rev = "v1.0.1";
    sha256 = "1n72x87rz5w7w1qnhib0djjrgixa0rimav5q8wv8zjzi8scahsw8";
  };
  coordgen_src = fetchFromGitHub {
    owner = "schrodinger";
    repo = "coordgenlibs";
    rev = "v1.1";
    sha256 = "022nyk1bcqsnfpfx5032844x7qkc0rgcz30acq5h9a35vf18i44y";
  };
  catch2_src = fetchFromGitHub {
    owner = "catchorg";
    repo = "Catch2";
    # This specific version is required, the one in nixpkgs has moved files
    rev = "v2.1.2";
    sha256 = "14vcckqmbydjsg40ngi6iv999zimysh2l7fmrqj1d7xl990qz233";
  };
 inchi_src = fetchurl {
    url = "http://www.inchi-trust.org/download/105/INCHI-1-SRC.zip";
    sha256 = "081pcjx1z5jm23fs1pl2r3bccia0ww8wfkzcjpb7byhn7b513hsa";
  };
  avalon_src = fetchurl {
    url = "http://sourceforge.net/projects/avalontoolkit/files/AvalonToolkit_1.2/AvalonToolkit_1.2.0.source.tar";
    sha256 = "0rnnyy6axs2da7aa4q6l30ldavbk49v6l22llj1adn74h1i67bpv";
  };
  freesasa_src = fetchFromGitHub {
    owner = "mittinatten";
    repo = "freesasa";
    # This specific version is required, the one in nixpkgs has moved files
    rev = "2.0.1";
    sha256 = "1ajgsracz5n3fgpzif01k7gzw7ygfypgsgcc0i1xjrdd2grzam41";
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

  patches = [ ./avalon-tools.patch ];

  buildInputs = [ cmake boost sqlite catch2 unzip ];
  propagatedBuildInputs = [ numpy pillow ];

  postUnpack = ''
    # Hack rapidjson into the right place, since no RAPIDJSON_DIR flag exists
    ln -s ${rapidjson.src} source/External/rapidjson-1.1.0
    # _DIR flags don't seem to work either... (#includes are broken)
    ln -s ${maeparser_src} source/External/CoordGen/maeparser
    ln -s ${coordgen_src} source/External/CoordGen/coordgenlibs
    ln -s ${catch2_src} source/External/catch/catch
    # Unpack inchi_src
    unzip -d source/External/INCHI-API ${inchi_src}
    mv source/External/INCHI-API/INCHI-1-SRC source/External/INCHI-API/src
    # Unpack avalon tools
    tar -xf ${avalon_src} -C source/External/AvalonTools
    patch --directory=source/External/AvalonTools --strip=0 --input=AvalonToolkit_1.2_patch.txt
    # Download and prepare FreeSASA
    cp -r ${freesasa_src} source/External/FreeSASA/freesasa-${freesasa_src.rev}
    chmod +w source/External/FreeSASA/freesasa-${freesasa_src.rev}/src/
    cp source/External/FreeSASA/freesasa2.c source/External/FreeSASA/freesasa-${freesasa_src.rev}/src/
    ls -l source/External/FreeSASA/freesasa-${freesasa_src.rev} source/External/CoordGen/maeparser/
  '';

  cmakeFlags = [
    "-DRDK_INSTALL_INTREE=OFF"
    "-DRDK_BUILD_PYTHON_WRAPPERS=ON"

    # From RDKit .travis.yml
    "-DRDK_BUILD_AVALON_SUPPORT=ON"
    "-DRDK_BUILD_INCHI_SUPPORT=ON"
    "-DRDK_BUILD_THREADSAFE_SSS=ON"
    "-DRDK_BUILD_FREESASA_SUPPORT=ON"
    "-DRDK_TEST_MULTITHREADED=ON"

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
