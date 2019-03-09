GM.Name = "Furry Survival"
GM.Author = "KomDog"
GM.Email = "N/A"
GM.Website = "https://komdog.club"

team.SetUp(0, "Waiting...", Color(100, 100, 100, 255))
team.SetUp(1, "Furries", Color(150, 20, 20, 255))
team.SetUp(2, "Normies", Color(100, 60, 240, 255))
team.SetUp(3, "Animal Control", Color(240, 160, 20, 255))


function GM:Initialize()
    self.BaseClass.Initialize(self)
end