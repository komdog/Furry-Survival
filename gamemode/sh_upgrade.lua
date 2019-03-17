
if( SERVER ) then

    function resetKills()
        for k, ply in pairs( player.GetAll() ) do
            ply.kills = 0
        end
    end

    function upGrade(attacker)

        if(attacker:Team() == 1) then return end

        attacker.kills = attacker.kills + 1
        attacker:SetNWInt("kills", attacker.kills)
        if(attacker.kills == 5 ) then
            attacker:Give("yz_deagle") 
            attacker:GiveAmmo(135, "357")
            attacker:EmitSound("player/wep_upgrade.wav")
        elseif (attacker.kills == 10 ) then
            attacker:Give("weapon_smg1") 
            attacker:GiveAmmo(135, "SMG1")
            attacker:EmitSound("player/wep_upgrade.wav")
        elseif (attacker.kills == 15 ) then
            attacker:Give("yz_m3")
            attacker:GiveAmmo(135, "Buckshot")
            attacker:EmitSound("player/wep_upgrade.wav")
        end

        return
        -- for k, ply in pairs( playe r.GetAll() ) do
        --     ply:SetNWInt("kills", ply.kills)
        --     if(ply.kills == 5 ) then

        --         if (ply:HasWeapon("yz_deagle")) then return end
        --         ply:Give("yz_deagle") 
        --         ply:GiveAmmo(200, "SMG1")
        --         ply:EmitSound("player/wep_upgrade.wav")
        
        --     elseif(ply.kills == 10 ) then

        --         if (ply:HasWeapon("weapon_ar2")) then return end
        --         ply:Give("weapon_ar2")
        --         ply:GiveAmmo(200, "AR2")
        --         ply:EmitSound("player/wep_upgrade.wav")

        --     elseif(ply.kills == 15 ) then

        --         if (ply:HasWeapon("yz_m3")) then return end
        --         ply:Give("yz_m3")
        --         ply:GiveAmmo(200, "AR2")
        --         ply:EmitSound("player/wep_upgrade.wav")

        --     end
        -- end
    end


    function printKills()
        for k, ply in ipairs( player.GetAll() ) do
            if(ply:IsBot()) then return end
            local int = ply.kills
            print(ply:Nick() .. " - Kills: " .. int)
        end
    end

end

if( CLIENT ) then

    hook.Add("HUDPaint", "drawKills", function()

    local ply = LocalPlayer()
    if (ply:Team() == 1) then return end

    local kills = ply:GetNWInt('kills')

    -- Draw Cross

    surface.SetFont( "TEAM" )
    surface.SetTextColor( 255, 255, 255 )
    surface.SetTextPos( 50, ScrH()-ScrH()/2 )
    surface.DrawText( "Kills: "  ..  kills)

    
    end)

end

