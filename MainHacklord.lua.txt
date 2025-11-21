local Settings = {
	VisibleHitbox = true;
	Hitmarker = false
}
local RepoPath = "https://raw.githubusercontent.com/CoolCatUser/HacklordRepo/main/"
local loadedassets = {}
local getasset = getcustomasset or getsynasset or function(a) return "rbxasset://"..a end
do
	if not isfolder("HacklordPackages") then makefolder("HacklordPackages/") end
	local files = {"Asset.rbxmx","Layer1.mp3","Layer2.mp3","Layer3.mp3","Chase.mp3","LMS.mp3","Footstep.ogg","Footstep2.ogg","Slash.ogg","Entanglement.ogg","EntanglementThrow.ogg","MassInfection.ogg","UnstableEye.ogg","Rejuvenate.ogg","Execution.ogg","Unknown.ogg"}
	for _, v in next, files do
		if not isfile("HacklordPackages/"..v) then
			local success,response = pcall(game.HttpGet,game,RepoPath..v)

			if success then
				writefile("HacklordPackages/"..v,response)
				loadedassets[v] = getasset("HacklordPackages/"..v)
			end
		else
			loadedassets[v] = getasset("HacklordPackages/"..v)
		end
	end
end

local AnimationModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/CoolCatUser/KeyframePlayer/refs/heads/main/Transform.lua"))()

local script = game:GetObjects(loadedassets["Asset.rbxmx"])[1]

local Accessories = script.Accessories:Clone()
local Animations = script.Animations:Clone()
local Miscs = script.Miscs:Clone()
local Zombie = script.Zombie:Clone()

script:Destroy()

local Enum = Enum
local next = next
local New = Instance.new
local Vector3 = Vector3
local vector = vector
local CFrame = CFrame
local math = math
local table = table
local osclock = os.clock
local NewInstance = function(Class, Parent, Properties) local inst=New(Class) for prop,val in next,Properties do inst[prop] = val end inst.Parent = Parent return inst end

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Heartbeat = RunService.Heartbeat
local PreRender = RunService.PreRender

local RespawnTime = Players.RespawnTime
local CleanUp = {}
local Direction = 0
local current = osclock()
local last = current
local deltatime = 0
local debouche = false
local HeadLook = true
local debouchepriority = 1
local IsSprinting = false
local TerrorRange = 100
local PlayerTable = {}
local RootParts = {}
local PauseEverything = false
local StopEverything = false
local ShiftlockOn = false
local UnstableEyeEffectActive = false
local SpeedMultiply = 1
local SpeedEffectEndTime = current
local SpeedStackLevel = NewInstance("IntValue",Character,{Value=0})
local LMSActive = false
local ForceTriggerLMS = false

local getasset = getcustomasset or getsynasset or function(a) return "rbxasset://"..a end
local HacklordInfo = {
	Health = 1100;
	Speed = 8;
	SprintSpeed = 27;
	SlashDamage = 20;
	SlashPoisonLevel = 1;
	SlashPoisonDuration = 5;
	SlashGlitchLevel = 1;
	SlashGlitchDuration = 5;
	ExecutionDamage = 20;
	MassInfectionSlashDamage = 5;
	MassInfectionCloseSlashDamage = 58.33,
	MassInfectionSlashPoisonLevel = 5;
	MassInfectionSlashPoisonDuration = 3;
	MassInfectionShockwaveSpeed = 120;
	MassInfectionShockwaveLifetime = 6;
	MassInfectionShockwaveDamage = 35;
	MassInfectionShockwavePoisonLevel = 1;
	MassInfectionShockwavePoisonDuration = 5;
	MassInfectionShockwaveAuraDuration = 2;
	EntanglementSpeed = 125;
	EntanglementDamage = 10;
	EntanglementLifetime = 10;
	EntanglementPoisonLevel = 2;
	EntanglementPoisonDuration = 16;
	EntanglementAuraDuration = 2;
	EntanglementKillerSpeedBuffDuration = 3;
	UnstableEyeBuffDuration = 6.5;
	UnstableEyeDebuffDuration = 6.5;
	UnstableEyeAuraDuration = 5;
	ZombieHealth = 10;
	ZombieWalkSpeed = 6;
	ZombieSprintSpeed = 17.5;
	ZombieAttackCooldown = 3;
	ZombieAttackDamage = 14;
	ZombieAttackRange = 5;
	ZombieTargetRange = 30;
	ZombieLoseFocusRange = 50;
	ZombieKillSpeedLevel = 1;
	ZombieKillSpeedDuration = 10;
	ZombieLifeTime = 20;
	HighlightProperties = {
		FillColor = Color3.fromRGB(113, 94, 255);
		OutlineColor = Color3.fromRGB(2, 59, 10);
		FillTransparency = 1.5;
		OutlineTransparency = -10;
	};
	TargetHighlightProperties = {
		FillColor = Color3.fromRGB(255, 224, 20);
		OutlineColor = Color3.fromRGB(255, 255, 0);
		FillTransparency = 0.4;
		OutlineTransparency = 0.25;
	};
	ShockwaveTemplate = Miscs.shockwave;
	SwordsTemplate = Miscs.Swords;
	SwordTrail = Accessories.HaxxedGripR.ErlkingWeaponLeft.Trail;
	SavedAnimations = {};
	Sounds = {
		Footsteps = {loadedassets["Footstep.ogg"],loadedassets["Footstep2.ogg"]};
		Swing = loadedassets["Slash.ogg"];
		Entanglement = loadedassets["Entanglement.ogg"];
		EntanglementThrow = loadedassets["EntanglementThrow.ogg"];
		MassInfection = loadedassets["MassInfection.ogg"];
		UnstableEye = loadedassets["UnstableEye.ogg"];
		Rejuvenate = loadedassets["Rejuvenate.ogg"];
		Execution = loadedassets["Execution.ogg"];
		Unknown = loadedassets["Unknown.ogg"]
	};
	Themes = {
		Layer1 = loadedassets["Layer1.mp3"];
		Layer2 = loadedassets["Layer2.mp3"];
		Layer3 = loadedassets["Layer3.mp3"];
		Layer4 = loadedassets["Chase.mp3"];
		LMS = loadedassets["LMS.mp3"]
	}
}

local CurrentSpeed = HacklordInfo.Speed

HacklordInfo.SwordTrail.Enabled = false

local RootPart = Character:WaitForChild("HumanoidRootPart")
local Head = Character.Head
local Torso = Character.Torso
local RightArm = Character["Right Arm"]
local LeftArm = Character["Left Arm"]
local RightLeg = Character["Right Leg"]
local LeftLeg = Character["Left Leg"]
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local FolderStorage = New("Folder", Workspace)
local Highlights = New("Model", FolderStorage)
local VictimFolder = New("Model", FolderStorage)
local AllyFolder = New("Model", FolderStorage)
local HitboxFolder = New("Model", FolderStorage)
local State = New("StringValue", Character)
local Layer = NewInstance("IntValue", Character, {Value = 0})
local Device = NewInstance("StringValue", Character, {Value = "PC"})
local WalkMagnitude = 0
local RunMagnitude = 0
local HitmarkerUI

local XRay = NewInstance("Highlight",Highlights,{Enabled=false,Adornee=Highlights,FillColor=HacklordInfo.TargetHighlightProperties.FillColor,OutlineColor=HacklordInfo.TargetHighlightProperties.OutlineColor,FillTransparency=1,OutlineTransparency=1})
local BlurEffect = NewInstance("BlurEffect",Lighting,{Enabled=false,Size=0})

