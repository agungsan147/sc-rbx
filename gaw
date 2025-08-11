local player = game.Players.LocalPlayer
local hub = Instance.new("ScreenGui")
hub.Parent = player:WaitForChild("PlayerGui")
hub.Name = "Hub"

-- Tombol Shop
local btn = Instance.new("TextButton")
btn.Parent = hub
btn.Name = "ShopBtn"
btn.Size = UDim2.new(0, 250, 0, 50)
btn.Position = UDim2.new(0.5, -125, 0, 0)
btn.Text = "Shop"
btn.TextSize = 30
btn.Font = Enum.Font.Highway
btn.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
btn.TextColor3 = Color3.new(1, 1, 1)

-- Frame Shop
local shopFrame = Instance.new("Frame")
shopFrame.Parent = hub
shopFrame.Name = "ShopFrame"
shopFrame.Size = UDim2.new(0, 250, 0, 50)
shopFrame.Position = UDim2.new(0.5, -125, 0, 54)
shopFrame.BackgroundTransparency = 1
shopFrame.Visible = false

-- Tombol All Seed
local allSeedBtn = Instance.new("TextButton")
allSeedBtn.Parent = shopFrame
allSeedBtn.Name = "AllSeedBtn"
allSeedBtn.Size = UDim2.new(1, 0, 1, 0)
allSeedBtn.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
allSeedBtn.Text = ""

-- Label Nama
local allSeedName = Instance.new("TextLabel")
allSeedName.Parent = allSeedBtn
allSeedName.Size = UDim2.new(0.7, 0, 1, 0)
allSeedName.Text = "Buy All Seed"
allSeedName.TextSize = 30
allSeedName.Font = Enum.Font.Highway
allSeedName.BackgroundTransparency = 1
allSeedName.TextColor3 = Color3.new(1, 1, 1)

-- Label Check
local allSeedCheck = Instance.new("TextLabel")
allSeedCheck.Parent = allSeedBtn
allSeedCheck.AnchorPoint = Vector2.new(1, 0.5)
allSeedCheck.Position = UDim2.new(1, -10, 0.5, 0)
allSeedCheck.Size = UDim2.new(0, 30, 0, 30)
allSeedCheck.Text = "⬜"
allSeedCheck.TextSize = 30
allSeedCheck.Font = Enum.Font.Highway
allSeedCheck.BackgroundTransparency = 1
allSeedCheck.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Fungsi buka/tutup frame
btn.MouseButton1Click:Connect(function()
	shopFrame.Visible = not shopFrame.Visible
end)

-- Fungsi centang
local isBuying = false

allSeedBtn.MouseButton1Click:Connect(function()
	if not isBuying then
		-- Aktifkan
		isBuying = true
		allSeedCheck.Text = "✅"

		local seedList = {"Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn", "Daffodil", "Watermelon"}
		local rep = game:GetService("ReplicatedStorage")
		local event = rep.GameEvents.BuySeedStock

		task.spawn(function()
			while isBuying do
				for _, seedName in ipairs(seedList) do
					if not isBuying then break end -- stop kalau sudah off
					event:FireServer(seedName)
					task.wait(0.5)
				end
			end
		end)
	else
		-- Nonaktifkan
		isBuying = false
		allSeedCheck.Text = "⬜"
	end
end)

