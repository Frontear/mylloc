{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.default = import ./shell.nix { inherit pkgs; };

    packages.default = pkgs.callPackage ./package.nix { };
  };
}
