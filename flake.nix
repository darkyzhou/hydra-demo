{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:loongson-community/nixpkgs/loong-master";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "loongarch64-linux"; };
    in
    {
      defaultPackage.loongarch64-linux =
        with pkgs;
        stdenv.mkDerivation {
          name = "darkyzhou-hello-world";
          version = "1.1.2";
          src = self;
          buildPhase = "gcc -o hello ./hello.c";
          installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
        };

      hydraJobs = {
        hello = self.defaultPackage.loongarch64-linux;

        runCommandHook = {
          recurseForDerivations = true;
          example = pkgs.writeScript "run-me" ''
            #!${pkgs.runtimeShell}
            ${pkgs.jq}/bin/jq . "$HYDRA_JSON"

            ls ${self.defaultPackage.loongarch64-linux}
          '';
        };
      };
    };
}
