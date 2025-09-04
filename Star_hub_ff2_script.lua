loadstring([[-- Football Fusion 2: Advanced ESP & Visual Enhancements

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local settings = {
    enablePlayerESP = true,
    playerOutlineColor = Color3.fromRGB(255, 0, 0),
    playerOutlineThickness = 2,
    enableBallESP = true,
    ballOutlineColor = Color3.fromRGB(0, 255, 0),
    ballOutlineThickness = 2,
    ballGlowColor = Color3.fromRGB(0, 255, 255),
    ballGlowTransparency = 0.5,
    enableBallPathPrediction = true,
    ballPathPredictionColor = Color3.fromRGB(255, 255, 0),
    ballPathPredictionThickness = 1,
    enableBallBox = true,
    ballBoxColor = Color3.fromRGB(255, 165, 0),
    ballBoxTransparency = 0.3,
}

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

        local glow = Instance.new("PointLight")
        glow.Parent = ball
        glow.Color = settings.ballGlowColor
        glow.Brightness = 2
        glow.Range = 10
        glow.Enabled = settings.enableBallESP
    end
end

local function predictBallPath()
    local ball = workspace:FindFirstChild("Football")
    if ball then
        local trajectory = {}
        local velocity = ball.Velocity
        local position = ball.Position
        local gravity = workspace.Gravity

        for i = 1, 100 do
            local time = i / 60
            local x = position.X + velocity.X * time
            local y = position.Y + velocity.Y * time - 0.5 * gravity * time^2
            local z = position.Z + velocity.Z * time
            table.insert(trajectory, Vector3.new(x, y, z))
        end

        for i = 1, #trajectory - 1 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.2, 0.2, 0.2)
            part.Anchored = true
            part.CanCollide = false
            part.Position = trajectory[i]
            part.Color = settings.ballPathPredictionColor
            part.Material = Enum.Material.Neon
            part.Parent = workspace
            game:GetService("Debris"):AddItem(part, 0.1)
        end
    end
end

local function createBallBox()
    local ball = workspace:FindFirstChild("Football")
    if ball then
        local box = Instance.new("BoxHandleAdornment")
        box.Adornee = ball
        box.Size = Vector3.new(4, 4, 4)
        box.Color3 = settings.ballBoxColor
        box.Transparency = settings.ballBoxTransparency
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Parent = ball
        box.Visible = settings.enableBallBox
    end
end

RunService.RenderStepped:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            if not plr.Character:FindFirstChild(plr.Name .. "_ESP") then
                createPlayerESP(plr)
            end
        end
    end
    if settings.enableBallESP then createBallESP() end
    if settings.enableBallPathPrediction then predictBallPath() end
    if settings.enableBallBox then createBallBox() end
end)
]])()
