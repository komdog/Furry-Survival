AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_roundhud.lua")
AddCSLuaFile("cl_furrytracker.lua")
AddCSLuaFile("cl_sounds.lua")
AddCSLuaFile("sv_player.lua")
AddCSLuaFile("sh_scoreboard.lua")
AddCSLuaFile("rounds.lua")
AddCSLuaFile("shared.lua")

include("sv_player.lua")
include("rounds.lua")
include("shared.lua")



-- Init Round State

roundActive = false
furrySpawn = false

function GM:PlayerConnect(name, ip)
    print(name .. "Has joined the game!")
end

function GM:PlayerInitialSpawn(ply)  

end

function GM:PlayerSpawn(ply) 

    if(roundActive == false) then
        ply:SetupHands()
        ply:UnSpectate()
        ply:initTeam( 0 )

        timer.Simple(1, function() roundStart() return end)

    else
        if(furrySpawn == true) then 
            ply:StripWeapons()
            ply:UnSpectate()
            ply:SetupHands()
            ply:initTeam( 1 )
            ply:GiveWeps()
            return 
        else
            ply:StripWeapons()
            ply:UnSpectate()
            ply:SetupHands()
            ply:initTeam( autoBalance( ply ) )
            ply:GiveWeps()
            return 
        end
    end


end

-- On Death
function GM:PlayerDeath( ply )

    ply:SetHealth(0)
 
    timer.Create("infecteddelay", 3, 1, function() 

        if(furrySpawn == false) then
            return false
        else
            ply:Spawn()
        end   

    end)

    timer.Create("delay", 1, 1, function() roundCheck() end)
end 

function GM:PlayerDeathSound()
    return true
end

function GM:PlayerDisconnected(ply)
    timer.Create("delay", 1, 1, function() roundCheck() end)
end

-- On Player Death
function GM:PlayerDeathThink( ply )
    return false
end

function GM:CanPlayerSuicide( ply )

    if(ply:Team() == 0)then 
        return false 
    else
        return true 
    end

end



-- Console Commands

util.AddNetworkString( "center_text" )

-- 
util.AddNetworkString( "last" )
util.AddNetworkString( "endsound" )
util.AddNetworkString( "stopall" )

-- Start Round
concommand.Add( "yz_start", function( ply, cmd, args )
    roundStart()
	print( "Started Round" )
end )

-- End Round
concommand.Add( "yz_end", function( ply, cmd, args )
    roundEnd('nobody')
	print( "Ended Round" )
end )

-- Sound Test
concommand.Add( "yz_play", function( ply, cmd, args, str )
    net.Start( "last", false )
    net.Broadcast()
end)

-- Hud
concommand.Add( "yz_hud", function( ply, cmd, args, str )
    net.Start( "center_text", false )
        net.WriteString(str)
    net.Broadcast()
end )

-- Stopsound
concommand.Add( "yz_ss", function( ply, cmd, args, str )
    net.Start( "stopall", false )
    net.Broadcast()
end )



