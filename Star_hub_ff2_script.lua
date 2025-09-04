-- Football Fusion 2: Advanced ESP & Visual Enhancements

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local settings = {
    -- ESP Settings
    enablePlayerESP = true,
    playerOutlineColor = Color3.fromRGB(255, 0, 0),
    playerOutlineThickness = 2,
    enableBallESP = true,
    ballOutlineColor = Color3.fromRGB(0, 255, 0),
    ballOutlineThickness = 2,
    ballGlowColor = Color3.fromRGB(0, 255, 255),
    ballGlowTransparency = 0.5,
    -- Ball Path Prediction
    enableBallPathPrediction = true,
    ballPathPredictionColor = Color3.fromRGB(255, 255, 0),
    ballPathPredictionThickness = 1,
    -- Ball Box
    enableBallBox = true,
    ballBoxColor = Color3.fromRGB(255, 165, 0),
    ballBoxTransparency = 0.3,
}

-- Function to create ESP for players
local function createPlayerESP(player)
    local esp = Instance.new("Highlight")
    esp.Name = player.Name .. "_ESP"
    esp.Parent = workspace.CurrentCamera
    esp.Adornee = player.Character
    esp.FillColor = settings.playerOutlineColor
    esp.OutlineColor = settings.playerOutlineColor
    esp.OutlineTransparency = settings.playerOutlineThickness
    esp.FillTransparency = settings.playerOutlineThickness
    esp.Enabled = settings.enablePlayerESP
end

-- Function to create ESP for the football
local function createBallESP()
    local ball = workspace:FindFirstChild("Football")
    if ball then
        local esp = Instance.new("Highlight")
        esp.Name = "Football_ESP"
        esp.Parent = workspace.CurrentCamera
        esp.Adornee = ball
        esp.FillColor = settings.ballOutlineColor
        esp.OutlineColor = settings.ballOutlineColor
        esp.OutlineTransparency = settings.ballOutlineThickness
        esp.FillTransparency = settings.ballOutlineThickness
        esp.Enabled = settings.enableBallESP

        -- Ball Glow
        local glow = Instance.new("PointLight")
        glow.Parent = ball
        glow.Color = settings.ballGlowColor
        glow.Brightness = 2
        glow.Range = 10
        glow.Enabled = settings.enableBallESP
    end
end

-- Function to predict the ball's path
local function predictBallPath()
    local ball = workspace:FindFirstChild("Football")
    if ball then
        local trajectory = {} -- Store trajectory points
        local velocity = ball.Velocity
        local position = ball.Position
        local gravity = workspace.Gravity

        -- Simulate ball's path
        for i = 1, 100 do
            local time = i / 60
            local x = position.X + velocity.X * time
            local y = position.Y + velocity.Y * time - 0.5 * gravity * time^2
            local z = position.Z + velocity.Z * time
            table.insert(trajectory, Vector3.new(x, y, z))
        end

        -- Draw trajectory
        for i = 1, #trajectory - 1 do
            local part = Instance.new("Part")
            part.Size = Vector
