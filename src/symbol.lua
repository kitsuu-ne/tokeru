-- symbol.lua

return function(name: string)
    local self = newproxy(true)

    getmetatable(self).__tostring = function()
        return "Symbol (" .. name .. ")" 
    end

    return self
end