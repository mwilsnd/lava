TestMeta54 = {}

function TestMeta54:testClose()
	local flag = false
	local estr

	pcall(function()
		local test <close> = MetamethodTester:New(42, function(err)
			flag = true
			estr = err
		end)
		error("test error")
	end)

	lu.assertEquals(flag, true)
	lu.assertStrContains(estr, "test error")
end