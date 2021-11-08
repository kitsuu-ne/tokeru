-- mono.lua
-- @7kayoh

local acceptableProperties = require(script.Parent.properties)

local function initialize(object: Instance)
    for index, value in pairs(acceptableProperties) do
        if object:IsA(index) then
            for _, property in ipairs(value) do
                object:SetAttribute("tokeru." .. property, tonumber(object[property]))
            end
            break
        end
    end
end

return function(objects: {Instance})
    local allObject = {}

    for _, object in ipairs(objects) do
        initialize(object)
        table.insert(allObject, object)
        local descendants = object:GetDescendants()
        -- honestly, using a loop to achieve all descendants is not really optimal
        -- but as table.insert does not allow vararg function, there is really no
        -- favourable solutions to optimize the time complexity
        for _, descendant in ipairs(descendants) do
            initialize(descendant)
            table.insert(allObject, descendant)
        end
        
        -- add new descendant so it'll work with tokeru
        object.DescendantAdded:Connect(function(descendant)
            initialize(descendant)
            table.insert(allObject, descendant)
        end)

        -- remove references that should be GC'd
        object.DescendantRemoving:Connect(function(descendant)
            local index = table.find(allObject, descendant)
            if index then
                table.remove(allObject, index)
            end
        end)

        object.Destroying:Connect(function()
            local index = table.find(allObject, object)
            if index then
                table.remove(allObject, index)
            end
        end)
    end

    local mono = setmetatable({
        _objects = allObject
    }, {

    })

    return mono
end