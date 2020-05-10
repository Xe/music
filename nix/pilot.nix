{ pkgs ? import <nixpkgs> { }, fetchurl ? pkgs.fetchurl, unzip ? pkgs.unzip
, stdenv ? pkgs.stdenv, appimage-run ? pkgs.appimage-run
, writeScriptBin ? pkgs.writeScriptBin }:

let
  pilot = stdenv.mkDerivation rec {
    pname = "pilot";
    version = "latest";

    src = fetchurl {
      url = "file:///home/cadey/Downloads/pilot-linux-64.zip";
      sha256 = "0q5g2pqszxkf51n1369wbn2301rpmq6mjcy54hlr9ssa62wxiviv";
    };

    phases = "installPhase";

    installPhase = ''
      mkdir -p $out/share/pilot
      ${unzip}/bin/unzip $src
      cp -vrf * $out/share/pilot
    '';
  };
in pkgs.writeScriptBin "pilot" ''
  #!${stdenv.shell}
  cd ${pilot}/share/pilot
  ${appimage-run}/bin/appimage-run ./Pilot
''
