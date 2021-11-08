# tokeru
Fading as simple as ABC

## Introduction

tokeru (溶ける) is the Japanese word for dissolve. Filmmakers use the term dissolve to describe the transition that involves either fade in or fade out. That's the meaning of the name of this project.

Start fine-tuning your UI with tokeru, rather than having UI appears instantly, have them appear with an animation instead! Aside from that, you can also combine tokeru with tweens/springs to build much amazing transitions, such as fade and scale up.

tokeru is also capable of doing fade effects on other instances, such as: `BasePart`, `Sound`, `Decal`, `Texture`, et cetera, basically anything that has a Transparency modifier in it.

## API Reference

### tokeru
**tokeru(mono, direction, duration: number) -> tokeruTweens**

Apply the fading effect to a `Mono` (object), see the method below on how to create a `Mono`. For direction, use either `tokeru["in"]`, or `tokeru["out"]`, in means fade in, out means fade out. Duration is the time taken for tokeru to fade.

**tokeru.newMono(objects: {Instance}) -> mono**

Creates a new `Mono` (object) for tokeru, used for fading.

**tokeru["in"]**

A symbol, represents fade in.

**tokeru["out"]**

A symbol, represents fade out.

### tokeruTweens
**tokeruTweens:Connect(fun: function))**

Fires the defined function when the tokeru effect is completed.

**tokeruTweens:Wait(duration: number?)**

Halts the code until the tokeru effect is completed, the optional duration parameter is if you want to wait a bit more after completion.

**tokeruTweens:Pause()**

Pauses the tokeru effect.

**tokeruTweens:Resume()**

Resumes the tokeru effect.

**tokeruTweens:Cancel()**

Cancels the tokeru effect.

**tokeruTweens:Destroy()**

Destroys the tokeru effect, similar to `tokeruTweens:Cancel()`

## Example

**Code**

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local tokeru = require(Packages.tokeru)

local mono = tokeru.newMono({workspace})

wait(2.4)
tokeru(mono, tokeru.out, 0.6):Wait(1.2) -- fade out, 1.2s, wait for completion and wait 1.2 seconds
tokeru(mono, tokeru["in"], 0.6) -- fade in, 0.6s
```

**Video**

https://user-images.githubusercontent.com/91356714/140732444-cee1ad47-af32-4e5a-a092-5d0b49426aa6.mov

*thanks 7kayoh*

## Installation

tokeru can be installed with Wally, simply add tokeru in your Wally configuration for the project.

```toml
tokeru = "octale/tokeru@0.0.2"
```

## License

tokeru is licensed under MIT license
