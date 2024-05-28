{
  description = "A flake for publishing DSA stuff to https://dsa.adityakumar.xyz/";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: {
    packages.x86_64-linux.default = with import nixpkgs {system = "x86_64-linux";};
      stdenv.mkDerivation {
        name = "dsa";
        buildInputs = with pkgs; [
          bash
          hugo
          rsync
        ];
        src = self;
        buildPhase = "hugo server -D";
        installPhase = "bash deploy.sh";
      };
  };
}
