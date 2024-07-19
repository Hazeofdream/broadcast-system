-- Define Fonts
surface.CreateFont("BroadcastHeader", {
	font = "CenterPrintText",
	size = 40,
	weight = 500,
	bold = true
})

surface.CreateFont("BroadcastText", {
	font = "ChatFont",
	size = 25,
	weight = 500,
})

-- Receive broadcast event
net.Receive("mayor_broadcast", function()
    local Message = net.ReadString()
	local Time = net.ReadFloat()

	local Length = string.len(Message)
	local BroadcastTime = 4

	if Length > 100 then
		BroadcastTime = 6
	end

	if Length > 200 then
		BroadcastTime = 8
	end

	hook.Add("HUDPaint", "mayor_broadcast_text_"..Time, function()
		local Width = 300
		local Height = 95

		draw.RoundedBox(20, ScrW() / 2 - (ScrW() / 2) + Width / 2, 17, ScrW() - Width, Height, Color(0, 0, 0, 100))

		draw.SimpleText("Mayor Broadcast:", "BroadcastHeader", ScrW() / 2, 40, Color(203, 25, 12), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(Message, "BroadcastText", ScrW() / 2, Height / 1.2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end)

	timer.Create("remove_broadcast_"..Time, BroadcastTime, 1, function()
		hook.Remove("HUDPaint", "mayor_broadcast_text_"..Time)
	end)
end)

-- Receive admin broadcast event
net.Receive("admin_broadcast", function()
    local Message = net.ReadString()
	local Time = net.ReadFloat()

	local Length = string.len(Message)
	local BroadcastTime = 4

	if Length > 100 then
		BroadcastTime = 6
	end

	if Length > 200 then
		BroadcastTime = 8
	end

	hook.Add("HUDPaint", "admin_broadcast_text_"..Time, function()
		local Width = 300
		local Height = 95

		draw.RoundedBox(20, ScrW() / 2 - (ScrW() / 2) + Width / 2, 17, ScrW() - Width, Height, Color(0, 0, 0, 100))

		draw.SimpleText("Listen Up:", "BroadcastHeader", ScrW() / 2, 40, Color(203, 25, 12), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(Message, "BroadcastText", ScrW() / 2, Height / 1.2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end)

	timer.Create("remove_broadcast_"..Time, BroadcastTime, 1, function()
		hook.Remove("HUDPaint", "admin_broadcast_text_"..Time)
	end)
end)

-- Developer Information

local BroadcastVersion = "1.0"

concommand.Add("broadcast_info", function()
	local InfoTable = {
		"https://steamcommunity.com/sharedfiles/filedetails/?id=3246928845 created by Haze_of_dream",
		"",
		"Contact at: ",
		"STEAM_0:1:75838598",
		"https:/steamcommunity.com/id/Haze_of_dream",
		"",
		string.format("Broadcast Version: %s", BroadcastVersion)
	}
	
	for _, msg in pairs(InfoTable) do
		print(msg)
	end
end)

--#NoSimplerr#