{
  stdenv,
  lib,
  mylloc
}:
let
  inherit (lib) cleanSource;
in stdenv.mkDerivation (finalAttrs: {
  name = "mylloc-test";

  src = cleanSource ../.;

  nativeBuildInputs = [ mylloc ];

  dontConfigure = true;

  buildPhase = ''
    $CC -lmylloc -o $name $src/src/main.c
  '';

  installPhase = ''
    mkdir -p $out/bin

    cp $name $out/bin
  '';

  meta = with lib; {
    maintainers = with maintainers; [ frontear ];
    mainProgram = finalAttrs.name;
  };
})
