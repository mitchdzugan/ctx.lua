{
  description = "coroutine powered reader monad";
  inputs = {
    mitch-utils.url = "github:mitchdzugan/mitch-utils.nix";
    # mitch-utils.url = "path:/home/dz/Projects/mitch-utils.nix";
  };
  outputs = ({ mitch-utils, ... }:
    let
      mkLuaDeps = luaPkgs: with luaPkgs; [
        busted
        fennel
      ];
    in (mitch-utils.mkZnFnl "ctx" "0.0.1-0" mkLuaDeps ./.)
  );
}
