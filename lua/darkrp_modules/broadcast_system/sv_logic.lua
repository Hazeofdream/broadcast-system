util.AddNetworkString("mayor_broadcast")
util.AddNetworkString("admin_broadcast")

local function MayorBroadcast(ply, args)
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
        return ""
    end
    local Team = ply:Team()
    if not RPExtraTeams[Team] or not RPExtraTeams[Team].mayor then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("incorrect_job", DarkRP.getPhrase("broadcast")))
        return ""
    end
    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
            return
        end

        local col = team.GetColor(ply:Team())
        local col2 = Color(170, 0, 0, 255)
        local phrase = DarkRP.getPhrase("broadcast")
        local name = ply:Nick()
        for _, v in ipairs(player.GetAll()) do
            DarkRP.talkToPerson(v, col, phrase .. " " .. name, col2, text, ply)
        end

        net.Start("mayor_broadcast")
            net.WriteString(text)
            net.WriteFloat(CurTime())
        net.Broadcast()
    end
    return args, DoSay
end
DarkRP.defineChatCommand("broadcast", MayorBroadcast, 1.5)

local function AdminBroadcast(ply, args)
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
        return ""
    end
    local Team = ply:Team()
    if not ply:IsAdmin() or not ply:IsSuperAdmin() then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("incorrect_job", DarkRP.getPhrase("broadcast")))
        return ""
    end
    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
            return
        end

        net.Start("admin_broadcast")
            net.WriteString(text)
            net.WriteFloat(CurTime())
        net.Broadcast()
    end
    return args, DoSay
end
DarkRP.defineChatCommand("abroadcast", AdminBroadcast, 1.5)
DarkRP.defineChatCommand("adminbroadcast", AdminBroadcast, 1.5)

--#NoSimplerr#