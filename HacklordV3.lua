if not isfile("HacklordV3.rbxmx") then
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local PlayerGui = player:WaitForChild("PlayerGui")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = PlayerGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 200)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    MainFrame.BorderColor3 = Color3.fromRGB(0,255,0)
    MainFrame.BorderSizePixel = 3
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0,0,0,0)
    Title.BackgroundTransparency = 1
    Title.Text = "Hacklord"
    Title.TextColor3 = Color3.fromRGB(0,255,0)
    Title.Font = Enum.Font.Arcade
    Title.TextScaled = true
    Title.Parent = MainFrame

    local InfoText = Instance.new("TextLabel")
    InfoText.Size = UDim2.new(1, -20, 0, 50)
    InfoText.Position = UDim2.new(0,10,0,60)
    InfoText.BackgroundTransparency = 1
    InfoText.Text = "You need to manually download HacklordV3.rbxmx for this script to work. Once downloaded, place it in the Workspace file of your executor. If you don't know how to do this, watch a tutorial by pressing the Tutorial button (Paste the copied links into your browser)"
    InfoText.TextColor3 = Color3.fromRGB(255,255,255)
    InfoText.Font = Enum.Font.SourceSans
    InfoText.TextScaled = true
    InfoText.Parent = MainFrame

    local DownloadButton = Instance.new("TextButton")
    DownloadButton.Size = UDim2.new(0.4, 0, 0, 40)
    DownloadButton.Position = UDim2.new(0.05, 0, 0, 130)
    DownloadButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
    DownloadButton.Text = "Download"
    DownloadButton.Font = Enum.Font.SourceSans
    DownloadButton.TextColor3 = Color3.fromRGB(0,0,0)
    DownloadButton.TextScaled = true
    DownloadButton.Parent = MainFrame
    DownloadButton.MouseButton1Click:Connect(function()
        setclipboard("https://www.mediafire.com/file/pkowyq4di95cyl1/HacklordV3.rbxmx/file")
    end)

    local TutorialButton = Instance.new("TextButton")
    TutorialButton.Size = UDim2.new(0.4, 0, 0, 40)
    TutorialButton.Position = UDim2.new(0.55, 0, 0, 130)
    TutorialButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
    TutorialButton.Text = "Tutorial"
    TutorialButton.Font = Enum.Font.SourceSans
    TutorialButton.TextColor3 = Color3.fromRGB(0,0,0)
    TutorialButton.TextScaled = true
    TutorialButton.Parent = MainFrame
    TutorialButton.MouseButton1Click:Connect(function()
        setclipboard("https://youtu.be/cpFEreTdCCg?si=_5yNsFY2cRkiWYd")
    end)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
    CloseButton.TextScaled = true
    CloseButton.Parent = MainFrame
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
     return
