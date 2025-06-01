{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      defaultPackage.x86_64-linux =
        with import nixpkgs { system = "x86_64-linux"; };
        stdenv.mkDerivation {
          name = "my-hello";
          version = "1.0.8";
          src = self;
          buildPhase = "gcc -o hello ./hello.c";
          installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
        };
      hydraJobs."test" = self.defaultPackage;
    };
}
