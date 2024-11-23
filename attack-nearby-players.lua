-- Place this script inside the NPC model

local npc = script.Parent -- The NPC model
local humanoid = npc:FindFirstChild("Humanoid")
local attackRange = 10 -- Distance at which the NPC starts attacking players or other humanoids
local attackCooldown = 1 -- Time in seconds between attacks
local damageAmount = 10 -- Amount of damage dealt by the NPC
local lastAttackTime = 10

-- Function to detect the nearest target (player or humanoid)
function findNearestTarget()
	local closestTarget = nil
	local shortestDistance = attackRange

	-- Check players first
	for _, player in pairs(game.Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (npc.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
			if distance < shortestDistance then
				closestTarget = player
				shortestDistance = distance
			end
		end
	end

	-- Then check other NPCs with humanoids in the workspace (excluding self)
	for _, model in pairs(workspace:GetChildren()) do
		if model ~= npc and model:FindFirstChild("Humanoid") and model:FindFirstChild("HumanoidRootPart") then
			local distance = (npc.HumanoidRootPart.Position - model.HumanoidRootPart.Position).magnitude
			if distance < shortestDistance then
				closestTarget = model -- It's another NPC or humanoid model
				shortestDistance = distance
			end
		end
	end

	return closestTarget
end

-- Function to deal damage to the target (player or humanoid)
function attackTarget(target)
	local character = target.Character or target -- Check if it's a player or an NPC with a humanoid
	local targetHumanoid = character:FindFirstChild("Humanoid")

	if targetHumanoid then
		-- Apply damage
		targetHumanoid:TakeDamage(damageAmount)
	end
end

-- Main AI behavior loop
while true do
	local target = findNearestTarget() -- Find the closest player or humanoid

	if target then
		-- Move towards the target (player or humanoid NPC)
		local targetPosition = target:FindFirstChild("HumanoidRootPart") and target.HumanoidRootPart.Position or target.Position
		humanoid:MoveTo(targetPosition)

		-- Attack the target if close enough and on cooldown
		if (npc.HumanoidRootPart.Position - targetPosition).magnitude < 3 then
			-- Make sure the NPC doesn't attack too quickly (cooldown)
			if tick() - lastAttackTime > attackCooldown then
				attackTarget(target)
				lastAttackTime = tick() -- Update the last attack time
			end
		end
	end

	wait(0.5) -- Wait a bit before checking again
end
