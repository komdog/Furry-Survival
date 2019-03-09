surface.CreateFont( "MIDTEXT", {
	font = "consolas", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
	size = 36,
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


		local alpha = 1
		print(alpha)
		hook.Add("HUDPaint", "GameStart", function()


			--alpha = alpha + 2

			alpha = Lerp(2 * FrameTime(), alpha, 240)

			surface.SetDrawColor(Color(0, 0, 0, alpha ))
			surface.DrawRect(0, ScrH()-(ScrH()/2)-100, ScrW() , 40)
			
			-- Draw Text Name

			draw.SimpleText(string, "MIDTEXT", ScrW()-(ScrW()/2), ScrH()-(ScrH()/2)-80, Color(255,255,255,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			

		end)	

		timer.Create("hudfade", 5, 1, function() 

			hook.Add("HUDPaint", "GameStart", function()


			alpha = Lerp(10	 * FrameTime(), alpha, 0)

			surface.SetDrawColor(Color(0, 0, 0, alpha ))
			surface.DrawRect(0, ScrH()-(ScrH()/2)-100, ScrW() , 36)
			
			-- Draw Text Name
			
			draw.SimpleText(string, "MIDTEXT", ScrW()-(ScrW()/2), ScrH()-(ScrH()/2)-80, Color(255,255,255,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			

			end)	
		
		end)


		return
	
end)