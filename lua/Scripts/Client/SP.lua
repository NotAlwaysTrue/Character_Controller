LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.StatusEffect"],"user")
charLastControlled = nil
charCurrentControlling = nil
controlling = false
cd = 0

Hook.Add("roundEnd", "Drones.resetonend", function() --reset every controller on round end
    Character.Controlled = charLastControlled
end)

Hook.Add("Drone.control", "Drone.control", function(effect, deltaTime, item, targets, worldPosition)
    if targets == nil then return end
    local targetCharacter = targets[1]
    if targetCharacter == nil or targetCharacter.IsPlayer then return end
    if effect.type == ActionType.OnUse then
        local usingCharacter = effect.user
        charLastControlled = usingCharacter
        charCurrentControlling = targetCharacter
        controlling = true
        Character.Controlled = targetCharacter
    end
end)

Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function(character)  --F to Switch, cooldown for default 1s(1000ms) to avoid issue
    if not character then return end
    if charLastControlled == nil or charCurrentControlling == nil then return end
    if (charLastControlled.IsUnconscious or charCurrentControlling.IsUnconscious) and controlling then --Reset controller when controller or controlled is unconscious, only when controlling
        Character.Controlled = charLastControlled
        controlling = false
    end
    if PlayerInput.KeyDown(Keys.F) and cd == 0 and not (charLastControlled.IsUnconscious or charCurrentControlling.IsUnconscious) then
        if controlling then
            cd = 1
            Character.Controlled = charLastControlled
            Timer.Wait(function() controlling = false cd = 0 end, minSwitchtime)
        end
        if not controlling then
            cd = 1
            Character.Controlled = charCurrentControlling
            Timer.Wait(function() controlling = true cd = 0 end, minSwitchtime)
        end
    end
end, Hook.HookMethodType.After)

Hook.Add("character.death", "Drones.resetOndronesdead", function(character)  --Reset on death
    if character == nil or charCurrentControlling == nil or charLastControlled == nil then return end
    if character == charCurrentControlling then
        if not controlling then
            charCurrentControlling = nil
            controlling = false
            return
        end
        Character.Controlled = charLastControlled
        charCurrentControlling = nil
        controlling = false
    end
    if character == charLastControlled and controlling then  --Reset controller on controller death
        if not controlling then
            charCurrentControlling = nil
            charLastControllsed = nil
            controlling = false
            return
        end
        Character.Controlled = nil
        controlling = false
        charLastControllsed = nil
        charCurrentControlling = nil
    end
end)