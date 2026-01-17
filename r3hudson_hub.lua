--[[
    R3Hudson Hub
    UI ONLY - NON-FUNCTIONAL
    Draggable & ready for Xeno
--]]

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
main.Size = UDim2.new(0, 400, 0, 320)
main.Position = UDim2.new(0.5, -200, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

-- Top Bar
local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 45)
top.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
top.BorderSizePixel = 0
top.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 14)
topCorner.Parent = top

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "R3Hudson Hub"
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = top

-- Version
local version = Instance.new("TextLabel")
version.Size = UDim2.new(0, 80, 1, 0)
version.Position = UDim2.new(1, -90, 0, 0)
version.BackgroundTransparency = 1
version.Text = "v1.0"
version.TextColor3 = Color3.fromRGB(150, 150, 150)
version.Font = Enum.Font.Gotham
version.TextSize = 14
version.Parent = top

-- Section Label
local section = Instance.new("TextLabel")
section.Size = UDim2.new(1, -20, 0, 30)
section.Position = UDim2.new(0, 10, 0, 60)
section.BackgroundTransparency = 1
section.Text = "Combat"
section.TextXAlignment = Enum.TextXAlignment.Left
section.TextColor3 = Color3.fromRGB(180, 180, 180)
section.Font = Enum.Font.GothamBold
section.TextSize = 15
section.Parent = main

-- Fake toggle creator
local function createToggle(text, y)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 42)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    frame.Parent = main

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 65, 0, 26)
    toggle.Position = UDim2.new(1, -75, 0.5, -13)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.AutoButtonColor = false
    toggle.Parent = frame

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 6)
    tc.Parent = toggle

    toggle.MouseButton1Click:Connect(function()
        if toggle.Text == "OFF" then
            toggle.Text = "ON"
            toggle.BackgroundColor3 = Color3.fromRGB(0, 140, 0)
        else
            toggle.Text = "OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
        end
        -- intentionally does nothing
    end)
end

-- Toggles
createToggle("Aimbot", 100)
createToggle("Silent Aim", 150)
createToggle("ESP (Visual)", 200)
createToggle("Fly", 250)

-- Dragging
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
