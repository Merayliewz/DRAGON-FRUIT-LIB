# DragonFruit UI Library

A modern, clean, and lightweight UI library for Roblox script developers inspired by the dragon fruit theme. Designed with smooth animations, custom themes, draggable frames, and sidebar navigation tabs.

---

## 🌐 Language
* English (Current)
* [Tiếng Việt (Vietnamese)](README_VN.md)

---

## 🚀 Quick Start

Load **DragonFruitLib** into your script using `loadstring`:

```lua
local DragonFruitLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Merayliewz/DRAGON-FRUIT-LIB/refs/heads/main/dragonfruit%20lib.lua"))()
```

---

## 📜 Full Code Example

This example contains every available UI component without skipping any element:

```lua
-- Load Library
local DragonFruitLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Merayliewz/DRAGON-FRUIT-LIB/refs/heads/main/dragonfruit%20lib.lua"))()

-- 1. Create Window
local Window = DragonFruitLib:CreateWindow({
    Title = "Dragon Fruit Hub",
    Logo = "rbxassetid://90272501948122" -- Asset ID for your dragon fruit logo
})

-- 2. Create Tabs
local MainTab = Window:CreateTab("Main")
local SettingsTab = Window:CreateTab("Settings")

-- 3. Label Component
MainTab:AddLabel("Welcome to Dragon Fruit Hub!")

-- 4. Button Component
MainTab:AddButton({
    Text = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end
})

-- 5. Toggle Component
MainTab:AddToggle({
    Text = "Auto Farm",
    Default = false,
    Callback = function(State)
        print("Auto Farm state:", State)
    end
})

-- 6. Slider Component
MainTab:AddSlider({
    Text = "WalkSpeed",
    Min = 16,
    Max = 250,
    Default = 16,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})
```

---

## 📚 Component API Reference

### Window
Creates the main window interface.
```lua
local Window = DragonFruitLib:CreateWindow({
    Title = "Window Title",
    Logo = "rbxassetid://90272501948122"
})
```

### Tab
Creates a category section on the sidebar.
```lua
local Tab = Window:CreateTab("Tab Name")
```

### Label
Displays text inside a tab.
```lua
Tab:AddLabel("Your text here")
```

### Button
Creates an interactive button.
```lua
Tab:AddButton({
    Text = "Button Text",
    Callback = function()
        -- Code runs on click
    end
})
```

### Toggle
Creates an On/Off switch.
```lua
Tab:AddToggle({
    Text = "Toggle Text",
    Default = false, -- true or false
    Callback = function(State)
        -- State returns boolean (true / false)
    end
})
```

### Slider
Creates a range adjustment bar.
```lua
Tab:AddSlider({
    Text = "Slider Text",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        -- Value returns integer number
    end
})
```

### Dropdown
Creates a floating selection list.
```lua
Tab:AddDropdown({
    Text = "Dropdown Text",
    Items = {"Option 1", "Option 2"},
    Default = "Option 1",
    Callback = function(Selected)
        -- Returns selected item
    end
})
```

###TextBox
Creates a text input box.
```lua
Tab:AddTextBox({
    Text = "TextBox Text",
    Placeholder = "Type here...",
    Default = "",
    Callback = function(Text, EnterPressed)
        -- Returns input string
    end
})
```
