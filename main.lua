-- ========================= KEY SYSTEM (blocking-until-valid, Worker-only) =========================
do
    local getgenv = getgenv
    local G = getgenv()

    if not G.fadecc_validated then
        local function copyToClipboard(s)
            local ok = pcall(function()
                local setcb = rawget(_G, "setclipboard") or setclipboard
                if typeof(setcb) == "function" then
                    setcb(tostring(s)); return
                end
                if writeclipboard then writeclipboard(tostring(s)) return end
                print("[fade.cc] Clipboard not available. URL: " .. tostring(s))
            end)
            if not ok then print("[fade.cc] Clipboard copy failed.") end
        end

        local parent = (gethui and gethui()) or (syn and syn.protect_gui and game.CoreGui) or game:FindService("CoreGui")

        local KeyGui = Instance.new("ScreenGui")
        KeyGui.Name, KeyGui.ResetOnSpawn, KeyGui.ZIndexBehavior = "FadeCC_Key", false, Enum.ZIndexBehavior.Sibling
        KeyGui.Parent = parent

        local Frame = Instance.new("Frame")
        Frame.Parent = KeyGui
        Frame.BackgroundColor3 = Color3.fromRGB(30,18,55)
        Frame.BorderColor3 = Color3.fromRGB(57,29,87)
        Frame.BorderSizePixel = 2
        Frame.Size = UDim2.fromOffset(420, 290)
        Frame.Position = UDim2.new(0.5, -210, 0.5, -145)
        Frame.Active, Frame.Draggable = true, true

        local Bar = Instance.new("Frame")
        Bar.Parent = Frame
        Bar.Size = UDim2.new(1,0,0,30)
        Bar.BackgroundColor3 = Color3.fromRGB(63,12,100)

        local Title = Instance.new("TextLabel")
        Title.Parent = Bar
        Title.BackgroundTransparency = 1
        Title.Size = UDim2.new(1, -10, 1, 0)
        Title.Position = UDim2.new(0, 6, 0, 0)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 16
        Title.Text = "fade.cc — Key System"
        Title.TextColor3 = Color3.new(1,1,1)
        Title.TextXAlignment = Enum.TextXAlignment.Left

        local Inner = Instance.new("Frame")
        Inner.Parent = Frame
        Inner.BackgroundTransparency = 1
        Inner.Size = UDim2.new(1,-20,1,-50)
        Inner.Position = UDim2.new(0,10,0,40)

        local Lbl = Instance.new("TextLabel")
        Lbl.Parent = Inner
        Lbl.BackgroundTransparency = 1
        Lbl.Size = UDim2.fromOffset(380,20)
        Lbl.Position = UDim2.new(0,0,0,0)
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.Font = Enum.Font.Gotham
        Lbl.TextSize = 14
        Lbl.TextColor3 = Color3.new(1,1,1)
        Lbl.Text = "Enter Key:"

        local Box = Instance.new("TextBox")
        Box.Parent = Inner
        Box.Size = UDim2.fromOffset(380, 32)
        Box.Position = UDim2.new(0,0,0,26)
        Box.BackgroundColor3 = Color3.fromRGB(40,25,70)
        Box.BorderColor3 = Color3.fromRGB(57,29,87)
        Box.Font = Enum.Font.Gotham
        Box.TextSize = 14
        Box.TextColor3 = Color3.new(1,1,1)
        Box.PlaceholderText = "FADE-CC-XXXX-XXXX-XXXX-XXXX"

        local Status = Instance.new("TextLabel")
        Status.Parent = Inner
        Status.BackgroundTransparency = 1
        Status.Size = UDim2.fromOffset(380, 38)
        Status.Position = UDim2.new(0,0,0,64)
        Status.TextWrapped = true
        Status.Font = Enum.Font.Gotham
        Status.TextSize = 14
        Status.TextColor3 = Color3.new(1,1,1)
        Status.Text = "Status: Waiting for key..."

        local Buttons = Instance.new("Frame")
        Buttons.Parent = Inner
        Buttons.BackgroundTransparency = 1
        Buttons.Size = UDim2.fromOffset(380, 36)
        Buttons.Position = UDim2.new(0,0,0,108)

        local GetKey = Instance.new("TextButton")
        GetKey.Parent = Buttons
        GetKey.Size = UDim2.new(0.48,0,1,0)
        GetKey.Text = "Get Key"
        GetKey.BackgroundColor3 = Color3.fromRGB(63,12,100)
        GetKey.TextColor3 = Color3.new(1,1,1)
        GetKey.Font = Enum.Font.Gotham
        GetKey.TextSize = 14

        local Enter = Instance.new("TextButton")
        Enter.Parent = Buttons
        Enter.Position = UDim2.new(0.52,0,0,0)
        Enter.Size = UDim2.new(0.48,0,1,0)
        Enter.Text = "Enter Key"
        Enter.BackgroundColor3 = Color3.fromRGB(63,12,100)
        Enter.TextColor3 = Color3.new(1,1,1)
        Enter.Font = Enum.Font.Gotham
        Enter.TextSize = 14

        local Hint = Instance.new("TextLabel")
        Hint.Parent = Inner
        Hint.BackgroundTransparency = 1
        Hint.Size = UDim2.fromOffset(380, 80)
        Hint.Position = UDim2.new(0,0,0,150)
        Hint.TextXAlignment = Enum.TextXAlignment.Left
        Hint.TextYAlignment = Enum.TextYAlignment.Top
        Hint.TextWrapped = true
        Hint.Font = Enum.Font.Gotham
        Hint.TextSize = 12
        Hint.TextColor3 = Color3.fromRGB(200,200,200)
        Hint.Text = "Instructions:\n1) Click 'Get Key' to copy the URL\n2) Complete the session on the site\n3) Paste the generated FADE-CC-... code above and press 'Enter Key'"

        -- Premium Keys (50 valid keys)
        local VALID_KEYS = {
            "FADE-CC-7UVE-XPRE-MIUM-0001",
            "FADE-CC-7UVE-XPRE-MIUM-0002",
            "FADE-CC-7UVE-XPRE-MIUM-0003",
            "FADE-CC-7UVE-XPRE-MIUM-0004",
            "FADE-CC-7UVE-XPRE-MIUM-0005",
            "FADE-CC-7UVE-XPRE-MIUM-0006",
            "FADE-CC-7UVE-XPRE-MIUM-0007",
            "FADE-CC-7UVE-XPRE-MIUM-0008",
            "FADE-CC-7UVE-XPRE-MIUM-0009",
            "FADE-CC-7UVE-XPRE-MIUM-0010",
            "FADE-CC-7UVE-XPRE-MIUM-0011",
            "FADE-CC-7UVE-XPRE-MIUM-0012",
            "FADE-CC-7UVE-XPRE-MIUM-0013",
            "FADE-CC-7UVE-XPRE-MIUM-0014",
            "FADE-CC-7UVE-XPRE-MIUM-0015",
            "FADE-CC-7UVE-XPRE-MIUM-0016",
            "FADE-CC-7UVE-XPRE-MIUM-0017",
            "FADE-CC-7UVE-XPRE-MIUM-0018",
            "FADE-CC-7UVE-XPRE-MIUM-0019",
            "FADE-CC-7UVE-XPRE-MIUM-0020",
            "FADE-CC-7UVE-XPRE-MIUM-0021",
            "FADE-CC-7UVE-XPRE-MIUM-0022",
            "FADE-CC-7UVE-XPRE-MIUM-0023",
            "FADE-CC-7UVE-XPRE-MIUM-0024",
            "FADE-CC-7UVE-XPRE-MIUM-0025",
            "FADE-CC-7UVE-XPRE-MIUM-0026",
            "FADE-CC-7UVE-XPRE-MIUM-0027",
            "FADE-CC-7UVE-XPRE-MIUM-0028",
            "FADE-CC-7UVE-XPRE-MIUM-0029",
            "FADE-CC-7UVE-XPRE-MIUM-0030",
            "FADE-CC-7UVE-XPRE-MIUM-0031",
            "FADE-CC-7UVE-XPRE-MIUM-0032",
            "FADE-CC-7UVE-XPRE-MIUM-0033",
            "FADE-CC-7UVE-XPRE-MIUM-0034",
            "FADE-CC-7UVE-XPRE-MIUM-0035",
            "FADE-CC-7UVE-XPRE-MIUM-0036",
            "FADE-CC-7UVE-XPRE-MIUM-0037",
            "FADE-CC-7UVE-XPRE-MIUM-0038",
            "FADE-CC-7UVE-XPRE-MIUM-0039",
            "FADE-CC-7UVE-XPRE-MIUM-0040",
            "FADE-CC-7UVE-XPRE-MIUM-0041",
            "FADE-CC-7UVE-XPRE-MIUM-0042",
            "FADE-CC-7UVE-XPRE-MIUM-0043",
            "FADE-CC-7UVE-XPRE-MIUM-0044",
            "FADE-CC-7UVE-XPRE-MIUM-0045",
            "FADE-CC-7UVE-XPRE-MIUM-0046",
            "FADE-CC-7UVE-XPRE-MIUM-0047",
            "FADE-CC-7UVE-XPRE-MIUM-0048",
            "FADE-CC-7UVE-XPRE-MIUM-0049",
            "FADE-CC-7UVE-XPRE-MIUM-0050"
        }

        local KEY_URL = "https://fadecc.mysellauth.com/product/premiumscript"
        local attempts, MAX = 0, 3

        -- VALIDATION: accept FADE-CC style codes
        local function valid(key)
            if type(key) ~= "string" then return false end
            
            -- Check if it's in the valid keys list
            for _, valid_key in ipairs(VALID_KEYS) do
                if key == valid_key then
                    return true
                end
            end
            
            return false
        end

        GetKey.MouseButton1Click:Connect(function()
            copyToClipboard(KEY_URL)
            Status.Text = "Key URL copied to clipboard."
        end)

        Enter.MouseButton1Click:Connect(function()
            local k = tostring(Box.Text or ""):upper():gsub("%s+", "")
            if not valid(k) then
                attempts += 1
                Status.Text = ("Invalid or expired key. Attempts: %d/%d"):format(attempts, MAX)
                if attempts >= MAX then
                    Status.Text = "Too many attempts. Rejoin to try again."
                    Enter.Active, GetKey.Active = false, false
                end
                return
            end
            -- success
            G.fadecc_validated = true
            Status.Text = "Key accepted! Loading fade.cc..."
            task.delay(0.05, function() if KeyGui and KeyGui.Parent then KeyGui:Destroy() end end)
        end)

        while not G.fadecc_validated do
            task.wait()
        end
        pcall(function() if KeyGui and KeyGui.Parent then KeyGui:Destroy() end end)
    end
