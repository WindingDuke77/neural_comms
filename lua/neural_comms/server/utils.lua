ncomms = ncomms or {}
ncomms.config = ncomms.config or {}
local config = ncomms.config

function ncomms.notify(ply, msgtype, len, msg)
    if not istable(ply) then
        if not IsValid(ply) then
            return
        end

        ply = {ply}
    end

    local rcf = RecipientFilter()
    for _, v in pairs(ply) do
        rcf:AddPlayer(v)
    end

    umsg.Start("ncomms_Notify", rcf)
        umsg.String(msg)
        umsg.Short(msgtype)
        umsg.Long(len)
    umsg.End()
end

util.AddNetworkString("ncomms.ChatSend")

function ncomms.SendToClient(ply, Msg)
    if not IsValid(ply) then
        return
    end

    net.Start("ncomms.ChatSend")
        net.WriteTable(Msg)
    net.Send(ply)
end

local function sendMessage(ply, comms, author, args)
    if comms.fullcolor then
        ncomms.SendToClient(ply, {comms.color, "[", comms.name, "] ", comms.color, author:Nick(), ": ", table.concat(args, " ", 2)})
    else
        ncomms.SendToClient(ply, {comms.color, "[", comms.name, "] ", comms.color, author:Nick(), ": ", Color(255, 255, 255), table.concat(args, " ", 2)})
    end

end
    
function ncomms.BroadCastComms(commsType, comms, author, args)

    local CommName = comms.name or args[1]
    CommName = string.upper(CommName)

    for k, ply in ipairs(player.GetAll()) do
        if commsType then
            if (comms.customCheck and not comms.customCheck(ply)) or (comms.hearCheck and not comms.hearCheck(ply)) then continue end
            if comms.differentComms[ply:Team()] == commsType then
                --ncomms.SendToClient(ply, {comms.color, "[", CommName, "] ", comms.color, author:Nick(), ": ", Color(255, 255, 255), table.concat(args, " ", 2)})
                sendMessage(ply, comms, author, args)
            end
        else
            if (comms.customCheck and not comms.customCheck(ply)) or (comms.hearCheck and not comms.hearCheck(ply)) then continue end
            sendMessage(ply, comms, author, args)
        end
    end
end

