# Roblox NPC Attack AI Script

## Overview

This script adds basic AI behavior to an NPC (Non-Player Character) in Roblox. The NPC automatically detects and attacks nearby players or other humanoid NPCs. The script features an attack system where the NPC moves towards the closest target and deals damage if within range, with an attack cooldown to prevent rapid spamming.

This script is useful for games where you want NPCs to behave dynamically and interact with players or other NPCs in a combat setting, such as in RPGs, action games, or games with enemies that need to attack.

---

## Features

- **Target Detection**: The NPC identifies the nearest player or humanoid NPC within a set range.
- **Attack Mechanism**: The NPC attacks its target if it is within a specified distance.
- **Damage System**: The NPC deals damage to the target when in range.
- **Cooldown**: The NPC has a cooldown to prevent it from attacking too frequently.
- **Movement**: The NPC moves toward its target to engage in combat.

---

## Script Breakdown

### Variables:
- **npc**: Refers to the NPC model that the script is attached to.
- **humanoid**: Refers to the Humanoid object inside the NPC, allowing the NPC to move.
- **attackRange**: Defines the maximum distance at which the NPC starts looking for targets (default 10).
- **attackCooldown**: Sets the time between consecutive attacks (default 1 second).
- **damageAmount**: The amount of damage dealt to the target when the NPC attacks (default 10).
- **lastAttackTime**: Keeps track of the time of the last attack to implement the cooldown system.

### Functions:

1. **findNearestTarget()**:
   - This function scans for players and other NPCs in the workspace.
   - It checks the distance from the NPC to each player and humanoid NPC.
   - The closest target within the attack range is selected.

2. **attackTarget(target)**:
   - Once a target is found, this function applies damage to the target.
   - It checks if the target has a `Humanoid` object and applies damage to it.

3. **Main AI Loop**:
   - The script continuously looks for the nearest target.
   - When a target is detected within the attack range, the NPC moves towards it.
   - If the NPC is close enough to the target (within 3 studs), it checks the cooldown and performs an attack.

   The loop runs every 0.5 seconds, ensuring the NPC keeps searching for targets and attacking when appropriate.

---

## How to Use

1. **Setup**: Place this script inside the NPC model in your game. The NPC model should contain a `Humanoid` and a `HumanoidRootPart`.
2. **Customization**: You can adjust the `attackRange`, `attackCooldown`, and `damageAmount` variables to fit your game’s needs.

---

## Ideas for Future Enhancements

1. **Target Priority**:
   - Implement a priority system for targeting. For example, the NPC could prioritize players over other NPCs or certain NPC types over others (e.g., healers or ranged units).

2. **Health Regeneration**:
   - Add health regeneration or healing mechanics for NPCs to make them more challenging or dynamic.

3. **Movement Pathfinding**:
   - Integrate Roblox's Pathfinding service to allow the NPC to navigate around obstacles when chasing a target instead of moving directly in a straight line.

4. **Attack Animations**:
   - Implement custom animations for the NPC’s attack actions to make the combat more immersive.

5. **Multiple Attack Types**:
   - Add different types of attacks (e.g., ranged, area of effect, special abilities) depending on the NPC's state or proximity to the target.

6. **Aggro System**:
   - Create an aggro system where the NPC switches targets if it takes damage or if the current target escapes.

7. **Sound Effects and Particle Effects**:
   - Add sound and visual effects when the NPC attacks or takes damage to improve feedback for players.

8. **Team-Based AI**:
   - Allow NPCs to work together in teams, attacking the same targets or protecting each other from players.
