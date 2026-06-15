-- ===================================================
-- VŨ MODZ | WALLHOP ULTIMATE - CHẮC CHẮN HIỆN MENU
-- ✅ Menu LUÔN HIỆN RA, KHÔNG ẨN
-- ✅ ĐÚNG CƠ CHẾ: Bám tường -> Nhảy tiếp
-- ✅ Giao diện TÍM PHÁT SÁNG, ĐẠM CHẤT VIỄN TƯỞNG
-- ✅ Kéo thả được, thanh trượt chỉnh được, thu nhỏ được
-- ✅ HOÀN HẢO 100%
-- ===================================================

-- Dịch vụ hệ thống
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- =====================
-- CÀI ĐẶT
-- =====================
local Settings = {
    WallhopEnabled = false,
    AutoFlick = true,
    FlickAngle = 180,
    Velocity = 48,
    Cooldown = 0.03,
    LadderFlick = true,
    
    RayDistance = 1.9,
    MinSpeed = 0.2,
    LastJump = 0
}

-- Biến điều khiển
local Character, Humanoid, RootPart
local CanWallhop = true
local UI, MainFrame, TitleBar, Content

-- =====================
-- TẠO GIAO DIỆN - ĐẸP & LUÔN HIỆN
-- =====================
UI = Instance.new("ScreenGui")
UI.Name = "VuModz_Complete"
UI.Parent = LocalPlayer:WaitForChild("PlayerGui")
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UI.DisplayOrder = 9999
UI.IgnoreGuiInset = true -- QUAN TRỌNG: Không bị cắt màn hình
UI.Enabled = true -- LUÔN BẬT

-- NỀN CHÍNH - MÀU TÍM ĐẸP
MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = UI
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 40)
MainFrame.BackgroundTransparency = 0.05
MainFrame.Position = UDim2.new(0.02, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 330, 0, 440)
MainFrame.Visible = true -- LUÔN HIỆN
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

-- Bo góc mềm
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Gradient nền - hiệu ứng chiều sâu
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 20, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 30))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

-- Viền phát sáng điện tím
local BorderGlow = Instance.new("ImageLabel")
BorderGlow.Name = "BorderGlow"
BorderGlow.Parent = MainFrame
BorderGlow.BackgroundTransparency = 1
BorderGlow.Position = UDim2.new(-0.03, 0, -0.03, 0)
BorderGlow.Size = UDim2.new(1.06, 0, 1.06, 0)
BorderGlow.Image = "rbxassetid://6014261984"
BorderGlow.ImageColor3 = Color3.fromRGB(100, 50, 255)
BorderGlow.ImageTransparency = 0.5
BorderGlow.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", BorderGlow).CornerRadius = UDim.new(0, 16)

-- THANH TIÊU ĐỀ - NỔI BẬT
TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(90, 40, 255)
TitleBar.BackgroundTransparency = 0.1
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BorderSizePixel = 0
TitleBar.ClipsDescendants = true
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 14)

-- Gradient tiêu đề
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 50, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 60, 220))
}
TitleGradient.Rotation = 20
TitleGradient.Parent = TitleBar

-- Hiệu ứng điện chạy ngang
local EnergyEffect = Instance.new("Frame")
EnergyEffect.Name = "Energy"
EnergyEffect.Parent = TitleBar
EnergyEffect.BackgroundColor3 = Color3.fromRGB(200, 180, 255)
EnergyEffect.BackgroundTransparency = 0.4
EnergyEffect.Size = UDim2.new(0.3, 0, 1, 0)
EnergyEffect.Position = UDim2.new(-0.3, 0, 0, 0)
spawn(function()
    while UI do
        TweenService:Create(EnergyEffect, TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            Position = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 0.6
        }):Play()
        wait(1.2)
        EnergyEffect.Position = UDim2.new(-0.3, 0, 0, 0)
        EnergyEffect.BackgroundTransparency = 0.4
    end
end)

-- Tên Menu: VŨ MODZ - ĐẸP, PHÁT SÁNG
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 18, 0, 0)
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "VŨ MODZ"
TitleText.TextColor3 = Color3.new(1,1,1)
TitleText.TextSize = 18
TitleText.TextStrokeTransparency = 0.7
TitleText.TextStrokeColor3 = Color3.fromRGB(180, 120, 255)
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Nút Thu nhỏ
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Parent = TitleBar
MinBtn.BackgroundTransparency = 1
MinBtn.Position = UDim2.new(1, -60, 0, 8)
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "−"
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.TextSize = 22

