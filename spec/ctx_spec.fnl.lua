




 package.preload["ctx"] = package.preload["ctx"] or function(...) local function _(map_maybe) local or_3_ = map_maybe if not or_3_ then local function _4_(_241) return _241 end or_3_ = _4_ end return coroutine.yield({map = or_3_}) end local function cw_loop(ctx, co, resp) local succ_3f, data = coroutine.resume(co, resp) local case_5_ = {succ_3f, coroutine.status(co)} if ((case_5_[1] == false) and true) then local _0 = case_5_[2] return error(data) elseif ((case_5_[1] == true) and (case_5_[2] == "suspended")) then return cw_loop(ctx, co, data.map(ctx)) else local _0 = case_5_ return data end end local function exec(ctx, f) local co = coroutine.create(f) return cw_loop(ctx, co) end local function put(k, v) _()[k] = v return nil end local function get(f_or_k) local f do local case_7_ = type(f_or_k) if (case_7_ == "function") then f = f_or_k else local _0 = case_7_ local function _8_(t) return t[f_or_k] end f = _8_ end end return _(f) end local function with(t, f) local prevs = {} for k, v in pairs(t) do prevs[k] = {_()[k]} _()[k] = v end local res = f() for k, _10_ in pairs(prevs) do local v = _10_[1] _()[k] = v end return res end return {exec = exec, _ = _, put = put, get = get, with = with} end local function _1_() do local function _2_() do local ctx_2_auto = require("ctx") local function _11_()
 assert.same(nil, require("ctx").get("a"))
 do local ctx_1_auto = require("ctx") local function _12_()
 return assert.same(2, require("ctx").get("a")) end ctx_1_auto.with({a = 2}, _12_) end
 return assert.same(nil, require("ctx").get("a")) end ctx_2_auto.exec({}, _11_) end return nil end it("should work", _2_) end return nil end return describe("ctx", _1_)
