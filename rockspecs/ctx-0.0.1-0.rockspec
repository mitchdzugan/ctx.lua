package = "ctx"
version = "0.0.1-0"
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
