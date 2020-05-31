self: super: {
  lib = super.lib // {
    getFqdn = config: with config.networking; if domain == null then hostName else "${hostName}.${domain}";
  };
}
