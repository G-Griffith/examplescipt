local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "gun simulator (example)",
   LoadingTitle = "Example",
   LoadingSubtitle = "made by: G_Jonny",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Example"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key | Youtube Hub",
      Subtitle = "Key System",
      Note = "Key In Discord Server",
      FileName = "YoutubeHubKey1", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("Example", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main Example")

Rayfield:Notify({
   Title = "You executed the script",
   Content = "Cool GUI. Made by G_Jonny and legacy.GG",
   Duration = 5,
   Image = 13047715178,
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Okay!",
         Callback = function()
         print("The user tapped Okay!")
      end
   },
},
})

local Button = MainTab:CreateButton({
   Name = "Infinite Jump Toggle",
   Callback = function()
       --Toggles the infinite jump between on or off on every script run
_G.infinjump = not _G.infinjump

if _G.infinJumpStarted == nil then
	--Ensures this only runs once to save resources
	_G.infinJumpStarted = true
	
	--Notifies readiness
	game.StarterGui:SetCore("SendNotification", {Title="Youtube Hub"; Text="Infinite Jump Activated!"; Duration=5;})

	--The actual infinite jump
	local plr = game:GetService('Players').LocalPlayer
	local m = plr:GetMouse()
	m.KeyDown:connect(function(k)
		if _G.infinjump then
			if k:byte() == 32 then
			humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
			humanoid:ChangeState('Jumping')
			wait()
			humanoid:ChangeState('Seated')
			end
		end
	end)
end
   end,
})

local Button = MainTab:CreateButton({
   Name = "Fly",
   Info = "Button info/Description.", -- Speaks for itself, Remove if none.
   Interact = 'Changable',
   Callback = function()
 --Waits until the player is in game
repeat wait()
until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Torso") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
local mouse = game.Players.LocalPlayer:GetMouse()

--Waits until the player's mouse is found
repeat wait() until mouse

--Variables
local plr = game.Players.LocalPlayer
local torso = plr.Character.Torso
local flying = true
local deb = true
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}
local maxspeed = 50
local speed = 0
local bg = nil
local bv = nil

--Actual flying
function Fly()
	game.StarterGui:SetCore("SendNotification", {Title="Fly Activated"; Text="WeAreDevs.net"; Duration=1;})
    bg = Instance.new("BodyGyro", torso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = torso.CFrame
    bv = Instance.new("BodyVelocity", torso)
    bv.velocity = Vector3.new(0,0.1,0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    repeat wait()
      plr.Character.Humanoid.PlatformStand = true
      if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
        speed = speed+.5+(speed/maxspeed)
        if speed > maxspeed then
          speed = maxspeed
        end
      elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
        speed = speed-1
        if speed < 0 then
          speed = 0
        end
      end
      if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
        bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
        lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
      elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
        bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
      else
        bv.velocity = Vector3.new(0,0.1,0)
      end
      bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
    until not flying
    ctrl = {f = 0, b = 0, l = 0, r = 0}
    lastctrl = {f = 0, b = 0, l = 0, r = 0}
    speed = 0
    bg:Destroy()
	bg = nil
    bv:Destroy()
	bv = nil
    plr.Character.Humanoid.PlatformStand = false
	game.StarterGui:SetCore("SendNotification", {Title="Fly Deactivated"; Text="WeAreDevs.net"; Duration=1;})
end

--Controls
mouse.KeyDown:connect(function(key)
	if key:lower() == "e" then
		if flying then 
			flying = false
		else
			flying = true
			Fly()
		end
	elseif key:lower() == "w" then
		ctrl.f = 1
	elseif key:lower() == "s" then
		ctrl.b = -1
	elseif key:lower() == "a" then
		ctrl.l = -1
	elseif key:lower() == "d" then
		ctrl.r = 1
	end
end)

mouse.KeyUp:connect(function(key)
	if key:lower() == "w" then
		ctrl.f = 0
	elseif key:lower() == "s" then
		ctrl.b = 0
	elseif key:lower() == "a" then
		ctrl.l = 0
	elseif key:lower() == "d" then
		ctrl.r = 0
	end
end)

Fly()
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "WalkSpeed Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderws", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "JumpPower Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderjp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})

local Dropdown = MainTab:CreateDropdown({
   Name = "Select Area",
   Options = {"Starter World","Pirate Island","Pineapple Paradise"},
   CurrentOption = {"Starter World"},
   MultipleOptions = false,
   Flag = "dropdownarea", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
        print(Option)
   end,
})

local Input = MainTab:CreateInput({
   Name = "Walkspeed",
   PlaceholderText = "1-500",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Text)
   end,
})

local OtherSection = MainTab:CreateSection("Other")

local Toggle = MainTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        print("FARMING")
   end,
})

local TPTab = Window:CreateTab("🏝 Teleports", nil) -- Title, Image

local Button1 = TPTab:CreateButton({
   Name = "Starter Island",
   Callback = function()
        --Teleport1
   end,
})

local Button2 = TPTab:CreateButton({
   Name = "Pirate Island",
   Callback = function()
        --Teleport2
   end,
})

local Button3 = TPTab:CreateButton({
   Name = "Pineapple Paradise",
   Callback = function()
        --Teleport3
   end,
})

local TPTab = Window:CreateTab("Example", nil) -- Title, Image
