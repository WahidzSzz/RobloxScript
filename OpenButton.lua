local scren = Instance.new("ScreenGui")
local button = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local TextLabel = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")

--Properties:

scren.Name = "scren"
scren.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
scren.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

button.Name = "button"
button.Parent = scren
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.BorderColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 0
button.Position = UDim2.new(0.299180329, 0, 0.661478579, 0)
button.Size = UDim2.new(0, 55, 0, 55)
button.Font = Enum.Font.Unknown
button.Text = "OPEN"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 16.000
button.TextWrapped = true

UICorner.Parent = button

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(22, 22, 22)), ColorSequenceKeypoint.new(0.58, Color3.fromRGB(37, 37, 37)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(27, 27, 27))}
UIGradient.Rotation = 66
UIGradient.Parent = button

TextLabel.Parent = button
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Font = Enum.Font.Unknown
TextLabel.Text = "OPEN"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 16.000

UICorner_2.Parent = TextLabel

local function EODY_fake_script() -- button.LocalScript 
	local script = Instance.new('LocalScript', button)

	local UserInputService = game:GetService("UserInputService")
	local runService = (game:GetService("RunService"));
	local VirtualInputManager = game:GetService("VirtualInputManager")
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	function Lerp(a, b, m)
		return a + (b - a) * m
	end;
	
	local lastMousePos
	local lastGoalPos
	local DRAG_SPEED = (8); 
	function Update(dt)
		if not (startPos) then return end;
		if not (dragging) and (lastGoalPos) then
			gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
			return 
		end;
	
		local delta = (lastMousePos - UserInputService:GetMouseLocation())
		local xGoal = (startPos.X.Offset - delta.X);
		local yGoal = (startPos.Y.Offset - delta.Y);
		lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
		gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
	end;
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			lastMousePos = UserInputService:GetMouseLocation()
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	runService.Heartbeat:Connect(Update)
	
	gui.MouseButton1Click:Connect(function()
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
	end)
end
coroutine.wrap(EODY_fake_script)()
