TestMeta53 = {}

function TestMeta53:testNumerics()
	local test = MetamethodTester:New()
	local test2 = MetamethodTester:New(5)
	lu.assertEquals(test // 3, 0)
	lu.assertEquals(2.2 // test, 1)
	lu.assertEquals(test2 // test, 2)
	lu.assertEquals(test // test2, 0)
end

function TestMeta53:testBitwise()
	local test = MetamethodTester:New()
	lu.assertEquals(test & 0x0C, 0xC)
	lu.assertEquals(test | 0xFF, 0xFF)
	lu.assertEquals(test ~ 0xFF, 0x0)
	lu.assertEquals(test << 5, 8160)
	lu.assertEquals(test >> 2, 63)

	lu.assertEquals(0x0C & test, 0xC)
	lu.assertEquals(0xFF | test, 0xFF)
	lu.assertEquals(0xFF ~ test, 0x0)
	lu.assertEquals(1024 << test, 4096)
	lu.assertEquals(5 >> test, 1)
	lu.assertEquals(~test, -256)
end