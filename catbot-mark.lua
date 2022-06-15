local timers = {}
local timer = {}
function timer.Create(name, delay, times, func)

    table.insert(timers, 
    {["name"] = name, 
    ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})

end

function timer.Remove(name)

    for k,v in pairs(timers or {}) do
    
        if (name == v["name"]) then table.remove(timers, k) end
    
    end

end

function timer.Tick()

    for k,v in pairs(timers or {}) do
    
        if (v["times"] <= 0) then table.remove(timers, k) end
        
        if (v["lastTime"] + v["delay"] <= globals.RealTime()) then 
            timers[k]["lastTime"] = globals.RealTime()
            timers[k]["times"] = timers[k]["times"] - 1
            v["func"]() 
        end
    
    end

end

callbacks.Register( "Draw", timer.Tick);

timer.Create("catIdentify", 15, 9999999999999999999999, function()
    local kv = [[
        "AchievementEarned"
        {
            "achievementID" "0xCA8"
        }
    ]]
    if engine.SendKeyValues(kv) then
        client.ChatPrintf("\x04[CatBot] \x02You marked as:\x05 CAT")
    else
        client.ChatPrintf("\x04[CatBot] \x02Failed to mark as:\x05 CAT")
    end
   
end)
