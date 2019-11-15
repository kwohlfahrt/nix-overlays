self: super: {
  linuxDtbsFor = kernel: args: super.callPackage ./linux-dtbs.nix ({ linux = kernel; } // args);
}
