--[[
    irish hub auto steal
    from von
    https://discord.gg/rNvAU6cjVB
]]

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local Stats = game:GetService('Stats')
local TweenService = game:GetService('TweenService')
local Workspace = game:GetService('Workspace')
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')
local AUTO_STEAL = true
local HOLD_TIME = 1.3
local RADIUS = 60
local isStealing = false
local currentPrompt = nil
local gui = PlayerGui:FindFirstChild('J hub ')

if not gui then
    gui = Instance.new('ScreenGui')
    gui.Name = 'J hub '
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui
end

local main = Instance.new('Frame')

main.Size = UDim2.new(0, 260, 0, 70)
main.Position = UDim2.new(0.5, -130, 0, 35)
main.BackgroundTransparency = 1
main.Parent = gui

local topBar = Instance.new('Frame')

topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
topBar.BackgroundTransparency = 0.85
topBar.BorderSizePixel = 0
topBar.Parent = main
Instance.new('UICorner', topBar).CornerRadius = UDim.new(0, 8)

local stroke = Instance.new('UIStroke')

stroke.Color = Color3.fromRGB(0, 170, 0)
stroke.Thickness = 1.5
stroke.Parent = topBar

local statsLabel = Instance.new('TextLabel')

statsLabel.Size = UDim2.new(1, 0, 1, 0)
statsLabel.BackgroundTransparency = 1
statsLabel.Font = Enum.Font.GothamBold
statsLabel.TextSize = 14
statsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statsLabel.Text = 'Irish Hub | Ping: 0ms | FPS: 0'
statsLabel.TextXAlignment = Enum.TextXAlignment.Center
statsLabel.Parent = topBar

local progressHolder = Instance.new('Frame')

progressHolder.Size = UDim2.new(1, 0, 0, 14)
progressHolder.Position = UDim2.new(0, 0, 0, 34)
progressHolder.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
progressHolder.BackgroundTransparency = 0.25
progressHolder.Parent = main
Instance.new('UICorner', progressHolder).CornerRadius = UDim.new(0, 10)

local progressBar = Instance.new('Frame')

progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
progressBar.Parent = progressHolder
Instance.new('UICorner', progressBar).CornerRadius = UDim.new(0, 10)

local percentLabel = Instance.new('TextLabel')

percentLabel.Size = UDim2.new(1, 0, 1, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 11
percentLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
percentLabel.Text = '0%'
percentLabel.Parent = progressHolder

local function getRoot()
    local char = LocalPlayer.Character

    if not char then
        return nil
    end

    return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('UpperTorso') or char:FindFirstChild('Torso')
end
local function isValidPrompt(prompt)
    if not prompt then
        return false
    end
    if not prompt:IsA('ProximityPrompt') then
        return false
    end
    if not prompt.Enabled then
        return false
    end

    local state = prompt:GetAttribute('State')
    local text = tostring(prompt.ActionText)

    return state == 'Steal' or state == 'Grab' or text == 'Steal' or text == 'Grab'
end
local function getNearestPrompt()
    local root = getRoot()

    if not root then
        return nil
    end

    local nearest = nil
    local nearestDistance = RADIUS
    local plots = Workspace:FindFirstChild('Plots')

    if not plots then
        return nil
    end

    for _, plot in ipairs(plots:GetChildren())do
        local podiums = plot:FindFirstChild('AnimalPodiums')

        if podiums then
            for _, podium in ipairs(podiums:GetChildren())do
                local base = podium:FindFirstChild('Base')
                local spawn = base and base:FindFirstChild('Spawn')
                local attachment = spawn and spawn:FindFirstChild('PromptAttachment')

                if attachment then
                    for _, child in ipairs(attachment:GetChildren())do
                        if isValidPrompt(child) then
                            local distance = (root.Position - attachment.WorldPosition).Magnitude

                            if distance <= nearestDistance then
                                nearestDistance = distance
                                nearest = child
                            end
                        end
                    end
                end
            end
        end
    end

    return nearest
end
local function firePromptConnections(prompt, signalName)
    local connections = getconnections(prompt[signalName])

    for _, conn in ipairs(connections)do
        if conn.Function then
            task.spawn(conn.Function)
        end
    end
end
local function executeSteal(prompt)
    if isStealing then
        return
    end
    if not prompt then
        return
    end

    isStealing = true
    currentPrompt = prompt
    progressBar.Size = UDim2.new(0, 0, 1, 0)

    firePromptConnections(prompt, 'PromptButtonHoldBegan')

    local tween = TweenService:Create(progressBar, TweenInfo.new(HOLD_TIME, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, 1, 0),
    })

    tween:Play()

    for i = 1, 100 do
        percentLabel.Text = tostring(i) .. '%'

        task.wait(HOLD_TIME / 100)
    end

    if prompt and prompt.Parent and prompt.Enabled then
        firePromptConnections(prompt, 'Triggered')
    end

    progressBar.Size = UDim2.new(0, 0, 1, 0)
    percentLabel.Text = '0%'
    isStealing = false
    currentPrompt = nil
end

local frames = 0
local fps = 0
local ping = 0
local last = tick()

RunService.RenderStepped:Connect(function()
    frames += 1

    if tick() - last >= 1 then
        fps = frames
        frames = 0
        last = tick()

        local network = Stats:FindFirstChild('Network')

        if network then
            local serverStats = network:FindFirstChild('ServerStatsItem')

            if serverStats then
                local pingStat = serverStats:FindFirstChild('Data Ping')

                if pingStat then
                    ping = math.floor(pingStat:GetValue())
                end
            end
        end
    end

    statsLabel.Text = 'Irish Hub | Ping: ' .. ping .. 'ms | FPS: ' .. fps
end)
task.spawn(function()
    while task.wait(0.1) do
        if AUTO_STEAL and not isStealing then
            local prompt = getNearestPrompt()

            if prompt then
                executeSteal(prompt)
            end
        end
    end
end)