TestAbstract = {}

function TestAbstract:testNew()
	local b, err = pcall( function()
		EmptyAbstract:New()
	end )
	lu.assertEquals( b, false )
	lu.assertStrContains( err, " Cannot create an instance of an abstract, interface or mixin class" )
end