--[[
╔════════════════════════╗
║  Cypher Spectre ║ DeepSight            ║
╚════════════════════════╝
Script Deobfuscated by Cypher Spectre & Reconstructed by Cypher AI Bot
Version: DeepSight
Author on Discord / TikTok: @roman666cabj
]]

local charMap = {}
local availableCharCodes = {}
local mathFloor = math.floor
local mathRandom = math.random
local tableRemove = table.remove
local stringChar = string.char

local prngGlobalState = 0
local prngGlobalShift = 2

local charMapReference = charMap
local tempCharValue = 1

for i = 1, 256, 1 do
    availableCharCodes[i] = i
end

local charCodeToRemove
local randomIndex
repeat
    randomIndex = mathRandom(1, #availableCharCodes)
    charCodeToRemove = tableRemove(availableCharCodes, randomIndex)
    tempCharValue = stringChar(charCodeToRemove - 1)
    charMapReference[charCodeToRemove] = tempCharValue
until #availableCharCodes == 0

local function getDeobfuscationPrngByte()
    prngGlobalState = (prngGlobalState * 157 + 12394979399307) % 35184372088832
    local val = mathFloor(prngGlobalState / 2 ^ (13 - (prngGlobalShift - prngGlobalShift % 32) / 32))
    return mathFloor((val % 4294967296) / 2 ^ (prngGlobalShift % 32)) % 256
end

local prngByteGenerator = getDeobfuscationPrngByte

local decryptionCache = {}
local metatableForDecryptionCache = {
    __index = decryptionCache,
    __metatable = nil,
}
local decryptedStringAccess = setmetatable({}, metatableForDecryptionCache)
local decryptedStringAccessRef = decryptedStringAccess

local function decryptString(encryptedString, cacheKey)
    if decryptionCache[cacheKey] then
        return decryptionCache[cacheKey]
    else
        local charMapRef = charMapReference
        local stringLength = string.len(encryptedString)
        local decryptedChars = {}
        local currentCipherKey = 186

        for i = 1, stringLength, 1 do
            local charByte = string.byte(encryptedString, i)
            local prngByte = prngByteGenerator()
            
            local cipheredIndex = ((charByte + prngByte) + currentCipherKey) % 256
            currentCipherKey = cipheredIndex
            
            decryptedChars[i] = charMapRef[cipheredIndex + 1]
        end
        decryptionCache[cacheKey] = table.concat(decryptedChars)
        return decryptionCache[cacheKey]
    end
end
local decryptStringReference = decryptString


decryptionCache[31574947281263] = "OFF"
local decryptedTextKey_OFF = decryptStringReference('', 31574947281263)

local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local Workspace = game:GetService('Workspace')

repeat
    task.wait()
until game:IsLoaded()

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild('PlayerGui')

local getgenvConfig = getgenv()
getgenvConfig.ValenConfig = getgenvConfig.ValenConfig or {}
getgenvConfig.ValenConfig.Enabled = getgenvConfig.ValenConfig.Enabled or false
getgenvConfig.ValenConfig.Mode = getgenvConfig.ValenConfig.Mode or 'PC'

local configEnabled = getgenvConfig.ValenConfig.Enabled
local configMode = getgenvConfig.ValenConfig.Mode

local tweenDuration = 1.3
local isHandlingPrompt = false
local uiColors = {
    Main = Color3.fromRGB(14, 14, 14),
    Second = Color3.fromRGB(24, 24, 24),
    Stroke = Color3.fromRGB(70, 70, 70),
    Text = Color3.fromRGB(255, 255, 255),
    Sub = Color3.fromRGB(180, 180, 180),
    Fill = Color3.fromRGB(120, 120, 120),
}

local screenGui = Instance.new('ScreenGui')
screenGui.Name = 'ValenGrabFinal'
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local mainFrame = Instance.new('Frame')
mainFrame.Size = UDim2.new(0, 230, 0, 130)
mainFrame.Position = UDim2.new(0.5, -115, 0.5, -65)
mainFrame.BackgroundColor3 = uiColors.Main
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainFrameCorner = Instance.new('UICorner', mainFrame)
mainFrameCorner.CornerRadius = UDim.new(0, 14)

local mainFrameStroke = Instance.new('UIStroke')
mainFrameStroke.Color = uiColors.Stroke
mainFrameStroke.Thickness = 2
mainFrameStroke.Parent = mainFrame

local iconBackground = Instance.new('Frame')
iconBackground.Size = UDim2.new(0, 28, 0, 28)
iconBackground.Position = UDim2.new(0, 8, 0, 8)
iconBackground.BackgroundColor3 = uiColors.Second
iconBackground.BorderSizePixel = 0
iconBackground.Parent = mainFrame

local iconBackgroundCorner = Instance.new('UICorner', iconBackground)
iconBackgroundCorner.CornerRadius = UDim.new(1, 0)

local iconBackgroundStroke = Instance.new('UIStroke')
iconBackgroundStroke.Color = uiColors.Stroke
iconBackgroundStroke.Parent = iconBackground

local iconImage = Instance.new('ImageLabel')
iconImage.Size = UDim2.new(1, -6, 1, -6)
iconImage.Position = UDim2.new(0, 3, 0, 3)
iconImage.BackgroundTransparency = 1
iconImage.Image = 'rbxassetid://120042443836261'
iconImage.Parent = iconBackground

local iconImageCorner = Instance.new('UICorner', iconImage)
iconImageCorner.CornerRadius = UDim.new(1, 0)

local titleLabel = Instance.new('TextLabel')
titleLabel.Size = UDim2.new(1, -110, 0, 24)
titleLabel.Position = UDim2.new(0, 42, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = 'Valen Grab'
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 15
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextColor3 = uiColors.Text
titleLabel.Parent = mainFrame

local modeToggleBtn = Instance.new('TextButton')
modeToggleBtn.Size = UDim2.new(0, 52, 0, 20)
modeToggleBtn.Position = UDim2.new(1, -60, 0, 12)
modeToggleBtn.BackgroundColor3 = uiColors.Second
modeToggleBtn.TextColor3 = uiColors.Text
modeToggleBtn.Font = Enum.Font.GothamBold
modeToggleBtn.TextSize = 9
modeToggleBtn.Parent = mainFrame

local modeToggleBtnCorner = Instance.new('UICorner', modeToggleBtn)
modeToggleBtnCorner.CornerRadius = UDim.new(1, 0)

local modeToggleBtnStroke = Instance.new('UIStroke')
modeToggleBtnStroke.Color = uiColors.Stroke
modeToggleBtnStroke.Parent = modeToggleBtn

local autoGrabFrame = Instance.new('Frame')
autoGrabFrame.Size = UDim2.new(1, -16, 0, 40)
autoGrabFrame.Position = UDim2.new(0, 8, 0, 40)
autoGrabFrame.BackgroundColor3 = uiColors.Second
autoGrabFrame.BorderSizePixel = 0
autoGrabFrame.Parent = mainFrame

local autoGrabFrameCorner = Instance.new('UICorner', autoGrabFrame)
autoGrabFrameCorner.CornerRadius = UDim.new(0, 10)

local autoGrabFrameStroke = Instance.new('UIStroke')
autoGrabFrameStroke.Color = uiColors.Stroke
autoGrabFrameStroke.Parent = autoGrabFrame

local autoGrabLabel = Instance.new('TextLabel')
autoGrabLabel.Size = UDim2.new(0.6, 0, 1, 0)
autoGrabLabel.Position = UDim2.new(0, 10, 0, 0)
autoGrabLabel.BackgroundTransparency = 1
autoGrabLabel.Text = 'Auto Grab'
autoGrabLabel.Font = Enum.Font.GothamBold
autoGrabLabel.TextSize = 14
autoGrabLabel.TextXAlignment = Enum.TextXAlignment.Left
autoGrabLabel.TextColor3 = uiColors.Text
autoGrabLabel.Parent = autoGrabFrame

local autoGrabToggleBtn = Instance.new('TextButton')
autoGrabToggleBtn.Size = UDim2.new(0, 50, 0, 24)
autoGrabToggleBtn.Position = UDim2.new(1, -58, 0.5, -12)
autoGrabToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

autoGrabToggleBtn.Text = decryptedStringAccessRef[decryptedTextKey_OFF]
autoGrabToggleBtn.Parent = autoGrabFrame

local autoGrabToggleBtnCorner = Instance.new('UICorner', autoGrabToggleBtn)
autoGrabToggleBtnCorner.CornerRadius = UDim.new(1, 0)

local autoGrabToggleBtnInner = Instance.new('Frame')
autoGrabToggleBtnInner.Size = UDim2.new(0, 18, 0, 18)
autoGrabToggleBtnInner.Position = UDim2.new(0, 3, 0.5, -9)
autoGrabToggleBtnInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
autoGrabToggleBtnInner.Parent = autoGrabToggleBtn

local autoGrabToggleBtnInnerCorner = Instance.new('UICorner', autoGrabToggleBtnInner)
autoGrabToggleBtnInnerCorner.CornerRadius = UDim.new(1, 0)

local stealingStatusLabel = Instance.new('TextLabel')
stealingStatusLabel.Size = UDim2.new(1, -16, 0, 14)
stealingStatusLabel.Position = UDim2.new(0, 8, 0, 84)
stealingStatusLabel.BackgroundTransparency = 1
stealingStatusLabel.Text = 'Stealing: None'
stealingStatusLabel.Font = Enum.Font.GothamMedium
stealingStatusLabel.TextSize = 11
stealingStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
stealingStatusLabel.TextColor3 = uiColors.Sub
stealingStatusLabel.Parent = mainFrame

local progressBarBg = Instance.new('Frame')
progressBarBg.Size = UDim2.new(1, -16, 0, 16)
progressBarBg.Position = UDim2.new(0, 8, 0, 104)
progressBarBg.BackgroundColor3 = uiColors.Second
progressBarBg.BorderSizePixel = 0
progressBarBg.Parent = mainFrame

local progressBarBgCorner = Instance.new('UICorner', progressBarBg)
progressBarBgCorner.CornerRadius = UDim.new(1, 0)

local progressBarBgStroke = Instance.new('UIStroke')
progressBarBgStroke.Color = uiColors.Stroke
progressBarBgStroke.Parent = progressBarBg

local progressBarFill = Instance.new('Frame')
progressBarFill.Size = UDim2.new(0, 0, 1, 0)
progressBarFill.BackgroundColor3 = uiColors.Fill
progressBarFill.BorderSizePixel = 0
progressBarFill.Parent = progressBarBg

local progressBarFillCorner = Instance.new('UICorner', progressBarFill)
progressBarFillCorner.CornerRadius = UDim.new(1, 0)

local progressBarText = Instance.new('TextLabel')
progressBarText.Size = UDim2.new(1, 0, 1, 0)
progressBarText.BackgroundTransparency = 1
progressBarText.Text = '0%'
progressBarText.Font = Enum.Font.GothamBold
progressBarText.TextSize = 10
progressBarText.TextColor3 = uiColors.Text
progressBarText.Parent = progressBarBg

local function updateAutoGrabToggle(isEnabled)
    getgenvConfig.ValenConfig.Enabled = isEnabled

    if isEnabled then
        autoGrabToggleBtn.Text = "ON"
        local tweenInfo = TweenInfo.new(0.2)
        local targetPosition = UDim2.new(1, -21, 0.5, -9)
        local tween = TweenService:Create(autoGrabToggleBtnInner, tweenInfo, {Position = targetPosition})
        tween:Play()

        local tweenInfoColor = TweenInfo.new(0.2)
        local targetColor = Color3.fromRGB(100, 100, 100)
        local colorTween = TweenService:Create(autoGrabToggleBtn, tweenInfoColor, {BackgroundColor3 = targetColor})
        colorTween:Play()
    else
        autoGrabToggleBtn.Text = "OFF"
        local tweenInfo = TweenInfo.new(0.2)
        local targetPosition = UDim2.new(0, 3, 0.5, -9)
        local tween = TweenService:Create(autoGrabToggleBtnInner, tweenInfo, {Position = targetPosition})
        tween:Play()

        local tweenInfoColor = TweenInfo.new(0.2)
        local targetColor = Color3.fromRGB(45, 45, 45)
        local colorTween = TweenService:Create(autoGrabToggleBtn, tweenInfoColor, {BackgroundColor3 = targetColor})
        colorTween:Play()
    end
end

local function updateUIforMode()
    local currentMode = getgenvConfig.ValenConfig.Mode

    if currentMode == 'Mobile' then
        mainFrame.Size = UDim2.new(0, 230, 0, 130)
        modeToggleBtn.Text = 'MOBILE'
        if not getgenvConfig.ValenConfig.Enabled then
             updateAutoGrabToggle(false)
        else
            updateAutoGrabToggle(true) 
        end
    else
        mainFrame.Size = UDim2.new(0, 310, 0, 165)
        modeToggleBtn.Text = 'PC'
        updateAutoGrabToggle(getgenvConfig.ValenConfig.Enabled)
    end
end
local updateUIforModeRef = updateUIforMode

modeToggleBtn.MouseButton1Click:Connect(function()
    if getgenvConfig.ValenConfig.Mode == 'PC' then
        getgenvConfig.ValenConfig.Mode = 'Mobile'
    else
        getgenvConfig.ValenConfig.Mode = 'PC'
    end
    updateUIforModeRef()
end)

local function toggleAutoGrabMobile()
    if getgenvConfig.ValenConfig.Mode == 'Mobile' then
        updateAutoGrabToggle(not getgenvConfig.ValenConfig.Enabled)
    end
end

autoGrabToggleBtn.MouseButton1Click:Connect(toggleAutoGrabMobile)

local function toggleAutoGrabPC(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.E then
        if getgenvConfig.ValenConfig.Mode == 'PC' then
            updateAutoGrabToggle(not getgenvConfig.ValenConfig.Enabled)
        end
    end
end

local function runSafeCalls()
    warn("Cypher AI: runSafeCalls function is largely non-functional due to internal errors in original code and has been commented out.")
end

UserInputService.InputBegan:Connect(toggleAutoGrabPC)

local function checkPlotForSigns(plotModel)

    if not plotModel then
        return true
    end

    local plotSign = plotModel:FindFirstChild('PlotSign')
    if plotSign then
        local yourBase = plotSign:FindFirstChild('YourBase')
        if yourBase then
            if yourBase:IsA('BillboardGui') then
                return true
            else
                return true
            end
        end
    end
    return false
end

local function isStealable(prompt)
    if not prompt or not prompt:IsA('ProximityPrompt') then
        return false
    end
    return prompt:GetAttribute('State') == 'Steal'
end
local isStealableRef = isStealable

local function getLocalPlayerCharacter()
    local character = localPlayer.Character
    if not character then
        character = localPlayer.CharacterAdded:Wait()
    end
    return character
end
local getLocalPlayerCharacterRef = getLocalPlayerCharacter

local function findStealablePrompt()
    local character = getLocalPlayerCharacterRef()
    if not character then
        return nil
    end

    local plotsContainer = Workspace:FindFirstChild('Plots')
    if not plotsContainer then
        return nil
    end

    for _, plot in ipairs(plotsContainer:GetChildren()) do
        if not checkPlotForSigns(plot) then
            local animalPodiums = plot:FindFirstChild('AnimalPodiums')
            if animalPodiums then
                for _, podiumChild in ipairs(animalPodiums:GetChildren()) do
                    local basePart = podiumChild:FindFirstChild('Base')
                    if basePart then
                        for _, child in ipairs(basePart:GetChildren()) do
                            if child:IsA('ProximityPrompt') and isStealableRef(child) then
                                return child
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end
local findStealablePromptRef = findStealablePrompt

local function handlePromptTrigger(prompt)
    if isHandlingPrompt or not prompt or not prompt:IsA('ProximityPrompt') then
        return
    end
    isHandlingPrompt = true

    stealingStatusLabel.Text = 'Stealing: ' .. prompt.ObjectText

    local character = localPlayer.Character
    local characterHumanoid = character and character:FindFirstChildOfClass('Humanoid')
    if characterHumanoid then
        prompt:Trigger(characterHumanoid)
    else
        warn("Cypher AI: Could not find Humanoid to trigger ProximityPrompt for " .. prompt.ObjectText)
        isHandlingPrompt = false
        return
    end

    progressBarFill.Size = UDim2.new(0, 0, 1, 0)
    local startTime = tick()
    local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Linear)
    local targetSize = UDim2.new(1, 0, 1, 0)
    local tween = TweenService:Create(progressBarFill, tweenInfo, {Size = targetSize})
    tween:Play()

    local elapsed
    repeat
        elapsed = tick() - startTime
        local progress = mathFloor((elapsed / tweenDuration) * 100)
        progressBarText.Text = progress .. '%'
        task.wait()
    until elapsed >= tweenDuration

    progressBarText.Text = '100%'
    task.wait(0.1)

    stealingStatusLabel.Text = 'Stealing: None'
    progressBarFill.Size = UDim2.new(0, 0, 1, 0)
    progressBarText.Text = '0%'

    isHandlingPrompt = false
end
local handlePromptTriggerRef = handlePromptTrigger

local function autoGrabLoop()
    while true do
        task.wait(0.1)

        if getgenvConfig.ValenConfig.Enabled and not isHandlingPrompt then
            local foundPrompt = findStealablePromptRef()
            if foundPrompt then
                handlePromptTriggerRef(foundPrompt)
            else
                stealingStatusLabel.Text = 'Stealing: None'
            end
        elseif not getgenvConfig.ValenConfig.Enabled then
            stealingStatusLabel.Text = 'Stealing: None'
            progressBarFill.Size = UDim2.new(0, 0, 1, 0)
            progressBarText.Text = '0%'
        end
    end
end

task.spawn(autoGrabLoop)

local isDragging = false
local dragStartPosition = nil
local initialPosition = nil

local function onInputBegan(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and mainFrame:IsMouseOver() then
        isDragging = true
        dragStartPosition = input.Position
        initialPosition = mainFrame.Position
    end
end
mainFrame.InputBegan:Connect(onInputBegan)

local function onInputChanged(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPosition
        mainFrame.Position = UDim2.new(initialPosition.X.Scale, initialPosition.X.Offset + delta.X,
                                      initialPosition.Y.Scale, initialPosition.Y.Offset + delta.Y)
    end
end
UserInputService.InputChanged:Connect(onInputChanged)

local function onInputEnded(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end
UserInputService.InputEnded:Connect(onInputEnded)

updateUIforModeRef()
updateAutoGrabToggle(getgenvConfig.ValenConfig.Enabled)

print('Valen Auto Grab Final Loaded')