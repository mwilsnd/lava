TestMeta = {}

function TestMeta:testLogicNumerics()
	local test = MetamethodTester:New()
	lu.assertEquals(test + 2, 4)
	lu.assertEquals(test - 2, 0)
	lu.assertEquals(test * 2, 4)
	lu.assertEquals(test / 2, 1)
	lu.assertEquals(test % 2, 0)
	lu.assertEquals(test ^ 3, 8)
	lu.assertEquals(-test, -2)
	lu.assertEquals(#test, 2)

	lu.assertEquals(5 + test, 7)
	lu.assertEquals(5 - test, 3)
	lu.assertEquals(5 * test, 10)
	lu.assertEquals(5 / test, 2.5)
	lu.assertEquals(5 % test, 1)
	lu.assertEquals(5 ^ test, 25)

	local test2 = MetamethodTester:New(5)
	lu.assertEquals(test < test2, true)
	lu.assertEquals(test <= test2, true)
	lu.assertEquals(test2 > test, true)
	lu.assertEquals(test2 >= test, true)

	local test3 = MetamethodTester:New(2)
	lu.assertEquals(test < test3, false)
	lu.assertEquals(test <= test3, true)
	lu.assertEquals(test3 > test, false)
	lu.assertEquals(test3 >= test, true)

	lu.assertEquals(test3 == test, true)
	lu.assertEquals(test2 == test, false)
	lu.assertEquals(test2 ~= test, true)

	lu.assertEquals(test2 + test, 7)
	lu.assertEquals(test2 - test, 3)
	lu.assertEquals(test2 * test, 10)
	lu.assertEquals(test2 / test, 2.5)
	lu.assertEquals(test2 % test, 1)
	lu.assertEquals(test2 ^ test, 25)

	lu.assertEquals(test + test2, 7)
	lu.assertEquals(test - test2, -3)
	lu.assertEquals(test * test2, 10)
	lu.assertEquals(test / test2, 0.4)
	lu.assertEquals(test % test2, 2)
	lu.assertEquals(test ^ test2, 32)
end

function TestMeta:testCall()
	local test = MetamethodTester:New()
	lu.assertEquals(test(), 42)
end

function TestMeta:testStrings()
	local test = MetamethodTester:New()
	lu.assertEquals(tostring(test), "MetamethodTester __tostring")
	lu.assertEquals(test.. "stuff", "MetamethodTester __tostringstuff")
	lu.assertEquals("stuff".. test, "stuffMetamethodTester __tostring")
end