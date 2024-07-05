# mylloc
Simple custom implementation of `malloc(3)` for educational purposes.

## Table Of Contents
- [Building](#building)
- [Installing + Linking](#installing--linking)
- [License](#license)

## Building
Start by cloning the repository via `git clone https://github.com/Frontear/mylloc.git`.

- If GNU Make: `prefix=result make install`
- If Nix/NixOS: `nix build .#default`

The final shared library and include headers will be in `results/`:
```
result
├── include
│  └── fmalloc.h
└── lib
   └── libmylloc.so
```

## Installing + Linking
If you're running a standard Linux distribution, `sudo make install` will be enough.
You can then link it via `-lmylloc`:
```console
$ $CC -o my-app -lmylloc src/main.c
$ ./my-app
segmentation fault (core dumped) ./my-app
```

If you are running NixOS, you will need to attach this project to your package `nativeBuildInputs`.
You can see a flake example of this here:
```nix
# flake.nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.mylloc.url = "github:Frontear/mylloc";

  outputs = { nixpkgs, mylloc, ... }: {
    packages."x86_64-linux".default = nixpkgs.legacyPackages."x86_64-linux".callPackage ./package.nix { mylloc = mylloc.packages."x86_64-linux".default; };
  };
}

# package.nix
{
  stdenv,
  mylloc,
}:
stdenv.mkDerivation {
  nativeBuildInputs = [ mylloc ];
  
  # ...
}
```

## License
All code in this repo is subject to the GNU General Public License v3.0. Please be mindful of this when forking, download, and redistributing.
