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
    let
      mkLua = (luaPkgs: (luaPkgs.lua.withPackages (lp: with lp; [
        busted
        fennel
      ])));
      mkPkg = luaPkgs: luaPkgs.buildLuarocksPackage rec {
        pname = "ctx";
        version = "0.0.1-0";
        src = ./.;
        buildInputs = [(mkLua luaPkgs)];
        preBuild = ''
          rm dist/ctx.lua
          fennel --compile src/index.fnl > dist/ctx.lua
        '';
        knownRockspec = ./rockspecs/${pname}-${version}.rockspec;
        disabled = (luaPkgs.luaOlder "5.1") || (luaPkgs.luaAtLeast "5.4");
      }; in { mkPkg = mkPkg; } // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        luaPkgs = pkgs.lua5_1.pkgs;
        nativeBuildInputs = with pkgs; [];
        buildInputs = with pkgs; [
            (mkLua pkgs.lua5_1.pkgs)
            rlwrap
          ];
      in {
        packages.default = mkPkg pkgs.lua5_1.pkgs;
        devShells.default = pkgs.mkShell {inherit nativeBuildInputs buildInputs;};
      }
    );
}
