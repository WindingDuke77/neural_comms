ncomms = ncomms or {}
ncomms.config = ncomms.config or {}
local config = ncomms.config
config.UChecker = config.UChecker or {}
local uconfig = config.UChecker


uconfig.Github = uconfig.Github or "https://github.com/WindingDuke77/neural_comms"
uconfig.Branch = uconfig.Branch or "main"
uconfig.Enabled = uconfig.Enabled or true
uconfig.Path = uconfig.Path or "neural_comms"

print("[Neural Comms] TEST")
if not uconfig.Enabled then return end
print("[Neural Comms] TEST2")

local success = 0
local failed = 0
local failedFiles = {}
local totalFiles = 0

function getFile(path, callback)

    local url = uconfig.Github .. "/" .. uconfig.Branch .. "/lua/" .. uconfig.Path .. "/" .. path
    url = string.gsub(url, "github.com", "raw.githubusercontent.com")
    url = string.gsub(url, " ", "%%20")

    http.Fetch(url, callback, function(err) 
        print(err) 
        failed = failed + 1
        table.insert(failedFiles, path)
    end)
end


function checkfile(path)

    getFile(path, function(body, len, headers, code)
        local localfile = file.Read(path, "LUA")
        if localfile ~= body then
            failed = failed + 1
            table.insert(failedFiles, path)
            return 
        end
        success = success + 1
    end)
end

function LoadAllFiles(dir)
    local files, dirs = file.Find( dir .. "/*", "LUA" )
    for k, v in pairs( files ) do
        if string.find(v, "module") then return end
        if string.find(v, "plugins") then return end
        if string.find(v, "config") then return end

        checkfile(dir .. "/" .. v)
        local path = dir .. "/" .. v
    end
    for k, v in pairs( dirs ) do
        if string.find(v, "module") then return end         
        if string.find(v, "plugins") then return end
       LoadAllFiles( dir .. "/" .. v )
    end
    totalFiles = totalFiles + #files
end


print("[Neural Comms] Checking for updates...")

hook.Add("PlayerInitialSpawn", uconfig.Path .. "Updatecheck", function(ply)

    print("[Neural Comms] Checking for updates...")
    LoadAllFiles(uconfig.Path)

    timer.Create(uconfig.Path .. "Updatecheck", 3, 0, function ()

        if success + failed == totalFiles then
            if failed == 0 then
                return timer.Destroy(uconfig.Path .. "Updatecheck")
            elseif( failed == 1 )then
                MsgC(Color(255, 0, 0), "[Neural Comms] ", Color(255, 255, 255), "1 file has been tampered with:" .. failedFiles[1] .. "\n You may want to reinstall the addon from\n" .. uconfig.Github .. "\n")
                return timer.Destroy(uconfig.Path .. "Updatecheck")
            elseif (failed > 1) then
                MsgC(Color(255, 0, 0), "[Neural Comms] ", Color(255, 255, 255), "It seems like this addon is not up to date.\nThese Files have failed the check:\n")
                for k, v in pairs(failedFiles) do
                    MsgC(Color(255, 0, 0), "[Neural Comms] ", Color(255, 255, 255), v .. "\n")
                end
                return timer.Destroy(uconfig.Path .. "Updatecheck")
            end
            
            return timer.Destroy(uconfig.Path .. "Updatecheck")
        end
        
    end)
 
    hook.Remove("PlayerInitialSpawn", uconfig.Path .. "Updatecheck")
end)




 