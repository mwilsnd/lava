TestUsage = {}

function TestUsage:testCounter()
	local a, b = false, false
	local counter = testCounter.Counter:New()
	counter:SetFIFOGC( function()
		a = true
	end )
	counter:SetGCCB( function()
		b = true
	end )

	counter:Run( 500 )
	counter = nil
	collectgarbage( "collect" )
	lu.assertEquals( a, true )
	lu.assertEquals( b, true )

	local c = false
	for k, v in pairs( testCounter.Counter:GetInstances() ) do
		c = true
		break
	end

	local d = false
	for k, v in pairs( util.FIFO:GetInstances() ) do
		d = true
		break
	end

	lu.assertEquals( c, false )
	lu.assertEquals( d, false )
end