end
-- ======================= END KEY SYSTEM (continue file) =======================

--[[
	fade.cc Premium Loader with Key System - Fixed Version
]]

--// Cache
local loadstring, getgenv, game, pcall, warn = loadstring, getgenv, game, pcall, warn
local HttpService = game:GetService("HttpService")

--// Loaded check
if getgenv().fadecc then
    return
end

--// Environment
getgenv().fadecc = true

--// HWID Generation (simple implementation)
local function GetHWID()
    local success, result = pcall(function()
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    
    if success and result then
        return result
    end
    
    -- Fallback HWID generation
    local stats = game:GetService("Stats")
    return tostring(stats.Network.ServerStatsItem["Data Ping"]:GetValue()) .. 
           tostring(stats.Network.ServerStatsItem["Data Send"]:GetValue()) ..
           tostring(os.time())
end

local HWID = GetHWID()

--// Data saving/loading functions
local function SaveKey(key)
    local data = {
        key = key,
        hwid = HWID,
        timestamp = os.time()
    }
    
    pcall(function()
        writefile("fadecc_premium.txt", HttpService:JSONEncode(data))
    end)
end

local function LoadKey()
    local success, data = pcall(function()
        if isfile("fadecc_premium.txt") then
            return HttpService:JSONDecode(readfile("fadecc_premium.txt"))
        end
    end)
    
    if success and data then
        return data
    end
    return nil
end

--// Check if user already has a valid key
local function CheckExistingKey()
    local savedData = LoadKey()
    if savedData and savedData.hwid == HWID then
        return true
    end
    return false
end

--// Main UI function
local function LoadMainUI()
    local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()

    --// Frame
    local MainFrame = Library:CreateWindow({
        Name = "fade.cc Premium",
        Themeable = {
            Info = "fade.cc Premium Loader",
            Credit = false
        },
        Background = "",
        Theme = [[{"__Designer.Colors.topGradient":"3F0C64","__Designer.Colors.section":"C259FB","__Designer.Colors.hoveredOptionBottom":"4819B4","__Designer.Background.ImageAssetID":"rbxassetid://4427304036","__Designer.Colors.selectedOption":"4E149C","__Designer.Colors.unselectedOption":"482271","__Designer.Files.WorkspaceFile":"fade.cc","__Designer.Colors.unhoveredOptionTop":"310269","__Designer.Colors.outerBorder":"391D57","__Designer.Background.ImageColor":"69009C","__Designer.Colors.tabText":"B9B9B9","__Designer.Colors.elementBorder":"160B24","__Designer.Background.ImageTransparency":100,"__Designer.Colors.background":"1E1237","__Designer.Colors.innerBorder":"531E79","__Designer.Colors.bottomGradient":"361A60","__Designer.Colors.sectionBackground":"21002C","__Designer.Colors.hoveredOptionTop":"6B10F9","__Designer.Colors.otherElementText":"7B44A8","__Designer.Colors.main":"AB26FF","__Designer.Colors.elementText":"9F7DB5","__Designer.Colors.unhoveredOptionBottom":"3E0088","__Designer.Background.UseBackgroundImage":false}]]
    })

    --// Tabs
    local MainTab = MainFrame:CreateTab({
        Name = "Premium Loaders"
    })

    --// Main Sections
    local PremiumSection = MainTab:CreateSection({
        Name = "Premium Scripts"
    })

    -- Function to load scripts and close the UI
    local function LoadScript(url)
        -- Close the UI first
        pcall(function()
            if Library.Unload then
                Library:Unload()
            end
        end)
        
        getgenv().fadecc = nil
        
        -- Load the script
        local success, result = pcall(function()
            local script = game:HttpGet(url, true)
            loadstring(script)()
        end)
        
        if not success then
            warn("[fade.cc] Failed to load script: " .. tostring(result))
        end
    end

    -- Add South Bronx Premium button
    PremiumSection:AddButton({
        Name = "South Bronx Premium",
        Callback = function()
            LoadScript("https://raw.githubusercontent.com/7uvex/fadepremium/refs/heads/main/main.lua")
        end
    })

    -- Add Tha Bronx Premium button
    PremiumSection:AddButton({
        Name = "Tha Bronx Premium",
        Callback = function()
            LoadScript("https://raw.githubusercontent.com/7uvex/fadepremiumtb3/refs/heads/main/main.lua")
        end
    })
    
    -- Add account section
    local AccountSection = MainTab:CreateSection({
        Name = "Account"
    })
    
    local savedData = LoadKey()
    if savedData then
        AccountSection:AddLabel("Key: " .. savedData.key)
        AccountSection:AddLabel("HWID: " .. string.sub(savedData.hwid, 1, 8) .. "...")
    end
    
    AccountSection:AddButton({
        Name = "Logout",
        Callback = function()
            pcall(function()
                delfile("fadecc_premium.txt")
            end)
            Library:Unload()
            getgenv().fadecc = nil
        end
    })

    --// Unload callback
    Library.UnloadCallback = function()
        getgenv().fadecc = nil
    end
end

--// Check if user needs to authenticate
if CheckExistingKey() then
    LoadMainUI()
else
    -- The key system at the top will handle authentication
    LoadMainUI()
end
