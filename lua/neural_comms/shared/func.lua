ncomms = ncomms or {}
ncomms.funcs = ncomms.funcs or {}


function ncomms.funcs.copy (comm_name, new_comm_name, changes)
    local comm = ncomms.config.Comms[comm_name]
    if not comm then return end

    local new_comm = table.Copy(comm)
    new_comm.name = new_comm_name
    if changes then
        for k, v in pairs(changes) do
            new_comm[k] = v
        end
    end

    ncomms.config.Comms[new_comm_name] = new_comm
    return new_comm
end

function ncomms.funcs.blacklist(ply, ...)
    if not ply:IsPlayer() then return false end
    local blacklist = true  
    for _, v in pairs({...}) do
        if ply:Team() == v then
            blacklist = false
        end
    end
    return blacklist
end

function ncomms.funcs.whitelist(ply, ...)
    if not ply:IsPlayer() then return false end
    local whitelist = false 
    for _, v in pairs({...}) do
        if ply:Team() == v then
            whitelist = true
        end
    end
    return whitelist
end