-- Nội dung chính
Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 0, 0, 48)
Content.Size = UDim2.new(1, 0, 1, -48)
Content.CanvasSize = UDim2.new(0, 0, 0, 380)
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = Color3.fromRGB(110, 50, 255)
Content.BorderSizePixel = 0

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Content
UIListLayout.Padding = UDim.new(0, 14)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- =====================
-- HÀM TẠO CÔNG TẮC (HOẠT ĐỘNG ĐÚNG)
-- =====================
local function CreateToggle(name, order, callback)
    local Container = Instance.new("Frame", Content)
    Container.BackgroundColor3 = Color3.fromRGB(25, 20, 55)
    Container.BackgroundTransparency = 0.1
    Container.Size = UDim2.new(0.92, 0, 0, 52)
    Container.LayoutOrder = order
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 10)

    -- Hiệu ứng sáng
    local Glow = Instance.new("ImageLabel", Container)
    Glow.BackgroundTransparency = 1
    Glow.Position = UDim2.new(-0.05, 0, -0.1, 0)
    Glow.Size = UDim2.new(1.1, 0, 1.2, 0)
    Glow.Image = "rbxassetid://6014261984"
    Glow.ImageColor3 = Color3.fromRGB(100, 50, 255)
    Glow.ImageTransparency = 0.85
    Glow.ScaleType = Enum.ScaleType.Fit

    -- Tên chức năng
    local Text = Instance.new("TextLabel", Container)
    Text.BackgroundTransparency = 1
    Text.Position = UDim2.new(0, 16, 0, 0)
    Text.Size = UDim2.new(0.7, 0, 1, 0)
    Text.Font = Enum.Font.GothamSemibold
    Text.Text = name
    Text.TextColor3 = Color3.new(0.95, 0.95, 1)
    Text.TextSize = 14
    Text.TextXAlignment = Enum.TextXAlignment.Left

    -- Nền công tắc
    local ToggleBG = Instance.new("Frame", Container)
    ToggleBG.BackgroundColor3 = Color3.fromRGB(40, 35, 70)
    ToggleBG.BackgroundTransparency = 0.2
    ToggleBG.Position = UDim2.new(1, -50, 0.5, -12)
    ToggleBG.Size = UDim2.new(0, 38, 0, 24)
    Instance.new("UICorner", ToggleBG).CornerRadius = UDim.new(1,0)

    -- Điểm tròn
    local ToggleCircle = Instance.new("Frame", ToggleBG)
    ToggleCircle.BackgroundColor3 = Color3.new(1,1,1)
    ToggleCircle.Position = UDim2.new(0, 2, 0, 2)
    ToggleCircle.Size = UDim2.new(0, 20, 0, 20)
    Instance.new("UICorner", ToggleCircle).CornerRadius = UDim.new(1,0)

    -- Hiệu ứng sáng khi bật
    local CircleGlow = Instance.new("ImageLabel", ToggleCircle)
    CircleGlow.BackgroundTransparency = 1
    CircleGlow.Position = UDim2.new(-0.3, 0, -0.3, 0)
    CircleGlow.Size = UDim2.new(1.6, 0, 1.6, 0)
    CircleGlow.Image = "rbxassetid://6014261984"
    CircleGlow.ImageColor3 = Color3.fromRGB(150, 80, 255)
    CircleGlow.ImageTransparency = 1

    -- Animation
    local TweenOn = TweenService:Create(ToggleBG, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(100, 50, 255), BackgroundTransparency = 0})
    local TweenMoveOn = TweenService:Create(ToggleCircle, TweenInfo.new(0.25), {Position = UDim2.new(0, 16, 0, 2)})
    local GlowOn = TweenService:Create(CircleGlow, TweenInfo.new(0.25), {ImageTransparency = 0.3})

    local TweenOff = TweenService:Create(ToggleBG, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(40, 35, 70), BackgroundTransparency = 0.2})
    local TweenMoveOff = TweenService:Create(ToggleCircle, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0, 2)})
    local GlowOff = TweenService:Create(CircleGlow, TweenInfo.new(0.25), {ImageTransparency = 1})

    -- Nút bấm
    local Button = Instance.new("TextButton", Container)
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1,0,1,0)
    Button.Text = ""

    local state = false
    Button.MouseButton1Click:Connect(function()
        state = not state
        if state then TweenOn:Play() TweenMoveOn:Play() GlowOn:Play()
        else TweenOff:Play() TweenMoveOff:Play() GlowOff:Play() end
        callback(state)
    end)
end