end
writefile("Layer1V3.mp3", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/Layer1V3.mp3"))
writefile("Layer2V3.mp3", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/Layer2V3.mp3"))
writefile("Layer3V3.mp3", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/Layer3V3.mp3"))
writefile("ThemeV3.mp3", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/ThemeV3.mp3"))
writefile("LMSV3.mp3", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/LMSV3.mp3"))
writefile("Slash.ogg", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/Slash.ogg"))
writefile("Entanglement.ogg", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/Entanglement.ogg"))
writefile("MassInfection.ogg", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/MassInfection.ogg"))
writefile("UnstableEye.ogg", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/UnstableEye.ogg"))
writefile("RejuvenateTheRotten.ogg", game:HttpGet("https://github.com/ian49972/smth/raw/refs/heads/main/RejuvenateTheRotten.ogg"))

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local choiceGui = Instance.new("ScreenGui")
choiceGui.Name = "HacklordChoice"
choiceGui.ResetOnSpawn = false
choiceGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,500,0,320)
frame.Position = UDim2.new(0.5,-250,0.5,-160)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(255,0,0)
frame.Parent = choiceGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,60)
title.BackgroundTransparency = 1
title.Text = "HACKLORD"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.TextScaled = true
title.Font = Enum.Font.Arcade
title.Parent = frame

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1,-20,0,80)
info.Position = UDim2.new(0,10,0,60)
info.BackgroundTransparency = 1
info.TextColor3 = Color3.new(1,1,1)
info.TextScaled = true
info.TextWrapped = true
info.Text = "USE RIG → Uses Forsaken Hacklord Rig, players can't see you and doesn't support reanim\nUSE CHARACTER → Uses Hacklord V2 character, players can see you and supports reanim"
info.Font = Enum.Font.Gotham
info.Parent = frame

local rigBtn = Instance.new("TextButton")
rigBtn.Size = UDim2.new(0.45,0,0,70)
rigBtn.Position = UDim2.new(0.05,0,0.65,0)
rigBtn.BackgroundColor3 = Color3.fromRGB(0,120,0)
rigBtn.Text = "USE RIG"
rigBtn.TextColor3 = Color3.new(1,1,1)
rigBtn.TextScaled = true
rigBtn.Font = Enum.Font.Arcade
rigBtn.Parent = frame

local charBtn = Instance.new("TextButton")
charBtn.Size = UDim2.new(0.45,0,0,70)
charBtn.Position = UDim2.new(0.5,0,0.65,0)
charBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
charBtn.Text = "USE CHARACTER"
charBtn.TextColor3 = Color3.new(1,1,1)
charBtn.TextScaled = true
charBtn.Font = Enum.Font.Arcade
charBtn.Parent = frame

local choice = nil
local choiceMade = false

rigBtn.MouseButton1Click:Connect(function()
	choice = "rig"
	choiceMade = true
	choiceGui:Destroy()
end)

charBtn.MouseButton1Click:Connect(function()
	choice = "character"
	choiceMade = true
	choiceGui:Destroy()
end)

repeat task.wait() until choiceMade

local Object = game:GetObjects(getcustomasset("HacklordV3.rbxmx"))[1]
Object.Parent = Workspace

for _, v in pairs(Object:GetDescendants()) do
	if v:IsA("TextLabel") then
		local t = string.lower(v.Text)
		if t:find("hacklord") 
		or t:find("script made by") 
		or t:find("assets are from") 
		or t:find("forsaken") 
		or t:find("ban_") then
			v:Destroy() -- remove completamente o crédito
		end
	end
end


local function getRelativeCFrame(item, referencePart)
	if not referencePart or not item then return CFrame.new() end
	if item:IsA("Attachment") then
		return referencePart.CFrame:Inverse() * (item.Parent.CFrame * item.CFrame)
	end
	return referencePart.CFrame:Inverse() * item.CFrame
end

local function weldToCharacter(character, part, targetPart, relativeCFrame, useMotor6D, offset)
	part.Anchored = false
	part.CanCollide = false
	local finalCFrame = (relativeCFrame or CFrame.new()) * (offset or CFrame.new())
	if useMotor6D then
		local motor = Instance.new("Motor6D")
		motor.Part0 = targetPart
		motor.Part1 = part
		motor.C0 = finalCFrame
		motor.C1 = CFrame.new()
		motor.Parent = character
	else
		local weld = Instance.new("Weld")
		weld.Part0 = targetPart
		weld.Part1 = part
		weld.C0 = finalCFrame
		weld.C1 = CFrame.new()
		weld.Parent = character
	end
	part.Parent = character
end

local function moveAttachmentToPlayerHead(character, attachment, hackLordHead)
	if not attachment or not hackLordHead then return end
	local relativeCFrame = getRelativeCFrame(attachment, hackLordHead)
	attachment.CFrame = relativeCFrame
	attachment.Parent = character.Head
end

local hasApplied = false
local weldedParts = {}
local hacklordUI = nil
local musicFolder = nil
local currentCharacter = nil
local currentHumanoid = nil
local currentHRP = nil

local tStyle = {
	[Enum.PoseEasingStyle.Linear] = Enum.EasingStyle.Linear,
	[Enum.PoseEasingStyle.Bounce] = Enum.EasingStyle.Bounce,
	[Enum.PoseEasingStyle.Cubic] = Enum.EasingStyle.Cubic,
	[Enum.PoseEasingStyle.Elastic] = Enum.EasingStyle.Elastic,
	[Enum.PoseEasingStyle.Constant] = Enum.EasingStyle.Linear,
}

local tDirection = {
	[Enum.PoseEasingDirection.In] = Enum.EasingDirection.In,
	[Enum.PoseEasingDirection.Out] = Enum.EasingDirection.Out,
	[Enum.PoseEasingDirection.InOut] = Enum.EasingDirection.InOut,
}

local function BuildTweens(Model, KeyFrameSequence, SpeedMult)
	SpeedMult = SpeedMult or 1
	local frames = {}
	for _, kf in ipairs(KeyFrameSequence:GetKeyframes()) do
		table.insert(frames, {Time = kf.Time, Keyframe = kf})
	end
	table.sort(frames, function(a,b) return a.Time < b.Time end)
	local tweens, motors, values, keyPoses = {}, {}, {}, {}
	local function GetMotorFromPose(pose)
		for _,v in pairs(Model:GetDescendants()) do
			if v:IsA("Motor6D") and v.Part1 and v.Part1.Name == pose.Name and v.Part0 and v.Part0.Name == pose.Parent.Name then
				return v
			end
		end
	end
	for i,frame in ipairs(frames) do
		keyPoses[i] = {Time = frame.Time, Poses={}}
		for _, pose in ipairs(frame.Keyframe:GetDescendants()) do
			if pose:IsA("Pose") and pose.Weight > 0 then
				local motor = motors[pose.Name] or GetMotorFromPose(pose)
				if motor then
					motors[pose.Name] = motor
					if not values[pose.Name] then
						local cv = Instance.new("CFrameValue")
						cv.Value = motor.Transform
						cv.Parent = motor
						values[pose.Name] = cv
					end
					keyPoses[i].Poses[pose.Name] = {Motor=motor, Pose=pose}
				end
			end
		end
	end
	if #keyPoses > 1 then
		local last = {}
		for i=1,#keyPoses-1 do
			local k1, k2 = keyPoses[i], keyPoses[i+1]
			local dur = (k2.Time - k1.Time) / SpeedMult
			tweens[i] = {Time = dur, Tweens={}}
			for n,d in pairs(k1.Poses) do last[n]=d end
			for n,d in pairs(k2.Poses) do
				if last[n] then
					local info = TweenInfo.new(dur, tStyle[d.Pose.EasingStyle], tDirection[d.Pose.EasingDirection])
					tweens[i].Tweens[n] = TweenService:Create(values[n], info, {Value=d.Pose.CFrame})
				end
			end
		end
	end
	local totalDuration = 0
	for _, segment in ipairs(tweens) do totalDuration += segment.Time end
	return tweens, motors, values, totalDuration
end

local function PlayKeyframeSequence(Model, KeyFrameSequence, SpeedMult, looped, onFinished)
	SpeedMult = SpeedMult or 1
	local tweens, motors, values, totalDuration = BuildTweens(Model, KeyFrameSequence, SpeedMult)
	local stopped = false
	local hb
	hb = RunService.Heartbeat:Connect(function()
		if stopped then if hb then hb:Disconnect() end return end
		for n,motor in pairs(motors) do motor.Transform = values[n].Value end
	end)
	local function loop()
		repeat
			for _, segment in ipairs(tweens) do
				for _, tw in pairs(segment.Tweens) do tw:Play() end
				task.wait(segment.Time)
				if stopped then break end
			end
			if not looped and not stopped then
				stopped = true
				if onFinished then onFinished() end
				break
			end
		until stopped
	end
	task.spawn(loop)
	return {
		stop = function()
			stopped = true
			if hb then hb:Disconnect() hb = nil end
			for _,v in pairs(values) do if v then v:Destroy() end end
		end,
		getLength = function() return totalDuration end
	}
end

local minions = {}

local function setupMinion(minion, character)
	local hrp = minion:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local humanoid = minion:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	local keyframes = Object.Keyframes
	local summonAnim = keyframes.MinionSummon
	local runAnim = keyframes.MinionRun
	local walkAnim = keyframes.MinionWalk
	local attackAnim = keyframes.MinionAttack
	
	hrp.Anchored = false
	minion.Parent = workspace
	
	local currentMinionAnim = nil
	local lastAttack = 0
	local heartbeatConn = nil
	local wanderTarget = nil
	local lastWanderTime = 0
	local lastAnimChange = 0
	
	humanoid.WalkSpeed = 14
	
	local function stopMinionAnim()
		if currentMinionAnim then currentMinionAnim.stop() currentMinionAnim = nil end
	end
	
	local function playAnim(kf, speed, loop, cb)
		local now = tick()
		if currentMinionAnim and now - lastAnimChange < 0.3 then return end
		stopMinionAnim()
		if kf then
			lastAnimChange = now
			currentMinionAnim = PlayKeyframeSequence(minion, kf, speed or 2, loop, cb)
		end
	end
	
	local attackHitbox = Instance.new("Part")
	attackHitbox.Size = Vector3.new(6,6,10)
	attackHitbox.Transparency = 1
	attackHitbox.CanCollide = false
	attackHitbox.CFrame = hrp.CFrame * CFrame.new(0,0,-5)
	attackHitbox.Parent = workspace
	
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = hrp
	weld.Part1 = attackHitbox
	weld.Parent = attackHitbox
	
	attackHitbox.Touched:Connect(function(hit)
		if tick() - lastAttack < 1.5 then return end
		local vic = hit:FindFirstAncestorWhichIsA("Model")
		if not vic or not vic:FindFirstChildOfClass("Humanoid") then return end
		local plr = Players:GetPlayerFromCharacter(vic)
		if not plr or plr == LocalPlayer then return end
		
		local hum = vic:FindFirstChildOfClass("Humanoid")
		if hum.Health <= 30 then
			hum.Health = hum.MaxHealth
		else
			hum:TakeDamage(30)
		end
		
		lastAttack = tick()
		playAnim(attackAnim, 1.5, false, function()
			playAnim(runAnim, 2, true)
		end)
	end)
	
	PlayKeyframeSequence(minion, summonAnim, 1.5, false, function()
		playAnim(walkAnim, 2, true)
		
		heartbeatConn = RunService.Heartbeat:Connect(function()
			if not minion or not minion.Parent or not hrp or not hrp.Parent then
				if heartbeatConn then heartbeatConn:Disconnect() end
				if attackHitbox then attackHitbox:Destroy() end
				return
			end
			
			local now = tick()
			local closestDist = 80
			local closestPlayer = nil
			for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					local dist = (plr.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
					if dist < closestDist then
						closestDist = dist
						closestPlayer = plr
					end
				end
			end
			
			if closestPlayer and closestDist <= 70 then
				humanoid:MoveTo(closestPlayer.Character.HumanoidRootPart.Position)
				if humanoid.MoveDirection.Magnitude > 0.1 then
					playAnim(runAnim, 2, true)
				end
			else
				if not wanderTarget or (hrp.Position - wanderTarget).Magnitude < 6 or (now - lastWanderTime) > 6 then
					local angle = math.random() * math.pi * 2
					local dist = math.random(15, 30)
					wanderTarget = character.HumanoidRootPart.Position + Vector3.new(math.cos(angle) * dist, 0, math.sin(angle) * dist)
					lastWanderTime = now
					humanoid:MoveTo(wanderTarget)
				end
				if humanoid.MoveDirection.Magnitude > 0.1 then
					playAnim(walkAnim, 2, true)
				end
			end
		end)
	end)
	
	table.insert(minions, {minion = minion, hb = heartbeatConn})
end

local function spawnProjectile(modelName)
	if not currentHRP then return end
	local template = Object:FindFirstChild(modelName)
	if not template then return end
	local clone = template:Clone()
	local root = clone:FindFirstChild("Root") or clone.PrimaryPart or clone:FindFirstChildWhichIsA("BasePart")
	if not root then clone:Destroy() return end
	for _, v in pairs(clone:GetDescendants()) do if v:IsA("BasePart") then v.Anchored = false v.CanCollide = false end end
	
	clone:SetPrimaryPartCFrame(currentHRP.CFrame * CFrame.new(0,1,-6))
	if modelName == "Entanglement" then
		for _, part in pairs(clone:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CFrame = part.CFrame * CFrame.Angles(0, math.pi, 0)
			end
		end
	end
	
	clone.Parent = workspace
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(5e4,5e4,5e4)
	bv.Velocity = currentHRP.CFrame.LookVector * 110
	bv.P = 3000
	bv.Parent = root
	task.delay(6, function() if clone and clone.Parent then clone:Destroy() end end)
end

local function characterOnlyCleanup()
	if choice ~= "character" then return end
	for _, obj in pairs(weldedParts) do
		if obj and obj.Parent then obj:Destroy() end
	end
	weldedParts = {}
end

local function fullCleanup()
	if hacklordUI and hacklordUI.Parent then hacklordUI:Destroy() end
	hacklordUI = nil

	if musicFolder and musicFolder.Parent then musicFolder:Destroy() end
	musicFolder = nil

	for _, d in minions do
		if d.minion and d.minion.Parent then d.minion:Destroy() end
		if d.hb then d.hb:Disconnect() end
	end
	minions = {}
end

local function setupCharacter(char)
	if hasApplied then return end
	hasApplied = true
	currentCharacter = char
	currentHumanoid = char:WaitForChild("Humanoid")
	currentHRP = char:WaitForChild("HumanoidRootPart")

	hacklordUI = Object:FindFirstChild("HacklordUI", true)
	if hacklordUI and hacklordUI:IsA("ScreenGui") then 
		hacklordUI = hacklordUI:Clone()
		hacklordUI.Parent = LocalPlayer.PlayerGui
	end

	local keyframes = Object.Keyframes
	local introAnim = keyframes.Intro
	local idleAnim = keyframes.Idle
	local walkAnim = keyframes.Walk
	local runAnim = keyframes.Run
	local slashAnim = keyframes.Slash
	local rottenAnim = keyframes.Rotten
	local executionAnim = keyframes.Execution_Hacklord
	local executionVictimAnim = keyframes.Execution_Player
	local massinfectionAnim = keyframes.massinfection
	local entanglementAnim = keyframes.Entanglement
	local eyeAnim = keyframes.Eye

	local currentAnimObj = nil
	local isRunning = false
	local connections = {}
	local lastMagnitude = 0
	local setupComplete = false
	local isPlayingAbility = false
	local lmsEnabled = false

	if choice == "rig" then
		local hacklordModel = Object.HacklordRig
		if hacklordModel then
			local cf = currentHRP.CFrame
			hacklordModel.Parent = workspace
			hacklordModel.Name = char.Name
			hacklordModel.HumanoidRootPart.CFrame = cf
			hacklordModel.HumanoidRootPart.Anchored = false

			LocalPlayer.Character = hacklordModel
			currentCharacter = hacklordModel
			currentHumanoid = hacklordModel:FindFirstChildOfClass("Humanoid")
			currentHRP = hacklordModel.HumanoidRootPart
			Workspace.CurrentCamera.CameraSubject = currentHumanoid

			char:Destroy()
		end
	else
		task.wait(1)
		local success, model = pcall(function() return game:GetObjects("rbxassetid://102473641596712")[1] end)
		if success and model then
			local hackLord = model:FindFirstChild("HackLord")
			if hackLord then
				local referencePart = hackLord.PrimaryPart or hackLord:FindFirstChildWhichIsA("BasePart")
				if referencePart then
					local components = {
						ExtraModels = hackLord:FindFirstChild("ExtraModels"),
						Coffin = hackLord:FindFirstChild("Coffin"),
						ErlkingCoffinChains = hackLord:FindFirstChild("ErlkingCoffinChains"),
						HaxxedCrown = hackLord:FindFirstChild("Haxxed Crown")
					}
					for name, component in pairs(components) do
						if component then
							if component:IsA("Model") then
								for _, part in ipairs(component:GetDescendants()) do
									if part:IsA("BasePart") then
										local relativeCFrame = getRelativeCFrame(part, referencePart)
										weldToCharacter(currentCharacter, part, currentCharacter.HumanoidRootPart, relativeCFrame, true)
										table.insert(weldedParts, part)
									end
								end
							elseif component:IsA("BasePart") then
								local relativeCFrame = getRelativeCFrame(component, referencePart)
								if name == "ErlkingCoffinChains" then
									local target = currentCharacter:FindFirstChild("Torso") or currentCharacter.HumanoidRootPart
									weldToCharacter(currentCharacter, component, target, relativeCFrame, false)
								elseif name == "HaxxedCrown" then
									weldToCharacter(currentCharacter, component, currentCharacter.Head, relativeCFrame, false, CFrame.new(0,-1.5,0))
								else
									weldToCharacter(currentCharacter, component, currentCharacter.HumanoidRootPart, relativeCFrame, true)
								end
								table.insert(weldedParts, component)
							end
						end
					end
					local hackLordHead = hackLord:FindFirstChild("Head")
					if hackLordHead then
						for _, attachment in ipairs(hackLordHead:GetChildren()) do
							if attachment:IsA("Attachment") then
								moveAttachmentToPlayerHead(currentCharacter, attachment, hackLordHead)
							end
						end
					end
				end
				model:Destroy()
			end
		end
	end

	if currentHumanoid then
		local animator = currentHumanoid:FindFirstChildOfClass("Animator")
		if animator then animator:Destroy() end
	end

	musicFolder = Instance.new("Folder")
	musicFolder.Name = "HacklordMusic"
	musicFolder.Parent = workspace

	local layer1 = Instance.new("Sound"); layer1.SoundId = getcustomasset("Layer1V3.mp3"); layer1.Volume = 0.8; layer1.Looped = true; layer1.Parent = musicFolder
	local layer2 = Instance.new("Sound"); layer2.SoundId = getcustomasset("Layer2V3.mp3"); layer2.Volume = 0.8; layer2.Looped = true; layer2.Parent = musicFolder
	local layer3 = Instance.new("Sound"); layer3.SoundId = getcustomasset("Layer3V3.mp3"); layer3.Volume = 0.8; layer3.Looped = true; layer3.Parent = musicFolder
	local theme = Instance.new("Sound"); theme.SoundId = getcustomasset("ThemeV3.mp3"); theme.Volume = 1; theme.Looped = true; theme.Parent = musicFolder
	local lms = Instance.new("Sound"); lms.SoundId = getcustomasset("LMSV3.mp3"); lms.Volume = 1; lms.Looped = true; lms.Parent = musicFolder

	local currentMusic = nil
	local function stopAll() for _,s in pairs(musicFolder:GetChildren()) do s:Stop() end currentMusic = nil end
	local function playMusic(snd) if currentMusic == snd then return end stopAll() snd:Play() currentMusic = snd end

	if hacklordUI then
		local lmsButton = Instance.new("TextButton")
		lmsButton.Size = UDim2.new(0,200,0,50)
		lmsButton.Position = UDim2.new(0.5,-100,0,10)
		lmsButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
		lmsButton.Text = "LMS OFF"
		lmsButton.TextColor3 = Color3.new(1,1,1)
		lmsButton.TextScaled = true
		lmsButton.Font = Enum.Font.Arcade
		lmsButton.Parent = hacklordUI

		lmsButton.MouseButton1Click:Connect(function()
			lmsEnabled = not lmsEnabled
			lmsButton.Text = lmsEnabled and "LMS ON" or "LMS OFF"
			lmsButton.BackgroundColor3 = lmsEnabled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
			if lmsEnabled then playMusic(lms) else stopAll() end
		end)
	end

	connections.terror = RunService.Heartbeat:Connect(function()
		if not currentCharacter or not currentCharacter.Parent or not currentHRP or lmsEnabled then return end
		local closest = math.huge
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local d = (plr.Character.HumanoidRootPart.Position - currentHRP.Position).Magnitude
				if d < closest then closest = d end
			end
		end
		if closest <= 25 then playMusic(theme)
		elseif closest <= 50 then playMusic(layer3)
		elseif closest <= 75 then playMusic(layer2)
		elseif closest <= 100 then playMusic(layer1)
		else stopAll() end
	end)

	local function playAnimation(anim, speedMult, looped, onFinish)
		if currentAnimObj then currentAnimObj.stop() currentAnimObj = nil end
		if anim then currentAnimObj = PlayKeyframeSequence(currentCharacter, anim, speedMult or 2, looped, onFinish) end
	end

	playAnimation(introAnim, 2, false, function()
		setupComplete = true
		currentHumanoid.WalkSpeed = 16
		playAnimation(idleAnim, 2, true)
	end)

	if hacklordUI then
		local abilityFrame = hacklordUI:WaitForChild("Abilitys")

		local function playAbilitySound(name)
			local s = Instance.new("Sound")
			s.SoundId = getcustomasset(name..".ogg")
			s.Volume = 1
			s.Parent = currentHRP
			s:Play()
			Debris:AddItem(s, 6)
		end

		local function connectAbility(name, anim, callback)
			local btn = abilityFrame:FindFirstChild(name)
			if btn then
				btn.MouseButton1Click:Connect(function()
					if isPlayingAbility or not setupComplete then return end
					isPlayingAbility = true
					currentHumanoid.WalkSpeed = (name == "Slash") and currentHumanoid.WalkSpeed or 2
					playAbilitySound(name)
					if callback then task.spawn(callback) end
					playAnimation(anim, 2, false, function()
						isPlayingAbility = false
						currentHumanoid.WalkSpeed = isRunning and 28 or 16
						if currentHumanoid.MoveDirection.Magnitude > 0 then
							playAnimation(isRunning and runAnim or walkAnim, 2, true)
						else
							playAnimation(idleAnim, 2, true)
						end
					end)
				end)
			end
		end

		connectAbility("RejuvenateTheRotten", rottenAnim, function()
			task.wait(1)
			local t = Object:FindFirstChild("Minion")
			if t then
				local l = t:Clone(); l:SetPrimaryPartCFrame(currentHRP.CFrame * CFrame.new(-8,0,0)); setupMinion(l, currentCharacter)
				local r = t:Clone(); r:SetPrimaryPartCFrame(currentHRP.CFrame * CFrame.new(8,0,0)); setupMinion(r, currentCharacter)
			end
		end)

		connectAbility("MassInfection", massinfectionAnim, function() task.wait(2) spawnProjectile("Shockwave") end)
		connectAbility("Entanglement", entanglementAnim, function() task.wait(0.8) spawnProjectile("Entanglement") end)

		connectAbility("UnstableEye", eyeAnim, function()
			task.wait(1)
			local blur = Instance.new("BlurEffect"); blur.Size = 30; blur.Parent = Lighting
			local hl = {}
			for _, plr in Players:GetPlayers() do
				if plr ~= LocalPlayer and plr.Character then
					local h = Instance.new("Highlight")
					h.FillColor = Color3.fromRGB(255,140,0)
					h.OutlineColor = Color3.fromRGB(255,80,0)
					h.Parent = plr.Character
					table.insert(hl, h)
				end
			end
			task.delay(5, function()
				if blur and blur.Parent then blur:Destroy() end
				for _, h in hl do if h and h.Parent then h:Destroy() end end
			end)
		end)

		connectAbility("Slash", slashAnim, function()
			local hitbox = Instance.new("Part")
			hitbox.Size = Vector3.new(4,4,12)
			hitbox.Transparency = 1
			hitbox.CanCollide = false
			hitbox.Anchored = false
			hitbox.CFrame = currentHRP.CFrame * CFrame.new(0,0,-6)
			hitbox.Parent = workspace
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = currentHRP
			weld.Part1 = hitbox
			weld.Parent = hitbox

			local alreadyHit = {}
			local conn
			conn = hitbox.Touched:Connect(function(hit)
				if not hit or not hit.Parent then return end
				if hit:IsDescendantOf(currentCharacter) then return end
				local target = hit:FindFirstAncestorWhichIsA("Model")
				if not target or not target.Parent or alreadyHit[target] or not target:FindFirstChildOfClass("Humanoid") then return end
				alreadyHit[target] = true

				if target.Name == "Minion" then
					target:Destroy()
					for i = #minions, 1, -1 do
						if minions[i].minion == target then
							if minions[i].hb then minions[i].hb:Disconnect() end
							table.remove(minions, i)
						end
					end
					return
				end

				local hum = target:FindFirstChildOfClass("Humanoid")
				local plr = Players:GetPlayerFromCharacter(target)
				if not plr or plr == LocalPlayer then return end

				if hum.Health <= 30 then
					hum.Health = 1
					target.Archivable = true
					local clone = target:Clone()
					clone.Parent = workspace
					local chrp = clone:FindFirstChild("HumanoidRootPart")
					if chrp then
						chrp.CFrame = currentHRP.CFrame * CFrame.new(0,0,-3) * CFrame.Angles(0,math.pi,0)
						chrp.Anchored = true
						local w = Instance.new("WeldConstraint")
						w.Part0 = currentHRP
						w.Part1 = chrp
						w.Parent = chrp

						if currentAnimObj then currentAnimObj.stop() end
						
						playAnimation(executionAnim, 2, false, function()
							if clone and clone.Parent then clone:Destroy() end
							isPlayingAbility = false
							currentHumanoid.WalkSpeed = isRunning and 28 or 16
							if currentHumanoid.MoveDirection.Magnitude > 0 then
								playAnimation(isRunning and runAnim or walkAnim, 2, true)
							else
								playAnimation(idleAnim, 2, true)
							end
						end)
						
						if executionVictimAnim then 
							PlayKeyframeSequence(clone, executionVictimAnim, 2, false) 
						end
						
						task.wait(0.1)
						if hum and hum.Parent then
							hum.Health = hum.MaxHealth
						end
					end
				else
					hum:TakeDamage(30)
				end
			end)

			task.delay(1, function() 
				if conn and conn.Connected then conn:Disconnect() end 
				if hitbox and hitbox.Parent then hitbox:Destroy() end 
			end)
		end)

		local sprintButton = hacklordUI:FindFirstChild("Sprint")
		if sprintButton then
			sprintButton.MouseButton1Click:Connect(function()
				if not setupComplete or isPlayingAbility then return end
				isRunning = not isRunning
				currentHumanoid.WalkSpeed = isRunning and 28 or 16
				if currentHumanoid.MoveDirection.Magnitude > 0 then
					playAnimation(isRunning and runAnim or walkAnim, 2, true)
				end
			end)
		end
	end

	connections.move = RunService.Heartbeat:Connect(function()
		if not currentHumanoid or not currentCharacter or not currentCharacter.Parent or not setupComplete or isPlayingAbility then return end
		local mag = currentHumanoid.MoveDirection.Magnitude
		if mag > 0 and lastMagnitude == 0 and currentHumanoid.WalkSpeed > 2 then
			playAnimation(isRunning and runAnim or walkAnim, 2, true)
		elseif mag == 0 and lastMagnitude > 0 then
			playAnimation(idleAnim, 2, true)
		end
		lastMagnitude = mag
	end)

	currentHumanoid.Died:Connect(function()
		characterOnlyCleanup()
		fullCleanup()
	end)
end

if LocalPlayer.Character then
	setupCharacter(LocalPlayer.Character)
end