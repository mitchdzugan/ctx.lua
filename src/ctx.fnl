(local _ (require :__))

(local ctx {})

(fn ctx._ [map_maybe] (coroutine.yield {:map (or map_maybe #$)}))
(fn cw-loop [ctx co resp]
  (let [(succ? data) (coroutine.resume co resp)]
    (case [succ? (coroutine.status co)]
      [false _] (error data)
      [true :suspended] (cw-loop ctx co (data.map ctx))
      _ data)))
(fn ctx.exec [ctx f]
  (let [co (coroutine.create f)] (cw-loop ctx co)))
(fn ctx.put [k v] (tset (ctx._) k v))
(fn ctx.get [gtr] (ctx._ (_.gtr gtr)))
(fn ctx.with [t f]
  (let [prevs (_.Map [])]
    (each [k v (pairs t)]
      (prevs:set k (. (ctx._) k))
      (tset (ctx._) k v))
    (let [res (f)]
      (each [[k v] (prevs:ientries)] (tset (ctx._) k v))
      res)))

(-> ctx)
