
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
	local endshootpos = shootpos + ply:GetAimVector() * 200

	-- Hit Box
	local tmin = Vector(1,1,1) * 55
	local tmax = Vector(1,1,1) * -55

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

	local wepSound = {
		"furry/default/moan_01.wav",
		"furry/default/moan_02.wav",
		"furry/default/moan_03.wav",
		"furry/default/moan_04.wav",
		"furry/default/moan_05.wav"
	}

	ply:ViewPunch( Angle( -10, 0, 0 ) )

	if (IsValid( ent ))  then

		if(ent:IsPlayer()) then

			if(ent:Team() == 1) then return false end
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
			ply:SetAnimation(PLAYER_ATTACK1)
			if(SERVER) then
				ent:TakeDamage( 68 )
				ply:EmitSound(wepSound[math.random(1, 5)])
			end
			if(ent:Health() <= 0) then
				ply:AddFrags(1)
			end

		elseif(isentity( ent )) then

	
			if(SERVER) then
				ent:TakeDamage( 10000 )
				obj = ent:GetPhysicsObject()
				if(obj:IsValid()) then
					obj:SetVelocity( ply:GetAimVector()*1500 )
				end
			end


		end
		
	elseif(!IsValid( ent )) then

		if(SERVER) then
			ply:EmitSound(wepSound[math.random(1, 5)])
		end
		ply:SetAnimation(PLAYER_ATTACK1)

	end

	self:SetNextPrimaryFire( CurTime() + 2)

end

--[[---------------------------------------------------------
	Name: SWEP:SecondaryAttack()
	Desc: +attack2 has been pressed
-----------------------------------------------------------]]
function SWEP:SecondaryAttack()

	local ply = self:GetOwner()
	local rSpeed = ply:GetWalkSpeed()
	local rSpeed = ply:GetRunSpeed()

	ply:EmitSound("npc/strider/striderx_alert5.wav")

	ply:SetRenderMode( RENDERMODE_TRANSALPHA )
	ply:SetColor(Color(0, 0, 0, 0))

	timer.Simple(3, function()
		ply:SetColor(Color(255, 255, 255, 255))
	end)

	self:SetNextSecondaryFire( CurTime() + 15)

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


