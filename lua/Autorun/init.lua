Drones = {}
Drones.Path = table.pack(...)[1]

if Game.IsMultiplayer then
	dofile(Drones.Path.."/lua/Scripts/Shared/Shared.lua")
end

if CLIENT and Game.IsMultiplayer then
	--dofile(Drones.Path.."/lua/Scripts/Client/HUD.lua")  --Unfinished GUI works
	dofile(Drones.Path.."/lua/Scripts/Client/Client.lua")
end

if SERVER and Game.IsMultiplayer then
	dofile(Drones.Path.."/lua/Scripts/Server/Server.lua")
end

if Game.IsSingleplayer then
	dofile(Drones.Path.."/lua/Scripts/Client/SP.lua")
	--dofile(Drones.Path.."/lua/Scripts/Client/HUD.lua")  --Unfinished GUI works
end