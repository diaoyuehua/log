require("class")

--interface
local ITest = interface("ITest")

function ITest:Test() end

ITest.check()

--base
local BaseClass = class("BaseClass", nil, ITest)

BaseClass.s_a = 1

function BaseClass:create(x)
    --BaseClass.super.create(self, x, y)
    self.x = x
end

function BaseClass:PrintX()
    print(self.x)
end

function BaseClass.PrintA()
    print(BaseClass.s_a)
end

function BaseClass:Test()
    print("Test Interface")
end

BaseClass.check()

--sub
local SubClass = class("SubClass", BaseClass)

SubClass.s_b = 2

function SubClass:create(x, y)
    SubClass.super.create(self, x)
    self.y = y
end

function SubClass:Plus()
    return self.x + self.y
end

function SubClass.PrintB()
    print(SubClass.s_b)
end

SubClass.check()

local sub = SubClass.new(3, 4)
print(sub:Plus())
sub:PrintX()
sub:PrintB()
sub:Test()