local Neck = Torso:FindFirstChild("Neck") or NewInstance("Motor6D", Torso, {Name = "Neck"})
local RootJoint = RootPart:FindFirstChild("RootJoint") or NewInstance("Motor6D", RootPart, {Name = "RootJoint"})

local TerrorTheme = NewInstance("Sound", RootPart, {Volume = 3.5, Looped = true, MaxDistance = 10000})
local LMS = NewInstance("Sound", Character, {Volume = 2.5, Looped = true})

local Lerp = function(a,b,t) return a:Lerp(b,math.min(deltatime*4+t,1)) end
local NLerp = function(a,b,t) return a+(b-a)*math.min(deltatime*4+t,1) end

local LocalAnimator = AnimationModule.new(Humanoid)
local Animators = {LocalAnimator}
local AnimationTracks = {}

table.insert(CleanUp, FolderStorage)
table.insert(CleanUp, BlurEffect)

local AddDebris = function(Object, Time)
	task.spawn(function()
		local stop = osclock()+Time
		while osclock()<=stop do Heartbeat:Wait() end
		if Object then
			Object:Destroy()
		end
	end)
end

pcall(function()
	local Description = Humanoid:GetAppliedDescription()
	Zombie.Parent = FolderStorage
	Zombie.Zombie:FindFirstChildOfClass("Humanoid"):ApplyDescription(Description)
	PreRender:Wait()
	Zombie.Parent = nil
end)

Accessories.Parent = Character
pcall(function()
	for _,v in next,Accessories:GetChildren() do
		local Weld = v:FindFirstChildOfClass("Weld") or v:FindFirstChildOfClass("Motor6D")
		if Weld then
			if v:FindFirstChild("HaxxedGripR") then
				Weld.Part0 = RootPart
				v.Parent = RootPart
			elseif v:FindFirstChild("HaxxedGripL") then
				Weld.Part0 = RootPart
				v.Parent = RootPart
			else
				if v:FindFirstChild("BodyBackAttachment") then
					Weld.Part1 = Torso
					Weld.C0 *= CFrame.new(0,-0.2,0)
				elseif v:FindFirstChild("LeftShoulderAttachment") then
					Weld.Part1 = LeftArm
					Weld.C0 *= CFrame.new(0,-0.3,0)
				elseif v:FindFirstChild("RightShoulderAttachment") then
					Weld.Part1 = RightArm
					Weld.C0 *= CFrame.new(0,-0.3,0)
				elseif v:FindFirstChild("HatAttachment") then
					Weld.Part1 = Head
				elseif v:FindFirstChild("FaceCenterAttachment") then
					Weld.Part1 = Head
				elseif v:FindFirstChild("BodyFrontAttachment") then
					Weld.Part1 = Torso
					Weld.C0 *= CFrame.new(0,-0.2,0)
				elseif v:FindFirstChild("HairAttachment") then
					Weld.Part1 = Head
				elseif v:FindFirstChild("RightGripAttachment") then
					Weld.Part0 = RightArm
				elseif v:FindFirstChild("LeftHipAttachment") then
					Weld.Part1 = LeftLeg
				elseif v:FindFirstChild("RightKneeRigAttachment") then
					Weld.Part1 = RightLeg
				elseif v:FindFirstChild("LeftKneeRigAttachment") then
					Weld.Part1 = LeftLeg
				elseif v:FindFirstChild("LeftElbowRigAttachment") then
					Weld.Part1 = LeftArm
				elseif v:FindFirstChild("RightElbowRigAttachment") then
					Weld.Part1 = RightArm
				end
			end
			v.Anchored = false
		end
	end
end)

for _,v in next, Animations:GetChildren() do
	local Name = v.Name
	HacklordInfo.SavedAnimations[Name] = v
	v.Parent = Humanoid
	
	if not string.find(Name,"Zombie") then
		AnimationTracks[Name] = LocalAnimator:LoadAnimation(v)
	end
end

NewInstance("Highlight",Character,{Adornee=Character,DepthMode=Enum.HighlightDepthMode.Occluded,FillColor=HacklordInfo.HighlightProperties.FillColor,OutlineColor=HacklordInfo.HighlightProperties.OutlineColor,FillTransparency=HacklordInfo.HighlightProperties.FillTransparency,OutlineTransparency=HacklordInfo.HighlightProperties.OutlineTransparency})
NewInstance("Highlight",AllyFolder,{Adornee=AllyFolder,DepthMode=Enum.HighlightDepthMode.Occluded,FillColor=HacklordInfo.HighlightProperties.FillColor,OutlineColor=HacklordInfo.HighlightProperties.OutlineColor,FillTransparency=HacklordInfo.HighlightProperties.FillTransparency,OutlineTransparency=HacklordInfo.HighlightProperties.OutlineTransparency})

local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Exclude
RayParams.RespectCanCollide = true
RayParams.FilterDescendantsInstances = {Character}

local OverlayParams = OverlapParams.new()
OverlayParams.FilterType = Enum.RaycastFilterType.Exclude
OverlayParams.RespectCanCollide = false
OverlayParams.FilterDescendantsInstances = {Character}

local ReturnRoot = function(c)
	return c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso") or c:FindFirstChild("Head") or c.PrimaryPart
end

local FWait = function(t)
	if t then
		local stop = osclock()+t
		while osclock()<=stop do
			Heartbeat:Wait()
		end
		return osclock()-stop
	else
		return Heartbeat:Wait()
	end
end

local RWait = function(t)
	if t then
		local stop = osclock()+t
		while osclock()<=stop do
			PreRender:Wait()
		end
		return osclock()-stop
	else
		return PreRender:Wait()
	end
end

local lastsync = current
local IsRightTime = function(ContinueTime)
	if ContinueTime then
		local Now = osclock()
		if Now - lastsync >= ContinueTime / 2 then
			lastsync = Now
			return true
		else
			return false
		end
	end
	return false
end

if Character:FindFirstChild("Animate") then
	Character.Animate:Destroy()
end
if Humanoid:FindFirstChildOfClass("Animator") then
	Humanoid:FindFirstChildOfClass("Animator"):Destroy()
end
for _,v in next,Character:GetDescendants() do
	if v:IsA("Motor6D") then
		v.Transform = CFrame.identity
	end
end

local NewSFX = function(ContentId, CFrame, Volume, Speed, TimePos)
	local SoundPart = NewInstance("Part", RootPart, {CFrame = CFrame or RootPart.CFrame, Size = Vector3.new(), CanCollide = false, Anchored = true, Transparency = 1, Massless = true, CanQuery = false, CanTouch = false, CastShadow = false})
	
	local Sound = New("Sound", SoundPart)
	Sound.SoundId = ContentId or ""
	Sound.Volume = Volume or 0.5
	Sound.PlaybackSpeed = Speed or 1
	Sound.TimePosition = TimePos or 0
	Sound.Playing = true
	
	Sound.Ended:Once(function() SoundPart:Destroy() end)
end

local NewHitmarker = function(ContentId, Volume)
	local Sound = New("Sound", Character)
	Sound.SoundId = ContentId or ""
	Sound.Volume = Volume or 0.5
	Sound.Playing = true
	
	Sound.Ended:Once(function() Sound:Destroy() end)
end

