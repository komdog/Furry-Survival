
-- Hide Normal HUD
local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudCrosshair"] = true
}

surface.CreateFont( "TEAM", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
	size = 21,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

surface.CreateFont( "HP", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
	size = 30,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

surface.CreateFont( "AMMO", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
	size = 16,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )

hook.Add("HUDPaint", "hud", function()

    local ply = LocalPlayer()

    local hp = ply:Health()
    local maxHp = ply:GetMaxHealth()

	surface.SetAlphaMultiplier(1)
	
	-- Draw Cross

    draw.RoundedBox( 4,ScrW() / 2 - 3.5,ScrH() / 2 - 3.5,5,5, Color ( 255,255,255,100 ))

    -- Draw Team Name

    surface.SetFont( "TEAM" )
    surface.SetTextColor( 255, 255, 255 )
    surface.SetTextPos( 30, ScrH()-124 )
    surface.DrawText( team.GetName( ply:Team() ) )

    -- Draw HP
    surface.SetDrawColor(Color(0, 0, 0, 245))
    surface.DrawRect(28 , ScrH()-102, 254 , 34)

    surface.SetDrawColor(team.GetColor(ply:Team()))
    surface.DrawRect(30 , ScrH()-100,250*(hp/maxHp), 30)

    surface.SetFont( "HP" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 50, ScrH()-99 )
    surface.DrawText( hp )

    if not IsValid( ply:GetActiveWeapon() ) then return end

    if(ply:GetActiveWeapon():Clip1() >= 0) then

        local ammo = ply:GetActiveWeapon():Clip1()
		local maxAmmo = ply:GetActiveWeapon():GetMaxClip1()
		local clipsize = ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType())
        -- Draw ammo
        surface.SetDrawColor(Color(0, 0, 0, 245))
        surface.DrawRect(28 , ScrH()-64, 254 , 14)

        surface.SetDrawColor(Color(255, 100, 0, 255))
        surface.DrawRect(30 , ScrH()-62,250*(ammo/maxAmmo), 10)

        surface.SetFont( "AMMO" )
        surface.SetTextColor( 255, 255, 255 )
        surface.SetTextPos( 50, ScrH()-65 )
        surface.DrawText( ammo .. "/" .. clipsize )

    end

     
end)

-- Color

local norm = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0.01,
	[ "$pp_colour_addb" ] = 0.01,
	[ "$pp_colour_brightness" ] = -0.01,
	[ "$pp_colour_contrast" ] = 1.1,
	[ "$pp_colour_colour" ] = 0.2,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

local w = {
	[ "$pp_colour_addr" ] = 0.0,
	[ "$pp_colour_addg" ] = 0.0,
	[ "$pp_colour_addb" ] = 0.0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}


local yiff = {
	[ "$pp_colour_addr" ] = 0.01,
	[ "$pp_colour_addg" ] = 0.0,
	[ "$pp_colour_addb" ] = 0.0,
	[ "$pp_colour_brightness" ] = 0.0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 2,
	[ "$pp_colour_mulr" ] = 2,
	[ "$pp_colour_mulg" ] = 1,
	[ "$pp_colour_mulb" ] = 1
}



hook.Add( "RenderScreenspaceEffects", "color_modify_example", function()


	local ply = LocalPlayer()

	if (ply:Team() == 0) then DrawColorModify( w ) return end
	if (ply:Team() == 1) then DrawColorModify( yiff ) return end
	if (ply:Team() == 2) then DrawColorModify( norm ) return end
	if (ply:Team() == 3) then DrawColorModify( norm ) return end

end )