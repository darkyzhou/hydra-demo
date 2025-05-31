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
      packages.x86_64-linux.top = nixpkgs.legacyPackages.x86_64-linux.top;
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.top;
      hydraJobs."test" = self.defaultPackage;
    };
}
