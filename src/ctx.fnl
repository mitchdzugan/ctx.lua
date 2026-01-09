(fn _ [map_maybe] (coroutine.yield {:map (or map_maybe #$)}))
(fn cw-loop [ctx co resp]
  (let [(succ? data) (coroutine.resume co resp)]
    (match [succ? (coroutine.status co)]
      [false _] (error data)
      [true :suspended] (cw-loop ctx co (data.map ctx))
      _ data)))
(fn exec [ctx f] (let [co (coroutine.create f)] (cw-loop ctx co)))
(fn put [k v] (tset (_) k v))
(fn get [f-or-k]
  (let [f (match (type f-or-k)
            "function" f-or-k
            _ (fn [t] (. t f-or-k)))]
    (_ f)))
(fn with [t f]
  (let [prevs {}]
    (each [k v (pairs t)]
      (tset prevs k (. (_) k))
      (tset (_) k v))
    (let [res (f)]
      (each [k v (pairs prevs)] (tset (_) k v))
      res)))

{: exec
 : _
 : put
 : get
 : with}
