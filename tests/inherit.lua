TestInherit = {}

function TestInherit:testAExtnedsBContainsMethods()
	local a = BasicClassA:New()
	local b = BasicClassB:New()
	local c = BasicClassC:New()

	lu.assertNotIsNil( a )
	lu.assertNotIsNil( b )
	lu.assertNotIsNil( c )

	lu.assertIsFunction( b.MyMethodFromB )
	lu.assertNotIsFunction( a.MyMethodFromB )

	lu.assertIsFunction( c.MyMethodFromB )
	lu.assertIsFunction( c.MyMethodFromC )
end

function TestInherit:testAExtnedsBContainsMembers()
	local a = BasicClassA:New()
	local b = BasicClassB:New()
	local c = BasicClassC:New()

	lu.assertNotIsNil( a )
	lu.assertNotIsNil( b )
	lu.assertNotIsNil( c )
	lu.assertIsFunction( a.GetBool )
	lu.assertIsFunction( b.GetBool )

	lu.assertNotIsNil( a:GetString() )
	lu.assertNotIsNil( a:GetString() )

	lu.assertEquals( a:GetBool(), b:GetBool() )
	lu.assertEquals( a:GetNumber(), b:GetNumber() )
	lu.assertNotEquals( a:GetString(), b:GetString() )
	lu.assertNotEquals( a:GetString(), c:GetString() )
	lu.assertNotEquals( b:GetString(), c:GetString() )
end

function TestInherit:testAttemptExtendFinal()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/extend_final.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Attempt to extend the class 'BasicClassD' is not allowed, 'BasicClassD' is marked as final" )
end

function TestInherit:testAttemptExtendSelf()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_self_extend.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Class test.MalformedSelfExtend is trying to extend itself" )
end

function TestInherit:testAttemptExtendMissingClass()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_extend_nil.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Parent class 'MissingClass' is nil - child class 'MalformedExtendNil'" )
end

function TestInherit:testAttemptExtendMissingClass()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_method_member_conflict.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Method/member name conflict" )
end

function TestInherit:testInheritConstructor()
	local a = BasicClassInheritCons:New()
end