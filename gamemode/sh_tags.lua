
-- Defne Tags
local ranks = {
    { name = "Owner", color = Color( 252, 10, 0 ), group = "owner" },
	{ name = "Super Admin", color = Color( 252, 100 ,0 ), group = "superadmin" },
	{ name = "Admin", color = Color( 252, 200, 0 ), group = "admin" },
	{ name = "Developer", color = Color(120, 245, 15 ), group = "dev" },
	{ name = "Moderator", color = Color( 10, 50, 250 ), group = "mod" },
	{ name = "Trusted", color = Color( 100, 0, 255 ), group = "trusted" },
	{ name = "Member", color = Color( 255, 105, 180 ), group = "member" },
	{ name = "Guest", color = Color( 200, 200, 200 ), group = "user" }
}

-- Add Tag to Chat
function ChatPrefixes(ply, text, teamChat, isDead)

    cmd = string.Explode(" ", text)
    
    if(cmd[1] == "!me`") then 
        table.remove( cmd, 1 )
        chat.AddText(Color(150, 255, 150, 255), ply:Nick(), " ", table.concat(cmd, " ")) 
        return true 
    end

    group = ply:GetUserGroup()


    for k, r in pairs(ranks) do
        if(group == ranks[k].group) then
            chat.AddText(ranks[k].color, "["..ranks[k].name.."] ", team.GetColor(ply:Team()), ply:GetName(), Color(255, 255, 255, 255), ": ", text)
            return true
        end
    end

    return true

end



if( CLIENT ) then
    hook.Add("OnPlayerChat", "ChatPrefixes", ChatPrefixes)
end
    
