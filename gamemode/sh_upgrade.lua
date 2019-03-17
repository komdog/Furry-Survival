
if( SERVER ) then

    function resetKills()
        for k, ply in pairs( player.GetAll() ) do
            ply.kills = 0
        end
    end

    function upGrade()
        for k, ply in pairs( player.GetAll() ) do
            if (ply:Team() == 1) then return end
            ply:SetNWInt("kills", ply.kills)
            if(ply:Team() == 1) then return false end
            if(ply.kills == 5 ) then

                if (ply:HasWeapon("yz_deagle")) then return end
                ply:Give("yz_deagle") 
                ply:GiveAmmo(200, "SMG1")
                ply:EmitSound("player/wep_upgrade.wav")
                
            elseif(ply.kills == 10 ) then

                if (ply:HasWeapon("weapon_ar2")) then return end
                ply:Give("weapon_ar2")
                ply:GiveAmmo(200, "AR2")
                ply:EmitSound("player/wep_upgrade.wav")

            elseif(ply.kills == 15 ) then

                if (ply:HasWeapon("yz_m3")) then return end
                ply:Give("yz_m3")
                ply:GiveAmmo(200, "AR2")
                ply:EmitSound("player/wep_upgrade.wav")

            end
        end
    end


    function printKills()
        for k, ply in ipairs( player.GetAll() ) do
            local int = ply.kills
            print(ply:Nick() .. " - Kills: " .. int)
        end
    end



    printKills()

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

