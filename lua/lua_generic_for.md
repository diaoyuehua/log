# 泛型for

for有两种使用形式

1. 数值循环
```
    for i = 1, 10, 1 do
        print(i)
    end
```

2. 迭代器
```
    for k, v in pairs(tbl) do
        print(k, v)
    end
```

第二种就是泛型for,是迭代器,闭包的综合应用

________

泛型for的基本形式是'for <var-list> in <exp-list> do <block> end'

泛型for的执行过程由有部

1. 对表达式求值,获得一个迭代器函数,一个恒定参数,一个可变参数

2. 接下来循环执行迭代器方法,参数为恒定变量和控制变量,得到迭代器的返回值后,复制in之前参数列表,同时将控制变量赋值为第一个返回值,如果第一个返回值为nil,则停止,循环执行这段逻辑

```
for var_1, ..., var_n in <explist> do <block> end -- 就等价于以下代码：
do
     local _f, _s, _var = <explist>    -- 返回迭代器函数、恒定状态和控制变量的初值
     while true do
          local var_1, ..., var_n = _f(_s, _var)
          _var = var_1
          if _var == nil then break end
          <block>
          end
     end
end
```
