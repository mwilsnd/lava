TestMixin = {}

function TestMixin:testMixin()
	local a = BasicMixinClass:New()

	lu.assertNotIsNil( a )
	lu.assertIsFunction( a.SetPos )
	lu.assertIsFunction( a.GetPos )

	lu.assertEquals( a.x, 0 )
	lu.assertEquals( a.y, 0 )

	a:SetPos( 2, 3 )
	lu.assertEquals( a.x, 2 )
	lu.assertEquals( a.y, 3 )

	a:SetPos( 4, 5 )
	local x, y = a:GetPos()
	lu.assertEquals( x, 4 )
	lu.assertEquals( y, 5 )
end

function TestMixin:testMany()
	local a = BasicMixinClass3:New()

	lu.assertNotIsNil( a )
	lu.assertIsFunction( a.SetPos )
	lu.assertIsFunction( a.GetPos )
	lu.assertIsFunction( a.Method )

	lu.assertEquals( a.x, 0 )
	lu.assertEquals( a.y, 0 )

	a:SetPos( 2, 3 )
	lu.assertEquals( a.x, 2 )
	lu.assertEquals( a.y, 3 )

	a:SetPos( 4, 5 )
	local x, y = a:GetPos()
	lu.assertEquals( x, 4 )
	lu.assertEquals( y, 5 )
end

function TestMixin:testMixinsFromParent()
	local a = BasicMixinClass4:New()

	lu.assertNotIsNil( a )
	lu.assertIsFunction( a.SetPos )
	lu.assertIsFunction( a.GetPos )
	lu.assertIsFunction( a.Method )

	lu.assertEquals( a.x, 0 )
	lu.assertEquals( a.y, 0 )

	a:SetPos( 2, 3 )
	lu.assertEquals( a.x, 2 )
	lu.assertEquals( a.y, 3 )

	a:SetPos( 4, 5 )
	local x, y = a:GetPos()
	lu.assertEquals( x, 4 )
	lu.assertEquals( y, 5 )
end

function TestMixin:testRedefinition()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_mixin_redefinition.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Parent class 'BasicMixinClass' contains the same mixin as the child class 'BasicMixinClassMalformed' (mixin 'mixins.Basic')" )

	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_mixin_redefinition_2.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Parent class 'BasicMixinClass2' contains the same mixin as the child class 'BasicMixinClassMalformed2' (mixin 'mixins.Basic2')" )
end

function TestMixin:testDoubleAdd()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_mixin_double.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Attempt to add a mixin that has already been added" )
end

function TestMixin:testConflict()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_mixin_redefinition_3.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Mixin member conflict" )
end

function TestMixin:testMissing()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_mixin_missing.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Unable to find mixin 'mixins.Missing'" )
end

function TestMixin:testNew()
	local b, err = pcall( function()
		mixins.Basic:New()
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Cannot create an instance of an abstract, interface or mixin class" )
end

function TestMixin:testMalformedExtend()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_mixin_extends.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Extending a mixin is not allowed" )
end

function TestMixin:testMalformedImplements()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_mixin_implements.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "A mixin may not implement an interface" )
end

function TestMixin:testMalformedMixin()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_mixin_mixin.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Applying mixins to another mixin is not allowed" )
end

function TestMixin:testMalformedFinal()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_mixin_final.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Marking a mixin as final has no meaning, this is not allowed" )
end