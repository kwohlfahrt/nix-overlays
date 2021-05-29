self: super: {
  gomod2nix = super.callPackage ./gomod2nix.nix {};
  oath = super.callPackage ./oath.nix {};
  vipaccess = super.callPackage ./vipaccess.nix {};
  dyndns = super.callPackage ./dyndns.nix {};
  unstick = super.callPackage ./unstick.nix {};
  pimostat = super.callPackage ./pimostat.nix {};
  plz-cli = super.callPackage ./plz-cli.nix {};
  nix = super.nix.overrideAttrs (o: {
    passthru.perl-bindings = o.passthru.perl-bindings.overrideAttrs (o: {
      patches = [(super.writeText "perl-sigs.patch" ''
        diff --git a/lib/Nix/Store.xs b/lib/Nix/Store.xs
        index ce553bb53..e76d71cef 100644
        --- a/lib/Nix/Store.xs
        +++ b/lib/Nix/Store.xs
        @@ -111,10 +111,14 @@ SV * queryPathInfo(char * path, int base32)
                     XPUSHs(sv_2mortal(newSVpv(s.c_str(), 0)));
                     mXPUSHi(info->registrationTime);
                     mXPUSHi(info->narSize);
        -            AV * arr = newAV();
        -            for (PathSet::iterator i = info->references.begin(); i != info->references.end(); ++i)
        -                av_push(arr, newSVpv(i->c_str(), 0));
        -            XPUSHs(sv_2mortal(newRV((SV *) arr)));
        +            AV * refs = newAV();
        +            for (auto & i : info->references)
        +                av_push(refs, newSVpv(i.c_str(), 0));
        +            XPUSHs(sv_2mortal(newRV((SV *) refs)));
        +            AV * sigs = newAV();
        +            for (auto & i : info->sigs)
        +                av_push(sigs, newSVpv(i.c_str(), 0));
        +            XPUSHs(sv_2mortal(newRV((SV *) sigs)));
                 } catch (Error & e) {
                     croak("%s", e.what());
                 }
      '')];
    });
  });
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
