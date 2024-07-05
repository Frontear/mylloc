{ ... }: {
  perSystem = { self', pkgs, ... }: {
    apps.default = {
      type = "app";
      program = pkgs.callPackage ./app.nix { mylloc = self'.packages.default; };
    };

    devShells.default = import ./shell.nix { inherit pkgs; };

    packages.default = pkgs.callPackage ./package.nix { };
  };
}
