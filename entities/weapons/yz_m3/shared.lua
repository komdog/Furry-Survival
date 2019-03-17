-- Variables that are used on both client and server
SWEP.Gun 					= ("yz_m3")					-- must be the name of your swep
SWEP.Category				= "Shotguns"
SWEP.Author					= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.MuzzleAttachment		= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.PrintName				= "M3"		-- Weapon name (Shown on HUD)	
SWEP.Slot					= 3			-- Slot in the weapon selection menu
SWEP.SlotPos				= 1	-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight					= 30			-- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/cstrike/c_shot_m3super90.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_shot_m3super90.mdl"	-- Weapon world model
SWEP.Base 					= "yz_shotgun_base"
SWEP.Spawnable				= true
SWEP.UseHands 				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= "weapons/2m3/m3-1.wav"		-- script that calls the primary fire sound
SWEP.Primary.RPM			= 70		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize		= 8			-- Size of a clip
SWEP.Primary.DefaultClip	= 30	-- Default number of bullets in a clip
SWEP.Primary.KickUp			= 5				-- Maximum up recoil (rise)
SWEP.Primary.KickDown		= 0.8		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal	= 1	-- Maximum up recoil (stock)
SWEP.Primary.Automatic		= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot"

SWEP.Secondary.IronFOV		= 60		-- How much you 'zoom' in. Less is more! 

SWEP.ShellTime				= .3

SWEP.Primary.NumShots		= 9		-- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage			= 10	-- Base damage per bullet
SWEP.Primary.Spread			= .15	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy 	= .035	-- Ironsight accuracy, should be the same for shotguns
-- Because irons don't magically give you less pellet spread!

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-7.64, -3.225, 3.48)
SWEP.IronSightsAng = Vector(0.13, 0.089, 0)
SWEP.SightsPos = Vector(-7.64, -3.225, 3.48)
SWEP.SightsAng = Vector(0.13, 0.089, 0)
SWEP.RunSightsPos = Vector(9.843, -16.458, 0)
SWEP.RunSightsAng = Vector(-5.371, 70, 0)
