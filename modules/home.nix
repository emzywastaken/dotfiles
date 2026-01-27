{lib, ...}: {
  imports = [(lib.mkAliasOptionModule ["hj"] ["hjem" "users" "emzy"])];

  hjem = {
    clobberByDefault = true;
    users.emzy = {
      enable = true;
      # this interferes with home-manager's systemd unit management
      systemd.enable = false;
    };
  };
}