local TriggerLMS = function(Bool)
	if Bool == true then
		LMSActive = true
		if not LMS.IsPlaying then
			LMS.SoundId = HacklordInfo.Themes.LMS
			LMS.Volume = 4.5
			LMS.TimePosition = 0
			LMS.Looped = true
			LMS.Playing = true
		end
	else
		LMSActive = false
		LMS.Playing = false
	end
end

local IndicateDamage = function(Humanoid, Value)
	if not Humanoid then return end
	if not Settings.Hitmarker then return end
	
	local c = Humanoid.Parent
	local Root = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso") or c:FindFirstChild("Head") or c.PrimaryPart
	if HitmarkerUI and RootPart then
		local Part = NewInstance("Part", RootPart, {CFrame = Root.CFrame*CFrame.new(math.random(-2,2),math.random(-2,2),math.random(-2,2)), Size = Vector3.new(1,1,1), CanCollide = false, Anchored = true, Transparency = 1, Massless = true, CanQuery = false, CanTouch = false, CastShadow = false})
		local HitmarkerUI = HitmarkerUI:Clone()
		local Title = HitmarkerUI.Title
		HitmarkerUI.Adornee = Part
		HitmarkerUI.Parent = Part
		
		local Size = HitmarkerUI.Size + UDim2.fromScale(2,2)
		Title.Text = math.round(Value * 100) / 100
		
		TweenService:Create(HitmarkerUI,TweenInfo.new(0.25),{Size=Size}):Play()
		FWait(1)
		AddDebris(Part,1.5)
		TweenService:Create(Title,TweenInfo.new(1.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{TextTransparency=1}):Play()
		TweenService:Create(Title.UIStroke,TweenInfo.new(1.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Transparency=1}):Play()
	end
end

local InitHealthSystem = function(Humanoid)
	local HealthInstance = Humanoid:FindFirstChild("HacklordingIt_Health")
	if HealthInstance then
		if HealthInstance.Value == 0 then
			HealthInstance.Value = 100
		end
		return HealthInstance, HealthInstance.Value
	else
		local CurrentHealth = math.min(Humanoid.Health,100)
		HealthInstance = NewInstance("NumberValue",Humanoid,{Name="HacklordingIt_Health",Value=CurrentHealth})
		return HealthInstance, CurrentHealth
	end
end
local Damage = function(Humanoid, Value, OnDeathFunction)
	if typeof(Humanoid)=="Instance" then
		local HealthInstance, Health = InitHealthSystem(Humanoid)
		local CurrentHealth = math.max(Health-Value,0)
		local DamageDealt = Health - CurrentHealth
		if OnDeathFunction then
			if CurrentHealth == 0 then
				task.spawn(OnDeathFunction, Humanoid)
				HealthInstance.Value = 0
				if Humanoid:FindFirstChild("HacklordAllies") then
					SpeedStackLevel.Value += 1
					SpeedEffectEndTime = osclock() + 6
				end
			else
				HealthInstance.Value = CurrentHealth
				NewHitmarker("rbxassetid://1129547534", 2.5)
				task.spawn(IndicateDamage, Humanoid, DamageDealt)
			end
		else
			if CurrentHealth == 0 then
				HealthInstance.Value = 0
				NewHitmarker("rbxassetid://1129547534", 2.5)
				task.spawn(IndicateDamage, Humanoid, DamageDealt)
				if Humanoid:FindFirstChild("HacklordAllies") then
					SpeedStackLevel.Value += 1
					SpeedEffectEndTime = osclock() + 6
				end
			else
				HealthInstance.Value = CurrentHealth
				NewHitmarker("rbxassetid://1129547534", 2.5)
				task.spawn(IndicateDamage, Humanoid, DamageDealt)
			end
		end
	end
end

local VisualHitbox = function(Origin, RangeOrVector)
	if not Settings.VisibleHitbox then return nil end
	
	if typeof(RangeOrVector) == "Vector3" then
		local HB = NewInstance("Part",HitboxFolder,{Name="VisualHitbox_Debug",Anchored=true,CanCollide=false,CanTouch=false,CanQuery=false,Massless=true,CastShadow=false,Size=RangeOrVector,CFrame=Origin,Transparency=0.5,Color=Color3.new(1,0,0),Material="ForceField"})
		AddDebris(HB, 0.3)
		return HB
	elseif typeof(RangeOrVector) == "number" then
		local HB = NewInstance("Part",HitboxFolder,{Name="VisualHitbox_Debug",Anchored=true,CanCollide=false,CanTouch=false,CanQuery=false,Massless=true,CastShadow=false,Size=Vector3.new(RangeOrVector,RangeOrVector,RangeOrVector)*2,CFrame=Origin,Transparency=0.5,Color=Color3.new(1,0,0),Material="ForceField"})
		AddDebris(HB, 0.3)
		return HB
	end
end

local DamageFromHitbox = function(ScanCount, WaitEachScan, From, Offset, Size, Value, StopAfterHit, HitOneTargetOnly, OnDeathFunction)
	if not From then return end
	local Humanoids = {}
	
	local Stop = false
	local StopEntirely = false
	Offset = Offset or CFrame.identity
	local HB = NewInstance("Part",RootPart,{Name="Hitbox",Anchored=true,CanCollide=false,CanTouch=false,CanQuery=false,Massless=true,CastShadow=false,Size=Size,Transparency=1})
	
	task.spawn(function()
		for _ = 1, ScanCount or 1 do
			if Stop then if HB then HB:Destroy() end break end
			if Stop then return end
			
			local Origin = From.CFrame * Offset
			HB.CFrame = Origin
			
			local Parts = Workspace:GetPartsInPart(HB, OverlayParams)
			local VisualHB = VisualHitbox(Origin, Size)
		
			for _, Part in next, Parts do
				if StopEntirely then break end
				if StopEntirely then return end
				
				local Model = Part.Parent
				if Model:IsA("Model") then
					local Humanoid = Model:FindFirstChildOfClass("Humanoid")
					local HealthInstance, Health = InitHealthSystem(Humanoid)
					if Humanoid and Health~=0 and not table.find(Humanoids, Humanoid) then
						table.insert(Humanoids, Humanoid)
						Damage(Humanoid, Value, OnDeathFunction)
						if VisualHB then VisualHB.Color = Color3.new(0,0.8,0) end
						if HitOneTargetOnly then StopEntirely = true; Stop = true end
						if StopAfterHit then Stop = true end
					end
				end
			end
			RWait(WaitEachScan or 0.1)
		end
		if HB then HB:Destroy() end
	end)
	
	return function()
		Stop = true
	end
end

local BaseIdle = AnimationTracks["Idle"]
local BaseWalk = AnimationTracks["Walk"]
local BaseRun = AnimationTracks["Run"]
local BaseSlash = AnimationTracks["Slash"]
local Introduction = AnimationTracks["Introduction"]
local Execution = AnimationTracks["ExecutionKillerRig"]

local BaseEntanglement = AnimationTracks["Entanglement"]
local BaseMassInfection = AnimationTracks["MassInfection"]
local BaseUnstableEye = AnimationTracks["UnstableEye"]
local BaseRejuvenateTheRotten = AnimationTracks["RejuvenateTheRotten"]

BaseIdle.Priority = Enum.AnimationPriority.Idle
BaseWalk.Priority = Enum.AnimationPriority.Movement
BaseRun.Priority = Enum.AnimationPriority.Movement
BaseSlash.Priority = Enum.AnimationPriority.Action
BaseEntanglement.Priority = Enum.AnimationPriority.Action2
BaseMassInfection.Priority = Enum.AnimationPriority.Action2
BaseUnstableEye.Priority = Enum.AnimationPriority.Action2
BaseRejuvenateTheRotten.Priority = Enum.AnimationPriority.Action2
Introduction.Priority = Enum.AnimationPriority.Action3
Execution.Priority = Enum.AnimationPriority.Action3

local ApplyRagdoll = function(Character)
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		for _,v in next, Character:GetDescendants() do
			if v:IsA("Motor6D") then
				local Part0, Part1 = v.Part0, v.Part1
				if Part0 and Part1 then
					local Att0 = NewInstance("Attachment",Part0,{CFrame=v.C0})
					local Att1 = NewInstance("Attachment",Part1,{CFrame=v.C1})
					local BallSocketConstraint = NewInstance("BallSocketConstraint",Character,{Attachment0=Att0,Attachment1=Att1,LimitsEnabled=true,TwistLimitsEnabled=true,UpperAngle=90,TwistLowerAngle=-45,TwistUpperAngle=45})
					v.Enabled = false
				end
			elseif v:IsA("BasePart") then
				v.CanCollide = false
				v.Anchored = false
				v.Massless = false
			end
		end
	end
end

local ApplyAI = function(Model)
	local Humanoid = Model:FindFirstChildOfClass("Humanoid")
	local RootPart = Model:FindFirstChild("HumanoidRootPart")
	local MaxDistance = HacklordInfo.ZombieTargetRange
	local LoseFocusRange = HacklordInfo.ZombieLoseFocusRange
	local LifeTime = HacklordInfo.ZombieLifeTime
	local AttackRange = HacklordInfo.ZombieAttackRange
	local AttackCooldown = HacklordInfo.ZombieAttackCooldown
	local AttackDamage = HacklordInfo.ZombieAttackDamage
	
	if Humanoid then
		local Descendants = Model:GetDescendants()
		
		local HealthInstance = InitHealthSystem(Humanoid)
		
		NewInstance("StringValue",Humanoid,{Name="HacklordAllies"})
		
		local AAnimator = AnimationModule.new(Humanoid)
		local Idle = AAnimator:LoadAnimation(HacklordInfo.SavedAnimations["ZombieIdle"])
		local Walk = AAnimator:LoadAnimation(HacklordInfo.SavedAnimations["ZombieWalk"])
		local Run = AAnimator:LoadAnimation(HacklordInfo.SavedAnimations["ZombieRun"])
		local Attack = AAnimator:LoadAnimation(HacklordInfo.SavedAnimations["ZombieAttack"])
		local Summon = AAnimator:LoadAnimation(HacklordInfo.SavedAnimations["ZombieSummon"])
		
		Idle.Priority = Enum.AnimationPriority.Movement
		Walk.Priority = Enum.AnimationPriority.Movement
		Run.Priority = Enum.AnimationPriority.Movement
		Attack.Priority = Enum.AnimationPriority.Action
		Summon.Priority = Enum.AnimationPriority.Action2
		
		Summon:Play(1,10)
		Summon.Ended:Wait()
		Summon:Stop(1)
		
		local Distance = 9e9
		local Wander = true
		local Chasing = false
		local TargetRoot, TargetPosition = nil, RootPart.Position
		local ReturnNearestTarget = function()
			for _,v in next,RootParts do
				if typeof(v)=="Instance" and v:IsDescendantOf(Workspace) then
					local Pos = v.Position
					local CurrentDistance = (Pos-RootPart.Position).Magnitude
					if CurrentDistance < Distance then
						Distance = CurrentDistance
						TargetRoot = v
					end
				end
			end
			if Distance <= MaxDistance then
				if TargetRoot then
					TargetPosition = TargetRoot.Position
					Wander = false
					Chasing = true
				end
			elseif Distance > LoseFocusRange then
				Wander = true
				Chasing = false
			end
		end
		
		HealthInstance:GetPropertyChangedSignal("Value"):Connect(function()
			if Humanoid then
				Humanoid.Health = 0
			end
		end)
		
		local End = function()
			for _,v in next,Descendants do
				local IsBasePart, IsDecal = v:IsA("BasePart"), v:IsA("Decal")
				if IsBasePart or IsDecal then
					if v.Transparency ~= 1 then
						TweenService:Create(v,TweenInfo.new(0.3),{Transparency=1}):Play()
					end
				end
			end
			FWait(0.3)
			Model:Destroy()
			if AAnimator and not AAnimator._destroyed then AAnimator:Destroy() end
		end
		
		local Con
		local timecheck, timecheck2, cooldownasync = 0, 0, AttackCooldown
		Con = PreRender:Connect(function(deltatime)
			if PauseEverything then return end
			if StopEverything then
				if AAnimator and not AAnimator._destroyed then AAnimator:Destroy() end
				Con:Disconnect()
			end
			cooldownasync += deltatime
			timecheck += deltatime
			if timecheck > 0.1 then
				timecheck = 0
				ReturnNearestTarget()
			end
			
			if Distance <= AttackRange then
				if cooldownasync > AttackCooldown then
					Attack:Play(1,10)
					cooldownasync = 0
					local Model = TargetRoot.Parent
					if typeof(Model)=="Instance" then
						local Humanoid = Model:FindFirstChildOfClass("Humanoid")
						if Humanoid then
							Damage(Humanoid, AttackDamage)
						end
					end
				end
			end
			
			local MoveMagnitude = (RootPart.Velocity*Vector3.new(1,0,1)).Magnitude
			if MoveMagnitude > HacklordInfo.ZombieWalkSpeed / 2 then
				if Chasing then
					if not Run.IsPlaying then
						Run:Play(1,10)
						Idle:Stop(1)
						Walk:Stop(1)
					end
				else
					if not Walk.IsPlaying then
						Walk:Play(1,10)
						Idle:Stop(1)
						Run:Stop(1)
					end
				end
			else
				if not Idle.IsPlaying then
					Idle:Play(1,10)
					Walk:Stop(1)
					Run:Stop(1)
				end
			end
			
			if Wander then
				Humanoid.WalkSpeed = HacklordInfo.ZombieWalkSpeed
				timecheck2 += deltatime
				if timecheck2 > 2.5 then
					timecheck2 = 0
					Humanoid:MoveTo(RootPart.Position+Vector3.new(math.random(-20,20),0,math.random(-20,20)))
				end
			else
				Humanoid.WalkSpeed = HacklordInfo.ZombieSprintSpeed
				Humanoid:MoveTo(TargetPosition)
			end
		end)
		Humanoid.Died:Once(function()
			if Con then Con:Disconnect() end
			if Model then task.spawn(End) end
		end)
		task.spawn(function()
			local stop = osclock()+LifeTime
			while osclock()<=stop do
				if not Model then
					break
				end
				Heartbeat:Wait()
			end
			if Model then End() end
			if Con then Con:Disconnect() end
		end)
	end
end

local Sprinting = function()
	IsSprinting = not IsSprinting
end

local Shiftlock = function()
	if ShiftlockOn == nil then return end
	ShiftlockOn = not ShiftlockOn
end

local Introduction = function()
	if StopEverything or debouche then return end
	
	HeadLook = false
	debouchepriority = 2
	debouche = true
	Introduction:Play(1,10)
	Introduction.Speed = 0.65
	Introduction.TimePosition = 3.2
	FWait(2.676)
	debouchepriority = 1
	debouche = false
	HeadLook = true
end

local Slash = function()
	if StopEverything or debouche then return end
	local isExecuting = false
	
	local AttackFunc = function()
		FWait(0.4)
		
		DamageFromHitbox(10, 0.02, RootPart, CFrame.new(0,0,-3-3*RunMagnitude), Vector3.new(6,5.75,7.5), HacklordInfo.SlashDamage, true, false, function(Hum)
			if Hum:FindFirstChild("HacklordIsHere") or Hum:FindFirstChild("HacklordAllies") then
				return
			end
			
			local ExecuteDamage = HacklordInfo.ExecutionDamage
			
			local SavedShiftlockOn = ShiftlockOn
			ShiftlockOn = nil
			debouchepriority = 999
			isExecuting = true
			
			local RealCharacter = Hum.Parent
			local RealRoot = ReturnRoot(RealCharacter)
			local LastParent = RealCharacter.Parent
			Hum.BreakJointsOnDeath = false
			
			local FakeCharacter = Players:CreateHumanoidModelFromDescription(Hum:GetAppliedDescription(),Enum.HumanoidRigType.R6)
			local Root = ReturnRoot(FakeCharacter)
			local Huma = FakeCharacter:FindFirstChildOfClass("Humanoid")
			local Children = FakeCharacter:GetChildren()
			
			NewInstance("StringValue",Huma,{Name="HacklordIsHere"})
			Huma.BreakJointsOnDeath = false
			Huma.Health = 0
			
			Root.CFrame = RootPart.CFrame
			
			local Animator = AnimationModule.new(Huma)
			local Executed = Animator:LoadAnimation(HacklordInfo.SavedAnimations["ExecutionVictimRig"])
			
			local ZePlayer = Players:FindFirstChild(RealCharacter.Name)
			if ZePlayer then
				FakeCharacter.Name = ZePlayer.DisplayName
			else
				FakeCharacter.Name = RealCharacter.Name
			end
			FakeCharacter.Parent = VictimFolder
			
			local Con
			Con = Heartbeat:Connect(function()
			for _,v in next,Children do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
				Root.CFrame = RootPart.CFrame
			end)
			
			local OnExecute = function()
				FWait(0.75)
				DamageFromHitbox(1, 0, RootPart, CFrame.new(0,0,-4), Vector3.new(6.6,5.5,8), ExecuteDamage)
				FWait(0.65)
				DamageFromHitbox(1, 0, RootPart, CFrame.new(0,0,-4), Vector3.new(6.6,5.5,8), ExecuteDamage)
				FWait(0.65)
				DamageFromHitbox(1, 0, RootPart, CFrame.new(0,0,-4), Vector3.new(6.6,5.5,8), ExecuteDamage)
			end
			
			Executed:Play(1,10)
			Execution:Play(1,10)
			NewSFX(HacklordInfo.Sounds.Execution, RootPart.CFrame, 4, 1)
			task.spawn(OnExecute)
			FWait(2)
			Executed:Stop()
			FWait(0.15)
			ApplyRagdoll(FakeCharacter)
			Root.AssemblyLinearVelocity = Vector3.new(100,0,0)
			Animator:Destroy()
			Con:Disconnect()
			ShiftlockOn = SavedShiftlockOn
			debouchepriority = 0
			debouche = false
			task.spawn(function()
				FWait(RespawnTime)
				FakeCharacter:Destroy()
			end)
		end)
	end
	
	debouchepriority = 1
	debouche = true
	HacklordInfo.SwordTrail.Enabled = true
	BaseSlash:Play(1,10)
	NewSFX(HacklordInfo.Sounds.Swing, RootPart.CFrame, 4, 1)
	task.spawn(AttackFunc)
	BaseSlash.Ended:Wait()
	if not isExecuting then debouche = false HacklordInfo.SwordTrail.Enabled = false end
end

local Entanglement = function()
	if StopEverything or debouche then return end
	
	local AttackFunc = function()
		FWait(0.48)
		local CF = RootPart.CFrame * CFrame.new(0,0,-5)
		local deltaRadius = 0
		local Speed = HacklordInfo.EntanglementSpeed
		local LifeTime = HacklordInfo.EntanglementLifetime
		local EntanglementDamage = HacklordInfo.EntanglementDamage
		
		NewSFX(HacklordInfo.Sounds.Entanglement, CF, 2.5, 0.75)
		
		local Swords = HacklordInfo.SwordsTemplate:Clone()
		local Core = Swords.Core
		Core.Anchored = true
		Core.CFrame = CF
		
		local StopFunc = DamageFromHitbox(2500, 0.01, Core, nil, Core.Size+Vector3.new(2.5,0,5), EntanglementDamage)
		
		Swords.Parent = FolderStorage
		table.insert(CleanUp,Swords)
		
		local stop = osclock()+LifeTime
		while osclock()<=stop do
			deltaRadius += (deltatime * Speed)
			Core.CFrame = CF * CFrame.new(0,0,-deltaRadius)
			Heartbeat:Wait()
		end
		StopFunc()
		Swords:Destroy()
	end
	
	debouchepriority = 2
	debouche = true
	BaseEntanglement:Play(1,10,1.2)
	NewSFX(HacklordInfo.Sounds.EntanglementThrow, CF, 2.5, 0.735)
	task.spawn(AttackFunc)
	BaseEntanglement.Ended:Wait()
	debouchepriority = 1
	debouche = false
end

local MassInfection = function()
	if StopEverything or debouche then return end
	
	local AttackFunc = function()
		FWait(1.65)
		
		local CF = RootPart.CFrame * CFrame.new(0,0,-12)
		local deltaRadius = 0
		local Speed = HacklordInfo.MassInfectionShockwaveSpeed
		local LifeTime = HacklordInfo.MassInfectionShockwaveLifetime
		local ShockwaveDamage = HacklordInfo.MassInfectionShockwaveDamage
		local SlashDamage = HacklordInfo.MassInfectionSlashDamage
		local CloseUpSlashDamage = HacklordInfo.MassInfectionCloseSlashDamage
		
		NewSFX(HacklordInfo.Sounds.EntanglementThrow, CF, 2.5, 1)
		
		local Shockwave = HacklordInfo.ShockwaveTemplate:Clone()
		local Root = Shockwave.Root
		Root.Anchored = true
		Root.CFrame = CF
		
		Shockwave.Parent = FolderStorage
		table.insert(CleanUp,Shockwave)
		
		DamageFromHitbox(1, 0.035, RootPart, CFrame.new(0,0,-3.5), Vector3.new(10,5.5,10), SlashDamage)
		DamageFromHitbox(1, 0.035, RootPart, CFrame.new(0,0,-3), Vector3.new(8,4,8), CloseUpSlashDamage)
		
		local StopFunc = DamageFromHitbox(2500, 0.01, Root, nil, Root.Size+Vector3.new(0,0,10), ShockwaveDamage)
		
		local stop = osclock()+LifeTime
		while osclock()<=stop do
			deltaRadius += (deltatime * Speed)
			Root.CFrame = CF * CFrame.new(0,0,-deltaRadius)
			Heartbeat:Wait()
		end
		StopFunc()
		Shockwave:Destroy()
	end
	
	debouchepriority = 2
	debouche = true
	HacklordInfo.SwordTrail.Enabled = true
	BaseMassInfection:Play(1,10)
	NewSFX(HacklordInfo.Sounds.MassInfection, RootPart.CFrame, 10, 0.9)
	NewSFX(HacklordInfo.Sounds.Rejuvenate, RootPart.CFrame, 3.5, 1)
	task.spawn(AttackFunc)
	BaseMassInfection.Ended:Wait()
	HacklordInfo.SwordTrail.Enabled = false
	debouchepriority = 1
	debouche = false
end

local UnstableEye = function()
	if StopEverything or debouche then return end
	if UnstableEyeEffectActive then return end
	
	local AttackFunc = function()
		UnstableEyeEffectActive = true
		SpeedEffectEndTime = osclock() + 6
		SpeedStackLevel.Value = 1
		FWait(0.75)
		XRay.Enabled = true
		BlurEffect.Enabled = true
		TweenService:Create(XRay,TweenInfo.new(1),{FillTransparency=HacklordInfo.TargetHighlightProperties.FillTransparency,OutlineTransparency=HacklordInfo.TargetHighlightProperties.OutlineTransparency}):Play()
		TweenService:Create(BlurEffect,TweenInfo.new(1),{Size=30}):Play()
		FWait(6)
		TweenService:Create(XRay,TweenInfo.new(1),{FillTransparency=1,OutlineTransparency=1}):Play()
		TweenService:Create(BlurEffect,TweenInfo.new(1),{Size=0}):Play()
		FWait(1)
		XRay.Enabled = false
		BlurEffect.Enabled = false
		UnstableEyeEffectActive = false
	end
	
	debouchepriority = 2
	debouche = true
	BaseUnstableEye:Play(1,10)
	NewSFX(HacklordInfo.Sounds.UnstableEye, CF, 2.5, 1)
	task.spawn(AttackFunc)
	BaseUnstableEye.Ended:Wait()
	debouchepriority = 1
	debouche = false
end

local RejuvenateTheRotten = function()
	if StopEverything or debouche then return end
	
	local AttackFunc = function()
		FWait(2.2)
		local StartPos = RootPart.Position + Vector3.new(0,500,0)
		for i = 1, 5 do
			local CastResult = Workspace:Raycast(StartPos+Vector3.new(math.random(-65,65),0,math.random(-65,65)), -Vector3.new(0,600,0), RayParams)
			if CastResult then
				local ClonedZombie = Zombie.Zombie:Clone()
				ClonedZombie:WaitForChild("HumanoidRootPart",9e9).Velocity = Vector3.zero
				ClonedZombie:PivotTo(CFrame.new(CastResult.Position+Vector3.new(0,3,0)))
				task.spawn(ApplyAI, ClonedZombie)
				
				ClonedZombie.Parent = AllyFolder
				table.insert(CleanUp,ClonedZombie)
			end
		end
	end
	
	debouchepriority = 2
	debouche = true
	HacklordInfo.SwordTrail.Enabled = true
	BaseRejuvenateTheRotten:Play(1,10)
	NewSFX(HacklordInfo.Sounds.Rejuvenate, RootPart.CFrame, 4.5, 1)
	task.spawn(AttackFunc)
	BaseRejuvenateTheRotten.Ended:Wait()
	HacklordInfo.SwordTrail.Enabled = false
	debouchepriority = 1
	debouche = false
end

Device.Value = UserInputService.KeyboardEnabled and "PC" or "Mobile"

--GUI
local ScreenGui = NewInstance("ScreenGui",LocalPlayer.PlayerGui,{Name="nnb type gui lol also ts made by epic"})

local MassInfectionButton = NewInstance("ImageButton",ScreenGui,{Size=UDim2.fromOffset(65,65),Position=UDim2.new(1,-90,1,-160),ImageColor3=Color3.new(1,1,1),Image="rbxassetid://112065267803856",BackgroundTransparency=1,Active=true})
local EntanglementButton = NewInstance("ImageButton",ScreenGui,{Size=UDim2.fromOffset(65,65),Position=UDim2.new(1,-90,1,-230),ImageColor3=Color3.new(1,1,1),Image="rbxassetid://119069138923680",BackgroundTransparency=1,Active=true})
local UnstableEyeButton = NewInstance("ImageButton",ScreenGui,{Size=UDim2.fromOffset(65,65),Position=UDim2.new(1,-90,1,-300),ImageColor3=Color3.new(1,1,1),Image="rbxassetid://135373963092918",BackgroundTransparency=1,Active=true})
local RejuvenateTheRottenButtton = NewInstance("ImageButton",ScreenGui,{Size=UDim2.fromOffset(65,65),Position=UDim2.new(1,-90,1,-370),ImageColor3=Color3.new(1,1,1),Image="rbxassetid://102037518703784",BackgroundTransparency=1,Active=true})
local SlashButton = NewInstance("ImageButton",ScreenGui,{Size=UDim2.fromOffset(65,65),Position=UDim2.new(1,-165,1,-85),ImageColor3=Color3.new(1,1,1),Image="rbxassetid://120590195585579",BackgroundTransparency=1,Active=true})
local SprintingButton = NewInstance("ImageButton",ScreenGui,{Size=UDim2.fromOffset(65,65),Position=UDim2.new(1,-235,1,-85),ImageColor3=Color3.new(1,1,1),Image="rbxassetid://132640025048316",BackgroundTransparency=1,Active=true})
local ShiftlockButton = NewInstance("ImageButton",ScreenGui,{Size=UDim2.fromOffset(65,65),Position=UDim2.new(1,-165,1,-160),ImageColor3=Color3.new(1,1,1),Image="rbxassetid://77581797168866",BackgroundTransparency=1,Active=true})

NewInstance("TextLabel",SlashButton,{Text="Slash",Size=UDim2.fromScale(1,0.5),Position=UDim2.fromScale(0,0.65),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=20,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})
NewInstance("TextLabel",SlashButton,{Text="LMB",Size=UDim2.fromScale(1,0.25),Position=UDim2.fromScale(0,0),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=10,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})
NewInstance("TextLabel",MassInfectionButton,{Text="Mass Infection",Size=UDim2.fromScale(1,0.5),Position=UDim2.fromScale(0,0.65),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=14,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})
NewInstance("TextLabel",MassInfectionButton,{Text="Q",Size=UDim2.fromScale(1,0.25),Position=UDim2.fromScale(0,0),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=10,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})
NewInstance("TextLabel",EntanglementButton,{Text="Entanglement",Size=UDim2.fromScale(1,0.5),Position=UDim2.fromScale(0,0.65),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=16,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})
NewInstance("TextLabel",EntanglementButton,{Text="E",Size=UDim2.fromScale(1,0.25),Position=UDim2.fromScale(0,0),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=10,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})
NewInstance("TextLabel",UnstableEyeButton,{Text="Unstable Eye",Size=UDim2.fromScale(1,0.5),Position=UDim2.fromScale(0,0.65),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=15,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})
NewInstance("TextLabel",UnstableEyeButton,{Text="R",Size=UDim2.fromScale(1,0.25),Position=UDim2.fromScale(0,0),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=10,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})
NewInstance("TextLabel",RejuvenateTheRottenButtton,{Text="Rejuvenate The Rotten",Size=UDim2.fromScale(1,0.5),Position=UDim2.fromScale(0,0.65),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=10,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})
NewInstance("TextLabel",RejuvenateTheRottenButtton,{Text="T",Size=UDim2.fromScale(1,0.25),Position=UDim2.fromScale(0,0),TextColor3=Color3.new(1,1,1),TextStrokeColor3=Color3.new(0,0,0),TextSize=10,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),BackgroundTransparency=1,TextStrokeTransparency=0})

