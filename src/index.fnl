(fn _ [map_maybe] (coroutine.yield {:map (or map_maybe #$)}))
(fn cw-loop [co ctx]
  (let [(succ? data) (coroutine.resume co ctx)]
    (match [succ? (coroutine.status co)]
      [false _] (error data)
      [true :suspended] (cw-loop co (data.map ctx))
      _ data)))
(fn exec [ctx f] (let [co (coroutine.create f)] (cw-loop co ctx)))
(fn put [k v] (tset (_) k v))
(fn get [f-or-k]
  (let [f (match (type f-or-k)
            "function" f-or-k
            _ (fn [t] (. t f-or-k)))]
    (_ f)))

{: exec
 : _
 : put
 : get}
