GM.Name = "Furry Survival"
GM.Author = "KomDog"
GM.Email = "N/A"
GM.Website = "https://komdog.club"
GM.TeamBased = true

function GM:Initialize()
    self.BaseClass.Initialize(self)
end

function GM:CreateTeams()

    TEAM_WAITING = 0
    team.SetUp(0, "Waiting...", Color(100, 100, 100, 255))
    team.SetSpawnPoint( TEAM_WAITING, { "info_n_spawn" } )

    TEAM_FURRY = 1
    team.SetUp(1, "Furries", Color(150, 20, 20, 255))
    team.SetSpawnPoint( TEAM_FURRY, { "info_yiff_spawn" } )

    TEAM_NORMIE = 2
    team.SetUp(2, "Normies", Color(100, 60, 240, 255))
    team.SetSpawnPoint( TEAM_NORMIE, { "info_n_spawn" } )

    TEAM_AC = 3
    team.SetUp(3, "Animal Control", Color(240, 160, 20, 255))
    team.SetSpawnPoint( TEAM_AC, { "info_n_spawn" } )

end