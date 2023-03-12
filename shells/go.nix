{ pkgs ? import <nixpkgs> { } }:

let 
  options = [
    ''--option experimental-features "nix-command flakes"''
  ];

in pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    go
    gopls
    gopls
    go-outline
    gocode
    gopkgs
    gocode-gomod
    godef
    golint
  ];
}
