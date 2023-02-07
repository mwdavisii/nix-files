{ pkgs ? import <nixpkgs> { } }:

let
    # Pinned nixpkgs, deterministic. Last updated: 2/12/21.
    pkgs = import (fetchTarball("https://github.com/NixOS/nixpkgs/archive/a58a0b5098f0c2a389ee70eb69422a052982d990.tar.gz")) {};
    nixConf = import ./nix/conf.nix;
    options = [
    ''--option extra-trusted-substituters "${builtins.concatStringsSep " " nixConf.binaryCaches}"''
    ''--option extra-trusted-public-keys "${builtins.concatStringsSep " " nixConf.binaryCachePublicKeys}"''
    ''--option experimental-features "nix-command flakes"''
    ];
  # Rolling updates, not deterministic.
  # pkgs = import (fetchTarball("channel:nixpkgs-unstable")) {};
in pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    git
    git-crypt
    nixUnstable
    cargo
    rustc
  ];
}