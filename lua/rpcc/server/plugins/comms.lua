local plugin = {}

plugin.name = "Comms"

ncomms = ncomms or {}
ncomms.config = ncomms.config or {}
local config = ncomms.config
ncomms.funcs = ncomms.funcs or {}
config.Comms = {}

function plugin.run(ply, commandObj, commsName, msg)

    local comms = config.Comms[commsName]

    if not comms then
        MsgC(Color(255, 0, 0), "[RPCC/NCOMMS] " ..  commandObj.key .. ": Comms not found!\n")
        return
    end

    -- if commsType then
    --     if comms.differentComms then
    --         MsgC(Color(255, 0, 0), "[RPCC/NCOMMS] " ..  commandObj.key .. ": Comms doesnt have Different Comms Channel!\n")
    --     end
    --     if not comms[commsType] then
    --         MsgC(Color(255, 0, 0), "[RPCC/NCOMMS] " ..  commandObj.key .. ": Comms Type not found!\n")
    --         return
    --     end
    -- end

    ncomms.BroadCastComms(commsType, commsName, commandObj.key or "Console")



   
end

return plugin

