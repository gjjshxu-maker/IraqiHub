-- ==========================================
-- 🇮🇶 IRAQI HUB - (V24 Ultimate Monster Edition)
-- حقوق: المطور العراقي 🇮🇶
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==========================================
-- 🛡️ حماية ضد الطرد
-- ==========================================
local rawMetatable = getrawmetatable(game)
if setreadonly then setreadonly(rawMetatable, false) end

local oldNamecall = rawMetatable.__namecall
rawMetatable.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if tostring(method):lower() == "kick" then
        warn("[Iraqi Hub]: تم إحباط محاولة طرد محلي!")
        return nil
    end
    return oldNamecall(self, ...)
end)
if setreadonly then setreadonly(rawMetatable, true) end

-- ==========================================
-- 🖼️ إنشاء الواجهة
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IraqiForestHubV24"
ScreenGui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ==========================================
-- 🔒 زر العلم - ثواني 2
-- ==========================================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 75, 0, 75)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleBtn.BorderSizePixel = 2
ToggleBtn.BorderColor3 = Color3.fromRGB(220, 20, 20)
ToggleBtn.Text = "🇮🇶\nحقوق عراقي\n🔒 مقفول"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 11
ToggleBtn.Active = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = ToggleBtn

local holdStartTime = 0
local isHolding = false
local isDragging = false
local dragStartPos, frameStartPos

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        holdStartTime = tick()
        isHolding = true
        isDragging = false
        dragStartPos = input.Position
        frameStartPos = ToggleBtn.Position

        task.spawn(function()
            while isHolding do
                local elapsed = tick() - holdStartTime
                if elapsed >= 2 then
                    if ScreenGui:FindFirstChild("MainFrame") then
                        ScreenGui.MainFrame.Visible = not ScreenGui.MainFrame.Visible
                    end
                    isDragging = true
                    ToggleBtn.Text = "🇮🇶\nحقوق عراقي\n🔓 مفتوح"
                    ToggleBtn.BorderColor3 = Color3.fromRGB(0, 255, 100)
                    break
                else
                    ToggleBtn.Text = "🇮🇶\nانتظر..\n" .. string.format("%.1f", 2 - elapsed) .. "s"
                end
                task.wait(0.05)
            end
        end)
    end
end)

ToggleBtn.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartPos
        ToggleBtn.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y)
    end
end)

ToggleBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isHolding = false
        isDragging = false
        ToggleBtn.Text = "🇮🇶\nحقوق عراقي\n🔒 مقفول"
        ToggleBtn.BorderColor3 = Color3.fromRGB(220, 20, 20)
    end
end)

-- ==========================================
-- 🖼️ الإطار الرئيسي
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 530, 0, 360)
MainFrame.Position = UDim2.new(0.5, -265, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local function MakeFrameDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
        end
    end)
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end
MakeFrameDraggable(MainFrame)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 2)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🇮🇶 حقوق: المطور العراقي - [V24 Ultimate Monster]"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 13

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 145, 1, -35)
Sidebar.Position = UDim2.new(0, 5, 0, 32)
Sidebar.BackgroundTransparency = 1

local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, -160, 1, -38)
ContentFrame.Position = UDim2.new(0, 155, 0, 32)
ContentFrame.BackgroundTransparency = 1

local tabs, scrolls = {}, {}
local tabNames = {
    {id = 1, name = "🎯 أيم بوت وحش + هيدبوكس"},
    {id = 2, name = "👁️ كشف أماكن الخصوم (ESP)"},
    {id = 3, name = "⚡ حركة وثغرات وخوارق"}
}

local function SwitchTab(tabId)
    for id, scroll in pairs(scrolls) do scroll.Visible = (id == tabId) end
    for id, btn in pairs(tabs) do
        btn.BackgroundColor3 = (id == tabId) and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(22, 22, 22)
        btn.TextColor3 = (id == tabId) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    end
end

