-- Function to read config file
function LoadConfig()
    local config = {}
    local file = io.open("config.cfg", "r")

    if file then
        for line in file:lines() do
            local key, value = line:match("^(.-)=(.-)$")
            if key and value then
                -- Trim spaces
                key = key:match("^%s*(.-)%s*$")
                value = value:match("^%s*(.-)%s*$")

                -- Convert numeric values if needed
                if value:match("^%d+$") then
                    value = tonumber(value)
                elseif value:match("^%d+,%d*") then
                    local list = {}
                    for num in value:gmatch("%d+") do
                        table.insert(list, tonumber(num))
                    end
                    value = list
                end

                config[key] = value
            end
        end
        file:close()
    else
        print("[Train Script] Error loading config.cfg! Using defaults.")
        config["train_tracks"] = {0, 1, 3, 4, 5, 6, 7, 8, 10}
        config["freight_train_frequency"] = 30000
        config["metro_train_frequency"] = 30000
    end

    return config
end

Citizen.CreateThread(function()
    local config = LoadConfig()

    -- Activate train tracks from config
    for _, track in ipairs(config["train_tracks"]) do
        SwitchTrainTrack(track, true)
    end

    -- Set train spawn frequency from config
    SetTrainTrackSpawnFrequency(0, config["freight_train_frequency"]) -- Freight train
    SetTrainTrackSpawnFrequency(3, config["metro_train_frequency"]) -- Metro train

    -- Enable random trains
    SetRandomTrains(true)

    print("[Train Script] Junat ladattu. Frekvenssi: " .. config["freight_train_frequency"] .. "ms (Freight), " .. config["metro_train_frequency"] .. "ms (Metro)")
end)
