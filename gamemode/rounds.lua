function roundStart()

    if(roundActive == true) then return end
    print("Log: Attempting to Start Round")

    -- Get Alive
    local AllAlive = 0
    for k ,v in pairs(player.GetAll()) do
        if(v:Alive()) then
            AllAlive = AllAlive + 1
        end
    end

    -- Check For More than 1 Player
    if( table.Count(player.GetAll()) <= 1 ) then 
    print("Log: Not Enough People To Start Round")
        roundActive = false
        lastHuman = false
        return 
    end

    -- Round Inits
    roundActive = true
    lastHuman = false

    print("---------- Game Start ----------")


    -- Start Game After 1 Second
    timer.Simple(10, function()

        chosen = table.Random( player.GetAll() ) 
        print(chosen)

        -- Active State
        

        -- Cleanup
        game.CleanUpMap( false, {} )

        -- Display Message

        net.Start( "center_text", false )
            net.WriteString(chosen:Nick() .. " Has Been Chosen")
        net.Broadcast()

        -- Spawn Players
        for k,ply in pairs(player.GetAll()) do
            ply:SendLua('surface.PlaySound("round/start_zom.mp3")')
            ply:Spawn()
        end

        furrySpawn = true

        -- Round Check after intro
        timer.Simple(7, function()
            roundCheck()
        end)


    end)

end

function roundCheck()

    -- Get Alive
    local AllAlive = 0
    for k ,v in pairs(player.GetAll()) do
        if(v:Alive()) then
            AllAlive = AllAlive + 1
        end
    end

    if(AllAlive < 1) then return end
    if(roundActive == false) then return end

    -- End game if less than 
    if(table.Count(player.GetAll()) < 1 && roundActive == false) then

        roundEnd()

    end

    local fAlive = 0
    local nAlive = 0
    local acAlive = 0

    -- Get Furries Alive
    for k ,v in pairs(team.GetPlayers(1)) do
        if(v:Alive()) then
            fAlive = fAlive + 1
        end
    end

    -- Get Normies alive
    for k ,v in pairs(team.GetPlayers(2)) do
        if(v:Alive()) then
            nAlive = nAlive + 1
        end
    end

    -- Get AC Alive
    for k ,v in pairs(team.GetPlayers(3)) do
        if(v:Alive()) then
            acAlive = acAlive + 1
        end
    end

    -- Get Humans Alive
    local hAlive = nAlive + acAlive

    print("---------- Alive Data ----------")
    print("Total Alive Players: " .. fAlive)
    print("Total Alive Humans: " .. hAlive)
    print("Furries: " .. fAlive .. " | Normies: " .. nAlive .. " | AC: " .. acAlive)

    -- if(fAlive == 0) then roundEnd("Animal Control") end
    if(acAlive == 0 && nAlive == 0) then roundEnd("FurrGang") end

    if(hAlive == 1) then  

        if(lastHuman == true) then return end
        -- Music
        net.Start( "last", false )
        net.Send(player.GetAll())

        for k ,v in pairs(player.GetAll()) do
            if(v:Team() == 2 or v:Team() == 3) then
                if(v:Alive()) then
                    v:Give('weapon_ar2')
                    v:SetAmmo(1500, "AR2")
                end
            end
        end


        -- Text w/ Net Delay

        timer.Simple(1, function()
            net.Start( "center_text", false )
                net.WriteString("LAST HUMAN")
            net.Broadcast()
        end)

        lastHuman = true

    end

end

function roundEnd(winners)

    -- Change Round State
    roundActive = false
    furrySpawn = false

    -- Sound Stop
    net.Start( "stopall", false )
    net.Broadcast()

    print("---------- Round Ended ----------")

    -- Send HUD
    net.Start( "center_text", false )
        net.WriteString(winners .. " Wins!")
    net.Broadcast()

    -- Player Sound
    net.Start( "endsound", false )
    net.Broadcast()

    timer.Simple(10, function()

        -- Cleanup
        game.CleanUpMap( false, {} )

        -- Spawn Players
        for k, ply in pairs(player.GetAll()) do
            ply:SetupHands()
            ply:Spawn()
            ply:StripWeapons()
        end     
        
        game.SetTimeScale( 1 )

        roundStart()

    end)
    
end


function autoBalance( ply )

    local furries = table.Count( team.GetPlayers(1) )
    local normies = table.Count( team.GetPlayers(2) )
    local ac = table.Count( team.GetPlayers(3) )

    if(chosen == ply) then
        return 1
    else
        if(ac/2 > normies) then
            return 2
        else
            return 3
        end
    end
  

end