for i, tabInfo in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 36)
    btn.BackgroundColor3 = (i == 1) and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(22, 22, 22)
    btn.BorderSizePixel = 0
    btn.Text = tabInfo.name
    btn.TextColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 4)
    c.Parent = btn

    local scroll = Instance.new("ScrollingFrame")
    scroll.Parent = ContentFrame
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 580)
    scroll.ScrollBarThickness = 3
    scroll.Visible = (i == 1)

    local list = Instance.new("UIListLayout")
    list.Parent = scroll
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 6)

    tabs[tabInfo.id] = btn
    scrolls[tabInfo.id] = scroll

    btn.MouseButton1Click:Connect(function() SwitchTab(tabInfo.id) end)
end

local function AddHeader(parent, text)
    local head = Instance.new("TextLabel")
    head.Parent = parent
    head.Size = UDim2.new(1, -5, 0, 22)
    head.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    head.Text = "  " .. text
    head.TextColor3 = Color3.fromRGB(255, 215, 0)
    head.Font = Enum.Font.SourceSansBold
    head.TextSize = 11
    head.TextXAlignment = Enum.TextXAlignment.Left

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 3)
    c.Parent = head
end

local function AddToggle(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, -5, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = "  ⭕  " .. text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 3)
    c.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and ("  🔵  " .. text) or ("  ⭕  " .. text)
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 80, 150) or Color3.fromRGB(20, 20, 20)
        task.spawn(function() callback(active) end)
    end)
end

local function AddSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, -5, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 3)
    c.Parent = frame

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, -10, 0, 18)
    label.Position = UDim2.new(0, 5, 0, 2)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextBox")
    box.Parent = frame
    box.Size = UDim2.new(0, 50, 0, 18)
    box.Position = UDim2.new(1, -55, 0, 2)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    box.Text = tostring(default)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 11

    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Parent = frame
    sliderBtn.Size = UDim2.new(1, -10, 0, 14)
    sliderBtn.Position = UDim2.new(0, 5, 0, 24)
    sliderBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderBtn.Text = ""

    local fill = Instance.new("Frame")
    fill.Parent = sliderBtn
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    fill.BorderSizePixel = 0

    local function updateValue(val)
        val = math.clamp(math.floor(val), min, max)
        box.Text = tostring(val)
        label.Text = text .. ": " .. tostring(val)
        fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
        callback(val)
    end

    box.FocusLost:Connect(function()
        local n = tonumber(box.Text)
        if n then updateValue(n) end
    end)

    local dragging = false
    sliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            local relativeX = math.clamp(input.Position.X - sliderBtn.AbsolutePosition.X, 0, sliderBtn.AbsoluteSize.X)
            local pct = relativeX / sliderBtn.AbsoluteSize.X
            updateValue(min + pct * (max - min))
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relativeX = math.clamp(input.Position.X - sliderBtn.AbsolutePosition.X, 0, sliderBtn.AbsoluteSize.X)
            local pct = relativeX / sliderBtn.AbsoluteSize.X
            updateValue(min + pct * (max - min))
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ==========================================
-- 🎯 1️⃣ تبويب: الأيم بوت الخارق ومثبت الهيدشوت
-- ==========================================
AddHeader(scrolls[1], "أيم بوت وحشي (Headshot Focus Only)")

local aimbotEnabled = false
local headshotOnly = true
local fovRadius = 300

local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Transparency = 0.8
FOVCircle.Visible = true

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Radius = fovRadius
end)

local function GetClosestTargetHead()
    local bestPart = nil
    local shortestDist = fovRadius
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local targetPart = headshotOnly and p.Character:FindFirstChild("Head") or (p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart"))
            if targetPart then
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        bestPart = targetPart
                    end
                end
            end
        end
    end
    return bestPart
end

-- تثبيت ومتابعة وحشية وسريعة جداً على الرأس
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local targetHead = GetClosestTargetHead()
        if targetHead then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)
        end
    end
