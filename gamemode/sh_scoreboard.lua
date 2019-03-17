if (CLIENT) then
    local Scoreboard_Roundness = 0
	local Scoreboard_Color = Color(20, 20, 20, 220)
	local Scoreboard_XGap = 6
	local Scoreboard_YGap = 6
	local Scoreboard_TitleToNamesGap = 4

	local Title_Height = 12
	local Title_Color = Color(255, 255, 255, 255)
	local Title_Font = "ScoreboardTitleFont"
	local Title_Text = GetHostName()
	local Title_BackgroundRoundness = 0
	local Title_BackgroundColor = Color(10, 10, 10, 200)

	local Players_Spacing = 4
	local Players_EdgeGap = 4
	local Players_BackgroundRoundness = 0
	local Players_BackgroundColor = Color(160, 160, 160, 220)

	local PlayerBar_Height = 24
	local PlayerBar_Color = Color(255, 255, 255, 255)
	local PlayerBar_Font = "ScoreboardPlayersFont"
	local PlayerBar_BackgroundRoundness = 0
	local PlayerBar_BackgroundColor = Color(10, 10, 10, 255)

	local InfoBar_Height = 32
	local InfoBar_Color = Color(255, 255, 255, 255)
	local InfoBar_Font = "ScoreboardInfoFont"
	local InfoBar_BackgroundRoundness = 0
	local InfoBar_BackgroundColor = Color(20, 20, 20, 220)

	local 	Columns = {}
			Columns[1] = {name="Name", command=function(self, arg) return tostring(arg:Name()) end}
			Columns[2] = {name="Kills", command=function(self, arg) return tostring(arg:Frags()) end}
			Columns[3] = {name="Ping", command=function(self, arg) return tostring(arg:Ping()) end}

	surface.CreateFont("ScoreboardTitleFont", {
		font		= "Arial",
		size		= 42,
		weight		= 1000,
		antialias 	= true
	})

	surface.CreateFont("ScoreboardInfoFont", {
		font		= "Arial",
		size		= 28,
		weight		= 1000,
		antialias 	= true
	})

	surface.CreateFont("ScoreboardPlayersFont", {
		font		= "Arial",
		size		= 18,
		weight		= 800,
		antialias 	= true
	})

