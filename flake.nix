{
  description = "coroutine powered reader monad";
  inputs = {
    lua-__.url = "github:mitchdzugan/__.lua";
    # lua-__.url = "path:/VOID/proj/__.lua";
    mitch-utils.url = "github:mitchdzugan/mitch-utils.nix";
    # mitch-utils.url = "path:/VOID/proj/mitch-utils.nix";
  };
  outputs = ({ mitch-utils, lua-__, ... }:
    let
      mkLuaDeps = luaPkgs: with luaPkgs; [
        (lua-__.mkPkg luaPkgs)
      ];
    in (mitch-utils.mkZnFnl "ctx" "0.0.1-0" mkLuaDeps ./.)
  );
}
