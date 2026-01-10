




 package.preload["ctx"] = package.preload["ctx"] or function(...) local _ = require("__") local ctx = {} ctx._ = function(map_maybe) local or_3_ = map_maybe if not or_3_ then local function _4_(_241) return _241 end or_3_ = _4_ end return coroutine.yield({map = or_3_}) end local function cw_loop(ctx0, co, resp) local succ_3f, data = coroutine.resume(co, resp) local case_5_ = {succ_3f, coroutine.status(co)} if ((case_5_[1] == false) and true) then local _0 = case_5_[2] return error(data) elseif ((case_5_[1] == true) and (case_5_[2] == "suspended")) then return cw_loop(ctx0, co, data.map(ctx0)) else local _0 = case_5_ return data end end ctx.exec = function(ctx0, f) local co = coroutine.create(f) return cw_loop(ctx0, co) end ctx.put = function(k, v) ctx._()[k] = v return nil end ctx.get = function(gtr) return ctx._(_.gtr(gtr)) end ctx.with = function(t, f) local prevs = _.Map({}) for k, v in pairs(t) do prevs:set(k, ctx._()[k]) ctx._()[k] = v end local res = f() for _7_ in prevs:ientries() do local k = _7_[1] local v = _7_[2] ctx._()[k] = v end return res end return ctx end package.preload["__"] = package.preload["__"] or function(...) local _
