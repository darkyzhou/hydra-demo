{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      packages.x86_64-linux.gost = nixpkgs.legacyPackages.x86_64-linux.gost;
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.gost;
      hydraJobs."test" = self.defaultPackage;
    };
}