HitmarkerUI = NewInstance("BillboardGui",nil,{AlwaysOnTop=true,Size=UDim2.new(2,15,0.5,15)-UDim2.fromScale(2,2)})
local Title = NewInstance("TextLabel",HitmarkerUI,{Name="Title",Size=UDim2.fromScale(1,1),BackgroundTransparency=1,FontFace=Font.new("rbxasset://fonts/families/AccanthisADFStd.json",Enum.FontWeight.Bold),RichText=true,TextColor3=Color3.new(1,1,1),TextScaled=true})
NewInstance("UIStroke",Title,{Color=Color3.new(0,0,0)})

SprintingButton.MouseButton1Down:Connect(Sprinting)
SlashButton.MouseButton1Down:Connect(Slash)
MassInfectionButton.MouseButton1Down:Connect(MassInfection)
EntanglementButton.MouseButton1Down:Connect(Entanglement)
UnstableEyeButton.MouseButton1Down:Connect(UnstableEye)
RejuvenateTheRottenButtton.MouseButton1Down:Connect(RejuvenateTheRotten)
ShiftlockButton.MouseButton1Down:Connect(Shiftlock)

--Wrap it up

local HideTouchUI = function(Bool)
	ScreenGui.Enabled = Bool
end

table.insert(CleanUp, UserInputService.WindowFocusReleased:Connect(function()
	PauseEverything = true
end))

