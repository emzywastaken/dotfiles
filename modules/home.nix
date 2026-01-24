{lib, ...}: {
  imports = [(lib.mkAliasOptionModule ["hj"] ["hjem" "users" "emzy"])];

  hjem = {
    clobberByDefault = true;
    users.emzy.enable = true;
  };
}
