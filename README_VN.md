# DragonFruit UI Library

Thư viện giao diện (UI Library) hiện đại, mượt mà và nhẹ dành cho lập trình viên Roblox Script lấy cảm hứng từ quả thanh long. Tích hợp sẵn animation chuyển động, theme tối giản, khả năng kéo thả và thanh điều hướng bên hông.

---

## 🌐 Ngôn Ngữ
* [English (Tiếng Anh)](README.md)
* Tiếng Việt (Hiện tại)

---

## 🚀 Khởi Chạy Nhanh

Tải **DragonFruitLib** vào script của bạn thông qua `loadstring`:

```lua
local DragonFruitLib = loadstring(game:HttpGet((https://raw.githubusercontent.com/Merayliewz/DRAGON-FRUIT-LIB/refs/heads/main/dragonfruit%20lib.lua"))()
```

---

## 📜 Code Mẫu Đầy Đủ

Đoạn code bên dưới chứa đầy đủ tất cả thành phần UI mà không bỏ sót bất kỳ nút nào:

```lua
-- Tải thư viện
local DragonFruitLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Merayliewz/DRAGON-FRUIT-LIB/refs/heads/main/dragonfruit%20lib.lua"))()

-- 1. Khởi tạo Cửa sổ
local Window = DragonFruitLib:CreateWindow({
    Title = "Dragon Fruit Hub",
    Logo = "rbxassetid://90272501948122" -- ID Asset Logo trái thanh long
})

-- 2. Tạo các Tab
local MainTab = Window:CreateTab("Trang Chủ")
local SettingsTab = Window:CreateTab("Cài Đặt")

-- 3. Mẫu Nhãn Chữ (Label)
MainTab:AddLabel("Chào mừng bạn đến với Dragon Fruit Hub!")

-- 4. Mẫu Nút Bấm (Button)
MainTab:AddButton({
    Text = "Nút Bấm Thử Nghiệm",
    Callback = function()
        print("Đã bấm nút!")
    end
})

-- 5. Mẫu Công Tắc Bật/Tắt (Toggle)
MainTab:AddToggle({
    Text = "Tự Động Đánh (Auto Farm)",
    Default = false,
    Callback = function(State)
        print("Trạng thái Auto Farm:", State)
    end
})

-- 6. Mẫu Thanh Trượt Giá Trị (Slider)
MainTab:AddSlider({
    Text = "Tốc Độ Di Chuyển",
    Min = 16,
    Max = 250,
    Default = 16,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})
```

---

## 📚 Chi Tiết Từng Thành Phần API

### Khởi Tạo Cửa Sổ (Window)
Tạo giao diện cửa sổ chính.
```lua
local Window = DragonFruitLib:CreateWindow({
    Title = "Tiêu Đề Cửa Sổ",
    Logo = "rbxassetid://90272501948122"
})
```

### Tạo Tab (Tab)
Tạo danh mục phân loại ở thanh bên.
```lua
local Tab = Window:CreateTab("Tên Tab")
```

### Nhãn Chữ (Label)
Hiển thị dòng chữ trong tab.
```lua
Tab:AddLabel("Nội dung văn bản")
```

### Nút Bấm (Button)
Tạo nút bấm thực thi hành động khi tương tác.
```lua
Tab:AddButton({
    Text = "Tên Nút Bấm",
    Callback = function()
        -- Code chạy khi bấm nút
    end
})
```

### Công Tắc (Toggle)
Tạo nút chuyển đổi trạng thái Bật/Tắt.
```lua
Tab:AddToggle({
    Text = "Tên Công Tắc",
    Default = false, -- true (bật) hoặc false (tắt)
    Callback = function(State)
        -- State trả về true hoặc false
    end
})
```

### Thanh Trượt (Slider)
Tạo thanh kéo điều chỉnh khoảng giá trị.
```lua
Tab:AddSlider({
    Text = "Tên Thanh Trượt",
    Min = 0,       -- Giá trị nhỏ nhất
    Max = 100,     -- Giá trị lớn nhất
    Default = 50,  -- Giá trị mặc định
    Callback = function(Value)
        -- Value trả về số nguyên trong khoảng Min-Max
    end
})
```
