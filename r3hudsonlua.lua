-- R3Hudson Hub
-- UI ONLY / NON-FUNCTIONAL

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

Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

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

-- Tabs
local function createTab(text, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,110,0,30)
    b.Position = UDim2.new(0,x,0,60)
    b.BackgroundColor3 = Color3.fromRGB(30,30,30)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(200,200,200)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.AutoButtonColor = false
    b.Parent = main
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
    return b
end

local rivalsTab = createTab("Rivals", 10)
local slapTab   = createTab("Slap Battles", 130)
local miscTab   = createTab("Misc", 270)

-- Content Frames
local frames = {}

local function createFrame(titleText)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,-20,0,220)
    f.Position = UDim2.new(0,10,0,100)
    f.BackgroundColor3 = Color3.fromRGB(26,26,26)
    f.Visible = false
    f.Parent = main
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,8)

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1,0,0,30)
    t.BackgroundTransparency = 1
    t.Text = titleText
    t.TextColor3 = Color3.fromRGB(220,220,220)
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.Parent = f

    return f
end

frames.Rivals = createFrame("Rivals")
frames.Slap = createFrame("Slap Battles")
frames.Misc = createFrame("Misc")

local function show(name)
    for k,v in pairs(frames) do
        v.Visible = (k == name)
    end
end

rivalsTab.MouseButton1Click:Connect(function() show("Rivals") end)
slapTab.MouseButton1Click:Connect(function() show("Slap") end)
miscTab.MouseButton1Click:Connect(function() show("Misc") end)

-- Fake Toggle
local function toggle(parent, text, y)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,-20,0,40)
    f.Position = UDim2.new(0,10,0,y)
    f.BackgroundColor3 = Color3.fromRGB(36,36,36)
    f.Parent = parent
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,6)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.7,0,1,0)
    l.Position = UDim2.new(0,10,0,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextColor3 = Color3.fromRGB(230,230,230)
    l.Font = Enum.Font.Gotham
    l.TextSize = 14
    l.Parent = f

    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,60,0,24)
    b.Position = UDim2.new(1,-70,0.5,-12)
    b.BackgroundColor3 = Color3.fromRGB(80,0,0)
    b.Text = "OFF"
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.AutoButtonColor = false
    b.Parent = f
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

    b.MouseButton1Click:Connect(function()
        if b.Text == "OFF" then
            b.Text = "ON"
            b.BackgroundColor3 = Color3.fromRGB(0,140,0)
        else
            b.Text = "OFF"
            b.BackgroundColor3 = Color3.fromRGB(80,0,0)
        end
    end)
end

-- ✅ RIVALS ONLY (as requested)
toggle(frames.Rivals, "Aimbot", 40)
toggle(frames.Rivals, "Silent Aim", 90)
toggle(frames.Rivals, "ESP", 140)
toggle(frames.Rivals, "Ragebot", 190)

-- Other sections left empty intentionally
show("Rivals")

-- Dragging
local dragging, startPos, startInput
top.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startInput = i.Position
        startPos = main.Position
    end
end)

top.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - startInput
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + d.X,
            startPos.Y.Scale, startPos.Y.Offset + d.Y
        )
    end
end)
