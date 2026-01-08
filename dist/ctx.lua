local function _(map_maybe)
  local or_1_ = map_maybe
  if not or_1_ then
    local function _2_(_241)
      return _241
    end
    or_1_ = _2_
  end
  return coroutine.yield({map = or_1_})
end
local function cw_loop(co, ctx)
  local succ_3f, data = coroutine.resume(co, ctx)
  local case_3_ = {succ_3f, coroutine.status(co)}
  if ((case_3_[1] == false) and true) then
    local _0 = case_3_[2]
    return error(data)
  elseif ((case_3_[1] == true) and (case_3_[2] == "suspended")) then
    return cw_loop(co, data.map(ctx))
  else
    local _0 = case_3_
    return data
  end
end
local function exec(ctx, f)
  local co = coroutine.create(f)
  return cw_loop(co, ctx)
end
local function put(k, v)
  _()[k] = v
  return nil
end
local function get(f_or_k)
  local f
  do
    local case_5_ = type(f_or_k)
    if (case_5_ == "function") then
      f = f_or_k
    else
      local _0 = case_5_
      local function _6_(t)
        return t[f_or_k]
      end
      f = _6_
    end
  end
  return _(f)
end
return {exec = exec, _ = _, put = put, get = get}
