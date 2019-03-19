-- RP command
print('Done')

function RP(ply, text, teamChat, isDead)

    chat.AddText(Color(255, 255, 255, 255), ply:GetName(), "dffd ", text)
    return true

end


if( CLIENT ) then
    hook.Add("OnPlayerChat", "RP", RP)
end