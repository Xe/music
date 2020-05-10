let
  pkgs = import <nixpkgs> { };
  pilot = pkgs.callPackage ./nix/pilot.nix { };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # creation tools
    pkgs.nur.repos.xe.orca
    pilot
    yoshimi

    # conversion
    ffmpeg
    audacity
  ];
}
