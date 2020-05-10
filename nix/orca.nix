{ pkgs ? import <nixpkgs> { }, fetchurl ? pkgs.fetchurl, unzip ? pkgs.unzip
, stdenv ? pkgs.stdenv, appimage-run ? pkgs.appimage-run
, writeScriptBin ? pkgs.writeScriptBin }:

let
  orca = stdenv.mkDerivation rec {
    pname = "orca";
    version = "latest";

    src = fetchurl {
      url = "file:///home/cadey/Downloads/orca-linux-64.zip";
      sha256 = "0vwn3b25nvk38qf5ysz96179iqn923118as07lcai0qkjsj6j160";
    };

    phases = "installPhase";

    installPhase = ''
      mkdir -p $out/share/orca
      ${unzip}/bin/unzip $src
      cp -vrf * $out/share/orca
    '';
  };
in pkgs.writeScriptBin "orca" ''
  #!${stdenv.shell}
  cd ${orca}/share/orca
  ${appimage-run}/bin/appimage-run ./Orca
''