end)

AddToggle(scrolls[1], "تفعيل الأيم بوت الخارق (Monster Lock)", function(state) aimbotEnabled = state end)
AddToggle(scrolls[1], "🎯 تركيز قفل هيد شوت بالرأس فقط", function(state) headshotOnly = state end)
AddSlider(scrolls[1], "حجم نطاق الأيم بوت (FOV)", 50, 800, 300, function(val) fovRadius = val end)

AddHeader(scrolls[1], "هيد بوكس نافذ وتأثير ضرب حقيقي")

local hitboxSize = 25
local hitboxActive = false

AddSlider(scrolls[1], "حجم الهيد بوكس الخارق", 5, 200, 30, function(val) hitboxSize = val end)
AddToggle(scrolls[1], "تفعيل الهيدبوكس العنيف جداً", function(state)
    hitboxActive = state
    while hitboxActive do
        task.wait(0.1)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                local head = p.Character:FindFirstChild("Head")
                if hrp then
                    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    hrp.Transparency = 0.7
                    hrp.BrickColor = BrickColor.new("Really red")
                    hrp.Material = Enum.Material.Neon
                    hrp.CanCollide = false
                    hrp.CanTouch = true
                end
                if head then
                    head.Size = Vector3.new(hitboxSize / 2, hitboxSize / 2, hitboxSize / 2)
                    head.CanCollide = false
                end
            end
        end
    end
    if not hitboxActive then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                local head = p.Character:FindFirstChild("Head")
                if hrp then
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
                if head then
                    head.Size = Vector3.new(1.2, 1.2, 1.2)
                end
            end
        end
    end
end)

-- ==========================================
-- 👁️ 2️⃣ تبويب: كشف أماكن الخصوم (ESP 2D / 3D / Tracers)
-- ==========================================
AddHeader(scrolls[2], "كشف صريح وواضح للشاشة")

local esp2D = false
local esp3D = false
local espTracers = false
local espHealthBar = false
local espDistance = false

local playerDrawings = {}

local function RemoveESP(player)
    if playerDrawings[player] then
        for _, obj in pairs(playerDrawings[player]) do
            if type(obj) == "table" then
                for _, subObj in pairs(obj) do subObj:Remove() end
            else
                obj:Remove()
            end
        end
        playerDrawings[player] = nil
    end
end

RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            local hum = char and char:FindFirstChild("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            if char and hum and hrp and hum.Health > 0 and (esp2D or esp3D or espTracers or espHealthBar or espDistance) then
                local topPos, topOnScreen = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3.2, 0))
                local bottomPos, bottomOnScreen = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.5, 0))

                if topOnScreen or bottomOnScreen then
                    if not playerDrawings[p] then
                        playerDrawings[p] = {
                            Box2D = Drawing.new("Square"),
                            Tracer = Drawing.new("Line"),
                            HealthBarBG = Drawing.new("Square"),
                            HealthBar = Drawing.new("Square"),
                            Text = Drawing.new("Text"),
                            Box3DLines = {}
                        }
                        for i = 1, 12 do
                            local line = Drawing.new("Line")
                            line.Thickness = 1.5
                            line.Color = Color3.fromRGB(0, 255, 255)
                            table.insert(playerDrawings[p].Box3DLines, line)
                        end
                    end

                    local drawings = playerDrawings[p]
                    local boxHeight = math.abs(topPos.Y - bottomPos.Y)
                    local boxWidth = boxHeight * 0.65
                    local boxPos = Vector2.new(topPos.X - boxWidth / 2, topPos.Y)

                    -- 1. 2D Box
                    drawings.Box2D.Visible = esp2D
                    drawings.Box2D.Color = Color3.fromRGB(0, 255, 150)
                    drawings.Box2D.Thickness = 2
                    drawings.Box2D.Size = Vector2.new(boxWidth, boxHeight)
                    drawings.Box2D.Position = boxPos

                    -- 2. Tracers (خطوط الرؤية)
                    drawings.Tracer.Visible = espTracers
                    drawings.Tracer.Color = Color3.fromRGB(255, 255, 0)
                    drawings.Tracer.Thickness = 1.5
                    drawings.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    drawings.Tracer.To = Vector2.new(bottomPos.X, bottomPos.Y)

                    -- 3. 3D Box ESP (مربع ثنائي/ثلاثي الأبعاد مجسم)
                    if esp3D then
                        local cf = hrp.CFrame
                        local size = Vector3.new(2.5, 5, 2.5)
                        local corners = {
                            cf * CFrame.new(-size.X, size.Y, -size.Z), cf * CFrame.new(size.X, size.Y, -size.Z),
                            cf * CFrame.new(size.X, size.Y, size.Z), cf * CFrame.new(-size.X, size.Y, size.Z),
                            cf * CFrame.new(-size.X, -size.Y, -size.Z), cf * CFrame.new(size.X, -size.Y, -size.Z),
                            cf * CFrame.new(size.X, -size.Y, size.Z), cf * CFrame.new(-size.X, -size.Y, size.Z)
                        }
                        local screenCorners = {}
                        local allOnScreen = true
                        for idx, corner in ipairs(corners) do
                            local scrPos, vis = Camera:WorldToViewportPoint(corner.Position)
                            screenCorners[idx] = Vector2.new(scrPos.X, scrPos.Y)
                            if not vis then allOnScreen = false end
                        end

                        if allOnScreen then
                            local connections = {
                                {1,2}, {2,3}, {3,4}, {4,1},
                                {5,6}, {6,7}, {7,8}, {8,5},
                                {1,5}, {2,6}, {3,7}, {4,8}
                            }
                            for idx, conn in ipairs(connections) do
                                local line = drawings.Box3DLines[idx]
                                line.Visible = true
                                line.From = screenCorners[conn[1]]
                                line.To = screenCorners[conn[2]]
                            end
                        else
                            for _, line in ipairs(drawings.Box3DLines) do line.Visible = false end
                        end
                    else
                        for _, line in ipairs(drawings.Box3DLines) do line.Visible = false end
                    end

                    -- 4. Health Bar
                    if espHealthBar then
                        local healthPct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                        local barWidth = 4
                        local barHeight = boxHeight * healthPct

                        drawings.HealthBarBG.Visible = true
                        drawings.HealthBarBG.Color = Color3.fromRGB(10, 10, 10)
                        drawings.HealthBarBG.Filled = true
                        drawings.HealthBarBG.Size = Vector2.new(barWidth, boxHeight)
                        drawings.HealthBarBG.Position = Vector2.new(boxPos.X - barWidth - 3, boxPos.Y)

                        drawings.HealthBar.Visible = true
                        drawings.HealthBar.Color = Color3.fromRGB(255 * (1 - healthPct), 255 * healthPct, 0)
                        drawings.HealthBar.Filled = true
                        drawings.HealthBar.Size = Vector2.new(barWidth, barHeight)
                        drawings.HealthBar.Position = Vector2.new(boxPos.X - barWidth - 3, boxPos.Y + (boxHeight - barHeight))
                    else
                        drawings.HealthBarBG.Visible = false
                        drawings.HealthBar.Visible = false
                    end

                    -- 5. Text
                    local infoText = p.Name
                    if espDistance and myHrp then
                        local dist = math.floor((hrp.Position - myHrp.Position).Magnitude)
                        infoText = infoText .. " [" .. dist .. "m]"
                    end

                    drawings.Text.Visible = (esp2D or esp3D or espDistance)
                    drawings.Text.Text = infoText
                    drawings.Text.Size = 13
                    drawings.Text.Color = Color3.fromRGB(255, 255, 255)
                    drawings.Text.Center = true
                    drawings.Text.Outline = true
                    drawings.Text.Position = Vector2.new(topPos.X, boxPos.Y - 18)
                else
                    RemoveESP(p)
                end
            else
                RemoveESP(p)
            end
        end
    end
