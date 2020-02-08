TestSharedBlocks = {}

function TestSharedBlocks:testSharedBlock()
	local a = SharedClass:New()
	local b = SharedClass:New()

	lu.assertNotIsNil( a )
	lu.assertNotIsNil( b )

	lu.assertIsFunction( a.GetMyValue )
	lu.assertIsFunction( a.SetMyValue )

	lu.assertEquals( a:GetSharedValue(), b:GetSharedValue() )
	a:SetSharedValue( "Something different" )
	lu.assertEquals( a:GetSharedValue(), b:GetSharedValue() )

	a:SetMyValue( "1234" )
	lu.assertNotEquals( a:GetMyValue(), b:GetMyValue() )
end

function TestSharedBlocks:testSharedBlockFromParent()
	local a = SharedChildA:New()
	local b = SharedChildA:New()

	lu.assertNotIsNil( a )
	lu.assertNotIsNil( b )

	lu.assertEquals( a:GetSharedValue(), b:GetSharedValue() )
	b:SetSharedValue( "123" )
	lu.assertEquals( a:GetSharedValue(), b:GetSharedValue() )
end

function TestSharedBlocks:testSharedBlockFromParentParent()
	local a = SharedChildC:New()
	local b = SharedChildC:New()
	local c = SharedChildA:New()

	lu.assertNotIsNil( a )

	lu.assertEquals( a:GetSharedValue(), b:GetSharedValue() )
	lu.assertEquals( a:GetSharedValue(), c:GetSharedValue() )

	b:SetSharedValue( "123" )

	lu.assertEquals( a:GetSharedValue(), b:GetSharedValue() )
	lu.assertEquals( a:GetSharedValue(), c:GetSharedValue() )
end

function TestSharedBlocks:testTwoSharedBlocks()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_two_shared_blocks.lua"
	end )
	lu.assertEquals( b, false )
end

function TestSharedBlocks:testRuntimeSharedBlock()
	local b, err = pcall( function()
		MalformedSharedBlockRuntime:New():DoError()
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "A shared_block can only be defined during class definition" )
end