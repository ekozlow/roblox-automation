-- Get the NPC model and HumanoidRootPart
local npc = script.Parent -- This assumes the script is attached to the NPC model
local humanoidRootPart = npc:WaitForChild("HumanoidRootPart") -- Wait until the HumanoidRootPart is available
local rotationSpeed = math.rad(50) -- Speed of rotation in radians per loop iteration (5 degrees per iteration)

-- Ensure the HumanoidRootPart exists
if not humanoidRootPart then
	print("Error: HumanoidRootPart not found!")
	return
end

-- Print message to indicate the script is running
print("Starting the NPC spinning loop...")

-- Main loop to spin the NPC
while true do
	-- Calculate the new rotation around the Y-axis (up direction)
	local currentCFrame = humanoidRootPart.CFrame
	local newCFrame = currentCFrame * CFrame.Angles(0, rotationSpeed, 0) -- Apply the rotation to the Y-axis

	-- Apply the new CFrame to the HumanoidRootPart to make it spin
	humanoidRootPart.CFrame = newCFrame

	-- Debug output to show the current rotation angle (in degrees)
	local angle = math.deg(newCFrame.LookVector.Y)
	print("NPC Rotation Angle: " .. angle .. " degrees")

	wait(0.1) -- Wait for a short period to control the speed of the spin
end
