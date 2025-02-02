Citizen.CreateThread(function()
    -- Activate train tracks
    local trainTracks = {0, 1, 3, 4, 5, 6, 7, 8, 10} -- List of train track IDs to enable

    for _, track in ipairs(trainTracks) do
        SwitchTrainTrack(track, true)
    end

    -- Set spawn frequency
    SetTrainTrackSpawnFrequency(0, 120000) -- Freight train spawn frequency
    SetTrainTrackSpawnFrequency(3, 120000) -- Metro train spawn frequency

    -- Enable random trains
    SetRandomTrains(true)

    print("[Juna Scripti] Junat ladattu onnistuneesti.")
end)
