{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:loongson-community/nixpkgs/loong-master";
  };

  outputs =
    { self, nixpkgs }:
    {
      defaultPackage.loongarch64-linux =
        with import nixpkgs { system = "loongarch64-linux"; };
        stdenv.mkDerivation {
          name = "darkyzhou-hello-world";
          version = "1.1.0";
          src = self;
          buildPhase = "gcc -o hello ./hello.c";
          installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
        };
      hydraJobs."darkyzhou-hello-world" = self.defaultPackage;
    };
}
