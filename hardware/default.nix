self: super: {
  linuxDtbsFor = kernel: args: super.callPackage ./linux-dtbs.nix ({ linux = kernel; } // args);
  dt-overlays = super.callPackage ./dt-overlays.nix {};
}