--We currently only support Synapse, so we add a quick check.
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

if not syn then
     game.Players.LocalPlayer:Kick("Only Synapse script")
     wait(5)
     TeleportService:Teleport(game.PlaceId, LocalPlayer)
else

--Check if TestHub is already loaded.
if game.CoreGui:FindFirstChild("TestHub") then
     error("TestHub is already loaded, if you encounter any issues, please rejoin and try again!")
else

--Services
local CoreGui = game.CoreGui

--Instances
		
		
--Properties
local PlaceID = game.PlaceId

--Information
local ScriptBase64 = "LS1IZXkhIFRoaXMgZmlsZSBpcyBoZXJlIGluIGNhc2UgeW91IGxvc3QgdGhlIHNjcmlwdCwgaWYgdGhhdCBoYXBwZW5lZCwganVzdCBjb3B5IHRoZSBjb250ZW50cyBvZiB0aGlzIGZpbGUgYW5kIHRoYXQncyB0aGUgc2NyaXB0IQpsb2Fkc3RyaW5nKGdhbWU6SHR0cEdldCJodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vTWVnYW1pU2hpbi9FeHBsb2l0LVNjcmlwdHMvbWFpbi9UM1BIVUIvU2NyaXB0Lmx1YSIpKCk="
local DecodedScript = syn.crypt.base64.decode(ScriptBase64)

--Functions
--Torso getter
function GetTorso(Player)
     if Player.Character then
          if Player.Character:FindFirstChild("UpperTorso") then
               return Player.Character.UpperTorso
          else
               return Player.Character.Torso
          end
     end
end

--UI library, not made by me, not a single part of it! All credits for it go to dawid on V3rm!!!!!!
local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/MegamiShin/UI-Librarys/main/fluxlib.txt")()

--Create a Boolvalue in the Coregui to show that TestHub is already loaded.
local IsLoadedValue = Instance.new("BoolValue", CoreGui)
IsLoadedValue.Name = "TestHub"
IsLoadedValue.Value = true

--Get the player's DisplayName
local DisplayName = LocalPlayer.DisplayName

--Create the T folder if it doesn't already exist in the workspace.
if not isfolder("TestHub") then
     makefolder("TestHub")
end
--Create a file containing the script if it already doesn't exist in the TestHub folder.

if not isfile('TestHub/Script.lua') then
     writefile("TestHub/Script.lua", DecodedScript)
end
 
--Get the color
if not isfile('TestHub/Color.cfg') then
      writefile("TestHub/Color.cfg", "184, 7, 53")
end
      
local RealColor = readfile("TestHub/Color.cfg")
local TrueColor = string.split(RealColor, ', ')
local TrulyFinalColor = Color3.fromRGB(tonumber(TrueColor[1]), tonumber(TrueColor[2]), tonumber(TrueColor[3]))

--Create the main window
local Mainframe = Flux:Window("TestHub", "Welcome, "..DisplayName.."!", TrulyFinalColor, Enum.KeyCode.Tab)


--Check if this is the users first time running the GUI

if not isfile('TestHub/AlreadyRan.cfg') then
     Flux:Notification("Welcome to TestHub! This hub has been made in the legacy of an old but useful GUI called T0PK3K. If you enjoy this, please leave a vouch and a honest review. Also, you can toggle the hub with the TAB key.", "Let's roll!")
     writefile("TestHub/AlreadyRan.cfg", "true")
else
end


--Create the tabs

local SelfTab = Mainframe:Tab("Self", "http://www.roblox.com/asset/?id=6023426915")
local PlayersTab = Mainframe:Tab("Players", "http://www.roblox.com/asset/?id=5107183916")
local MiscTab = Mainframe:Tab("Miscellaneous", "http://www.roblox.com/asset/?id=6022668888")
local SettingsTab = Mainframe:Tab("Settings", "http://www.roblox.com/asset/?id=5480743826")

--Create labels
SelfTab:Label("This tab has things that affect only you.")
PlayersTab:Label("This tab has things that affect a certain player.")
MiscTab:Label("This tab has some other useful stuff!")
SettingsTab:Label("Please note that certain things save only after rejoin.")

