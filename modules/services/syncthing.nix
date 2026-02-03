{
  pkgs,
  lib,
  ...
}: {
  # systemd.user.services.syncthing = {
  #   after = ["network.target"];
  #   wantedBy = ["default.target"];
  #   unitConfig.ConditionUser = "emzy";
  # };
  systemd.packages = [pkgs.syncthing];
}
