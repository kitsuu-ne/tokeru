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
local tokeruTweens = require(script.tokeruTweens)

local tokeru = {}
tokeru.__index = tokeru

tokeru["in"] = symbol "in"
tokeru.out = symbol "out"

tokeru.newMono = mono

tokeru._function = function(mono, direction, duration: number)
    assert(table.find({tokeru["in"], tokeru.out}, direction), 
        "direction must be either tokeru.in or tokeru.out")
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tweens = {}

    for _, object in ipairs(mono._objects) do
        for index, value in pairs(acceptableProperties) do
            if object:IsA(index) then
                local goal = {}
                for _, property in ipairs(value) do
                    if direction == tokeru["in"] then
                        goal[property] = object:GetAttribute("tokeru" .. property)
                    else
                        if object:IsA("Sound") then
                            goal[property] = 0
                        else
                            goal[property] = 1
                        end
                    end
                end

                local tween = TweenService:Create(object, tweenInfo, goal)
                table.insert(tweens, tween)
                tween:Play()
                break
            end
        end
    end

    return tokeruTweens.new(tweens)
end

return setmetatable(tokeru, {
    __call = function(_, mono, direction, duration: number)
        return tokeru._function(mono, direction, duration)
    end
})