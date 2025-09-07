-- Star Hub Menu - Robust Load + Massive Halo + Overpower Magnet
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- Settings
local settings = {
    magnet = true,
    overpowerMagnet = false,
    autoCatch = true,
    angle = true,
    freezeTech = false,
    freezeTime = 2,
    esp = true,
    path = true,
    range = 20,
    catchLeft = true,
    catchRight = true,
    superKick=false,
    speedBoost=false,
    autoScore=false,
    instantPass=false,
    autoBlock=false,
    fastRespawn=false,
    greenHalo=true
}

-- GUI creation
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "StarHub_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 350)
    frame.Position = UDim2.new(0.5, -150, 0.2, 0)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    local title =
