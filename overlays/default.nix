{pkgs, ...}: {
  nixpkgs.overlays = [
    (_: _: {
      custom = import ../pkgs {inherit pkgs;};
    })
  ];
}
