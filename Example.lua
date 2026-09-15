local DragonFruitLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Merayliewz/DRAGON-FRUIT-LIB/refs/heads/main/dragonfruit%20lib.lua"))() -- Hoặc require nếu trong game

-- Tạo Cửa Sổ UI với Theme tùy chọn ("DragonFruit", "Dark", "Ocean", "Emerald", "Midnight", "Cyberpunk", "Blood")
local Window = DragonFruitLib:CreateWindow({
	Title = "Dragon Fruit Hub v2",
	Logo = "rbxassetid://90272501948122",
	Theme = "DragonFruit"
})

-- TAB CHÍNH
local MainTab = Window:CreateTab("Trang Chủ", "🏠")
local SettingsTab = Window:CreateTab("Cài Đặt", "⚙️")
MainTab:AddLabel("Chào mừng bạn đến với Dragon Fruit Hub!")

MainTab:AddButton({
	Text = "Bật Auto Farm",
	Callback = function()
		Window:Notify("Thông Báo", "Đã bật tính năng Auto Farm!", 3)
	end
})

MainTab:AddToggle({
	Text = "Gom Mái Nhà (Auto Teleport)",
	Default = true,
	Callback = function(Value)
		print("Trạng thái Toggle:", Value)
	end
})

MainTab:AddSlider({
	Text = "Tốc Độ Di Chuyển",
	Min = 16,
	Max = 200,
	Default = 50,
	Callback = function(Value)
		print("Tốc độ mới:", Value)
	end
})

-- TAB CÀI ĐẶT THEMES (CẤU HÌNH GIAO DIỆN)
SettingsTab:AddLabel("Tùy Chọn Giao Diện (Themes)")

-- Tự động lấy danh sách Theme từ Library để tạo Dropdown
local themeList = Window:GetThemes()

SettingsTab:AddDropdown({
	Text = "Đổi Theme",
	Items = themeList,
	Default = "DragonFruit",
	Callback = function(selectedTheme)
		Window:SetTheme(selectedTheme)
		Window:Notify("Giao Diện", "Đã chuyển sang Theme: " .. selectedTheme, 3)
	end
})

SettingsTab:AddTextBox({
	Text = "Mã Ghép",
	Placeholder = "Nhập Key vào đây...",
	Callback = function(Text, EnterPressed)
		if EnterPressed then
			print("Đã ấn Enter gửi text:", Text)
		end
	end
})
