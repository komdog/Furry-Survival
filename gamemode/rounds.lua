function roundStart()

    if(roundActive == true) then return end
    if(roundStarted == true) then return end
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

    -- Start Round
    roundStarted = true

    print("---------- Game Start ----------")


    -- Start Game After 1 Second
    

    -- Start Game After 1 Second
    
    function setupGame()

        if(roundStarted == false) then return end

        resetKills()


        chosen = table.Random( player.GetAll() ) 
        print(chosen)


        -- Cleanup
        game.CleanUpMap( false, {} )

        -- Display Message
        net.Start( "center_text", false )
            net.WriteString(chosen:Nick() .. " Has Been Chosen")
        net.Broadcast()

        -- Timer Tick
        net.Start( "starttimer", false )
        net.Broadcast()

        -- Set Active Round State
        roundActive = true

        -- Spawn Players
        for k,ply in pairs(player.GetAll()) do
            ply:SendLua('surface.PlaySound("round/start_zom.mp3")')
            ply:Spawn()
        end

        -- After Spawn Inits 
        lastHuman = false
        furrySpawn = true

        -- Round Timer
        roundTimer = CurTime() + 300

    end

    timer.Simple(10, setupGame)

    

end


function roundCheck()

    if(roundActive == false) then return end


        -- Get Alive
        local AllAlive = 0
        for k ,v in pairs(player.GetAll()) do
            if(v:Alive()) then
                AllAlive = AllAlive + 1
            end
        end
    if(AllAlive < 1) then return end

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

    -- if(fAlive == 0) then roundEnd("Animal Control") end
    if(CurTime() > roundTimer ) then roundEnd("Normies") end
    if(acAlive == 0 && nAlive == 0) then roundEnd("FurrGang") end

    if(hAlive == 1) then  

        if(lastHuman == true) then return end
        -- Music
        net.Start( "last", false )
        net.Send(player.GetAll())

        -- Text w/ Net Delay

        net.Start( "center_text", false )
            net.WriteString("LAST HUMAN")
        net.Broadcast()


        lastHuman = true

    end

end

function roundEnd(winners)

    -- Change Round State
    roundActive = false
    furrySpawn = false
    roundStarted = false

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

        -- Reset Kills
        resetKills()

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
            return math.random(2, 3)
    end
  

end