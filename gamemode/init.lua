AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_roundhud.lua")
AddCSLuaFile("cl_furrytracker.lua")
AddCSLuaFile("cl_sounds.lua")
AddCSLuaFile("sv_player.lua")
AddCSLuaFile("sh_tags.lua")
AddCSLuaFile("sh_chat.lua")
AddCSLuaFile("sh_scoreboard.lua")
AddCSLuaFile("sh_upgrade.lua")
AddCSLuaFile("sh_killicon.lua")
AddCSLuaFile("rounds.lua")
AddCSLuaFile("shared.lua")

include("sv_player.lua")
include("rounds.lua")
include("shared.lua")
include("sh_upgrade.lua")
include("sh_killicon.lua")
include("sh_tags.lua")
include("sh_chat.lua")



-- Init Round State
roundActive = false
round = 1

function GM:PlayerConnect(name, ip)
    print(name .. "Has joined the game!")
end

function GM:PlayerInitialSpawn(ply)  

    if(roundActive == true) then ply:initTeam( TEAM_FURRY ) end

end

function GM:PlayerSpawn(ply) 


    if(respawnFurry == false) then
        roundStart() 
        ply:initTeam( TEAM_WAITING )
    else
        ply:initTeam( TEAM_FURRY )
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
    upGrade(attacker)

    -- Reset Player Kill --
    ply.kills = 0 

    -- Check for Upgrade
    

end 

function GM:PlayerDisconnected(ply)

end

function GM:PlayerDeathSound()
    return true
end


local timerDelay = 0

function GM:Think()

    roundCheck()
    
    -- Tick Timer
    if CurTime() > timerDelay then 
        net.Start("timertick", false)
        net.Broadcast()
        timerDelay = CurTime() + 1 
    end
    
    
    
end

function GM:PlayerDeathThink( ply )

    -- Respawn Delay
    if respawnFurry == true and CurTime() > ply.infecteddelay then  
        ply:initTeam( TEAM_FURRY )   
        ply:Spawn()    
    end

    -- Respawn Delay
    if respawnFurry == false and CurTime() > ply.infecteddelay then  
        ply:initTeam( TEAM_WAITING )   
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
    roundEnd('No One')
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

-- Team
concommand.Add( "team_f", function( ply, cmd, args, str )
    ply:initTeam( TEAM_FURRY ) 
    ply:Spawn()   
end )

concommand.Add( "team_n", function( ply, cmd, args, str )
    ply:initTeam( TEAM_NORMIE ) 
    ply:Spawn()   
end )

concommand.Add( "team_ac", function( ply, cmd, args, str )
    ply:initTeam( TEAM_AC )    
    ply:Spawn()   
end )

-- Stats
concommand.Add( "yz_stats", function( ply, cmd, args, str )
    printKills()
end )

-- Spawns
concommand.Add( "yz_spawn_debug", function( ply, cmd, args, str )
    local spawns = ents.FindByClass( "info_n_spawn" )
    for k, sp in pairs(spawns) do
        print(sp)
    end
end )