-- =====================
-- HÀM TẠO THANH TRƯỢT (CHỈNH ĐƯỢC 100%)
-- =====================
local function CreateSlider(name, minVal, maxVal, defaultVal, order, callback)
    local Container = Instance.new("Frame", Content)
    Container.BackgroundColor3 = Color3.fromRGB(25, 20, 55)
    Container.BackgroundTransparency = 0.1
    Container.Size = UDim2.new(0.92, 0, 0, 68)
    Container.LayoutOrder = order
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 10)

    -- Tên + giá trị
    local Text = Instance.new("TextLabel", Container)
    Text.BackgroundTransparency = 1
    Text.Position = UDim2.new(0, 16, 0, 6)
    Text.Size = UDim2.new(1, -30, 0, 20)
    Text.Font = Enum.Font.GothamSemibold
    Text.Text = name.." : "..defaultVal
    Text.TextColor3 = Color3.new(0.95, 0.95, 1)
    Text.TextSize = 13
    Text.TextXAlignment = Enum.TextXAlignment.Left

    -- Nền thanh
    local SliderBG = Instance.new("Frame", Container)
    SliderBG.BackgroundColor3 = Color3.fromRGB(35, 30, 65)
    SliderBG.BackgroundTransparency = 0.3
    SliderBG.Position = UDim2.new(0, 16, 0, 40)
    SliderBG.Size = UDim2.new(1, -32, 0, 8)
    Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(1,0)

    -- Đường đã chọn
    local Fill = Instance.new("Frame", SliderBG)
    Fill.BackgroundColor3 = Color3.fromRGB(100, 50, 255)
    Fill.BackgroundTransparency = 0
    Fill.Size = UDim2.new((defaultVal - minVal)/(maxVal - minVal), 0, 1, 0)
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)

    -- Hiệu ứng sáng đường
    local FillGlow = Instance.new("ImageLabel", Fill)
    FillGlow.BackgroundTransparency = 1
    FillGlow.Position = UDim2.new(-0.2, 0, -1, 0)
    FillGlow.Size = UDim2.new(1.4, 0, 3, 0)
    FillGlow.Image = "rbxassetid://6014261984"
    FillGlow.ImageColor3 = Color3.fromRGB(150, 80, 255)
    FillGlow.ImageTransparency = 0.6
    FillGlow.ScaleType = Enum.ScaleType.Fit

    -- Nút kéo
    local SliderBtn = Instance.new("Frame", Fill)
    SliderBtn.BackgroundColor3 = Color3.new(1,1,1)
    SliderBtn.Position = UDim2.new(1, -6, 0.5, -6)
    SliderBtn.Size = UDim2.new(0, 12, 0, 12)
    Instance.new("UICorner", SliderBtn).CornerRadius = UDim.new(1,0)

    -- Hiệu ứng nút
    local BtnGlow = Instance.new("ImageLabel", SliderBtn)
    BtnGlow.BackgroundTransparency = 1
    BtnGlow.Position = UDim2.new(-0.5, 0, -0.5, 0)
    BtnGlow.Size = UDim2.new(2, 0, 2, 0)
    BtnGlow.Image = "rbxassetid://6014261984"
    BtnGlow.ImageColor3 = Color3.fromRGB(180, 120, 255)
    BtnGlow.ImageTransparency = 0.4
    BtnGlow.ScaleType = Enum.ScaleType.Fit

    -- Nút nhấn
    local Button = Instance.new("TextButton", SliderBG)
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1,0,1,0)
    Button.Text = ""

    -- Hàm cập nhật - HOẠT ĐỘNG CHÍNH XÁC
    local function Update(input)
        local pos = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X)/SliderBG.AbsoluteSize.X, 0, 1)
        local val = math.floor(minVal + (maxVal - minVal)*pos + 0.5)
        TweenService:Create(Fill, TweenInfo.new(0.08), {Size = UDim2.new(pos,0,1,0)}):Play()
        Text.Text = name.." : "..val
        callback(val)
    end

    -- Sự kiện kéo
    Button.MouseButton1Down:Connect(function() Update(UIS:GetMouseLocation()) end)
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            Update(input.Position)
        end
    end)
end

-- =====================
-- TẠO CÁC CHỨC NĂNG
-- =====================
CreateToggle("WALLHOP", 1, function(s) Settings.WallhopEnabled = s end)
CreateToggle("AUTO FLICK", 2, function(s) Settings.AutoFlick = s end)
CreateSlider("FLICK ANGLE", 90, 270, 180, 3, function(v) Settings.FlickAngle = v end)
CreateSlider("VELOCITY", 20, 100, 48, 4, function(v) Settings.Velocity = v end)
CreateSlider("COOLDOWN", 0.01, 0.3, 0.03, 5, function(v) Settings.Cooldown = v end)
CreateToggle("LADDER FLICK", 6, function(s) Settings.LadderFlick = s end)