table.insert(CleanUp, UserInputService.WindowFocused:Connect(function()
	PauseEverything = false
end))

table.insert(CleanUp, UserInputService.InputBegan:Connect(function(Input, gp)
	if gp then return end
	
	local KeyCode, UserInputType = Input.KeyCode, Input.UserInputType
	if UserInputType == Enum.UserInputType.Keyboard then
		HideTouchUI(false)
		
		if KeyCode == Enum.KeyCode.LeftShift then
			Shiftlock()
		elseif KeyCode == Enum.KeyCode.RightShift then
			Sprinting()
		elseif KeyCode == Enum.KeyCode.LeftControl then
			Slash()
		elseif KeyCode == Enum.KeyCode.Q then
			MassInfection()
		elseif KeyCode == Enum.KeyCode.E then
			Entanglement()
		elseif KeyCode == Enum.KeyCode.R then
			UnstableEye()
		elseif KeyCode == Enum.KeyCode.T then
			RejuvenateTheRotten()
		elseif KeyCode == Enum.KeyCode.U then
			Introduction()
		elseif KeyCode == Enum.KeyCode.P then
			ForceTriggerLMS = not ForceTriggerLMS
			if ForceTriggerLMS then
				TriggerLMS(true)
			else
				TriggerLMS(false)
			end
		end
	elseif UserInputType == Enum.UserInputType.Touch then
		HideTouchUI(true)
	end
end))

