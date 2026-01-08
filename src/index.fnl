; (fn CTX_IDENT [])
; (fn _ [] (coroutine.yield CTX_IDENT))

; (fn ctx-cmd [] {})
; (fn ask [map] (ctx-cmd :ask {: map}))
; (fn get [map] (ctx-cmd :get {: map}))
; (fn write [val] (ctx-cmd :write {: val}))

; (fn mset [t p v]
  ; (table.set t p v)
  ; t)

; (fn mget [t p o]
  ; (match (table.get t p)
    ; nil o
    ; v v))

; (fn init-writer [spec] nil)

; (fn ensure-opts [arg]
  ; (match (type arg)
    ; "table" arg
    ; _ {:mk-monad arg}))

; (fn mk-with-opts [opt] (fn [arg v] (-> arg ensure-opts (mset opt v))))
; (local with-initial-state (mk-with-opts :initial-state))
; (local with-writer-spec (mk-with-opts :writer-spec))
; (local with-reader (mk-with-opts :reader))

; (fn exec-loop [ctx co])

; (fn exec-2 [mk-monad-or-opts]
  ; (let [opts (ensure-opts mk-monad-or-opts)
        ; mk-monad (mget opts :mk-monad (fn []))
        ; state (mget opts :initial-state {})
        ; writer (init-writer (mget opts :writer-spec nil))
        ; reader (mget opts :reader)
        ; ctx {: state : writer : reader}
        ; co (coroutine.create mk-monad)]
    ; (exec-loop ctx co)))

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

(print
 (exec {:ctx-key :ctx-val}
       (fn []
         (print :in-the-exec-body)
         (let [v (_)]
           (put :vnew :aNewVal)
           (print :v)
           (print v.ctx-key))
         (print :new-val!!)
         (print (get :vnew))
         (print :returning-3)
         3)))

{: exec
 : _
 : put
 : get
 ; : with-initial-state
 ; : with-reader
 ; : with-writer-spec
}