--BEGIN FEATURES

--Speed change
SelfTab:Slider("Walkspeed", "Choose your speed! Default is 16.", 0, 500,16,function(speed)
    LocalPlayer.Character.Humanoid.WalkSpeed = speed
end)

--JumpHeight changer
SelfTab:Slider("Jumppower", "Choose how high you wanna jump! Default is 50.", 0, 500,50,function(jump)
    LocalPlayer.Character.Humanoid.UseJumpPower = true
    LocalPlayer.Character.Humanoid.JumpPower = jump
end)

--Show backpack
SelfTab:Toggle("Toggle backpack", "Pesky game disabled your backpack? Just turn it back on! Or off, if that's what you need!", false, function(t)
    if t == true then
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
    else
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
    end
end)

--Increase zoom distance
SelfTab:Button("Increase zoom distance", "Need more zooming? No problem!", function()
    game.Players.LocalPlayer.CameraMaxZoomDistance = 1000
end)

--Rejoin same server
MiscTab:Button("Rejoin", "Rejoin the same server you are in!", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

--Saveinstance
MiscTab:Button("Save the game", "Save the games files to the workspace folder.", function()
    saveinstance()
end)

SettingsTab:Label("Rainbow mode currently doesn't work. Don't use it, trust me...")

--Color changer
SettingsTab:Colorpicker("Hub Color", TrulyFinalColor, function(t)
--Convert Color3 to Color3.fromRGB for easier manipulation
    local r, g, b = math.round(t.R*255), math.round(t.G*255), math.round(t.B*255)
    local RGB_Color = Color3.new(r,g,b)
    delfile("TestHub/Color.cfg")
    writefile("TestHub/Color.cfg", tostring(RGB_Color))
end)

--Purge config
SettingsTab:Button("Purge TestHub configration", "Delete ABSOLUTELY ALL records of TestHub usage on your computer. This is irreversible, and you will be rejoined.", function()
    delfolder("TestHub")
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

--ServerHop
MiscTab:Button("Serverhop", "Join a different server in the same game.", function()--Script created by CharWar on V3rmillion
    loadstring(game:HttpGet"https://raw.githubusercontent.com/MegamiShin/Exploit-Scripts/main/Assets/NotMine/ServerHopper.lua")()
end)

--Ctrl + Click Teleport
SelfTab:Button("CTRL + Click teleport", "Hold CTRL and click to teleport to where your mouse is pointing at!", function()
    local Mouse = LocalPlayer:GetMouse()

    Mouse.Button1Down:Connect(function()
    if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
    LocalPlayer.Character:MoveTo(Mouse.Hit.p)
end)
end)

--CTRL + Click delete
SelfTab:Button("ALT + Click delete", "Hold ALT and click to delete a wall, or anything really that your mouse is pointing at!", function()
    local Mouse = LocalPlayer:GetMouse()

    Mouse.Button1Down:Connect(function()
    if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
    if not Mouse.Target then return end
    Mouse.Target:Destroy()
end)
end)

MiscTab:Button("Unlock workspace", "Workspace is locked and you can't delete stuff? Just unlock it!", function()
function UnlockEverything(main)
for _,v in pairs(main:GetChildren()) do
   if v:IsA("Part") then
   v.Locked = false
end
UnlockEverything(v)
end
end
UnlockEverything(game.Workspace)
end)

--Suicide
SelfTab:Bind("Suicide Bind", Enum.KeyCode.Z, function()
    LocalPlayer.Character.Head:Destroy()
end)


--DANGER ZONE SELF TAB
SelfTab:Label("DANGER ZONE: USE WITH CAUTION")

--Get BTools
SelfTab:Button("Get BTools", "Get building tools. CTRL + Click delete is a MUCH safer alternative.", function(t)
--Game tool
		local GameTool = Instance.new("HopperBin")
		GameTool.BinType = "GameTool"
		GameTool.Parent = LocalPlayer.Backpack

--Clone tool
		local CloneTool = Instance.new("HopperBin")
		CloneTool.BinType = "Clone"
		CloneTool.Parent = LocalPlayer.Backpack

--Hammer tool
		local HammerTool = Instance.new("HopperBin")
		HammerTool.BinType = "Hammer"
		HammerTool.Parent = LocalPlayer.Backpack   
end)

--Fly
SelfTab:Toggle("Fly", "Need to fly around the map? Go ahead! WARNING: This MAY be bannable in some games!",false, function()
if Fly == true then

	Fly = false

	return

end

Fly = true

local Mouse = game.Players.LocalPlayer:GetMouse()

LocalPlayer = game.Players.LocalPlayer

local HumanoidRootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart")

local Speed = 0

local Keys = {a=false,d=false,w=false,s=false} 

local e1

local e2

local function Begin()

	local pos = Instance.new("BodyPosition",HumanoidRootPart)

	local gyro = Instance.new("BodyGyro",HumanoidRootPart)

	pos.Name="nothinggyro"

	pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)

	pos.position = HumanoidRootPart.Position

	gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9) 

	gyro.cframe = HumanoidRootPart.CFrame

	repeat

		wait()

		LocalPlayer.Character.Humanoid.PlatformStand=true

		local new=gyro.cframe - gyro.cframe.p + pos.position

		if not Keys.w and not Keys.s and not Keys.a and not Keys.d then

			Speed=1

		end 

		if Keys.w then 

			new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * Speed

			Speed=Speed+0.01

		end

		if Keys.s then 

			new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * Speed

			Speed=Speed+0.01

		end

		if Keys.d then 

			new = new * CFrame.new(Speed,0,0)

			Speed=Speed+0.01

		end

		if Keys.a then 

			new = new * CFrame.new(-Speed,0,0)

			Speed=Speed+0.01

		end

		if Speed>5 then

			Speed=5

		end

		pos.position=new.p

		if Keys.w then

			gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(Speed*15),0,0)

		elseif Keys.s then

			gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(Speed*15),0,0)

		else

			gyro.cframe = workspace.CurrentCamera.CoordinateFrame

		end

	until not Fly

	if gyro then gyro:Destroy() end

	if pos then pos:Destroy() end

	flying=false

	LocalPlayer.Character.Humanoid.PlatformStand=false

	Speed=0

