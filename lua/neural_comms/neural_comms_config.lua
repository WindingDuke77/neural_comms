-- This Addon was created by:
-- Bob Bobington#2947
-- 
-- any questions, please contact me
ncomms = ncomms or {}
ncomms.config = ncomms.config or {}
local config = ncomms.config
ncomms.funcs = ncomms.funcs or {}
config.Comms = {}

local copy = ncomms.funcs.copy
local blacklist = ncomms.funcs.blacklist
local whitelist = ncomms.funcs.whitelist
timer.Simple( 0 , function ()
-- Do not above this line. 

-- Custom Functions 
--[[
    COPY: 
        Func: 
            copy(comm_name, new_comm_name, { -- This comms options
                -- You can use all the same settings as the original example
            })
        Example: 
            copy("comms", "comms-lvl2", { 
                color = Color(0, 255, 255),
                aliases = {"c2"},
                customCheck = function(ply)
                    return ply:isCP()
                end,
            })

    BLACKLIST:
        Func: 
            blacklist(ply, { -- List of teams to blacklist
                TEAM_NAME,
                TEAM_NAME2,
            })
        Example:
            CustomCheck = function(ply)
                return blacklist(ply, { -- List of teams to blacklist
                    TEAM_NAME,
                    TEAM_NAME2,
                })
            end

    WHITELIST:
        Func: 
            whitelist(ply, { -- List of teams to whitelist
                TEAM_NAME,
                TEAM_NAME2,
            })
        Example:
            CustomCheck = function(ply)
                return whitelist(ply, { -- List of teams to whitelist
                    TEAM_NAME,
                    TEAM_NAME2,
                })
            end
]]--


-- Example Copys of Comms
--[[
    ** means Required   

    config.Comms["Name"] = { **
        name = "Display_Name", 
        aliases = {"AnotherName"}, 
        color = Color(255, 255, 255),  **
        differentComms = {  -- Comms Ids, allows infinite comms for different teams
            --[TEAM_NAME] = "Comm_ID",
            [TEAM_CIV] = "comms_civ",
            [TEAM_CIV2] = "comms_civ2",
            
        },
        customCheck = function(ply)  -- Check if the player can use the command
            return true 
        end,
        hearCheck = function(ply)  -- Check if the player can hear the command
            return true 
        end,
    }
--]]



-- use the above to make new comms

config.prefix = "/" -- prefix for the commands

--[[

-- 2 different comms for the two team_vars (TEAM_CIV and TEAM_CIV2)
config.Comms["comms"] = { -- name of Comm
    name = "comms", -- name of Comm -- Not Required
    aliases = {"c"},  -- aliases for the command -- Not Required
    color = Color(102, 255, 0),  -- color of the text -- Required
    differentComms = {  -- different comms for different teams -- Not Required
        -- Team_Name = "Comm_ID",
        [TEAM_CIV] = "comms_civ",
        [TEAM_CIV2] = "comms_civ2",
        
    },
    customCheck = function(ply)  -- custom check for the command -- Not Required
        return true 
    end,
}

-- anyone can speak
config.Comms["opencomms"] = { -- name of Comm
    name = "opencomms", -- name of Comm -- Not Required
    aliases = {"oc"},  -- aliases for the command -- Not Required
    color = Color(251, 255, 0), 
}

-- only Civial Protection can speak in chat
copy("comms", "comms-lvl2", { 
    color = Color(0, 255, 255),
    aliases = {"c2"},
    customCheck = function(ply)
        return ply:isCP()
    end,
})

]]--

-- You can remove the comms bellow and add your own
config.Comms["comms"] = { -- name of Comm
    name = "comms", -- name of Comm -- Not Required
    aliases = {"c"},  -- aliases for the command -- Not Required
    color = Color(238, 255, 0),  -- color of the text -- Required
}

config.Comms["rp"] = { -- name of Comm
    name = "RP", -- name of Comm -- Not Required
    color = Color(0, 255, 179),  -- color of the text -- Required
}

config.Comms["opencomms"] = { -- name of Comm
    name = "Open Comms", -- name of Comm -- Not Required
    aliases = {"oc"},  -- aliases for the command -- Not Required
    color = Color(238, 255, 0),  -- color of the text -- Required
}

-- Do not edit below this line
end)



