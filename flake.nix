{
  description = "coroutine powered reader monad";
  inputs = {
    lua-__.url = "github:mitchdzugan/__.lua";
    # lua-__.url = "path:/VOID/proj/__.lua";
    mitch-utils.url = "github:mitchdzugan/mitch-utils.nix";
    # mitch-utils.url = "path:/VOID/proj/mitch-utils.nix";
  };
  outputs = (inputs@{ mitch-utils, ... }:
    (mitch-utils.mkZnFnl inputs ./.)
  );
}
