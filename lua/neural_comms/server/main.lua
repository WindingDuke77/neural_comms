-- This Addon was created by:
-- Bob Bobington#2947
-- 
-- any questions, please contact me

ncomms = ncomms or {}
ncomms.config = ncomms.config or {}
local config = ncomms.config
 
-- Do not above this line.

timer.Simple(1, function ()
    for k, v in pairs(config.Comms) do
        if not v.aliases then continue end
        if not type(v.aliases) == "table" then continue end

        for k2, v2 in ipairs(v.aliases) do
            config.Comms[v2] = table.Copy(v)
            config.Comms[v2].aliases = nil
        end
    end
    
    for k, v in pairs(config.Comms) do
        if not v.aliases then continue end
        if not type(v.aliases) == "table" then continue end

        for k2, v2 in ipairs(v.aliases) do
            config.Comms[v2] = table.Copy(v)
            config.Comms[v2].aliases = nil
        end
    end
end)



hook.Add("PlayerSay", "ncomms_psay", function (ply, msg)
    local args = string.Split(msg, " ")
    if not config.prefix then return MsgC(Color(255,0,0), "[NCOMMS]: Config isnt loaded. Please Scroll up and check the errors") end
    args[1] = string.sub(args[1], #config.prefix + 1)
    args[1] = string.lower(args[1])
    local comms = config.Comms[args[1]]

    if not comms then return end

    if comms.customCheck and not comms.customCheck(ply) then return end

    local commsType = nil  

    if comms.differentComms then
        commsType = comms.differentComms[ply:Team()]

        if comms.differentComms[ply:Team()] == nil then
            return 
        end
    end
    
    local CommName = comms.name or args[1]
    CommName = string.upper(CommName)

    local author = ply
    
    if ncomms.MODULE then
        ncomms.MODULE:Log("{1} said {2} in {3}.", GAS.Logging:FormatPlayer(ply), GAS.Logging:Highlight(table.concat(args, " ", 2)), GAS.Logging:Highlight(CommName .. "_" .. (commsType or "default")))
    end

    ncomms.BroadCastComms(commsType, comms, author, args)

    return ""
end)