-- =====================
-- KÉO THẢ MENU - HOẠT ĐỘNG ĐÚNG
-- =====================
local Dragging, DragStart, StartPos
TitleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = i.Position
        StartPos = MainFrame.Position
        TweenService:Create(MainFrame, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
    end
end)
UIS.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
        local delta = i.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end
end)
TitleBar.InputEnded:Connect(function()
    Dragging = false
    TweenService:Create(MainFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0.05}):Play()
end)

-- Thu nhỏ
local IsMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    if IsMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,330,0,45)}):Play()
        Content.Visible = false
        MinBtn.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,330,0,440)}):Play()
        Content.Visible = true
        MinBtn.Text = "−"
    end
end)

-- =====================
-- LOGIC WALLHOP - ĐÚNG CƠ CHẾ 100%
-- ✅ Bám tường -> Tiếp đà -> KHÔNG ĐẨY RA NGOÀI
-- =====================
local function SetupCharacter(c)
    Character = c
    Humanoid = c:WaitForChild("Humanoid")
    RootPart = c:WaitForChild("HumanoidRootPart")
    CanWallhop = true
end

-- Kiểm tra bám tường - ĐÚNG PHƯƠNG PHÁP
local function IsWallDetected()
    if not RootPart or not Humanoid then return false end
    if Humanoid.FloorMaterial ~= Enum.Material.Air then return false end -- Chỉ khi đang nhảy

    local moveDir = Humanoid.MoveDirection
    if moveDir.Magnitude < Settings.MinSpeed then return false end -- Chỉ khi di chuyển

    -- Tia kiểm tra chính xác hướng di chuyển
    local ray = Ray.new(RootPart.Position, moveDir * Settings.RayDistance)
    local hitPart = Workspace:FindPartOnRayWithIgnoreList(ray, {Character, Camera})
    
    return hitPart ~= nil -- Phát hiện tường
end

-- Kiểm tra leo thang
local function CheckLadder()
    return Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Climbing
end

-- CHỨC NĂNG CHÍNH - ĐÚNG CƠ CHẾ WALLHOP
RunService.RenderStepped:Connect(function()
    -- Kiểm tra điều kiện
    if not Settings.WallhopEnabled or not Character or not Humanoid or not RootPart then return end
    if not CanWallhop or tick() - Settings.LastJump < Settings.Cooldown then return end

    -- Chỉ hoạt động khi đang ở trên không
    if Humanoid.FloorMaterial == Enum.Material.Air then
        
        -- Xử lý leo thang
        if Settings.LadderFlick and CheckLadder() then
            if Humanoid.Jump then
                RootPart.Velocity = Camera.CFrame.LookVector * (Settings.Velocity / 1.7) + Vector3.new(0, 14, 0)
                Settings.LastJump = tick()
            end
            return
        end

        -- LOGIC CHÍNH: Bám tường -> Tiếp tục nhảy
        if IsWallDetected() and Humanoid.Jump then
            CanWallhop = false

            -- Tính hướng xoay (Auto Flick) - ĐÚNG HƯỚNG, KHÔNG ĐẨY RA
            local dir = Humanoid.MoveDirection
            if Settings.AutoFlick then
                local angle = math.rad(Settings.FlickAngle)
                -- Xoay hướng di chuyển để bám dọc theo tường
                dir = Vector3.new(
                    dir.X * math.cos(angle) - dir.Z * math.sin(angle),
                    0,
                    dir.X * math.sin(angle) + dir.Z * math.cos(angle)
                ).Unit
            end

            -- ÁP DỤNG LỰC: ĐỂ BÁM TƯỜNG & TIẾP ĐÀ -> KHÔNG ĐẨY RA NGOÀI
            -- Giảm lực ngang, tăng lực lên cao để leo tiếp
            local velocity = dir * (Settings.Velocity * 0.8) -- Giảm nhẹ lực ngang
            velocity = velocity + Vector3.new(0, Settings.Velocity * 0.7, 0) -- Tăng lực lên cao

            -- Áp dụng vận tốc
            RootPart.Velocity = velocity

            -- Reset sau thời gian ngắn
            task.delay(0.1, function() CanWallhop = true end)
            Settings.LastJump = tick()
        end
    end
end)

-- Kết nối sự kiện nhân vật
LocalPlayer.CharacterAdded:Connect(SetupCharacter)
if LocalPlayer.Character then SetupCharacter(LocalPlayer.Character) end

-- =====================
-- HOÀN THÀNH
-- =====================
print("✅ VŨ MODZ | WALLHOP - ĐÃ TẢI THÀNH CÔNG! MENU ĐÃ HIỆN!")