BaseIdle:Play(1,10)
local Movements = function(Magnitude)
	if Magnitude==0 then
		State.Value = "Idle"
	else
		if debouchepriority >= 2 then
			State.Value = "Idle"
		else
			if IsSprinting then
				State.Value = "Sprint"
				BaseRun.Speed = RunMagnitude
			else
				State.Value = "Walk"
				BaseWalk.Speed = WalkMagnitude
			end
		end
	end
end

local CreateFakeRoot = function(part)
	if not part then return end
	local FakeRoot = NewInstance("Part",Highlights,{Size=part.Size/1.05,CFrame=part.CFrame,CanCollide=false,CanTouch=false,CanQuery=false,CastShadow=false})
	NewInstance("WeldConstraint",FakeRoot,{Part0=FakeRoot,Part1=part})
	part.Destroying:Once(function()
		FakeRoot:Destroy()
	end)
	return FakeRoot
end
local OnCharacter = function(v)
	local ThisPlayer = v
	local Clear = function(Character, RootPart, Cons)
		local getreal = table.find(RootParts, RootPart)
		if getreal then
			table.remove(RootParts, getreal)
			for _,v in next,Cons do if v then v:Disconnect() end end
			if Highlights:FindFirstChild(ThisPlayer.Name) then
				Highlights[ThisPlayer.Name]:Destroy()
			end
		end
	end
	if ThisPlayer and ThisPlayer~=LocalPlayer then
		local Character = ThisPlayer.Character
		if Character then
			local RootPart = ReturnRoot(Character)
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			CreateFakeRoot(RootPart).Name = ThisPlayer.Name
			table.insert(RootParts, RootPart)
			local LeaveConnect, DiedConnect
			if Humanoid then
				DiedConnect = Humanoid.Died:Connect(function()
					Clear(Character, RootPart, {LeaveConnect,DiedConnect})
				end)
			end
			LeaveConnect = Players.PlayerRemoving:Connect(function(plr)
				if plr==ThisPlayer then
					Clear(Character, RootPart, {LeaveConnect,DiedConnect})
				end
			end)
			table.insert(CleanUp, DiedConnect)
			table.insert(CleanUp, LeaveConnect)
		end
		table.insert(CleanUp, ThisPlayer:GetPropertyChangedSignal("Character"):Connect(function()
			local c = ThisPlayer.Character
			if c then
				PreRender:Wait()
				
				local RootPart = ReturnRoot(c) or c:WaitForChild("HumanoidRootPart")
				
				if RootPart then
					table.insert(RootParts, RootPart)
					CreateFakeRoot(RootPart).Name = ThisPlayer.Name
					
					local LeaveConnect, DiedConnect
					
					local Humanoid = c:FindFirstChildOfClass("Humanoid")
					if Humanoid then
						DiedConnect = Humanoid.Died:Connect(function()
							Clear(Character, RootPart, {LeaveConnect,DiedConnect})
						end)
						table.insert(CleanUp, DiedConnect)
					end
					LeaveConnect = Players.PlayerRemoving:Connect(function(plr)
						if plr==ThisPlayer then
							Clear(Character, RootPart, {LeaveConnect,DiedConnect})
						end
					end)
					table.insert(CleanUp, LeaveConnect)
				end
			end
		end)) 
	end
