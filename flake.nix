{
  description = "Empty Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = pkgs.lib;
        luaPkgs = pkgs.lua5_1.pkgs;
        nativeBuildInputs = with pkgs; [];
        buildInputs = with pkgs; [];
      in {
        packages.default = luaPkgs.buildLuarocksPackage {
          pname = "ctx";
          version = "0.0.1-0";

          src = ./.;
          knownRockspec = ./rockspecs/ctx-0.0.1-0.rockspec;
          disabled = (luaPkgs.luaOlder "5.1") || (luaPkgs.luaAtLeast "5.4");
          propagatedBuildInputs = [ luaPkgs.bit32 luaPkgs.lua luaPkgs.std-normalize ];

          meta = with lib; {
            homepage = "https://github.com/luaposix/luaposix/";
            description = "Lua bindings for POSIX";
            maintainers = with maintainers; [ vyp lblasc ];
            license.fullName = "MIT/X11";
          };
        };
        devShells.default = pkgs.mkShell {inherit nativeBuildInputs buildInputs;};
      }
    );
}
