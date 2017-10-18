--[[
    lua table 的比较函数一定要返回 a < b 或者 b < a,不能包含等于,因为这个比较函数不像c的比较函数,包括大于小于等于三种情况,只有两个结果
    这样的情况下,如果结果包含了等于,那么正向比较和反向比较都成立了,比较函数不能判断两个值的大小,顺序就会错乱,或者出现自己和自己比较的情况或者传入的两个待比较的参数为nil
--]]

local tbl = {}

table.insert(tbl, {index=1,value=1})
table.insert(tbl, {index=4,value=4})
table.insert(tbl, {index=2,value=2})
table.insert(tbl, {index=3,value=3})

table.sort(tbl, function(a, b)
    print(a.index, ":", b.index)
    return a.value <= b.value
end)

print("result:")
for k, v in ipairs(tbl) do
    print(v.index)
end
