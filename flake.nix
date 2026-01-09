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
      # mkFlakeFnl
      mkLuaDeps = luaPkgs: with luaPkgs; [
        busted
        fennel
      ];
      mkLua = luaPkgs: (luaPkgs.lua.withPackages mkLuaDeps);
      mkMacroPath = luaPkgs: (
        builtins.concatStringsSep
        ";"
        (map (pkg: "${pkg}/macro-path/?.fnl") (mkLuaDeps luaPkgs))
      );
      mkPkg = luaPkgs: luaPkgs.buildLuarocksPackage rec {
        pname = "ctx";
        version = "0.0.1-0";
        src = ./.;
        buildInputs = [(mkLua luaPkgs)];
        preBuild = ''
          rm -rf dist
          mkdir dist
          fennel --compile src/ctx.fnl > dist/ctx.lua
        '';
        postInstall = ''
          cp -r macro-path $out
        '';
        knownRockspec = ./rockspecs/${pname}-${version}.rockspec;
        disabled = (luaPkgs.luaOlder "5.1") || (luaPkgs.luaAtLeast "5.4");
      }; in { mkPkg = mkPkg; } // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        luaPkgs = pkgs.lua5_1.pkgs;
        nativeBuildInputs = with pkgs; [];
        buildInputs = with pkgs; [
            (mkLua luaPkgs)
            rlwrap
          ];
      in {
        packages.default = mkPkg pkgs.lua5_1.pkgs;
        devShells.default = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs;
          shellHook = ''
            function getFlakeRoot {
              d=$(pwd)
              if [[ -f "$d/flake.nix" ]]; then
                echo $d
              elif [[ "$d" == "/" ]]; then
                echo $1
              else
                cd ..
                getFlakeRoot $1
              fi
            }
            function f {
              rlwrap fennel "$@"
            }
            export FLAKE_ROOT=$(getFlakeRoot $(pwd))
            export FENNEL_MACRO_PATH="$FLAKE_ROOT/macro-path/?.fnl;${mkMacroPath(luaPkgs)}"
            export FENNEL_PATH="$FLAKE_ROOT/src/?.fnl"
          '';
        };
      }
    );
}
