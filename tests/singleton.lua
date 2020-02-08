TestSingleton = {}

function TestSingleton:test()
	local a = BasicSingle:New()
	local b = BasicSingle:New()

	lu.assertEquals( a, b )

	a = nil
	b = nil
	collectgarbage( "collect" )
end

function TestSingleton:testGCLeaks()
	local a = BasicSingle:New()
	local b = BasicSingle:New()
	local strID = tostring( a )

	lu.assertEquals( a, b )
	a = nil
	b = nil
	collectgarbage( "collect" )

	local c = BasicSingle:New()
	lu.assertNotEquals( strID, tostring(c) )
	c = nil
	collectgarbage( "collect" )
end