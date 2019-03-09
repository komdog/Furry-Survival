	function draw.Circle( x, y, radius, seg )
		local cir = {}

		table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
		for i = 0, seg do
			local a = math.rad( ( i / seg ) * -360 )
			table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
		end

		local a = math.rad( 0 ) -- This is needed for non absolute segment counts
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

		surface.DrawPoly( cir )
    end


     hook.Add( "HUDPaint", "Wallhack", function()

	 
        local ply = LocalPlayer()
         
        if ply:Team() == 1 then

            for k,v in pairs ( team.GetPlayers(2) ) do
                local Position = ( v:GetPos() + Vector( 0,0,50 ) ):ToScreen()
                if (v:Alive() && v:Team() != 0) then
                Speed = ply:GetVelocity():Length()
                local a = 200 + math.sin( CurTime()*1 ) * 50 - Speed
                surface.SetDrawColor( 120,60,255, a )
                draw.Circle( Position.x,Position.y, (a/40)+5, 100 )

                end
            end

            for k,v in pairs ( team.GetPlayers(3) ) do
                local Position = ( v:GetPos() + Vector( 0,0,50 ) ):ToScreen()
                if (v:Alive() && v:Team() != 0) then
                Speed = ply:GetVelocity():Length()
                local a = 200 + math.sin( CurTime()*1 ) * 50 - Speed
                surface.SetDrawColor( 240,160,20, a )
                draw.Circle( Position.x,Position.y, (a/40)+5, 100 )

            end
            
        end

		end
	 
	end )

