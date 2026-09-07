local DragonFruitLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Merayliewz/DRAGON-FRUIT-LIB/refs/heads/main/dragonfruit%20lib.lua"))()

-- =================================================================
-- 2. KHỞI TẠO CỬA SỔ & THÊM MẤY NÚT CHỨC NĂNG BÊN DƯỚI
-- =================================================================
local Window = DragonFruitLib:CreateWindow({
	Title = "Dragon Fruit Hub",
	Logo = "rbxassetid://90272501948122" -- ID Logo trái chuối (Hiển thị bự ở giữa Sidebar)
})

-- Tạo các Tab
local MainTab = Window:CreateTab("Trang Chủ")
local FarmTab = Window:CreateTab("Auto Farm")
local SettingsTab = Window:CreateTab("Cài Đặt")

-- Thêm chức năng vào Tab Trang Chủ
MainTab:AddLabel("Chào mừng bạn đến với Dragon Fruit Hub!")
MainTab:AddButton({
	Text = "Kiểm tra Console",
	Callback = function()
		print("UI đã tải và hoạt động thành công!")
	end
})

-- Thêm chức năng vào Tab Auto Farm
FarmTab:AddToggle({
	Text = "Bật Auto Farm Quái",
	Default = false,
	Callback = function(Value)
		print("Trạng thái Auto Farm:", Value)
	end
})

FarmTab:AddToggle({
	Text = "Tự động nhặt đồ",
	Default = true,
	Callback = function(Value)
		print("Trạng thái Nhặt Đồ:", Value)
	end
})

FarmTab:AddSlider({
	Text = "Tốc độ gom quái",
	Min = 10,
	Max = 100,
	Default = 50,
	Callback = function(Value)
		print("Tốc độ gom quái:", Value)
	end
})

-- Thêm chức năng vào Tab Cài Đặt
SettingsTab:AddToggle({
	Text = "Gửi thông báo Webhook",
	Default = false,
	Callback = function(Value)
		print("Webhook:", Value)
	end
})
