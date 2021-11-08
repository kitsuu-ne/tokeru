-- tokeruTweens.lua
-- provides extra methods for a tokeru, such as cancelling, waiting, etc
-- @octale

local tokeruTweens = {}
tokeruTweens.__index = tokeruTweens

function tokeruTweens:Cancel()
    for _, tween in ipairs(self._tweens) do
        tween:Cancel()
    end
end

function tokeruTweens:Pause()
    for _, tween in ipairs(self._tweens) do
        tween:Pause()
    end
end

function tokeruTweens:Resume()
    for _, tween in ipairs(self._tweens) do
        tween:Resume()
    end
end

function tokeruTweens:Wait(extra: number?)
    local lastTween = self._tweens[#self._tweens]
    lastTween.Completed:Wait()
    if extra then
        task.wait(extra)
    end
end

function tokeruTweens:Connect(fun)
    local lastTween = self._tweens[#self._tweens]
    lastTween.Completed:Connect(fun)
end

-- somewhat unnecessary
function tokeruTweens:Destroy()
    for _, tween in ipairs(self._tweens) do
        tween:Destroy()
    end
end

function tokeruTweens.new(tweens: {Tween})
    return setmetatable({
        _tweens = tweens
    }, tokeruTweens)
end

return tokeruTweens