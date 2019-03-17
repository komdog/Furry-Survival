
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

	self.Owner:LagCompensation( true )

	local tr = util.TraceHull( {
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ( ply:GetAimVector() * 90 ),
		filter = ply,
		mins = Vector( -4, -4, -4 ),
		maxs = Vector( 4, 4, 4 ),
		mask = MASK_SHOT_HULL
	})

	if(!IsValid( tr.Entity )) then  
		
	end

	local ent = tr.Entity

	local wepSound = {
		"furry/default/moan_01.wav",
		"furry/default/moan_02.wav",
		"furry/default/moan_03.wav",
		"furry/default/moan_04.wav",
		"furry/default/moan_05.wav"
	}

	if( SERVER ) then ply:EmitSound(wepSound[math.random(1, 5)]) end
	ply:ViewPunch( Angle( -10, 0, 0 ) )
	
	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()

		local attacker = ply
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )

		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( math.random( 40, 80 ) )
		if(tr.Entity:IsPlayer()) then ply:EmitSound("ambient/machines/thumper_hit.wav") end

		tr.Entity:TakeDamageInfo( dmginfo )
		hit = truew
	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 50000 * phys:GetMass(), tr.HitPos )
			ply:EmitSound("npc/vort/foot_hit.wav")
			
		end
	end


	self.Owner:LagCompensation( false )

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

	if( SERVER ) then

	ply:EmitSound("furry/default/teleport.wav")
	
	local t = {}
	t.start = ply:GetPos() + Vector( 0, 0, 32 ) -- Move them up a bit so they can travel across the ground
	t.endpos = ply:GetPos() + ply:EyeAngles():Forward() * 300
	t.filter = ply

	local tr = util.TraceEntity( t, ply )

	local pos = tr.HitPos

	-- target_ply.ulx_prevpos = target_ply:GetPos()
	-- target_ply.ulx_prevang = target_ply:EyeAngles()

	ply:SetPos( pos )
	ply:SetLocalVelocity( Vector( 0, 0, 0 ) ) -- Stop!

	end



	self:SetNextSecondaryFire( CurTime() + 5)

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


