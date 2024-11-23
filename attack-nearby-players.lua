-- Place this script inside the NPC model

-- Reference to the NPC model (the parent of this script)
local npc = script.Parent 

-- The humanoid object inside the NPC, which controls the NPC's health, movement, etc.
local humanoid = npc:FindFirstChild("Humanoid")

-- Distance at which the NPC starts attacking players or other humanoids (in studs)
local attackRange = 10 

-- Time in seconds between consecutive attacks to prevent spamming
local attackCooldown = 1 

-- Amount of damage dealt by the NPC to its target
local damageAmount = 10 

-- Stores the time of the last attack to handle cooldown
local lastAttackTime = 10

-- Function to detect the nearest target (player or humanoid NPC)
function findNearestTarget()
	-- Start with no target and set the shortest distance to the attack range
	local closestTarget = nil
	local shortestDistance = attackRange

	-- Loop through all players in the game
	for _, player in pairs(game.Players:GetPlayers()) do
		-- Ensure the player has a character and a "HumanoidRootPart" to calculate distance
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			-- Calculate the distance between the NPC and the player's HumanoidRootPart
			local distance = (npc.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
			-- If this player is within the attack range, update the closest target
			if distance < shortestDistance then
				closestTarget = player
				shortestDistance = distance
			end
		end
	end

	-- Now check all other NPCs in the game
	for _, model in pairs(workspace:GetChildren()) do
		-- Ensure the model is not the NPC itself, has a humanoid, and a "HumanoidRootPart"
		if model ~= npc and model:FindFirstChild("Humanoid") and model:FindFirstChild("HumanoidRootPart") then
			-- Calculate the distance between the NPC and another NPC or humanoid
			local distance = (npc.HumanoidRootPart.Position - model.HumanoidRootPart.Position).magnitude
			-- If this NPC or humanoid is within the attack range, update the closest target
			if distance < shortestDistance then
				closestTarget = model -- It's another NPC or humanoid model
				shortestDistance = distance
			end
		end
	end

	-- Return the closest target found (could be a player or an NPC)
	return closestTarget
end

-- Function to deal damage to the target (either a player or a humanoid NPC)
function attackTarget(target)
	-- Check if the target is a player or an NPC by accessing their "Character"
	local character = target.Character or target -- Handle NPCs without players
	-- Find the humanoid inside the character, which controls health, damage, etc.
	local targetHumanoid = character:FindFirstChild("Humanoid")

	-- If the target has a humanoid (meaning it can take damage), apply the damage
	if targetHumanoid then
		-- Apply damage using the TakeDamage function of the Humanoid
		targetHumanoid:TakeDamage(damageAmount)
	end
end

-- Main AI behavior loop that runs continuously
while true do
	-- Find the closest target (player or NPC)
	local target = findNearestTarget()

	-- If a target is found, move the NPC towards it
	if target then
		-- If the target has a "HumanoidRootPart" (player) or a position (NPC)
		local targetPosition = target:FindFirstChild("HumanoidRootPart") and target.HumanoidRootPart.Position or target.Position
		-- Move the NPC to the target's position using the humanoid's MoveTo function
		humanoid:MoveTo(targetPosition)

		-- Check if the NPC is close enough to attack the target (within 3 studs)
		if (npc.HumanoidRootPart.Position - targetPosition).magnitude < 3 then
			-- Make sure the NPC doesn't attack too quickly by checking the cooldown
			if tick() - lastAttackTime > attackCooldown then
				-- Attack the target if the cooldown has passed
				attackTarget(target)
				-- Update the last attack time with the current time
				lastAttackTime = tick()
			end
		end
	end

	-- Wait a small amount of time before checking again (prevents too frequent checks)
	wait(0.5)
end
