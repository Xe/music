let
  pkgs = import <nixpkgs> { };
  orca = pkgs.callPackage ./nix/orca.nix { };
  pilot = pkgs.callPackage ./nix/pilot.nix { };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # creation tools
    pkgs.nur.repos.xe.orca
    pilot

    # conversion
    ffmpeg
  ];
}
