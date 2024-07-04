let
  flakeLock = builtins.fromJSON (builtins.readFile ../flake.lock);

  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${flakeLock.nodes.nixpkgs.locked.rev}.tar.gz";
    sha256 = flakeLock.nodes.nixpkgs.locked.narHash;
  };
in
{
  pkgs ? import nixpkgs {}
}:
pkgs.mkShell {
  packages = with pkgs; [
    man-pages
  ];
}
