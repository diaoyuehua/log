function class(className, superClass, ...)
    if type(className) == "string" and className == nil or className == "" then
        error("bad className")
    end
    
    if superClass ~= nil and superClass.__class == nil then
        error("bad superClass")
    end
    
    for k, v in ipairs{...} do
        if v.__interface == nil then
            error("bad interface")
        end
    end
    
    local interfaces = {...}
    
    local class = {}
    class.__class = className
    class.super = superClass
    
    class.__index = class
    
    setmetatable(class, {__index = superClass})
    
    class.new = function(...)
        local obj = {}
        
        setmetatable(obj, class)
        
        obj:create(...)
        return obj
    end
    
    class.check = function()
        for k, v in pairs(interfaces) do
            for k1, v1 in pairs(v) do
                if k1 ~= "__interface" and k1 ~= "check" then
                    local implement = class[k1]
                    print(implement)
                    if type(implement) ~= "function" then
                        error("interface "..k1.." dose not has implemention")
                    end
                end
            end
        end
        return class
    end
    
    return class
end

function interface(interfaceName)
    if interfaceName == nil or interfaceName == "" then
        error("interfaceName can't be nil or \"\"")
    end
    
    local interface = {}
    interface.__interface = interfaceName
    
    interface.check = function()
        for k, v in pairs(interface) do
            if k ~= "__interface" and type(v) ~= "function" then
                error(k.." is not a function")
            end
        end
        return interface
    end
    
    
    return interface
end