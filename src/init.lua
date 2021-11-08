-- tokeru.lua
-- Fade in and out effects for everything
-- example:
--[[
    local tokeru = require("tokeru")

    local GUI = script.Parent.UI
    local mono = tokeru.newMono({GUI})

    tokeru(mono, tokeru.in, 0.3)
    task.wait(0.3)
    tokeru(mono, tokeru.out, 0.3)
--]]
-- @octale

local TweenService = game:GetService("TweenService")

local symbol = require(script.symbol)
local mono = require(script.mono)
local acceptableProperties = require(script.properties)

local tokeru = {}
tokeru.__index = tokeru

tokeru.in = symbol "in"
tokeru.out = symbol "out"

tokeru.newMono = mono

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