local function AddPlayerModel( name, model, arm, armBG )
  list.Set( "PlayerOptionsModel", name, model )
  player_manager.AddValidModel( name, model )
  if arm != nil then
    if armBG == nil then armBG = 0 end
    player_manager.AddValidHands( name, arm, 0, "00000000" )
  end
end

AddPlayerModel( "Krystal",          "models/kupo/chr/krystal/krystal_sfa.mdl" )