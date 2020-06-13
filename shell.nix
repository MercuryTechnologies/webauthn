let
  pkgs = (import (import ./nix/sources.nix).nixpkgs) {};
in
pkgs.mkShell rec {
  name = "shell-file";
  buildInputs = [
    pkgs.haskell.compiler.ghc865
    pkgs.cabal-install
    pkgs.pkg-config
    pkgs.entr
    pkgs.yarn
  ];
  nativeBuildInputs = [
    pkgs.zlib
    pkgs.gmp
    pkgs.ncurses
  ];
  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath nativeBuildInputs}:$LD_LIBRARY_PATH
    export NIX_GHC="$(which ghc)"
    export NIX_GHCPKG="$(which ghc-pkg)"
    export NIX_GHC_DOCDIR="$NIX_GHC/../../share/doc/ghc/html"
    export NIX_GHC_LIBDIR="$(ghc --print-libdir)"
  '';
}