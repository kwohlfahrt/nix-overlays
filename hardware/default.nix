self: super: {
  linuxDtbsFor = kernel: super.callPackage ./linux-dtbs.nix { linux = kernel; };
}
