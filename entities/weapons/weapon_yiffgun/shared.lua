
-- Variables that are used on both client and server

SWEP.PrintName		= "YiffGun" -- 'Nice' Weapon name (Shown on HUD)
SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""

SWEP.Spawnable		= false
SWEP.AdminOnly		= false

SWEP.Primary.ClipSize		= -1			-- Size of a clip
SWEP.Primary.DefaultClip	= -1		-- Default number of bullets in a clip
SWEP.Primary.Automatic		= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1			-- Size of a clip
SWEP.Secondary.DefaultClip	= -1		-- Default number of bullets in a clip
SWEP.Secondary.Automatic		= true		-- Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"



--[[---------------------------------------------------------
	Name: SWEP:Initialize()
	Desc: Called when the weapon is first loaded
-----------------------------------------------------------]]
function SWEP:Initialize()

end

--[[---------------------------------------------------------
	Name: SWEP:PrimaryAttack()
	Desc: +attack1 has been pressed
-----------------------------------------------------------]]
function SWEP:PrimaryAttack()


	local ply = self:GetOwner()


	-- Get Shoot Vectors
	local shootpos = ply:GetShootPos()
	local endshootpos = shootpos + ply:GetAimVector() * 100

	-- Hit Box
	local tmin = Vector(1,1,1) * -15
	local tmax = Vector(1,1,1) * 15

	local tr = util.TraceHull({
		start = shootpos,
		endpos = endshootpos,
		filter = ply,
		mask = MASK_SHOT_HULL,
		mins = tmin,
		maxs = tmax
	})

	if(!IsValid( tr.Entity )) then
		tr = util.TraceLine({
			start = shootpos,
			endpos = endshootpos,
			filter = ply,
			mask = MASK_SHOT_HULL
		})
	end

	local ent = tr.Entity

	
	if(IsValid( ent ) and ent:IsPlayer()) then

		if(ent:Team() == 1) then return false end

		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		ply:SetAnimation(PLAYER_ATTACK1)
		ply:EmitSound("player/death.wav")
		ent:SetHealth( ent:Health() - 100 ) 
		if(ent:Health() <= 0) then
			ent:Kill()
		end
	elseif(!IsValid( ent )) then

		ply:EmitSound("player/death.wav")
		ply:SetAnimation(PLAYER_ATTACK1)

	end

	self:SetNextPrimaryFire( CurTime() + 1)

end

--[[---------------------------------------------------------
	Name: SWEP:SecondaryAttack()
	Desc: +attack2 has been pressed
-----------------------------------------------------------]]
function SWEP:SecondaryAttack()

	local ply = self:GetOwner()

	local multi = 1

	if( ply:OnGround() ) then

	self.Owner:SetVelocity( ply:GetAimVector() * 1000 )
	ply:EmitSound("npc/stalker/go_alert2.wav", 75, 90, 0.7, CHAN_SWEP )

	end

	self:SetNextSecondaryFire( CurTime() + 3)

end

--[[---------------------------------------------------------
	Name: SWEP:Reload()
	Desc: Reload is being pressed
-----------------------------------------------------------]]
function SWEP:Reload()
	self:DefaultReload( ACT_VM_RELOAD )
end

--[[---------------------------------------------------------
	Name: SWEP:Think()
	Desc: Called every frame
-----------------------------------------------------------]]
function SWEP:Think()
end

--[[---------------------------------------------------------
	Name: SWEP:Holster( weapon_to_swap_to )
	Desc: Weapon wants to holster
	RetV: Return true to allow the weapon to holster
-----------------------------------------------------------]]
function SWEP:Holster( wep )
	return true
end

--[[---------------------------------------------------------
	Name: SWEP:Deploy()
	Desc: Whip it out
-----------------------------------------------------------]]
function SWEP:Deploy()
	return true
end

--[[---------------------------------------------------------
	Name: OnRemove
	Desc: Called just before entity is deleted
-----------------------------------------------------------]]
function SWEP:OnRemove()
end

--[[---------------------------------------------------------
	Name: OwnerChanged
	Desc: When weapon is dropped or picked up by a new player
-----------------------------------------------------------]]
function SWEP:OwnerChanged()
end


--[[---------------------------------------------------------
	Name: SetDeploySpeed
	Desc: Sets the weapon deploy speed.
		 This value needs to match on client and server.
-----------------------------------------------------------]]
function SWEP:SetDeploySpeed( speed )
	self.m_WeaponDeploySpeed = tonumber( speed )
end


