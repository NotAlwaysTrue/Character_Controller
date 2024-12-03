function findcharacterbyID(id)
    local characterlist = Character.CharacterList
    for i,v in pairs(characterlist) do
        if tostring(v.ID) == id then
            return v
        end
    end
    return nil
end