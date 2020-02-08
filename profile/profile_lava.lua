local prof = {}

IS_PLATFORM_WINDOWS = true
local profiler = require "profile/profiler"

lava = require "lava"
class = lava.class
abstract = lava.abstract
interface = lava.interface
singleton = lava.singleton
mixin = lava.mixin

lava.loadClass "profile/classes/basic.lua"

lava.loadClass "profile/classes/interface_a.lua"
lava.loadClass "profile/classes/interface_b.lua"
lava.loadClass "profile/classes/interface_c.lua"

lava.loadClass "profile/classes/mixin_a.lua"
lava.loadClass "profile/classes/mixin_b.lua"
lava.loadClass "profile/classes/mixin_c.lua"

lava.loadClass "profile/classes/complex.lua"

local function gcBefore()
	collectgarbage( "collect" )
	collectgarbage( "stop" )
end

local function gcAfter()
	collectgarbage( "restart" )
	collectgarbage( "collect" )
end

function prof:Stats( num, fnTest )
	local total = 0
	local min = math.huge
	local max = -math.huge
	local len
	for i = 1, num do
		len = fnTest( self ).duration
		total = total + len
		if len < min then min = len end
		if len > max then max = len end
	end
	total = total / num
	return {
		total = total,
		min = min,
		max = max,
	}
end

function prof:ProfileConstructor( reps, times )
	gcBefore()
	local time = self:Stats( times, function()
		profiler:pushScope "Constructor"

		for i = 1, reps do
			local test = Basic:New()
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("Constructor took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileComplexConstructor( reps, times )
	gcBefore()
	local time = self:Stats( times, function()
		profiler:pushScope "Constructor"

		for i = 1, reps do
			local test = Complex:New()
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("Complex constructor took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileConstructorDestructor( reps, times )
	collectgarbage( "collect" )
	local time = self:Stats( times, function()
		profiler:pushScope "Constructor+Destructor"

		for i = 1, reps do
			local test = Basic:New()
			test = nil
			collectgarbage( "collect" )
		end

		return profiler:popScope()
	end )
	collectgarbage( "collect" )
	print( string.format("Constructor+destructor took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileComplexConstructorDestructor( reps, times )
	collectgarbage( "collect" )
	local time = self:Stats( times, function()
		profiler:pushScope "Constructor+Destructor"

		for i = 1, reps do
			local test = Complex:New()
			test = nil
			collectgarbage( "collect" )
		end

		return profiler:popScope()
	end )
	collectgarbage( "collect" )
	print( string.format("Complex constructor+destructor took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileGetSetMethod( reps, times )
	gcBefore()
	local test = Basic:New()

	local time = self:Stats( times, function()
		profiler:pushScope "GetSetMethod"

		for i = 1, reps do
			test:SetA( 20 )
			test:GetB()
			test:SetC( "aaa" )
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("GetSetMethod took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileGetSetVar( reps, times )
	gcBefore()
	local test = Basic:New()

	local time = self:Stats( times, function()
		profiler:pushScope "GetSetMethod"

		for i = 1, reps do
			test.thing = i
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("GetSetVar took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileFibMembers( reps, times, fib )
	gcBefore()
	local test = Complex:New()

	local time = self:Stats( times, function()
		profiler:pushScope "FibMembers"

		for i = 1, reps do
			test:Fib( fib )
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("FibMembers took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileFibGlobals( reps, times, fib )
	gcBefore()
	local test = Complex:New()

	local time = self:Stats( times, function()
		profiler:pushScope "FibGlobals"

		for i = 1, reps do
			test:FibGlobals( fib )
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("FibGlobals took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileFibLocals( reps, times, fib )
	gcBefore()
	local test = Complex:New()

	local time = self:Stats( times, function()
		profiler:pushScope "FibLocals"

		for i = 1, reps do
			test:FibLocals( fib )
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("FibLocals took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileFibShared( reps, times, fib )
	gcBefore()
	local test = Complex:New()

	local time = self:Stats( times, function()
		profiler:pushScope "FibShared"

		for i = 1, reps do
			test:FibShared( fib )
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("FibShared took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileFizzMembers( reps, times, n )
	gcBefore()
	local test = Complex:New()

	local time = self:Stats( times, function()
		profiler:pushScope "FizzBuzzMembers"

		for i = 1, reps do
			test:FizzBuzz( n )
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("FizzBuzzMembers took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileFizzGlobals( reps, times, n )
	gcBefore()
	local test = Complex:New()

	local time = self:Stats( times, function()
		profiler:pushScope "FizzBuzzGlobals"

		for i = 1, reps do
			test:FizzBuzzGlobals( n )
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("FizzBuzzGlobals took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileFizzLocals( reps, times, n )
	gcBefore()
	local test = Complex:New()

	local time = self:Stats( times, function()
		profiler:pushScope "FizzBuzzLocals"

		for i = 1, reps do
			test:FizzBuzzLocals( n )
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("FizzBuzzLocals took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

function prof:ProfileFizzShared( reps, times, n )
	gcBefore()
	local test = Complex:New()

	local time = self:Stats( times, function()
		profiler:pushScope "FizzBuzzShared"

		for i = 1, reps do
			test:FizzBuzzShared( n )
		end

		return profiler:popScope()
	end )
	gcAfter()
	print( string.format("FizzBuzzShared took %f avg seconds (%f min, %f max)", time.total, time.min, time.max) )
end

prof:ProfileConstructor( 1, 500000 )
prof:ProfileComplexConstructor( 1, 100000 )
prof:ProfileConstructorDestructor( 1, 5000 )
prof:ProfileComplexConstructorDestructor( 1, 5000 )
prof:ProfileGetSetMethod( 1, 500000 )
prof:ProfileGetSetVar( 1, 500000 )
prof:ProfileFibMembers( 1, 500, 1400 )
prof:ProfileFibGlobals( 1, 500, 1400 )
prof:ProfileFibLocals( 1, 500, 1400 )
prof:ProfileFibShared( 1, 500, 1400 )
prof:ProfileFizzMembers( 1, 500, 50000 )
prof:ProfileFizzGlobals( 1, 500, 50000 )
prof:ProfileFizzLocals( 1, 500, 50000 )
prof:ProfileFizzShared( 1, 500, 50000 )