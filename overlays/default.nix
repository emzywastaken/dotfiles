{pkgs, ...}: {
  nixpkgs.overlays = [
    (_: prev: {
      custom = import ../pkgs {inherit pkgs;};
    })
  ];
}