end)

Players.PlayerRemoving:Connect(RemoveESP)

AddToggle(scrolls[2], "كشف الصندوق العادي (ESP 2D)", function(state) esp2D = state end)
AddToggle(scrolls[2], "📐 كشف الصندوق مجسم ثلاثي الأبعاد (ESP 3D)", function(state) esp3D = state end)
AddToggle(scrolls[2], "⚡ زر خطوط الرؤية (Tracers)", function(state) espTracers = state end)
AddToggle(scrolls[2], "🔴 كشف شريط دم الخصم", function(state) espHealthBar = state end)
AddToggle(scrolls[2], "📏 كشف مسافة الخصم", function(state) espDistance = state end)

-- ==========================================
-- ⚡ 3️⃣ تبويب: الطيران وسرعة الحركة والخوارق
-- ==========================================
AddHeader(scrolls[3], "طيران حر وسلس المجهود")

local flyActive = false
local flySpeed = 60

AddSlider(scrolls[3], "سرعة الطيران السلس", 10, 300, 60, function(val) flySpeed = val end)
AddToggle(scrolls[3], "🛸 تشغيل / إطفاء الطيران الحر", function(state)
    flyActive = state
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if flyActive then
        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.Name = "FreeFlyVelV24"
        bodyVel.Parent = hrp
        bodyVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bodyVel.Velocity = Vector3.new(0, 0, 0)

        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Name = "FreeFlyGyroV24"
        bodyGyro.Parent = hrp
        bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bodyGyro.P = 9e4
        bodyGyro.CFrame = Camera.CFrame

        task.spawn(function()
            while flyActive do
                task.wait()
                local hum = char:FindFirstChildOfClass("Humanoid")
                bodyGyro.CFrame = Camera.CFrame
                if hum and hum.MoveDirection.Magnitude > 0 then
                    bodyVel.Velocity = Camera.CFrame.LookVector * flySpeed
                else
                    bodyVel.Velocity = Vector3.new(0, 0, 0)
                end
            end
            bodyVel:Destroy()
            bodyGyro:Destroy()
        end)
    else
        if hrp:FindFirstChild("FreeFlyVelV24") then hrp.FreeFlyVelV24:Destroy() end
        if hrp:FindFirstChild("FreeFlyGyroV24") then hrp.FreeFlyGyroV24:Destroy() end
    end
end)

AddHeader(scrolls[3], "اختراق الجدران والسرعة والقفز الخارق")

-- 1. اختراق الجدران (Noclip)
local noclipActive = false
AddToggle(scrolls[3], "🧱 تفعيل اختراق الجدران (Noclip)", function(state)
    noclipActive = state
    while noclipActive do
        task.wait(0.1)
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- 2. التحكم بالقفزة (Jump Power)
local customJump = 50
local jumpActive = false

AddSlider(scrolls[3], "ارتفاع القفزة العالية", 50, 300, 100, function(val) customJump = val end)
AddToggle(scrolls[3], "🦘 تفعيل القفزة العالية", function(state)
    jumpActive = state
    while jumpActive do
        task.wait(0.1)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            hum.UseJumpPower = true
            hum.JumpPower = customJump
        end
    end
    if not jumpActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
    end
end)

-- 3. السرعة (WalkSpeed)
local customSpeed = 35
local speedActive = false

AddSlider(scrolls[3], "سرعة المشي (WalkSpeed)", 16, 300, 35, function(val) customSpeed = val end)
AddToggle(scrolls[3], "🏃‍♂️ تفعيل التحكم بالسرعة", function(state)
    speedActive = state
    while speedActive do
        task.wait(0.05)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = customSpeed
        end
    end
    if not speedActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
end)
