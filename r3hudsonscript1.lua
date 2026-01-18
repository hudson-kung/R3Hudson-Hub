-- R3Hudson Hub with game sections
-- NON-FUNCTIONAL, UI only

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "R3HudsonHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 450, 0, 350)
main.Position = UDim2.new(0.5, -225, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(16,16,16)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,14)
corner.Parent = main

-- Top Bar
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,50)
top.BackgroundColor3 = Color3.fromRGB(25,25,25)
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-20,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "R3Hudson Hub"
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = top

-- Section Buttons Container
local buttons = {}

local function createTab(name, posX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,100,0,30)
    btn.Position = UDim2.new(0,posX,0,55)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200,200,200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.Parent = main

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,6)
    corner.Parent = btn

    return btn
end

-- Tabs
local rivalsTab = createTab("Rivals", 10)
local slapTab = createTab("Slap Battles", 120)
local miscTab = createTab("Misc", 240)

-- Content Frames
local contentFrames = {}

local function createContentFrame(name)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-20,0,220)
    frame.Position = UDim2.new(0,10,0,100)
    frame.BackgroundColor3 = Color3.fromRGB(26,26,26)
    frame.Visible = false
    frame.Parent = main

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,30)
    label.Position = UDim2.new(0,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = name.." Section"
    label.TextColor3 = Color3.fromRGB(220,220,220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.Parent = frame

    return frame
end

contentFrames.Rivals = createContentFrame("Rivals")
contentFrames.SlapBattles = createContentFrame("Slap Battles")
contentFrames.Misc = createContentFrame("Misc")

-- Toggle visual content
local function showFrame(name)
    for k,v in pairs(contentFrames) do
        v.Visible = (k == name)
    end
end

rivalsTab.MouseButton1Click:Connect(function() showFrame("Rivals") end)
slapTab.MouseButton1Click:Connect(function() showFrame("SlapBattles") end)
miscTab.MouseButton1Click:Connect(function() showFrame("Misc") end)

-- Add fake toggles to frames
local function createToggle(parent, text, y)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,35)
    frame.Position = UDim2.new(0,0,0,y)
    frame.BackgroundColor3 = Color3.fromRGB(36,36,36)
    frame.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,6)
    c.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7,0,1,0)
    label.Position = UDim2.new(0,10,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = Color3.fromRGB(230,230,230)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0,60,0,24)
    toggle.Position = UDim2.new(1,-70,0.5,-12)
    toggle.BackgroundColor3 = Color3.fromRGB(80,0,0)
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(255,255,255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.AutoButtonColor = false
    toggle.Parent = frame

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0,6)
    tc.Parent = toggle

    toggle.MouseButton1Click:Connect(function()
        if toggle.Text == "OFF" then
            toggle.Text = "ON"
            toggle.BackgroundColor3 = Color3.fromRGB(0,140,0)
        else
            toggle.Text = "OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(80,0,0)
        end
    end)
end

-- Fake toggles in Rival section
createToggle(contentFrames.Rivals, "Rival Aimbot", 40)
createToggle(contentFrames.Rivals, "Rival ESP", 90)

-- Fake toggles in Slap Battles section
createToggle(contentFrames.SlapBattles, "Slap Fly", 40)
createToggle(contentFrames.SlapBattles, "Slap ESP", 90)

-- Fake toggles in Misc section
createToggle(contentFrames.Misc, "Player Speed", 40)
createToggle(contentFrames.Misc, "Invisibility", 90)

-- Dragging main frame
local dragging = false
local dragStart, startPos

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

top.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Show default section
showFrame("Rivals")
