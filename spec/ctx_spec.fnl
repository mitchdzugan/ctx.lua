(import-macros ctx :ctx)
(import-macros {: desc : spec} :busted)

(desc "ctx"
  (spec "should work"
    (ctx.exec {}
      (assert.same nil (ctx.get :a))
      (ctx.with {:a 2}
        (assert.same 2 (ctx.get :a)))
      (assert.same nil (ctx.get :a))
      )))
