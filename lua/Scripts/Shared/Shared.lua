LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.StatusEffect"],"user")
Controllers = { }

Hook.Add("Drone.control", "Drone.control", function(effect, deltaTime, item, targets, worldPosition)
    if targets == nil then return end
    local targetCharacter = targets[1]
    if targetCharacter == nil or targetCharacter.IsPlayer then return end
    if effect.type == ActionType.OnUse then
        if SERVER then
            local usingCharacter = effect.user
            local usingclient = Util.FindClientCharacter(usingCharacter)
            if usingclient == nil then return end
            Controllers[usingclient] = usingCharacter
            usingclient.SetClientCharacter(targetCharacter)
            local message = Networking.Start("user")
            message.WriteString(tostring(usingCharacter.ID))
            Networking.Send(message, usingclient.Connection)
        end
        if CLIENT then
            charCurrentControlling = targetCharacter
            controlling = true
        end
    end
end)