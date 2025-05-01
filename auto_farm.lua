-- Variables
local flySpeed = 390.45
local flyDuration = 21
local centerPosition = Vector3.new(0, 100, 0)
local chestPosition = Vector3.new(15, -5, 9495)
local player = game.Players.LocalPlayer
local autoFarming = false
local antiAFKEnabled = false

local autoFarmGui
local bodyVelocity
local mainFrame

-- Functions

function startAntiAFK()
    spawn(function()
        while antiAFKEnabled do
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, math.random(-1, 1))
            end
            wait(2)
        end
    end)
end

function enableNoclip(character)
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

function startAutoFarm()
    spawn(function()
        while autoFarming do
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:FindFirstChild("HumanoidRootPart")

            if hrp then
                hrp.CFrame = CFrame.new(centerPosition)
                enableNoclip(character)

                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                bodyVelocity.Velocity = Vector3.new(0, 0, flySpeed)
                bodyVelocity.Parent = hrp

                wait(flyDuration)

                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
                hrp.CFrame = CFrame.new(chestPosition)

                character:BreakJoints()

                wait(9)
            end
        end
    end)
end

function stopFlying()
    if bodyVelocity then
        bodyVelocity:Destroy()
    end
end

function teleportToBase()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(0, 10, 0)
    end
end

function makeRounded(instance)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = instance
end

function makeDraggable(frame)
    frame.Active = true
    frame.Draggable = true
end

-- GUIs
function createAutoFarmGui()
    autoFarmGui = Instance.new("ScreenGui", game.CoreGui)

    mainFrame = Instance.new("Frame", autoFarmGui)
    mainFrame.Size = UDim2.new(0, 300, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    makeRounded(mainFrame)
    makeDraggable(mainFrame)

    -- Top Bar with Title and buttons
    local topBar = Instance.new("Frame", mainFrame)
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    topBar.BorderSizePixel = 0
    makeRounded(topBar)

    local titleLabel = Instance.new("TextLabel", topBar)
    titleLabel.Size = UDim2.new(1, -70, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.Text = "Auto Farm GUI"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local minimizeButton = Instance.new("TextButton", topBar)
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -60, 0, 0)
    minimizeButton.Text = "_"
    minimizeButton.TextSize = 20
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.BorderSizePixel = 0
    makeRounded(minimizeButton)

    local closeButton = Instance.new("TextButton", topBar)
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.Text = "X"
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.BorderSizePixel = 0
    makeRounded(closeButton)

    local startButton = Instance.new("TextButton", mainFrame)
    startButton.Size = UDim2.new(0.8, 0, 0.15, 0)
    startButton.Position = UDim2.new(0.1, 0, 0.3, 0)
    startButton.Text = "Start Auto Farm"
    startButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    makeRounded(startButton)

    local antiAFKButton = Instance.new("TextButton", mainFrame)
    antiAFKButton.Size = UDim2.new(0.8, 0, 0.15, 0)
    antiAFKButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    antiAFKButton.Text = "Enable Anti-AFK"
    antiAFKButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    antiAFKButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    makeRounded(antiAFKButton)

    -- Minimized Frame
    local minimizedFrame = Instance.new("Frame", autoFarmGui)
    minimizedFrame.Size = UDim2.new(0, 120, 0, 40)
    minimizedFrame.Position = UDim2.new(0.5, -60, 0, 10)
    minimizedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    minimizedFrame.Visible = false
    makeRounded(minimizedFrame)
    makeDraggable(minimizedFrame)

    local openButton = Instance.new("TextButton", minimizedFrame)
    openButton.Size = UDim2.new(1, 0, 1, 0)
    openButton.Text = "Open Auto Farm"
    openButton.BackgroundTransparency = 1
    openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    openButton.Font = Enum.Font.GothamBold
    openButton.TextSize = 14

    -- Events
    startButton.MouseButton1Click:Connect(function()
        autoFarming = not autoFarming
        startButton.Text = autoFarming and "Stop Auto Farm" or "Start Auto Farm"
        if autoFarming then
            startAutoFarm()
        else
            stopFlying()
            teleportToBase()
        end
    end)

    antiAFKButton.MouseButton1Click:Connect(function()
        antiAFKEnabled = not antiAFKEnabled
        if antiAFKEnabled then
            startAntiAFK()
            antiAFKButton.Text = "Disable Anti-AFK"
        else
            antiAFKButton.Text = "Enable Anti-AFK"
        end
    end)

    minimizeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        minimizedFrame.Visible = true
    end)

    openButton.MouseButton1Click:Connect(function()
        minimizedFrame.Visible = false
        mainFrame.Visible = true
    end)

    closeButton.MouseButton1Click:Connect(function()
        autoFarming = false
        stopFlying()
        if autoFarmGui then
            autoFarmGui:Destroy()
        end
    end)
end

-- Start GUI
createAutoFarmGui()
