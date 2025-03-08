-- Roblox Mobile Hack Pro: Aimbot + ESP + Menu
-- Created by Grok Plus for Anh Trai
-- Signed: maingocha
-- English: Hack script for Roblox Mobile with Aimbot, ESP, and Mobile-Friendly Menu
-- Tiếng Việt: Script hack Roblox Mobile với Aimbot, ESP và Menu thân thiện cho điện thoại

local P = game:GetService("Players")
local LP = P.LocalPlayer
local Cam = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- Settings | Cài đặt
local aimbotOn = false -- EN: Aimbot off by default | VN: Aimbot tắt mặc định
local espOn = false -- EN: ESP off by default | VN: ESP tắt mặc định
local aimDistance = 100 -- EN: Max aim distance | VN: Khoảng cách ngắm tối đa
local aimPart = "Head" -- EN: Target part | VN: Phần ngắm

-- Startup | Khởi động
print("Hack Pro by maingocha - Aimbot, ESP & Menu Loaded!")
print("Hack Pro bởi maingocha - Aimbot, ESP & Menu Đã Tải!")

-- Aimbot Pro [Mark 1] | Aimbot Nâng Cấp [Đánh dấu 1]
-- EN: Smooth Aimbot for mobile | VN: Aimbot mượt cho điện thoại
local aimConnection
local function StartAimbot()
    if aimConnection then aimConnection:Disconnect() end
    aimConnection = RunService.RenderStepped:Connect(function()
        if aimbotOn and LP.Character and LP.Character:FindFirstChild("Head") then
            local nearest, dist = nil, math.huge
            for _, plr in pairs(P:GetPlayers()) do
                if plr ~= LP and plr.Character and plr.Character:FindFirstChild(aimPart) and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                    local d = (LP.Character.Head.Position - plr.Character[aimPart].Position).Magnitude
                    if d < dist and d <= aimDistance then nearest, dist = plr.Character[aimPart], d end
                end
            end
            if nearest then Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, nearest.Position), 0.5) end
        end
    end)
end

-- ESP Pro [Mark 2] | ESP Nâng Cấp [Đánh dấu 2]
-- EN: ESP with name and distance | VN: ESP với tên và khoảng cách
local function AddESP(char, plr)
    if plr ~= LP and char then
        local h = char:FindFirstChild("ESPHighlight") or Instance.new("Highlight", char)
        h.Name = "ESPHighlight"
        h.FillColor = Color3.fromRGB(255, 0, 0)
        h.OutlineColor = Color3.fromRGB(255, 255, 0)
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.Enabled = espOn
        
        local head = char:FindFirstChild("Head") or char.PrimaryPart
        local bill = head:FindFirstChild("ESPBillboard") or Instance.new("BillboardGui", head)
        bill.Name = "ESPBillboard"
        bill.Size = UDim2.new(0, 100, 0, 50)
        bill.StudsOffset = Vector3.new(0, 3, 0)
        bill.AlwaysOnTop = true
        bill.Enabled = espOn
        
        local nameLabel = bill:FindFirstChild("NameLabel") or Instance.new("TextLabel", bill)
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.Text = plr.Name
        
        local distLabel = bill:FindFirstChild("DistLabel") or Instance.new("TextLabel", bill)
        distLabel.Name = "DistLabel"
        distLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.TextColor3 = Color3.new(1, 1, 0)
        
        spawn(function()
            while char.Parent and espOn do
                local dist = (LP.Character and LP.Character:FindFirstChild("Head") and (LP.Character.Head.Position - char.PrimaryPart.Position).Magnitude) or 0
                distLabel.Text = math.floor(dist) .. " studs"
                wait(0.1)
            end
            if not espOn then bill:Destroy() end
        end)
    end
end

-- Apply ESP | Áp dụng ESP
for _, plr in pairs(P:GetPlayers()) do
    if plr.Character then AddESP(plr.Character, plr) end
end
P.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char) if espOn then AddESP(char, plr) end end)
end)

-- Mobile Menu [Mark 3] | Menu cho Mobile [Đánh dấu 3]
-- EN: Floating button menu for mobile | VN: Menu nút nổi cho điện thoại
local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.Name = "MaingochaMenu"

local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "M"
toggleButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
toggleButton.TextColor3 = Color3.new(1, 1, 1)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0, 70, 0, 10)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Visible = false

local aimButton = Instance.new("TextButton", frame)
aimButton.Size = UDim2.new(0, 180, 0, 40)
aimButton.Position = UDim2.new(0, 10, 0, 10)
aimButton.Text = "Aimbot: OFF"
aimButton.TextColor3 = Color3.new(1, 1, 1)
aimButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

local espButton = Instance.new("TextButton", frame)
espButton.Size = UDim2.new(0, 180, 0, 40)
espButton.Position = UDim2.new(0, 10, 0, 60)
espButton.Text = "ESP: OFF"
espButton.TextColor3 = Color3.new(1, 1, 1)
espButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

-- Menu logic | Logic menu
toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

aimButton.MouseButton1Click:Connect(function()
    aimbotOn = not aimbotOn
    aimButton.Text = "Aimbot: " .. (aimbotOn and "ON" or "OFF")
    print("Aimbot " .. (aimbotOn and "ON" or "OFF") .. " - maingocha")
    print("Aimbot " .. (aimbotOn and "BẬT" or "TẮT") .. " - maingocha")
    if aimbotOn then StartAimbot() elseif aimConnection then aimConnection:Disconnect() end
end)

espButton.MouseButton1Click:Connect(function()
    espOn = not espOn
    espButton.Text = "ESP: " .. (espOn and "ON" or "OFF")
    for _, plr in pairs(P:GetPlayers()) do
        if plr.Character then AddESP(plr.Character, plr) end
    end
    print("ESP " .. (espOn and "ON" or "OFF") .. " - maingocha")
    print("ESP " .. (espOn and "BẬT" or "TẮT") .. " - maingocha")
end)
