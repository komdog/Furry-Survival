local ply = FindMetaTable("Player")

local teams = {}

teams[0] = {
    name = "Waiting", 
    color = Vector(0.5, 0.5, 0.5), 
    health = {hp = 100,maxhp = 100},
    weapons = {},
    model = {'models/player/Group02/male_06.mdl'},
    move = { walk = 200, run = 200, jump = 200}
}

teams[1] = {
    name = "Furries", 
    color = Vector(1, 1, 1), 
    class = {
        furry = {
            health = {hp = 200, maxhp = 200 },
            weapons = {'weapon_yiffgun'},
            model = {'models/player/mikier/renamon.mdl'},
            move = { walk = 260, run = 260, jump = 300}
        },
        yiffer = {
            health = {hp = 200, maxhp = 200 },
            weapons = {'weapon_yiffgun'},
            model = {'models/player/mikier/renamon.mdl'},
            move = { walk = 260, run = 260, jump = 300}
        }
    }

}

teams[2] = {
    name = "Normies", 
    color = Vector(0.8, 0.4, 1), 
    health = {hp = 100,maxhp = 100},
    weapons = {
            "yz_fiveseven",
        },
    model = {"models/player/Group02/male_06.mdl"},
    move = { walk = 250, run = 250, jump = 200}
}

teams[3] = {
    name = "Animal Control", 
    color = Vector(0, 1, 0), 
    health = {hp = 150,maxhp = 150},
    weapons = {
        'yz_fiveseven',
        'weapon_stunstick'
    },
    model = {"models/player/combine_soldier_prisonguard.mdl"},
    move = { walk = 240, run = 240, jump = 200}
}

function ply:initTeam(t)

    -- Set Team
    --if not teams[t] then return end

    self:SetTeam(t)
    self:StripWeapons()

    -- Get Team Stuff
    self:SetPlayerColor(teams[t].color)
    

    -- Set HP
    if(self:Team() == 1) then
        self:SetModel(teams[t].class.furry.model[1])
        self:SetHealth(teams[t].class.furry.health.hp/(table.Count(team.GetPlayers(1))/4)
        self:SetMaxHealth(teams[t].class.furry.health.maxhp/(table.Count(team.GetPlayers(1))/4)
        self:SetRunSpeed(teams[t].class.furry.move.run)
        self:SetWalkSpeed(teams[t].class.furry.move.walk)
        self:SetJumpPower(teams[t].class.furry.move.jump)
        self:Give(teams[t].class.furry.weapons[1])
    else
        self:SetModel(teams[t].model[1])
        self:SetHealth(teams[t].health.hp)
        self:SetMaxHealth(teams[t].health.maxhp)
        self:SetRunSpeed(teams[t].move.run)
        self:SetWalkSpeed(teams[t].move.walk)
        self:SetJumpPower(teams[t].move.jump)

        for k, wep in pairs(teams[t].weapons) do
            self:Give(wep)
            self:SetAmmo(250, "Pistol")
        end

    end
    
    
    return true
end


-- Fall Damage
function GM:GetFallDamage( ply, speed )
    
    if(ply:Team() == 1) then
        return false

    elseif(ply:Team() == 2) then

        return ( speed / 8 ) 

    elseif(ply:Team() == 3) then

        return ( speed / 20 ) 

    end


    
end

-- No TK
function GM:PlayerShouldTakeDamage( victim, killer )

    if (!killer:IsPlayer()) then return true end
    
    if victim:Team() == killer:Team() then
        return false
    elseif(killer:Team() == 2 and victim:Team() == 3) then
        return false
    elseif(killer:Team() == 3 and victim:Team() == 2) then
        return false
    else
        return true
    end

end

-- Sound Chats
function GM:PlayerSay(sender, text, teamChat)

    local stopArr ={
        'vo/trainyard/male01/cit_hit01.wav',
        'vo/trainyard/male01/cit_hit02.wav',
        'vo/trainyard/male01/cit_hit03.wav',
        'vo/trainyard/male01/cit_hit04.wav',
        'vo/trainyard/male01/cit_hit05.wav'
    }
    
    local spyArr ={
        'vo/trainyard/male01/cit_bench01.wav',
        'vo/trainyard/male01/cit_bench02.wav',
        'vo/trainyard/male01/cit_bench03.wav',
        'vo/trainyard/male01/cit_bench04.wav',
        'vo/trainyard/female01/cit_bench01.wav',
        'vo/trainyard/female01/cit_bench02.wav',
        'vo/trainyard/female01/cit_bench03.wav',
        'vo/trainyard/female01/cit_bench04.wav'
    }

    local helpArr ={
        'vo/Streetwar/sniper/male01/c17_09_help01.wav',
        'vo/Streetwar/sniper/male01/c17_09_help02.wav',
        'vo/Streetwar/sniper/male01/c17_09_help03.wav',
        'vo/canals/arrest_helpme.wav',
        'vo/coast/bugbait/sandy_help.wav',
        'vo/npc/Barney/ba_littlehelphere.wav',
        'vo/npc/female01/help01.wav',
        'vo/npc/male01/help01.wav',
        'vo/ravenholm/monk_helpme01.wav',
        'vo/ravenholm/monk_helpme02.wav',
        'vo/ravenholm/monk_helpme03.wav',
        'vo/ravenholm/monk_helpme04.wav',
        'vo/ravenholm/monk_helpme05.wav',
        'vo/Streetwar/rubble/ba_helpmeout.wav'
    }

    local ahArr ={
        'vo/Streetwar/Alyx_gate/al_ahno.wav'
    }

    local msg = text:lower()


    if(msg == 'stop') then
        sender:EmitSound(stopArr[math.random(table.Count(stopArr))])
        return false
    elseif(msg == 'spy') then
    sender:EmitSound(spyArr[math.random(table.Count(spyArr))])
        return false
    elseif(msg == 'help') then
    sender:EmitSound(helpArr[math.random(table.Count(helpArr))])
        return false
    elseif(msg == 'ah') then
    sender:EmitSound(ahArr[math.random(table.Count(ahArr))])
        return false
    else
        return text
    end



end

