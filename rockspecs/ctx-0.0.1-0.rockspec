package = "ctx"
version = "0.0.1-0"
source = {
  url = "https://github.com/mitchdzugan/ctx.lua/archive/refs/heads/main.zip",
  dir = "ctx.lua-main"
}
description = {
   summary = "coroutine powered rwse monad for lua (fennel)",
   detailed = "",
   homepage = "https://github.com/mitchdzugan/ctx.lua",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      ctx = "dist/ctx.lua"
   }
}