end

local PlayerCount = New("IntValue",Character)

table.insert(CleanUp, PlayerCount:GetPropertyChangedSignal("Value"):Connect(function()
	local PlayerCount = PlayerCount.Value
	if PlayerCount == 1 then
		TriggerLMS(true)
		if not LMS.IsPlaying then
			repeat LMS.Playing = true PreRender:Wait() until LMS.IsPlaying == true
			LMS.SoundId = HacklordInfo.Themes.LMS
			LMS.Volume = 0
			LMS.TimePosition = 0
			LMS.Playing = true
		end
	else
		TriggerLMS(false)
	end
end))

for _,v in next,Players:GetPlayers() do
	if v~=LocalPlayer then
		table.insert(PlayerTable,v)
		OnCharacter(v)
		PlayerCount.Value += 1
	end
end
table.insert(CleanUp, Players.PlayerAdded:Connect(function(v)
	table.insert(PlayerTable,v)
	OnCharacter(v)
	PlayerCount.Value += 1
end))
table.insert(CleanUp, Players.PlayerRemoving:Connect(function(v)
	if table.find(PlayerTable,v) then
		table.remove(PlayerTable,table.find(PlayerTable,v))
		PlayerCount.Value -= 1
	end
end))

table.insert(CleanUp, State:GetPropertyChangedSignal("Value"):Connect(function()
	local State = State.Value
	if State == "Idle" then
		if not BaseIdle.IsPlaying then
			BaseIdle:Play(1,10)
			BaseWalk:Stop(1)
			BaseRun:Stop(1)
		end
	elseif State == "Walk" then
		if not BaseWalk.IsPlaying then
			BaseWalk:Play(1,10)
			BaseIdle:Stop(1)
			BaseRun:Stop(1)
		end
	elseif State == "Sprint" then
		if not BaseRun.IsPlaying then
			BaseRun:Play(1,10)
			BaseIdle:Stop(1)
			BaseWalk:Stop(1)
		end
	end
end))

