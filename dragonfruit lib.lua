local DragonFruitLib = {}
DragonFruitLib.__index = DragonFruitLib

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Colors = {
	Background = Color3.fromRGB(15, 15, 20),
	Window = Color3.fromRGB(22, 22, 28),
	Border = Color3.fromRGB(45, 45, 55),
	TextMain = Color3.fromRGB(255, 255, 255),
	TextSub = Color3.fromRGB(150, 150, 160),
	Accent = Color3.fromRGB(150, 80, 250),
	AccentHover = Color3.fromRGB(170, 100, 255),
	SidebarUnselected = Color3.fromRGB(35, 35, 45),
	SidebarHover = Color3.fromRGB(50, 50, 65),
	Dots = {Color3.fromRGB(255, 90, 90), Color3.fromRGB(255, 180, 50), Color3.fromRGB(50, 200, 100)}
}

local function AddUICorner(parent, radius)
	local corner = Instance.new("UICorner", parent)
	corner.CornerRadius = UDim.new(0, radius)
	return corner
end

local function AddUIStroke(parent, color)
	local stroke = Instance.new("UIStroke", parent)
	stroke.Color = color
	stroke.Thickness = 1
	return stroke
end

function DragonFruitLib:CreateWindow(config)
	local WindowObj = setmetatable({}, DragonFruitLib)
	WindowObj.TitleText = config.Title or "Dragon Fruit Hub"
	WindowObj.LogoId = config.Logo or "rbxassetid://90272501948122"
	WindowObj.Tabs = {}

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = game:GetService("HttpService"):GenerateGUID(false)
	ScreenGui.ResetOnSpawn = false

	if gethui then
		ScreenGui.Parent = gethui()
	elseif syn and syn.protect_gui then
		syn.protect_gui(ScreenGui)
		ScreenGui.Parent = game:GetService("CoreGui")
	else
		local success, _ = pcall(function()
				ScreenGui.Parent = game:GetService("CoreGui")
		end)
		if not success then
			local targetGui = (typeof(PlayerGui) ~= "nil" and PlayerGui) or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
			ScreenGui.Parent = targetGui
		end	
	end
		
	WindowObj.ScreenGui = ScreenGui

	-- Nút bật/tắt UI (Có kéo thả + animation)
	local ToggleBtn = Instance.new("ImageButton", ScreenGui)
	ToggleBtn.Name = "OpenCloseToggle"
	ToggleBtn.Size = UDim2.new(0, 46, 0, 46)
	ToggleBtn.Position = UDim2.new(0, 25, 0, 100)
	ToggleBtn.BackgroundColor3 = Colors.Window
	ToggleBtn.Image = WindowObj.LogoId
	ToggleBtn.Active = true
	ToggleBtn.Draggable = true
	AddUICorner(ToggleBtn, 23)
	AddUIStroke(ToggleBtn, Colors.Accent)

	-- Khung chính UI
	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 620, 0, 380)
	MainFrame.Position = UDim2.new(0.5, -310, 0.5, -190)
	MainFrame.BackgroundColor3 = Colors.Window
	MainFrame.Active = true
	MainFrame.Draggable = true
	MainFrame.ClipsDescendants = true
	AddUICorner(MainFrame, 10)
	AddUIStroke(MainFrame, Colors.Border)
	WindowObj.MainFrame = MainFrame

	-- Animation Mở / Đóng Cửa Sổ từ nút tròn nổi
	local isOpen = true
	ToggleBtn.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		if isOpen then
			MainFrame.Visible = true
			TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 620, 0, 380),
				Position = UDim2.new(0.5, -310, 0.5, -190)
			}):Play()
		else
			local tween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				Size = UDim2.new(0, 0, 0, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0)
			})
			tween:Play()
			tween.Completed:Connect(function()
				if not isOpen then MainFrame.Visible = false end
			end)
		end
	end)

	-- Header
	local Header = Instance.new("Frame", MainFrame)
	Header.Size = UDim2.new(1, 0, 0, 40)
	Header.BackgroundTransparency = 1

	local dotButtons = {}
	for i, color in ipairs(Colors.Dots) do
		local dot = Instance.new("TextButton", Header)
		dot.Size = UDim2.new(0, 10, 0, 10)
		dot.Position = UDim2.new(0, 15 + (i - 1) * 18, 0, 15)
		dot.BackgroundColor3 = color
		dot.Text = ""
		dot.AutoButtonColor = false
		AddUICorner(dot, 5)
		table.insert(dotButtons, dot)
	end

	local RedButton = dotButtons[1]   -- Nút đỏ
	local YellowButton = dotButtons[2] -- Nút vàng

	-- 1. Nút Đỏ: Hủy / Xóa sạch hoàn toàn UI khỏi game[span_1](start_span)[span_1](end_span)
	RedButton.MouseButton1Click:Connect(function()
		if ScreenGui then
			ScreenGui:Destroy()
		end
	end)

	-- 2. Nút Vàng: Thu nhỏ / Ẩn hiện khung giao diện chính[span_2](start_span)[span_2](end_span)
	local isMinimized = false
	YellowButton.MouseButton1Click:Connect(function()
		isMinimized = not isMinimized
		MainFrame.Visible = not isMinimized
	end)

	local TitleLabel = Instance.new("TextLabel", Header)
	TitleLabel.Size = UDim2.new(1, -100, 1, 0)
	TitleLabel.Position = UDim2.new(0, 80, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = WindowObj.TitleText
	TitleLabel.TextColor3 = Colors.TextSub
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 13
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
	WindowObj.TitleLabel = TitleLabel

	local HeaderLine = Instance.new("Frame", Header)
	HeaderLine.Size = UDim2.new(1, 0, 0, 1)
	HeaderLine.Position = UDim2.new(0, 0, 1, 0)
	HeaderLine.BackgroundColor3 = Colors.Border

	-- Sidebar
	local Sidebar = Instance.new("Frame", MainFrame)
	Sidebar.Size = UDim2.new(0, 140, 1, -41)
	Sidebar.Position = UDim2.new(0, 0, 0, 41)
	Sidebar.BackgroundTransparency = 1

	local SidebarLine = Instance.new("Frame", Sidebar)
	SidebarLine.Size = UDim2.new(0, 1, 1, 0)
	SidebarLine.Position = UDim2.new(1, 0, 0, 0)
	SidebarLine.BackgroundColor3 = Colors.Border

	local SidebarLogo = Instance.new("ImageLabel", Sidebar)
	SidebarLogo.Size = UDim2.new(0, 48, 0, 48)
	SidebarLogo.Position = UDim2.new(0.5, -24, 0, 10)
	SidebarLogo.BackgroundTransparency = 1
	SidebarLogo.Image = WindowObj.LogoId

	local TabListContainer = Instance.new("Frame", Sidebar)
	TabListContainer.Size = UDim2.new(1, -16, 1, -75)
	TabListContainer.Position = UDim2.new(0, 8, 0, 68)
	TabListContainer.BackgroundTransparency = 1

	local UIList = Instance.new("UIListLayout", TabListContainer)
	UIList.SortOrder = Enum.SortOrder.LayoutOrder
	UIList.Padding = UDim.new(0, 6)

	local ContentArea = Instance.new("Frame", MainFrame)
	ContentArea.Size = UDim2.new(1, -141, 1, -41)
	ContentArea.Position = UDim2.new(0, 141, 0, 41)
	ContentArea.BackgroundTransparency = 1
	WindowObj.ContentArea = ContentArea
	WindowObj.TabListContainer = TabListContainer

	return WindowObj
end

function DragonFruitLib:CreateTab(tabName)
	local TabObj = {}
	local window = self

	local page = Instance.new("ScrollingFrame", window.ContentArea)
	page.Size = UDim2.new(1, -20, 1, -20)
	page.Position = UDim2.new(0, 10, 0, 10)
	page.BackgroundTransparency = 1
	page.ScrollBarThickness = 2
	page.Visible = false

	local PageList = Instance.new("UIListLayout", page)
	PageList.SortOrder = Enum.SortOrder.LayoutOrder
	PageList.Padding = UDim.new(0, 8)

	local tabBtn = Instance.new("TextButton", window.TabListContainer)
	tabBtn.Size = UDim2.new(1, 0, 0, 36)
	tabBtn.BackgroundColor3 = Colors.SidebarUnselected
	tabBtn.Text = tabName
	tabBtn.TextColor3 = Colors.TextSub
	tabBtn.Font = Enum.Font.GothamMedium
	tabBtn.TextSize = 13
	tabBtn.AutoButtonColor = false
	AddUICorner(tabBtn, 8)

	local function ActivateTab()
		for _, t in ipairs(window.Tabs) do
			t.Page.Visible = false
			TweenService:Create(t.Button, TweenInfo.new(0.2), {
				BackgroundColor3 = Colors.SidebarUnselected,
				TextColor3 = Colors.TextSub
			}):Play()
		end

		page.Position = UDim2.new(0, 20, 0, 10)
		page.Visible = true
		window.TitleLabel.Text = window.TitleText .. " - " .. tabName

		TweenService:Create(page, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Position = UDim2.new(0, 10, 0, 10)
		}):Play()

		TweenService:Create(tabBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = Colors.Accent,
			TextColor3 = Colors.TextMain
		}):Play()
	end

	tabBtn.MouseEnter:Connect(function()
		if not page.Visible then
			TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.SidebarHover}):Play()
		end
	end)

	tabBtn.MouseLeave:Connect(function()
		if not page.Visible then
			TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.SidebarUnselected}):Play()
		end
	end)

	tabBtn.MouseButton1Click:Connect(ActivateTab)

	TabObj.Page = page
	TabObj.Button = tabBtn
	table.insert(window.Tabs, TabObj)

	if #window.Tabs == 1 then ActivateTab() end

	function TabObj:AddLabel(text)
		local label = Instance.new("TextLabel", page)
		label.Size = UDim2.new(1, 0, 0, 22)
		label.BackgroundTransparency = 1
		label.Text = text
		label.TextColor3 = Colors.TextSub
		label.Font = Enum.Font.Gotham
		label.TextSize = 12
		label.TextXAlignment = Enum.TextXAlignment.Left
	end

	function TabObj:AddButton(options)
		local btnText = options.Text or "Button"
		local callback = options.Callback or function() end

		local btn = Instance.new("TextButton", page)
		btn.Size = UDim2.new(1, -5, 0, 38)
		btn.BackgroundColor3 = Colors.Accent
		btn.Text = btnText
		btn.TextColor3 = Colors.TextMain
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 13
		btn.AutoButtonColor = false
		AddUICorner(btn, 6)

		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.AccentHover}):Play()
		end)
		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Accent}):Play()
		end)
		btn.MouseButton1Down:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -9, 0, 35)}):Play()
		end)
		btn.MouseButton1Up:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -5, 0, 38)}):Play()
		end)

		btn.MouseButton1Click:Connect(callback)
	end

	function TabObj:AddToggle(options)
		local toggleText = options.Text or "Toggle"
		local defaultState = options.Default or false
		local callback = options.Callback or function() end

		local frame = Instance.new("Frame", page)
		frame.Size = UDim2.new(1, -5, 0, 38)
		frame.BackgroundColor3 = Colors.Background
		AddUICorner(frame, 6)
		AddUIStroke(frame, Colors.Border)

		local label = Instance.new("TextLabel", frame)
		label.Size = UDim2.new(1, -65, 1, 0)
		label.Position = UDim2.new(0, 12, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = toggleText
		label.TextColor3 = Colors.TextMain
		label.Font = Enum.Font.GothamMedium
		label.TextSize = 13
		label.TextXAlignment = Enum.TextXAlignment.Left

		local btn = Instance.new("TextButton", frame)
		btn.Size = UDim2.new(0, 44, 0, 22)
		btn.Position = UDim2.new(1, -52, 0.5, -11)
		btn.BackgroundColor3 = defaultState and Colors.Accent or Colors.SidebarUnselected
		btn.Text = ""
		btn.AutoButtonColor = false
		AddUICorner(btn, 11)

		local dot = Instance.new("Frame", btn)
		dot.Size = UDim2.new(0, 16, 0, 16)
		dot.Position = UDim2.new(0, defaultState and 24 or 4, 0, 3)
		dot.BackgroundColor3 = Colors.TextMain
		AddUICorner(dot, 8)

		local state = defaultState
		btn.MouseButton1Click:Connect(function()
			state = not state
			TweenService:Create(btn, TweenInfo.new(0.2), {
				BackgroundColor3 = state and Colors.Accent or Colors.SidebarUnselected
			}):Play()
			TweenService:Create(dot, TweenInfo.new(0.2), {
				Position = UDim2.new(0, state and 24 or 4, 0, 3)
			}):Play()
			callback(state)
		end)
	end

	function TabObj:AddSlider(options)
		local sliderText = options.Text or "Slider"
		local min = options.Min or 0
		local max = options.Max or 100
		local default = options.Default or min
		local callback = options.Callback or function() end

		local frame = Instance.new("Frame", page)
		frame.Size = UDim2.new(1, -5, 0, 48)
		frame.BackgroundColor3 = Colors.Background
		AddUICorner(frame, 6)
		AddUIStroke(frame, Colors.Border)

		local label = Instance.new("TextLabel", frame)
		label.Size = UDim2.new(1, -60, 0, 22)
		label.Position = UDim2.new(0, 12, 0, 2)
		label.BackgroundTransparency = 1
		label.Text = sliderText
		label.TextColor3 = Colors.TextMain
		label.Font = Enum.Font.GothamMedium
		label.TextSize = 13
		label.TextXAlignment = Enum.TextXAlignment.Left

		local valLabel = Instance.new("TextLabel", frame)
		valLabel.Size = UDim2.new(0, 50, 0, 22)
		valLabel.Position = UDim2.new(1, -60, 0, 2)
		valLabel.BackgroundTransparency = 1
		valLabel.Text = tostring(default)
		valLabel.TextColor3 = Colors.Accent
		valLabel.Font = Enum.Font.GothamBold
		valLabel.TextSize = 13

		local sliderBar = Instance.new("Frame", frame)
		sliderBar.Size = UDim2.new(1, -24, 0, 6)
		sliderBar.Position = UDim2.new(0, 12, 0, 32)
		sliderBar.BackgroundColor3 = Colors.SidebarUnselected
		AddUICorner(sliderBar, 3)

		local sliderFill = Instance.new("Frame", sliderBar)
		sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		sliderFill.BackgroundColor3 = Colors.Accent
		AddUICorner(sliderFill, 3)

		local dragging = false
		local function UpdateSlider(input)
			local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
			local value = math.floor(min + (max - min) * pos)
			valLabel.Text = tostring(value)
			TweenService:Create(sliderFill, TweenInfo.new(0.05), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
			callback(value)
		end

		sliderBar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				UpdateSlider(input)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				UpdateSlider(input)
			end
		end)
	end

	-- 3. ĐÃ SỬA: DROPDOWN (Hiển thị mượt mà, không bị cắt nội dung)
	function TabObj:AddDropdown(options)
		local dropText = options.Text or "Dropdown"
		local items = options.Items or {}
		local defaultItem = options.Default or items[1] or ""
		local callback = options.Callback or function() end

		local isDropped = false
		local headerHeight = 38
		local itemHeight = 32
		local maxVisibleItems = 4
		local currentChoice = defaultItem

		local visibleCount = math.clamp(#items, 1, maxVisibleItems)
		local openedHeight = headerHeight + (visibleCount * itemHeight) + 12

		local frame = Instance.new("Frame", page)
		frame.Name = "Dropdown"
		frame.Size = UDim2.new(1, -5, 0, headerHeight)
		frame.BackgroundColor3 = Colors.Background
		frame.ZIndex = 5
		AddUICorner(frame, 6)
		AddUIStroke(frame, Colors.Border)

		local label = Instance.new("TextLabel", frame)
		label.Size = UDim2.new(1, -40, 0, headerHeight)
		label.Position = UDim2.new(0, 12, 0, 0)
		label.BackgroundTransparency = 1
		label.ZIndex = 6
		label.Text = dropText .. ": " .. tostring(currentChoice)
		label.TextColor3 = Colors.TextMain
		label.Font = Enum.Font.GothamMedium
		label.TextSize = 13
		label.TextXAlignment = Enum.TextXAlignment.Left

		local arrow = Instance.new("TextLabel", frame)
		arrow.Size = UDim2.new(0, 30, 0, headerHeight)
		arrow.Position = UDim2.new(1, -35, 0, 0)
		arrow.BackgroundTransparency = 1
		arrow.ZIndex = 6
		arrow.Text = "▼"
		arrow.TextColor3 = Colors.TextSub
		arrow.Font = Enum.Font.GothamBold
		arrow.TextSize = 11

		local listContainer = Instance.new("ScrollingFrame", frame)
		listContainer.Size = UDim2.new(1, -10, 0, 0)
		listContainer.Position = UDim2.new(0, 5, 0, headerHeight + 2)
		listContainer.BackgroundTransparency = 1
		listContainer.BorderSizePixel = 0
		listContainer.ZIndex = 10
		listContainer.CanvasSize = UDim2.new(0, 0, 0, #items * itemHeight)
		listContainer.ScrollBarThickness = 2
		listContainer.ClipsDescendants = true

		local listLayout = Instance.new("UIListLayout", listContainer)
		listLayout.SortOrder = Enum.SortOrder.LayoutOrder
		listLayout.Padding = UDim.new(0, 2)

		for _, item in ipairs(items) do
			local itemBtn = Instance.new("TextButton", listContainer)
			itemBtn.Size = UDim2.new(1, 0, 0, itemHeight)
			itemBtn.BackgroundColor3 = Colors.SidebarUnselected
			itemBtn.ZIndex = 11
			itemBtn.Text = tostring(item)
			itemBtn.TextColor3 = Colors.TextSub
			itemBtn.Font = Enum.Font.Gotham
			itemBtn.TextSize = 12
			itemBtn.AutoButtonColor = false
			AddUICorner(itemBtn, 4)

			itemBtn.MouseButton1Click:Connect(function()
				currentChoice = item
				label.Text = dropText .. ": " .. tostring(currentChoice)
				isDropped = false
				
				TweenService:Create(frame, TweenInfo.new(0.2), {Size = UDim2.new(1, -5, 0, headerHeight)}):Play()
				TweenService:Create(listContainer, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, 0)}):Play()
				TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
				callback(currentChoice)
			end)
		end

		local triggerBtn = Instance.new("TextButton", frame)
		triggerBtn.Size = UDim2.new(1, 0, 0, headerHeight)
		triggerBtn.BackgroundTransparency = 1
		triggerBtn.ZIndex = 7
		triggerBtn.Text = ""

		triggerBtn.MouseButton1Click:Connect(function()
			isDropped = not isDropped

			TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, -5, 0, isDropped and openedHeight or headerHeight)
			}):Play()
			
			TweenService:Create(listContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, -10, 0, isDropped and (visibleCount * itemHeight) or 0)
			}):Play()

			TweenService:Create(arrow, TweenInfo.new(0.25), {
				Rotation = isDropped and 180 or 0
			}):Play()
		end)
	end

	-- 4. TÍNH NĂNG MỚI: TEXTBOX (Ô nhập văn bản tự do)
	function TabObj:AddTextBox(options)
		local boxText = options.Text or "TextBox"
		local placeholder = options.Placeholder or "Nhập ở đây..."
		local defaultVal = options.Default or ""
		local callback = options.Callback or function() end

		local frame = Instance.new("Frame", page)
		frame.Size = UDim2.new(1, -5, 0, 48)
		frame.BackgroundColor3 = Colors.Background
		AddUICorner(frame, 6)
		AddUIStroke(frame, Colors.Border)

		local label = Instance.new("TextLabel", frame)
		label.Size = UDim2.new(1, -24, 0, 18)
		label.Position = UDim2.new(0, 12, 0, 4)
		label.BackgroundTransparency = 1
		label.Text = boxText
		label.TextColor3 = Colors.TextSub
		label.Font = Enum.Font.GothamMedium
		label.TextSize = 12
		label.TextXAlignment = Enum.TextXAlignment.Left

		local textBox = Instance.new("TextBox", frame)
		textBox.Size = UDim2.new(1, -24, 0, 20)
		textBox.Position = UDim2.new(0, 12, 0, 24)
		textBox.BackgroundColor3 = Colors.SidebarUnselected
		textBox.Text = defaultVal
		textBox.PlaceholderText = placeholder
		textBox.TextColor3 = Colors.TextMain
		textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
		textBox.Font = Enum.Font.Gotham
		textBox.TextSize = 12
		textBox.ClearTextOnFocus = false
		AddUICorner(textBox, 4)

		textBox.FocusLost:Connect(function(enterPressed)
			callback(textBox.Text, enterPressed)
		end)
	end

	return TabObj
end

return DragonFruitLib