end

e1=Mouse.KeyDown:connect(function(key)

	if not HumanoidRootPart or not HumanoidRootPart.Parent then flying=false e1:disconnect() e2:disconnect() return end

	if key=="w" then

		Keys.w = true

	elseif key=="s" then

		Keys.s = true

	elseif key=="a" then

		Keys.a=true

	elseif key=="d" then

		Keys.d=true

	end

end)

e2=Mouse.KeyUp:connect(function(key)

	if key=="w" then

		Keys.w=false

	elseif key=="s" then

		Keys.s=false

	elseif key=="a" then

		Keys.a=false

	elseif key=="d" then

		Keys.d=false

	end

end)

Begin()
end)

--Player tab create dropdown
local PlayerTable = {}
local PlayersDropdown = PlayersTab:Dropdown("Choose a player", PlayerTable, function(t)
         ChosenPlayer = t
         ChosenPlayerInstance = Players:FindFirstChild(t)
         ChosenPlayerCharacter = ChosenPlayerInstance.Character
end)

PlayersTab:Button("Teleport to", "Teleport yourself to the selected player", function()
    if ChosenPlayer then
      LocalPlayer.Character.HumanoidRootPart.CFrame = ChosenPlayerCharacter.HumanoidRootPart.CFrame
    end
end)

--Player table filler
local function UpdateDropdown()
     --Clear the table
     table.clear(PlayerTable)

     --Compile list of players into a table
     for i,v in pairs(Players:GetPlayers()) do
        table.insert(PlayerTable, v.Name)
     end
   
     --Clear the Dropdown
     PlayersDropdown:Clear()
     
     --Fill in the Dropdown
     for i,v in pairs(PlayerTable) do
        PlayersDropdown:Add(v)
     end

end
UpdateDropdown()

Players.PlayerAdded:Connect(function()
    UpdateDropdown()
end)

Players.PlayerRemoving:Connect(function()
    wait(1.5)
    UpdateDropdown()
end)

end
end