table.insert(CleanUp, Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	local CurrentCamera = Workspace.CurrentCamera
	if CurrentCamera then
		Camera = CurrentCamera
	end
end))

table.insert(CleanUp, Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
	local Health = Humanoid.Health
	if Health == 0 then
		for _,v in next,CleanUp do if v then if typeof(v)=="Instance" then v:Destroy() else v:Disconnect() end end end
		for _,v in next,Animators do v:Destroy() end
		StopEverything = true
	end
end))

table.insert(CleanUp, SpeedStackLevel:GetPropertyChangedSignal("Value"):Connect(function()
	local SpeedStackLevel = SpeedStackLevel.Value
	
	SpeedMultiply = 1 + 0.25 * SpeedStackLevel
end))

table.insert(CleanUp, Layer:GetPropertyChangedSignal("Value"):Connect(function()
	local Layer = Layer.Value
	
	if Layer == 1 then
		if TerrorTheme.SoundId ~= HacklordInfo.Themes.Layer1 then
			TerrorTheme.SoundId = HacklordInfo.Themes.Layer1
			TerrorTheme.Volume = 3.5
			TerrorTheme.TimePosition = 0.7
			TerrorTheme.Playing = true
		end
	elseif Layer == 2 then
		if TerrorTheme.SoundId ~= HacklordInfo.Themes.Layer2 then
			TerrorTheme.SoundId = HacklordInfo.Themes.Layer2
			TerrorTheme.Volume = 3.5
			TerrorTheme.TimePosition = 0
			TerrorTheme.Playing = true
		end
	elseif Layer == 3 then
		if TerrorTheme.SoundId ~= HacklordInfo.Themes.Layer3 then
			TerrorTheme.SoundId = HacklordInfo.Themes.Layer3
			TerrorTheme.Volume = 3.5
			TerrorTheme.TimePosition = 0
			TerrorTheme.Playing = true
		end
	elseif Layer == 4 then
		if TerrorTheme.SoundId ~= HacklordInfo.Themes.Layer4 then
			TerrorTheme.SoundId = HacklordInfo.Themes.Layer4
			TerrorTheme.Volume = 3.5
			TerrorTheme.TimePosition = 0
			TerrorTheme.Playing = true
		end
	end
end))

table.insert(CleanUp, Heartbeat:Connect(function()
	if PauseEverything then return end

	last = current
	current = osclock()
	deltatime = current-last
	
	local MoveDirection = Humanoid.MoveDirection
	DirectionMagnitude = MoveDirection.Magnitude
	
	local HeadPosition = Head.CFrame.Position
	local TorsoLookVector = Torso.CFrame.LookVector
	local Dist = (Head.CFrame.Position-Camera.CFrame.Position).Magnitude
	local Diff = Head.CFrame.Y-Camera.CFrame.Y
	
	if not debouche then
		Humanoid.WalkSpeed = CurrentSpeed
	else
		if debouchepriority == 2 then
			Humanoid.WalkSpeed = 1
		elseif debouchepriority >= 3 then
			Humanoid.WalkSpeed = 0
		end
	end
	
	if HeadLook == true then
		Neck.C1=Lerp(Neck.C1,CFrame.new(0,-0.5,0,-1,0,0,0,0,1,0,1,-0)*CFrame.fromEulerAngles((math.asin(Diff/Dist)*0.7),0,vector.cross(((Head.CFrame.Position-Camera.CFrame.Position).Unit),Torso.CFrame.LookVector).Y*0.8),0.05)
	else
		Neck.C1=Lerp(Neck.C1,CFrame.new(0,-0.5,0,-1,0,0,0,0,1,0,1,-0),0.05)
	end
	Movements(DirectionMagnitude)
end))

table.insert(CleanUp, PreRender:Connect(function()
	if PauseEverything then return end
	
	local LastDistance, Distance = 125, 125
	for _,v in next,RootParts do
		if typeof(v)=="Instance" and v:IsDescendantOf(Workspace) then
			local Pos = v.Position
			local RootDistance = LocalPlayer:DistanceFromCharacter(Pos)
			
			LastDistance = Distance
			if LastDistance > RootDistance then
				Distance = RootDistance
			end
		end
	end
	
	WalkMagnitude = (RootPart.Velocity*Vector3.new(1,0,1)).Magnitude/HacklordInfo.Speed
	RunMagnitude = (RootPart.Velocity*Vector3.new(1,0,1)).Magnitude/HacklordInfo.SprintSpeed
	
	if osclock()>SpeedEffectEndTime then
		SpeedStackLevel.Value = 0
	end
	
	if IsSprinting then
		CurrentSpeed = HacklordInfo.SprintSpeed * SpeedMultiply
	else
		CurrentSpeed = HacklordInfo.Speed * SpeedMultiply
	end
	
	if Distance < TerrorRange*0.3 then
		Layer.Value = 4
	elseif Distance < TerrorRange*0.6 then
		Layer.Value = 3
	elseif Distance < TerrorRange*0.8 then
		Layer.Value = 2
	elseif Distance <= TerrorRange then
		Layer.Value = 1
	elseif Distance > TerrorRange then
		Layer.Value = 0
	end
	
	if ShiftlockOn == true then
		if not RootPart.Anchored and Camera then
			if LocalPlayer:DistanceFromCharacter(Camera.CFrame.Position) > 1 then
				Humanoid.AutoRotate = false
				RootPart.CFrame = Lerp(RootPart.CFrame, CFrame.new(RootPart.Position,Vector3.new(Camera.CFrame.LookVector.X*900000,RootPart.Position.Y,Camera.CFrame.LookVector.Z*900000)), 0.25)
				Camera.CFrame = Camera.CFrame*CFrame.new(1.7,0,0)
				Camera.Focus = CFrame.fromMatrix(Camera.Focus.Position,Camera.CFrame.RightVector,Camera.CFrame.UpVector)*CFrame.new(1.7,0,0)
			else
				Humanoid.AutoRotate = true
			end
		else
			Humanoid.AutoRotate = true
		end
	else
		Humanoid.AutoRotate = true
	end
	
	if LMSActive or Layer.Value == 0 then
		TerrorTheme.Volume = NLerp(TerrorTheme.Volume,0,0.05)
	end
	
	if Humanoid.FloorMaterial.Name ~= "Air" and State.Value~="Idle" then
		if IsSprinting then
			if IsRightTime(1.5-math.min(RunMagnitude,1)) then
				NewSFX(HacklordInfo.Sounds.Footsteps[math.random(1,2)], RootPart.CFrame, 1.25)
			end
		else
			if IsRightTime(2.15-math.min(WalkMagnitude,1)) then
				NewSFX(HacklordInfo.Sounds.Footsteps[math.random(1,2)], RootPart.CFrame, 0.86)
			end
		end
	end

end))

