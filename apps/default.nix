self: super: {
  gomod2nix = super.callPackage ./gomod2nix.nix {};
  oath = super.callPackage ./oath.nix {};
  vipaccess = super.callPackage ./vipaccess.nix {};
  nix-serve = super.nix-serve.overrideAttrs (o: {
    patches = [(super.writeText "sigs.patch" ''
      diff --git a/nix-serve.psgi b/nix-serve.psgi
      index 18d9e2a..e6ec46c 100644
      --- a/nix-serve.psgi
      +++ b/nix-serve.psgi
      @@ -25,7 +25,7 @@ my $app = sub {
               my $hashPart = $1;
               my $storePath = queryPathFromHashPart($hashPart);
               return [404, ['Content-Type' => 'text/plain'], ["No such path.\n"]] unless $storePath;
      -        my ($deriver, $narHash, $time, $narSize, $refs) = queryPathInfo($storePath, 1) or die;
      +        my ($deriver, $narHash, $time, $narSize, $refs, $sigs) = queryPathInfo($storePath, 1) or die;
               my $res =
                   "StorePath: $storePath\n" .
                   "URL: nar/$hashPart.nar\n" .
      @@ -42,6 +42,8 @@ my $app = sub {
                   my $fingerprint = fingerprintPath($storePath, $narHash, $narSize, $refs);
                   my $sig = signString($secretKey, $fingerprint);
                   $res .= "Sig: $sig\n";
      +        } elsif (defined $sigs && @$sigs) {
      +            $res .= join("\n", map { "Sig: $_" } @$sigs) . "\n";
               }
               return [200, ['Content-Type' => 'text/x-nix-narinfo'], [$res]];
           }
    '')];
  });
}
