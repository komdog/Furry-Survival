surface.CreateFont( "MIDTEXT", {
	font = "consolas", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
	size = 40,
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


net.Receive( "center_text", function( bool )

	string = net.ReadString()

	local w = ScrW()
	local h = ScrH()

	surface.SetFont( "MIDTEXT" )
	local x, y = surface.GetTextSize( string )

	-- Notification panel
	local NotifyPanel = vgui.Create( "DNotify" )
	NotifyPanel:SetPos( w/2 - x/2, h/2 - (y/2)-80 )
	NotifyPanel:SetSize( x, y )
	NotifyPanel:SetLife( 5 )

	local lbl = vgui.Create( "DLabel", NotifyPanel )
	lbl:SetText( string )
	lbl:SetTextColor( Color( 255, 255, 255 ) )
	lbl:SetFont( "MIDTEXT" )
	lbl:SizeToContents()

	NotifyPanel:AddItem( lbl )
	


	
end)


--[[--------------------------
Timer HUD
--]]--------------------------



surface.CreateFont( "TIME", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
	size = 19,
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


surface.CreateFont( "ROUND", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
	size = 40,
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

net.Receive("timertick", function()
	
	hook.Add("HUDPaint", "Round Number", function()
	
	draw.SimpleTextOutlined("Round: ".. "1", "ROUND", ScrW()-150, ScrH()-ScrH() + 60 , color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
	draw.RoundedBox(0, ScrW()-220, ScrH()-ScrH() + 80, 145, 1, Color(255, 255, 255, 255))
		
	end)

	-- Set Time
	net.Receive('starttimer', function()
		time = net.ReadInt(10)
	end)

	if(time == nil) then time = 0 end
	if(time > 0) then time = time - 1 end

	hook.Add("HUDPaint", "draw Timer", function()
	
	draw.SimpleTextOutlined("Time: ".. time, "TIME", ScrW()-188, ScrH()-ScrH() + 100 , color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		
	end)


end)