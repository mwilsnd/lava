TestMisc = {}

function TestMisc:testRemove()
	local a = BasicClassA:New()
	a:Remove()
	lu.assertEquals( BasicClassA:GetInstances()[a], nil )
	collectgarbage( "collect" )
end

function TestMisc:testRemoveIndex()
	local a = BasicClassA:New()
	a:Remove()
	lu.assertEquals( BasicClassA:GetInstances()[a], nil )

	local b, err = pcall( function()
		local x = a.Initialize
	end )

	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Attempt to index a removed class" )
end

function TestMisc:testRemoveNewIndex()
	local a = BasicClassA:New()
	a:Remove()
	lu.assertEquals( BasicClassA:GetInstances()[a], nil )

	local b, err = pcall( function()
		a.xyz = 3
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Attempt to index a removed class" )
end

function TestMisc:testGCLeaks()
	local a = BasicClassA:New()
	a = nil
	collectgarbage( "collect" )

	local i = 0
	for k, v in pairs( BasicClassA:GetInstances() ) do
		i = i +1
	end
	lu.assertEquals( i, 0 )
end

function TestMisc:testIsA()
	local a = BasicClassA:New()
	lu.assertEquals( lava.is_a(a, BasicClassA), true )
end

function TestMisc:testOneClassPerFile()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_two_classes.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Class definitions are restricted to 1 class per file/function" )
	lava.removeClass( MalformedA )
end

function TestMisc:testMissingConstructor()
	local b, err = pcall( function()
		MalformedMissingConstructor:New()
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Class MalformedMissingConstructor is missing a constructor" )
end

function TestMisc:testVarnameConflict()
	_G.MalformedNameConflict = true
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_name_conflict.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Class name conflict! Found another variable at" )
end

function TestMisc:testUserDefinedFinalizer()
	if not UserFinalizer then
		local b, err = pcall( function()
			lava.loadClass "tests/classes/user_defined_finalizer.lua"
		end )
		lu.assertEquals( b, true )
	end
	lu.assertEquals( _G.userFinalizerSingleton, UserFinalizer:New() )
end