-- tokeru.lua
-- Fade in and out effects for everything
-- @octale

local TweenService = game:GetService("TweenService")

local symbol = require(script.symbol)
local acceptableProperties = require(script.properties)

local tokeru = {}
tokeru.__index = tokeru

tokeru.in = symbol "in"
tokeru.out = symbol "out"

tokeru._function = function(mono, direction, duration: number)
    assert(table.find({tokeru.in, tokeru.out}, direction), 
    "direction must be either tokeru.in or tokeru.out")
    local tweenInfo = TweenInfo.new(duration, Enum.Easing.Linear)

    for _, object in ipairs(mono._objects) do
        for index, value in pairs(acceptableProperties) do
            if object:IsA(index) then
                local goal = {}
                for _, property in ipairs(value) do
                    if direction == tokeru.in then
                        goal[property] = object:GetAttribute(property)
                    else
                        if object:IsA("Sound") then
                            goal[property] = 0
                        else
                            goal[property] = 1
                        end
                    end
                end

                TweenService:Create(object, tweenInfo, goal):Play()
                break
            end
        end
    end
end

return setmetatable(tokeru, {
    __call = tokeru._function
})