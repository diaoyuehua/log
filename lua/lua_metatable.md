# lua metatable 的使用

setmetatable只能用于设置table的metatable
getmetatable可以获得所有对象的metatable
调用lua的c interface可以设置所有对象的metatable(特别是userdata)

## 修改或赋予一些基本行为

* __add '+'
* __sub '-'(二元负)
* __mul '*'
* __div '/'
* __mod '%'
* __unm '-'(一元负)
* __concat '..'
* __eq '=='
* __lt '<'
* __le '<='
* __pow '^'
* __len '#'
* __tostring 字符串转换

## weaktable

* __mode 设置为k, v, kv, 可以将table设置为weaktable,相应的key或者value变为只引用不计数

## 访问控制

*__index 使用索引获取table内容的时候调用

*__newindex 索引获取为table增加内容的时候调用

*rawset, rawget跳过元表操作table

## 一些元表的应用

1. 全局变量的访问控制

```
local oldG = _G
local newG = {}

setmetatable(newG, {
    __newindex = function(t, k, v)
        rawset(t, k, v)
    end, 
    __index = function(t, k)
        return rawset(t, k)
    end, 
})

setmetatable(oldG, {
    __newindex = function(k, v)
        error("bad access")
    end,
})

_G = newG
```
_G被新的代理替换了

2. 面向对象的实现

```
local class = {}

class.Set = function(t, v)
    t.v = v
end

class.Get = function(t)
    return t.v or 0
end

class.new - function()
    local one = {}
    setmetatable(one, {__index = class})
end
```
使class这个table成为one这个table的备选,用于表达类和实例,父类和子类的关系
