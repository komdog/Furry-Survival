
net.Receive("last", function()
    sound.PlayURL ( "https://komdog.club/api/gmod/audio/doom.wav", "2d", function( station )
        if ( IsValid( station ) ) then
            station:SetPos( LocalPlayer():GetPos() )
            station:Play()
        else
            LocalPlayer():ChatPrint( "Cannot Play Sound" )
        end
    end )
end)

net.Receive("endsound", function()
    sound.PlayURL ( "https://komdog.club/api/gmod/audio/end_r.mp3", "2d", function( station )
        if ( IsValid( station ) ) then
            station:SetPos( LocalPlayer():GetPos() )
            station:Play()
        else
            LocalPlayer():ChatPrint( "Cannot Play Sound" )
        end
    end )
end)

net.Receive("stopall", function()
    RunConsoleCommand( "stopsound" )
end)