----------LAUNCH SEQUENCE----------
	local CreateScoreboard = function()
		Scoreboard = vgui.Create("DFrame")
		Scoreboard:SetSize(ScrW()*.75, ScrH()*.75)
		Scoreboard:SetPos((ScrW()*.25)*.5, (ScrH()*.25)*.5)
		Scoreboard:SetTitle("")
		Scoreboard:SetDraggable(false)
		Scoreboard:ShowCloseButton(false)
		Scoreboard.Open = function(self)
			Scoreboard:SetVisible(true)
		end
		Scoreboard.Close = function(self)
			Scoreboard:SetVisible(false)
		end
		Scoreboard.Paint = function(self) 
			draw.RoundedBox(Scoreboard_Roundness, 0, 0, self:GetWide(), self:GetTall(), Scoreboard_Color)
		end
		 
		Scoreboard.TitlePanel = vgui.Create("DPanel")
		Scoreboard.TitlePanel:SetParent(Scoreboard)
		Scoreboard.TitlePanel:SetPos(Scoreboard_XGap, Scoreboard_YGap)
		surface.SetFont(Title_Font)
		local w, h = surface.GetTextSize(Title_Text)
		local Height = h+(Title_Height*2)
		Scoreboard.TitlePanel:SetSize(Scoreboard:GetWide()-(Scoreboard_XGap*2), Height)
		Scoreboard.TitlePanel.Paint = function(self)
			draw.RoundedBox(Title_BackgroundRoundness, 0, 0, self:GetWide(), self:GetTall(), Title_BackgroundColor)
			surface.SetFont(Title_Font)
			surface.SetTextColor(Title_Color.r, Title_Color.g, Title_Color.b, Title_Color.a)
			surface.SetTextPos(self:GetWide()*.5-(w*.5), self:GetTall()*.5-(h*.5))
			surface.DrawText(Title_Text)
		end

		local Column_Width = Scoreboard:GetWide()-(Scoreboard_XGap*2)
		local ColumnGap_Width = (Column_Width/#Columns)
		local ColumnGap_Half = ColumnGap_Width*.5

		Scoreboard.NamesListPanel = vgui.Create("DPanelList")
		Scoreboard.NamesListPanel.PlayerBars = {}
		Scoreboard.NamesListPanel.NextRefresh = CurTime()+3
		Scoreboard.NamesListPanel:SetParent(Scoreboard)
		Scoreboard.NamesListPanel:SetPos(Scoreboard_XGap, Scoreboard_YGap+Scoreboard.TitlePanel:GetTall()+Scoreboard_TitleToNamesGap+InfoBar_Height)
		Scoreboard.NamesListPanel:SetSize(Scoreboard:GetWide()-(Scoreboard_XGap*2), Scoreboard:GetTall()-(Scoreboard.TitlePanel:GetTall())-(Scoreboard_YGap*2)-(Scoreboard_TitleToNamesGap)-InfoBar_Height)
		Scoreboard.NamesListPanel:SetSpacing(Players_Spacing)
		Scoreboard.NamesListPanel:SetPadding(Players_EdgeGap)
		Scoreboard.NamesListPanel:EnableHorizontal(false)
		Scoreboard.NamesListPanel:EnableVerticalScrollbar(true)
		Scoreboard.NamesListPanel.Refill = function(self)
			self:Clear()

			for k, pl in pairs(player.GetAll()) do
				local ID = tostring(pl:SteamID())
				self.PlayerBars[ID] = vgui.Create("DPanel")
				self.PlayerBars[ID]:SetPos(0, 0)
				self.PlayerBars[ID]:SetSize(Scoreboard.NamesListPanel:GetWide()-(Players_Spacing*2), PlayerBar_Height)
				self.PlayerBars[ID].Paint = function(self)
					draw.RoundedBox(PlayerBar_BackgroundRoundness, 0, 0, self:GetWide(), self:GetTall(), team.GetColor(pl:Team()))

					surface.SetFont(PlayerBar_Font)
					surface.SetTextColor(PlayerBar_Color.r, PlayerBar_Color.g, PlayerBar_Color.b, PlayerBar_Color.a)
					for k, v in pairs(Columns) do
						local w, h = surface.GetTextSize(v:command(pl))
						if k==1 then
							surface.SetTextPos((ColumnGap_Half*k)-(w*.5), self:GetTall()*.5-(h*.5))
						else
							surface.SetTextPos((ColumnGap_Width*(k-1))+(ColumnGap_Half)-(w*.5), self:GetTall()*.5-(h*.5))
						end
						surface.DrawText(v:command(pl))
					end
				end

				self:AddItem(self.PlayerBars[ID])
			end
		end
		Scoreboard.NamesListPanel.Think = function(self)
			if self:IsVisible() then
				if Scoreboard.NamesListPanel.NextRefresh < CurTime() then
					Scoreboard.NamesListPanel.NextRefresh = CurTime()+3
					Scoreboard.NamesListPanel:Refill()
				end
			end
		end
		Scoreboard.NamesListPanel.Paint = function(self)
			draw.RoundedBox(Players_BackgroundRoundness, 0, 0, self:GetWide(), self:GetTall(), Players_BackgroundColor)
		end

		Scoreboard.InfoBar = vgui.Create("DPanel")
		Scoreboard.InfoBar:SetParent(Scoreboard)
		Scoreboard.InfoBar:SetPos(Scoreboard_XGap, Scoreboard_YGap+Scoreboard.TitlePanel:GetTall()+Scoreboard_TitleToNamesGap)
		Scoreboard.InfoBar:SetSize(Scoreboard:GetWide()-(Scoreboard_XGap*2), InfoBar_Height)
		Scoreboard.InfoBar.Paint = function(self)
			draw.RoundedBox(InfoBar_BackgroundRoundness, 0, 0, self:GetWide(), self:GetTall(), InfoBar_BackgroundColor)
			surface.SetFont(InfoBar_Font)
			surface.SetTextColor(InfoBar_Color.r, InfoBar_Color.g, InfoBar_Color.b, InfoBar_Color.a)
			for k, v in pairs(Columns) do
				local w, h = surface.GetTextSize(v.name)
				if k==1 then
					surface.SetTextPos((ColumnGap_Half*k)-(w*.5), self:GetTall()*.5-(h*.5))
				else
					surface.SetTextPos((ColumnGap_Width*(k-1))+(ColumnGap_Half)-(w*.5), self:GetTall()*.5-(h*.5))
				end
				surface.DrawText(v.name)
			end
		end

		Scoreboard.NamesListPanel:Refill()
	end


----------Hooks----------
	function ScoreboardOpened()
		if !ValidPanel(Scoreboard) then
			CreateScoreboard()
		end

		Scoreboard:Open()
		gui.EnableScreenClicker(true)
		return true
	end
	hook.Add("ScoreboardShow", "Open scoreboard.", ScoreboardOpened)

	function ScoreboardClosed()
		if !ValidPanel(Scoreboard) then
			CreateScoreboard()
		end

		gui.EnableScreenClicker(false)
		Scoreboard:Close()
		return true
	end
	hook.Add("ScoreboardHide", "Close scoreboard.", ScoreboardClosed)
	
end