{
  stdenv,
  lib,
  gnumake
}:
let
  inherit (lib) cleanSource;
in stdenv.mkDerivation (finalAttrs: {
  pname = "mylloc";
  version = "0.1.0";

  src = cleanSource ../.;

  nativeBuildInputs = [
    gnumake
  ];

  meta = with lib; {
    description = "Simple custom implementation of `malloc(3)` for educational purposes.";
    homepage = "https://github.com/Frontear/mylloc";
    license = licenses.gpl2;
    maintainers = with maintainers; [ frontear ];
  };
})
