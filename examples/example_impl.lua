--[[
	A simple example showing inheritance, mixins, metamethods and shared_blocks
]]

lava = require "lava"
class = lava.class
abstract = lava.abstract
interface = lava.interface
singleton = lava.singleton
mixin = lava.mixin

lava.loadClass "examples/mixin_transform.lua"
lava.loadClass "examples/base_entity.lua"
lava.loadClass "examples/player.lua"
lava.loadClass "examples/vector2.lua"

local player1 = ents.Player:New( 0, "Player 1" )
print( "Is player 1 the only player?", player1:IsOnlyPlayer() )

local player2 = ents.Player:New( 1, "Player 2" )
print( "Is player 1 STILL the only player?", player1:IsOnlyPlayer() )

player1:Update( math.Vector2:New(10, 20) - math.Vector2:New(8.124, 21.98) * 0.5, 2.1454 )
player2:Update( -math.Vector2:New(-31, 1) / 2, 0.454 )

print( player1, "transform is = ", player1:GetPos(), player1:GetScale(), player1:GetRotation() )
print( player2, "transform is = ", player2:GetPos(), player2:GetScale(), player2:GetRotation() )

player1:SetPos( 1, 2 )
player2:SetPos( math.Vector2:New(3, 4) )
print( "Player 1's position is = ", player1:GetPos() )
print( "Player 2's position is = ", player2:GetPos() )

print( "Is player 1 in the entity shared_block?", player1:IsInEntityRegistry() )
print( "Is player 2 in the entity shared_block?", player2:IsInEntityRegistry() )
print( "The entity registry has a size of 2", player2:GetNumEnts() == 2 )

player1:Remove()
print( "Player 2 is now the only player", player2:IsOnlyPlayer() )
print( "The entity registry has a size of 1", player2:GetNumEnts() == 1 )