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
      packages.x86_64-linux.tree = nixpkgs.legacyPackages.x86_64-linux.tree;
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.tree;
      hydraJobs."test" = self.defaultPackage;
    };
}
