(macro mwith [m & body]
      `(let [ctx# (require :ctx)]
         (ctx#.with ,m (fn [] ,(unpack body)))))
{: mwith}
