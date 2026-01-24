# flake.nix
{
  description = "Flutter dev shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.flutter
        pkgs.android-tools
        pkgs.jdk17
      ];
    };
  };
}
