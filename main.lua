--[[
  ____                     _                 _        ____           _               _       _ 
 |  _ \   _ __    ___     (_)   ___    ___  | |_     / ___|  _   _  | |__     ___   (_)   __| |
 | |_) | | '__|  / _ \    | |  / _ \  / __| | __|   | |     | | | | | '_ \   / _ \  | |  / _` |
 |  __/  | |    | (_) |   | | |  __/ | (__  | |_    | |___  | |_| | | |_) | | (_) | | | | (_| |
 |_|     |_|     \___/   _/ |  \___|  \___|  \__|    \____|  \__,_| |_.__/   \___/  |_|  \__,_|
                        |__/                                                                     
                                    __                _  __                    __     _        
                                   / /   __ __       / |/ / ___ _  ___   ___  / /__  (_)   ___ 
                                  / _ \ / // /      /    / / _ `/ / _ \ (_-< /  '_/ / /   / _ \
                                 /_.__/ \_, /      /_/|_/  \_,_/ /_//_//___//_/\_\ /_/   / .__/
                                       /___/                                            /_/    
 Inspired by Project Zomboid game.

]]--

-- only load everything from github

Config.Map = "nanskip.red_voxel"

Client.OnStart = function()
    githubScriptsCount = 0
    loadGitHub()
end

Client.Tick = function(dt)
    deltaTime = 62/(1/dt)
    if githubScriptsCount == 3 then
        githubScriptsCount = nil

        start()
    elseif githubScriptsCount == nil then
        tick()
    end
end

-- load everything
loadGitHub = function()
    loadFromGitHub("https://raw.githubusercontent.com/Nanskipp/project-cuboid/main/scripts/world_generator.lua",
    function(obj)
        world_generator = obj() -- set this as module
        print(world_generator.version)
    end)
    loadFromGitHub("https://raw.githubusercontent.com/Nanskipp/project-cuboid/main/scripts/start.lua",
    function(obj)
        start = obj -- set this as start function
        start()
    end)
    loadFromGitHub("https://raw.githubusercontent.com/Nanskipp/project-cuboid/main/scripts/tick.lua",
    function(obj)
        tick = obj -- set this as tick function
    end)
end

-- loading function
loadFromGitHub = function(url, callback)
    HTTP:Get(url, function(res)
        if res.StatusCode ~= 200 then
            print("Error on github loading. Code: " .. res.StatusCode)
            return
        end
        local obj = load(res.Body:ToString(), nil, "bt", _ENV)

        githubScriptsCount = githubScriptsCount + 1
        callback(obj)
        end)
end
--[[
 ____  ____   __     __  ____   ___  ____         ___  _  _  ____   __    __   ____ 
(  _ \(  _ \ /  \  _(  )(  __) / __)(_  _)       / __)/ )( \(  _ \ /  \  (  ) (    \
 ) __/ )   /(  O )/ \) \ ) _) ( (__   )(        ( (__ ) \/ ( ) _ ((  O )  )(   ) D (
(__)  (__\_) \__/ \____/(____) \___) (__)        \___)\____/(____/ \__/  (__) (____/
]]--