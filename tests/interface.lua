TestInterface = {}

function TestInterface:testImplements()
	local a = ImplementsPrintable:New( "Hello" )
	lu.assertEquals( lava.implements(a, interfaces.Printable), true )
	lu.assertEquals( lava.implements(a, interfaces.Stringable), false )
	lu.assertEquals( lava.implements(a, interfaces.Countable), false )

	local b = BasicClassA:New()
	lu.assertEquals( lava.implements(b, interfaces.Printable), false )
	lu.assertEquals( lava.implements(b, interfaces.Stringable), false )
	lu.assertEquals( lava.implements(b, interfaces.Countable), false )
end

function TestInterface:testImplementsMany()
	local a = ImplementsMany:New( "Hello" )
	lu.assertEquals( lava.implements(a, interfaces.Printable), true )
	lu.assertEquals( lava.implements(a, interfaces.Stringable), true )
	lu.assertEquals( lava.implements(a, interfaces.Countable), true )

	lu.assertEquals( #a, 42 )
	lu.assertEquals( a:Count(), 42 )
	lu.assertEquals( tostring(a), "Hello World!" )
end

function TestInterface:testParentImplements()
	local a = ChildParentInterface:New( "Hello" )
	lu.assertEquals( lava.implements(a, interfaces.Printable), true )
	lu.assertEquals( lava.implements(a, interfaces.Stringable), true )
	lu.assertEquals( lava.implements(a, interfaces.Countable), true )

	lu.assertEquals( #a, 42 )
	lu.assertEquals( a:Count(), 42 )
	lu.assertEquals( tostring(a), "Hello World!" )
end

function TestInterface:testMissingMethod()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_interface_missing_method.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Class 'MalformedInterfaceMissingMethod' uses interface 'Printable' but does not implement method 'Print'" )
end

function TestInterface:testRedefinition()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_interface_redefinition.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Interface re-implementation in class 'MalformedRedef' from parent 'ImplementsMany' - interface 'interfaces.Printable'" )
end

function TestInterface:testNew()
	local b, err = pcall( function()
		interfaces.Printable:New()
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Cannot create an instance of an abstract, interface or mixin class" )
end

function TestInterface:testMalformedExtend()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_extend_interface.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Extending an interface is not allowed" )
end

function TestInterface:testMalformedImplements()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_interface_implements.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "An interface may not implement another interface" )
end

function TestInterface:testMalformedMixin()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_interface_mixin.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Applying mixins to an interface is not allowed" )
end

function TestInterface:testMalformedFinal()
	local b, err = pcall( function()
		lava.loadClass "tests/classes/malformed_interface_final.lua"
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, "Marking an interface as final has no meaning, this is not allowed" )
end