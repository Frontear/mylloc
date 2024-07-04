{
  stdenv,
  lib,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "mylloc";
  version = "0.1.0";

  src = lib.cleanSource ../src;

  buildPhase = ''
    $CC -o $pname $src/main.c
  '';

  installPhase = ''
    mkdir -p $out/bin

    install -Dm755 $pname $out/bin
  '';

  meta = with lib; {
    description = "Simple custom implementation of `malloc(3)` for educational purposes.";
    homepage = "https://github.com/Frontear/mylloc";
    license = licenses.gpl2;
    maintainers = with maintainers; [ frontear ];
    mainProgram = finalAttrs.pname;
  };
})
