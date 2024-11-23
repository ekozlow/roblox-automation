-- Get the NPC model and HumanoidRootPart
local npc = script.Parent -- This assumes the script is attached to the NPC model. 'script.Parent' refers to the model containing this script.
local humanoidRootPart = npc:WaitForChild("HumanoidRootPart") -- Wait until the HumanoidRootPart is available before continuing. This ensures the NPC has a HumanoidRootPart, which is essential for manipulating the NPC's position.

-- Speed of rotation in radians per loop iteration (5 degrees per iteration).
local rotationSpeed = math.rad(50) -- Converts 50 degrees to radians using math.rad() because rotations in Roblox are done in radians.

-- Ensure the HumanoidRootPart exists (check to prevent errors if something goes wrong)
if not humanoidRootPart then
	-- If the HumanoidRootPart is not found, print an error and stop the script
	print("Error: HumanoidRootPart not found!")
	return -- Stops the script if the HumanoidRootPart is not found, preventing further errors.
end

-- Print a message to indicate that the script is running and the NPC will start spinning.
print("Starting the NPC spinning loop...")

-- Main loop to continuously spin the NPC
while true do
	-- Get the current position and orientation of the HumanoidRootPart using its CFrame
	local currentCFrame = humanoidRootPart.CFrame -- CFrame is a data type in Roblox that combines position and rotation in 3D space.
	
	-- Apply the rotation to the Y-axis (up direction) by multiplying the current CFrame by a new CFrame with a rotation around the Y-axis.
	local newCFrame = currentCFrame * CFrame.Angles(0, rotationSpeed, 0) -- CFrame.Angles() creates a rotation. Here, we only rotate around the Y-axis (which is the vertical axis in Roblox).

	-- Set the new CFrame to the HumanoidRootPart to apply the rotation, which causes the NPC to spin around its Y-axis.
	humanoidRootPart.CFrame = newCFrame

	-- Debug output to show the current rotation angle of the NPC in degrees
	-- The LookVector is a unit vector representing the direction the NPC is facing, and we extract the Y component to find the rotation angle.
	local angle = math.deg(newCFrame.LookVector.Y) -- math.deg() converts the angle from radians to degrees for easier human interpretation.
	print("NPC Rotation Angle: " .. angle .. " degrees") -- Prints the current rotation angle of the NPC to the output for debugging.

	-- Wait for a short period to control the speed of the spin and prevent the loop from running too fast.
	-- This pause makes the NPC spin at a visible speed instead of instantly.
	wait(0.1) -- Wait 0.1 seconds (10 times per second) before updating the rotation again.
end
