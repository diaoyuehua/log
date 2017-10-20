

function table.pretty(tbl, kname, tab, indent)
    local mutliString = function(str, num)
        local strTable = {}
        for i = 1, num do
            table.insert(strTable, str)
        end
        return table.concat(strTable)
    end

    tab = tab or "  "
    indent = indent or 0
    kname = kname or ""
    local prefix = mutliString(tab, indent)
    local strTable = {}
    if type(tbl) == "table" then
        table.insert(strTable, prefix..(kname ~= "" and kname.." = " or "").."{\n")
        for k, v in pairs(tbl) do
            table.insert(strTable, table.pretty(v, k, tab, indent+1))
        end
        table.insert(strTable, prefix.."},\n")
    else
        table.insert(strTable, prefix)
        if type(tbl) == "string" then
            table.insert(strTable, string.format("%s = \"%s\",", kname, tbl))
        else
            table.insert(strTable, string.format("%s = %s,", kname, tostring(tbl)))
        end
        table.insert(strTable, "\n")
    end
    return table.concat(strTable)
end

function table.shuffle(tbl, from, to)
    local start = from ~= nil and from or 1
    local finish = (to ~= nil and to <= #tbl-1) and to or #tbl
    
    for i = start, finish-1 do
        local x = math.random(finish - start) + start
        local temp = tbl[x]
        tbl[x] = tbl[i]
        tbl[i] = temp
    end
end