package.preload["core"] = package.preload["core"] or function(...)
  local function assign(dst, ...)
    do
      local sources = {...}
      for _, source in ipairs(sources) do
        for k, v in pairs(source) do
          dst[k] = v
        end
      end
    end
    return dst
  end
  local function nil_3f(a)
    return (a == nil)
  end
  local function any_3f(a)
    return (a ~= nil)
  end
  local function table_3f(a)
    return (type(a) == "table")
  end
  local function num_3f(a)
    return (type(a) == "number")
  end
  local function str_3f(a)
    return (type(a) == "string")
  end
  local function bool_3f(a)
    return (type(a) == "boolean")
  end
  local function fn_3f(a)
    return (type(a) == "function")
  end
  local function co_3f(a)
    return (type(a) == "thread")
  end
  local function dig(t, ks, fallback)
    if (not table_3f(t) or (0 == #ks)) then
      return (t or fallback)
    else
      local ks1 = ks[1]
      local ks_rest = (function (t, k) return ((getmetatable(t) or {}).__fennelrest or function (t, k) return {(table.unpack or unpack)(t, k)} end)(t, k) end)(ks, 2)
      return dig(t[ks1], ks_rest, fallback)
    end
  end
  local function co_wrap(f)
    local final_3f = false
    local function outer_wrapped(...)
      local res = f(...)
      final_3f = true
      return res
    end
    local inner_wrapped = coroutine.wrap(outer_wrapped)
    local function _2_(...)
      return {val = inner_wrapped(...), ["final?"] = final_3f}
    end
    return _2_
  end
  local function gtr(a)
    if fn_3f(a) then
      return a
    else
      local function _3_(_241)
        return _241[a]
      end
      return _3_
    end
  end
  local function tail(inits, body_fn)
    local function call_self(...)
      return tail(table.pack(...), body_fn)
    end
    return body_fn(call_self, table.unpack(inits))
  end
  local function It(it_params)
    local i = {["it-params"] = it_params}
    i.unpack = function()
      return table.unpack(i["it-params"])
    end
    return i
  end
  local function ifn1(tot, f)
    local function _5_(...)
      local args = {...}
      local case_6_ = (#args - tot)
      if (case_6_ == 0) then
        local ip1 = args[1]
        local rest = (function (t, k) return ((getmetatable(t) or {}).__fennelrest or function (t, k) return {(table.unpack or unpack)(t, k)} end)(t, k) end)(args, 2)
        return f(It({ip1}), table.unpack(rest))
      elseif (case_6_ == 1) then
        local ip1 = args[1]
        local ip2 = args[2]
        local rest = (function (t, k) return ((getmetatable(t) or {}).__fennelrest or function (t, k) return {(table.unpack or unpack)(t, k)} end)(t, k) end)(args, 3)
        return f(It({ip1, ip2}), table.unpack(rest))
      else
        local _ = case_6_
        local ip1 = args[1]
        local ip2 = args[2]
        local ip3 = args[3]
        local rest = (function (t, k) return ((getmetatable(t) or {}).__fennelrest or function (t, k) return {(table.unpack or unpack)(t, k)} end)(t, k) end)(args, 4)
        return f(It({ip1, ip2, ip3}), table.unpack(rest))
      end
    end
    return _5_
  end
  local ilist
  local function _8_(_241)
    local tbl_26_ = {}
    local i_27_ = 0
    for v in _241:unpack() do
      local val_28_ = v
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    return tbl_26_
  end
  ilist = ifn1(1, _8_)
  local ival_list
  local function _10_(_241)
    local tbl_26_ = {}
    local i_27_ = 0
    for _, v in _241:unpack() do
      local val_28_ = v
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    return tbl_26_
  end
  ival_list = ifn1(1, _10_)
  local itable
  local function _12_(_241)
    local tbl_21_ = {}
    for k, v in _241:unpack() do
      local k_22_, v_23_ = k, v
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    return tbl_21_
  end
  itable = ifn1(1, _12_)
  local function imap_impl(map, i)
    local f
    local function _14_()
      local function _15_(recur, it_fn, st_t, c_var)
        local k, v = it_fn(st_t, c_var)
        if nil_3f(k) then
          return nil
        else
          coroutine.yield(table.pack(map(k, v)))
          return recur(it_fn, st_t, k)
        end
      end
      return tail(table.pack(i:unpack()), _15_)
    end
    f = co_wrap(_14_)
    local function _17_()
      local _let_18_ = f()
      local v = _let_18_.val
      local final_3f = _let_18_["final?"]
      if final_3f then
        return nil
      else
        return table.unpack(v)
      end
    end
    return _17_
  end
  local function imap(map, ...)
    return imap_impl(map, It({...}))
  end
  local function imap_vals(map, ...)
    local function _20_(k, v)
      return k, map(k, v)
    end
    return imap_impl(_20_, It({...}))
  end
  local function mk_multi_n(n)
    local function _21_(...)
      local args = {...}
      return args[n]
    end
    return _21_
  end
  local multi_1 = mk_multi_n(1)
  local multi_2 = mk_multi_n(2)
  local function ivals(...)
    return imap_impl(multi_2, It({...}))
  end
  local function tvals(t)
    return ivals(pairs(t))
  end
  local function inc(i)
    return (i + 1)
  end
  local function dec(i)
    return (i - 1)
  end
  return {assign = assign, dig = dig, ["nil?"] = nil_3f, ["any?"] = any_3f, ["table?"] = table_3f, ["fn?"] = fn_3f, ["co?"] = co_3f, ["num?"] = num_3f, ["str?"] = str_3f, ["bool?"] = bool_3f, gtr = gtr, ilist = ilist, ["ival-list"] = ival_list, itable = itable, imap = imap, ["imap-vals"] = imap_vals, ivals = ivals, tvals = tvals, inc = inc, dec = dec, tail = tail, ["multi-1"] = multi_1, ["multi-2"] = multi_2, ["co-wrap"] = co_wrap, ["co-new"] = coroutine.create, ["co-yield"] = coroutine.yield, ["co-check"] = coroutine.status, ["co-play"] = coroutine.resume}
end
_ = require("core")
local class
package.preload["class"] = package.preload["class"] or function(...)
  local _ = require("core")
  local _class = require("middleclass")
  local BASE_CLASS_IDENT
  local function _22_()
  end
  BASE_CLASS_IDENT = _22_
  local function subclass_3f(any)
    return (_["table?"](any) and _["fn?"](any["get-base-class-ident"]) and (any["get-base-class-ident"]() == BASE_CLASS_IDENT))
  end
  local BaseClass = _class("BaseClase")
  BaseClass["get-base-class-ident"] = function()
    return BASE_CLASS_IDENT
  end
  local function class(name, ...)
    return _class(name, BaseClass, ...)
  end
  return {class = class, ["subclass?"] = subclass_3f}
end
package.preload["middleclass"] = package.preload["middleclass"] or function(...)
  local middleclass = {
    _VERSION     = 'middleclass v4.1.1',
    _DESCRIPTION = 'Object Orientation for Lua',
    _URL         = 'https://github.com/kikito/middleclass',
    _LICENSE     = [[
      MIT LICENSE
  
      Copyright (c) 2011 Enrique García Cota
  
      Permission is hereby granted, free of charge, to any person obtaining a
      copy of this software and associated documentation files (the
      "Software"), to deal in the Software without restriction, including
      without limitation the rights to use, copy, modify, merge, publish,
      distribute, sublicense, and/or sell copies of the Software, and to
      permit persons to whom the Software is furnished to do so, subject to
      the following conditions:
  
      The above copyright notice and this permission notice shall be included
      in all copies or substantial portions of the Software.
  
      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
      OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
      MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
      IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
      CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
      TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
      SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]]
  }
  
  local function _createIndexWrapper(aClass, f)
    if f == nil then
      return aClass.__instanceDict
    else
      return function(self, name)
        local value = aClass.__instanceDict[name]
  
        if value ~= nil then
          return value
        elseif type(f) == "function" then
          return (f(self, name))
        else
          return f[name]
        end
      end
    end
  end
  
  local function _propagateInstanceMethod(aClass, name, f)
    f = name == "__index" and _createIndexWrapper(aClass, f) or f
    aClass.__instanceDict[name] = f
  
    for subclass in pairs(aClass.subclasses) do
      if rawget(subclass.__declaredMethods, name) == nil then
        _propagateInstanceMethod(subclass, name, f)
      end
    end
  end
  
  local function _declareInstanceMethod(aClass, name, f)
    aClass.__declaredMethods[name] = f
  
    if f == nil and aClass.super then
      f = aClass.super.__instanceDict[name]
    end
  
    _propagateInstanceMethod(aClass, name, f)
  end
  
  local function _tostring(self) return "class " .. self.name end
  local function _call(self, ...) return self:new(...) end
  
  local function _createClass(name, super)
    local dict = {}
    dict.__index = dict
  
    local aClass = { name = name, super = super, static = {},
                     __instanceDict = dict, __declaredMethods = {},
                     subclasses = setmetatable({}, {__mode='k'})  }
  
    if super then
      setmetatable(aClass.static, {
        __index = function(_,k)
          local result = rawget(dict,k)
          if result == nil then
            return super.static[k]
          end
          return result
        end
      })
    else
      setmetatable(aClass.static, { __index = function(_,k) return rawget(dict,k) end })
    end
  
    setmetatable(aClass, { __index = aClass.static, __tostring = _tostring,
                           __call = _call, __newindex = _declareInstanceMethod })
  
    return aClass
  end
  
  local function _includeMixin(aClass, mixin)
    assert(type(mixin) == 'table', "mixin must be a table")
  
    for name,method in pairs(mixin) do
      if name ~= "included" and name ~= "static" then aClass[name] = method end
    end
  
    for name,method in pairs(mixin.static or {}) do
      aClass.static[name] = method
    end
  
    if type(mixin.included)=="function" then mixin:included(aClass) end
    return aClass
  end
  
  local DefaultMixin = {
    __tostring   = function(self) return "instance of " .. tostring(self.class) end,
  
    initialize   = function(self, ...) end,
  
    isInstanceOf = function(self, aClass)
      return type(aClass) == 'table'
         and type(self) == 'table'
         and (self.class == aClass
              or type(self.class) == 'table'
              and type(self.class.isSubclassOf) == 'function'
              and self.class:isSubclassOf(aClass))
    end,
  
    static = {
      allocate = function(self)
        assert(type(self) == 'table', "Make sure that you are using 'Class:allocate' instead of 'Class.allocate'")
        return setmetatable({ class = self }, self.__instanceDict)
      end,
  
      new = function(self, ...)
        assert(type(self) == 'table', "Make sure that you are using 'Class:new' instead of 'Class.new'")
        local instance = self:allocate()
        instance:initialize(...)
        return instance
      end,
  
      subclass = function(self, name)
        assert(type(self) == 'table', "Make sure that you are using 'Class:subclass' instead of 'Class.subclass'")
        assert(type(name) == "string", "You must provide a name(string) for your class")
  
        local subclass = _createClass(name, self)
  
        for methodName, f in pairs(self.__instanceDict) do
          _propagateInstanceMethod(subclass, methodName, f)
        end
        subclass.initialize = function(instance, ...) return self.initialize(instance, ...) end
  
        self.subclasses[subclass] = true
        self:subclassed(subclass)
  
        return subclass
      end,
  
      subclassed = function(self, other) end,
  
      isSubclassOf = function(self, other)
        return type(other)      == 'table' and
               type(self.super) == 'table' and
               ( self.super == other or self.super:isSubclassOf(other) )
      end,
  
      include = function(self, ...)
        assert(type(self) == 'table', "Make sure you that you are using 'Class:include' instead of 'Class.include'")
        for _,mixin in ipairs({...}) do _includeMixin(self, mixin) end
        return self
      end
    }
  }
  
  function middleclass.class(name, super)
    assert(type(name) == 'string', "A name (string) is needed for the new class")
    return super and super:subclass(name) or _includeMixin(_createClass(name), DefaultMixin)
  end
  
  setmetatable(middleclass, { __call = function(_, ...) return middleclass.class(...) end })
  
  return middleclass
end
class = require("class")
local dbg
package.preload["dbg"] = package.preload["dbg"] or function(...)
  local inspect = require("inspect")
  local class = require("class")
  local function dbg_str(item, opts)
    local skip_keys = {class = true}
    local function process(obj)
      if class["subclass?"](obj) then
        local tbl_21_ = {__CLASS = obj.class.name}
        for k, v in pairs(obj) do
          local k_22_, v_23_
          if not skip_keys[k] then
            k_22_, v_23_ = k, v
          else
            k_22_, v_23_ = nil
          end
          if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
            tbl_21_[k_22_] = v_23_
          else
          end
        end
        return tbl_21_
      else
        return obj
      end
    end
    return inspect(item, {process = process})
  end
  local function dbg(item, opts)
    print(dbg_str(item, opts))
    return item
  end
  return {dbg = dbg, ["dbg-str"] = dbg_str}
end
package.preload["inspect"] = package.preload["inspect"] or function(...)
  local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local math = _tl_compat and _tl_compat.math or math; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table
  local inspect = {Options = {}, }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  inspect._VERSION = 'inspect.lua 3.1.0'
  inspect._URL = 'http://github.com/kikito/inspect.lua'
  inspect._DESCRIPTION = 'human-readable representations of tables'
  inspect._LICENSE = [[
    MIT LICENSE
  
    Copyright (c) 2022 Enrique García Cota
  
    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:
  
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
  
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
  inspect.KEY = setmetatable({}, { __tostring = function() return 'inspect.KEY' end })
  inspect.METATABLE = setmetatable({}, { __tostring = function() return 'inspect.METATABLE' end })
  
  local tostring = tostring
  local rep = string.rep
  local match = string.match
  local char = string.char
  local gsub = string.gsub
  local fmt = string.format
  
  local function rawpairs(t)
     return next, t, nil
  end
  
  
  
  local function smartQuote(str)
     if match(str, '"') and not match(str, "'") then
        return "'" .. str .. "'"
     end
     return '"' .. gsub(str, '"', '\\"') .. '"'
  end
  
  
  local shortControlCharEscapes = {
     ["\a"] = "\\a", ["\b"] = "\\b", ["\f"] = "\\f", ["\n"] = "\\n",
     ["\r"] = "\\r", ["\t"] = "\\t", ["\v"] = "\\v", ["\127"] = "\\127",
  }
  local longControlCharEscapes = { ["\127"] = "\127" }
  for i = 0, 31 do
     local ch = char(i)
     if not shortControlCharEscapes[ch] then
        shortControlCharEscapes[ch] = "\\" .. i
        longControlCharEscapes[ch] = fmt("\\%03d", i)
     end
  end
  
  local function escape(str)
     return (gsub(gsub(gsub(str, "\\", "\\\\"),
     "(%c)%f[0-9]", longControlCharEscapes),
     "%c", shortControlCharEscapes))
  end
  
  local function isIdentifier(str)
     return type(str) == "string" and not not str:match("^[_%a][_%a%d]*$")
  end
  
  local flr = math.floor
  local function isSequenceKey(k, sequenceLength)
     return type(k) == "number" and
     flr(k) == k and
     1 <= (k) and
     k <= sequenceLength
  end
  
  local defaultTypeOrders = {
     ['number'] = 1, ['boolean'] = 2, ['string'] = 3, ['table'] = 4,
     ['function'] = 5, ['userdata'] = 6, ['thread'] = 7,
  }
  
  local function sortKeys(a, b)
     local ta, tb = type(a), type(b)
  
  
     if ta == tb and (ta == 'string' or ta == 'number') then
        return (a) < (b)
     end
  
     local dta = defaultTypeOrders[ta] or 100
     local dtb = defaultTypeOrders[tb] or 100
  
  
     return dta == dtb and ta < tb or dta < dtb
  end
  
  local function getKeys(t)
  
     local seqLen = 1
     while rawget(t, seqLen) ~= nil do
        seqLen = seqLen + 1
     end
     seqLen = seqLen - 1
  
     local keys, keysLen = {}, 0
     for k in rawpairs(t) do
        if not isSequenceKey(k, seqLen) then
           keysLen = keysLen + 1
           keys[keysLen] = k
        end
     end
     table.sort(keys, sortKeys)
     return keys, keysLen, seqLen
  end
  
  local function countCycles(x, cycles)
     if type(x) == "table" then
        if cycles[x] then
           cycles[x] = cycles[x] + 1
        else
           cycles[x] = 1
           for k, v in rawpairs(x) do
              countCycles(k, cycles)
              countCycles(v, cycles)
           end
           countCycles(getmetatable(x), cycles)
        end
     end
  end
  
  local function makePath(path, a, b)
     local newPath = {}
     local len = #path
     for i = 1, len do newPath[i] = path[i] end
  
     newPath[len + 1] = a
     newPath[len + 2] = b
  
     return newPath
  end
  
  
  local function processRecursive(process,
     item,
     path,
     visited)
     if item == nil then return nil end
     if visited[item] then return visited[item] end
  
     local processed = process(item, path)
     if type(processed) == "table" then
        local processedCopy = {}
        visited[item] = processedCopy
        local processedKey
  
        for k, v in rawpairs(processed) do
           processedKey = processRecursive(process, k, makePath(path, k, inspect.KEY), visited)
           if processedKey ~= nil then
              processedCopy[processedKey] = processRecursive(process, v, makePath(path, processedKey), visited)
           end
        end
  
        local mt = processRecursive(process, getmetatable(processed), makePath(path, inspect.METATABLE), visited)
        if type(mt) ~= 'table' then mt = nil end
        setmetatable(processedCopy, mt)
        processed = processedCopy
     end
     return processed
  end
  
  local function puts(buf, str)
     buf.n = buf.n + 1
     buf[buf.n] = str
  end
  
  
  
  local Inspector = {}
  
  
  
  
  
  
  
  
  
  
  local Inspector_mt = { __index = Inspector }
  
  local function tabify(inspector)
     puts(inspector.buf, inspector.newline .. rep(inspector.indent, inspector.level))
  end
  
  function Inspector:getId(v)
     local id = self.ids[v]
     local ids = self.ids
     if not id then
        local tv = type(v)
        id = (ids[tv] or 0) + 1
        ids[v], ids[tv] = id, id
     end
     return tostring(id)
  end
  
  function Inspector:putValue(v)
     local buf = self.buf
     local tv = type(v)
     if tv == 'string' then
        puts(buf, smartQuote(escape(v)))
     elseif tv == 'number' or tv == 'boolean' or tv == 'nil' or
        tv == 'cdata' or tv == 'ctype' then
        puts(buf, tostring(v))
     elseif tv == 'table' and not self.ids[v] then
        local t = v
  
        if t == inspect.KEY or t == inspect.METATABLE then
           puts(buf, tostring(t))
        elseif self.level >= self.depth then
           puts(buf, '{...}')
        else
           if self.cycles[t] > 1 then puts(buf, fmt('<%d>', self:getId(t))) end
  
           local keys, keysLen, seqLen = getKeys(t)
  
           puts(buf, '{')
           self.level = self.level + 1
  
           for i = 1, seqLen + keysLen do
              if i > 1 then puts(buf, ',') end
              if i <= seqLen then
                 puts(buf, ' ')
                 self:putValue(t[i])
              else
                 local k = keys[i - seqLen]
                 tabify(self)
                 if isIdentifier(k) then
                    puts(buf, k)
                 else
                    puts(buf, "[")
                    self:putValue(k)
                    puts(buf, "]")
                 end
                 puts(buf, ' = ')
                 self:putValue(t[k])
              end
           end
  
           local mt = getmetatable(t)
           if type(mt) == 'table' then
              if seqLen + keysLen > 0 then puts(buf, ',') end
              tabify(self)
              puts(buf, '<metatable> = ')
              self:putValue(mt)
           end
  
           self.level = self.level - 1
  
           if keysLen > 0 or type(mt) == 'table' then
              tabify(self)
           elseif seqLen > 0 then
              puts(buf, ' ')
           end
  
           puts(buf, '}')
        end
  
     else
        puts(buf, fmt('<%s %d>', tv, self:getId(v)))
     end
  end
  
  
  
  
  function inspect.inspect(root, options)
     options = options or {}
  
     local depth = options.depth or (math.huge)
     local newline = options.newline or '\n'
     local indent = options.indent or '  '
     local process = options.process
  
     if process then
        root = processRecursive(process, root, {}, {})
     end
  
     local cycles = {}
     countCycles(root, cycles)
  
     local inspector = setmetatable({
        buf = { n = 0 },
        ids = {},
        cycles = cycles,
        depth = depth,
        level = 0,
        newline = newline,
        indent = indent,
     }, Inspector_mt)
  
     inspector:putValue(root)
  
     return table.concat(inspector.buf)
  end
  
  setmetatable(inspect, {
     __call = function(_, root, options)
        return inspect.inspect(root, options)
     end,
  })
  
  return inspect
end
dbg = require("dbg")
local Maybe
package.preload["Maybe"] = package.preload["Maybe"] or function(...)
  local _ = require("core")
  local c = require("class")
  local MaybeClass = c.class("MaybeClass")
  MaybeClass.initialize = function(self, nilable)
    self.val = nilable
    return nil
  end
  MaybeClass["or"] = function(self, fallback)
    if _["nil?"](self.val) then
      return fallback
    else
      return self.val
    end
  end
  MaybeClass.value = function(self)
    return self["or"](self)
  end
  MaybeClass.case = function(self, on_some, on_nothing)
    if _["nil?"](self.val) then
      return on_nothing()
    else
      return on_some(self.val)
    end
  end
  local function _28_(nilable)
    return MaybeClass:new(nilable)
  end
  return _28_
end
Maybe = require("Maybe")
local Map
package.preload["Map"] = package.preload["Map"] or function(...)
  local _ = require("core")
  local c = require("class")
  local Maybe = require("Maybe")
  local MapClass = c.class("MapClass")
  MapClass.initialize = function(self, kvs, opts)
    self.data = {}
    self.opts = (opts or {})
    for _0, _29_ in pairs((kvs or {})) do
      local k = _29_[1]
      local v = _29_[2]
      self:set(k, v)
    end
    return nil
  end
  MapClass["to-key"] = function(self, k)
    local or_30_ = self.opts["to-key"]
    if not or_30_ then
      local function _31_(_241)
        return _241
      end
      or_30_ = _31_
    end
    return or_30_(k)
  end
  MapClass.set = function(self, k, v)
    self.data[self["to-key"](self, k)] = {k = k, v = v}
    return nil
  end
  MapClass.get = function(self, k)
    return (self.data[self["to-key"](self, k)] or {}).v
  end
  MapClass["has?"] = function(self, k)
    return _["any?"](self.data[self["to-key"](self, k)])
  end
  MapClass.rm = function(self, k)
    self.data[self["to-key"](self, k)] = nil
    return nil
  end
  MapClass.ientries = function(self)
    local function _33_(_32_)
      local k = _32_.k
      local v = _32_.v
      return {k, v}
    end
    return _.imap(_33_, _.tvals(self.data))
  end
  MapClass.imkeys = function(self)
    local function _35_(_34_)
      local k = _34_[1]
      return Maybe(k)
    end
    return _.imap(_35_, self:ientries())
  end
  MapClass.imvals = function(self)
    local function _37_(_36_)
      local _0 = _36_[1]
      local v = _36_[2]
      return Maybe(v)
    end
    return _.imap(_37_, self:ientries())
  end
  local function _38_(...)
    return MapClass:new(...)
  end
  return _38_
end
Map = require("Map")
return _.assign({Maybe = Maybe, Map = Map}, dbg, class, _) end local function _1_() do local function _2_() do local ctx_2_auto = require("ctx") local function _8_()
 assert.same(nil, require("ctx").get("a"))
 do local ctx_1_auto = require("ctx") local function _9_()
 return assert.same(2, require("ctx").get("a")) end ctx_1_auto.with({a = 2}, _9_) end
 return assert.same(nil, require("ctx").get("a")) end ctx_2_auto.exec({}, _8_) end return nil end it("should work", _2_) end return nil end return describe("ctx", _1_)
