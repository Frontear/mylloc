{
  stdenv,
  lib,
}:
let
  inherit (lib) cleanSource;
in stdenv.mkDerivation (finalAttrs: {
  pname = "mylloc";
  version = "0.1.0";

  src = cleanSource ../.;

  dontConfigure = true;

  buildPhase = ''
    $CC -fpic -shared -o lib$pname.so $src/lib/fmalloc.c
  '';

  installPhase = ''
    mkdir -p $out/lib

    install -Dm644 lib$pname.so $out/lib
    cp -R $src/lib/include $out
  '';

  meta = with lib; {
    description = "Simple custom implementation of `malloc(3)` for educational purposes.";
    homepage = "https://github.com/Frontear/mylloc";
    license = licenses.gpl2;
    maintainers = with maintainers; [ frontear ];
  };
})
