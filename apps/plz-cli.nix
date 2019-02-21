{ stdenv, python3, requireFile, fetchgit, timestamp ? null, sha256 ? null }:

let
  base_version = "0.1";
in python3.pkgs.buildPythonApplication (rec {
  version = "${base_version}.0";
  name = "${pname}-${version}";
  pname = "plz-cli";

  propagatedBuildInputs = (with python3.pkgs;
    [ docker glob2 prettytable python-dateutil paramiko requests urllib3 ]
  );
} // (if timestamp == null then {
  src = fetchGit {
    url = "https://github.com/prodo-ai/plz.git";
    rev = "92b371f57f241f731551bd828264047502cc44b9";
  };
  sourceRoot = "source/cli";
  checkInputs = with python3.pkgs; [ nose flask ];
  doCheck = true;
  checkPhase = ''
    nosetests
  '';
} else {
  format = "wheel";
  src = let
    hash = sha256; # Avoid infinite recursion
  in requireFile rec {
    name = "plz_cli-${base_version}.${timestamp}-py3-none-any.whl";
    sha256 = if hash != null then hash else abort message;

    message = ''
      When installing a specific timestamp, ${name} must be prefetched. Run:

          nix-prefetch-url "https://s3-eu-west-1.amazonaws.com/plz.prodo.ai/${name}"

      and then re-run the derivation with the `sha256` argument.
    '';
  };
}))
