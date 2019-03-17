AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_roundhud.lua")
AddCSLuaFile("cl_furrytracker.lua")
AddCSLuaFile("cl_sounds.lua")
AddCSLuaFile("sv_player.lua")
AddCSLuaFile("sh_tags.lua")
AddCSLuaFile("sh_scoreboard.lua")
AddCSLuaFile("sh_upgrade.lua")
AddCSLuaFile("rounds.lua")
AddCSLuaFile("shared.lua")

include("sv_player.lua")
include("rounds.lua")
include("shared.lua")
include("sh_upgrade.lua")
include("sh_tags.lua")



-- Init Round State
roundActive = false


function GM:PlayerConnect(name, ip)
    print(name .. "Has joined the game!")
end

function GM:PlayerInitialSpawn(ply)  

end

function GM:PlayerSpawn(ply) 

    if(roundActive == false) then
        ply:SetupHands()
        ply:initTeam( 0 )

        roundStart()

    else
        if(furrySpawn == true) then 
            ply:StripWeapons()
            ply:SetupHands()
            ply:initTeam( 1 )
            return 
        else
            ply:StripWeapons()
            ply:SetupHands()
            ply:initTeam( autoBalance( ply ) )
            return 
        end
    end


end

-- On Death
function GM:PlayerDeath( ply, inflictor, attacker )

    -- Player Code
    ply:SetHealth(0)

    -- Set Delay --
    ply.infecteddelay = CurTime() + 3
    ply.check = CurTime() + 3

    -- Death Sounds --
    if(ply:Team() == 1) then
        ply:EmitSound("npc/strider/striderx_die1.wav")
    end

    -- Add Attacker Kill
    attacker.kills = attacker.kills + 1

    -- Reset Player Kill --
    ply.kills = 0 

    -- Check for Upgrade
    upGrade()

end 

function GM:PlayerDisconnected(ply)
    if(table.Count(team.GetPlayers(1)) < 1) then roundEnd("Normies") end
end

function GM:PlayerDeathSound()
    return true
end


local timerDelay = 0
function GM:Think()

    roundCheck()
    
    if CurTime() > timerDelay then 
        net.Start("timertick", false)
        net.Broadcast()
        timerDelay = CurTime() + 1
    else   
        return      
    end
    
    
    
end

function GM:PlayerDeathThink( ply )

    -- Respawn Delay
    if roundActive == true and CurTime() > ply.infecteddelay then     
        ply:Spawn()    
    end

    return false
    
end 

function GM:CanPlayerSuicide( ply )
    return ply:IsSuperAdmin() 
end



-- Console Commands

util.AddNetworkString( "center_text" )
util.AddNetworkString( "timertick" )
util.AddNetworkString( "starttimer" )

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
    roundEnd('The Furry Spirit')
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

-- Stopsound
concommand.Add( "yz_team", function( ply, cmd, args, str )
    ply:Spawn()
    ply:initTeam(args[1])
end )

-- Spawns
concommand.Add( "yz_spawn_debug", function( ply, cmd, args, str )
    local spawns = ents.FindByClass( "info_player_start" )
    for k, sp in pairs(spawns) do
        print(sp)
    end
end )



