do class "Complex" : extends "Basic"
	: implements "InterfaceA"
	: implements "InterfaceB"
	: implements "InterfaceC"
	: mixin "MixinA"
	: mixin "MixinB"
	: mixin "MixinC"
	{
		a = 0,
		b = 0,
		fizzbuzz = 0,
		thing = 12345,
		stuff = {
			1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
			moreStuff = {
				1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
				evenMoreStuff = {
					1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
				},
			},
		},
	}

	shared_block {
		a = 0,
		b = 0,
		fizzbuzz = 0,
		thing = 12345,
		stuff = {
			1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
			moreStuff = {
				1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
				evenMoreStuff = {
					1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
				},
			},
		},
	}

	this.methods.Fib = function( self, n )
		self.a, self.b = 0, 1

		for i = 1, n do
		  self.a, self.b = self.b, self.a + self.b
		end
		return a
	end

	this.methods.FibGlobals = function( self, n )
		a, b = 0, 1

		for i = 1, n do
		  a, b = b, a + b
		end
		return a
	end

	this.methods.FibLocals = function( self, n )
		local a, b = 0, 1

		for i = 1, n do
		  a, b = b, a + b
		end
		return a
	end

	this.methods.FibShared = function( self, n )
		shared.a, shared.b = 0, 1

		for i = 1, n do
		  shared.a, shared.b = shared.b, shared.a + shared.b
		end
		return a
	end

	function FizzBuzz( self, n )
		for i = 1, n do
			if i % 3 == 0 then
				self.fizzbuzz = "fizz"
			elseif i % 5 == 0 then
				self.fizzbuzz = "buzz"
			elseif i % 3 == 0 and i % 5 == 0 then
				self.fizzbuzz = "fizzbuzz"
			else
				self.fizzbuzz = i
			end
		end
	end

	function FizzBuzzGlobals( self, n )
		for i = 1, n do
			if i % 3 == 0 then
				fizzbuzz = "fizz"
			elseif i % 5 == 0 then
				fizzbuzz = "buzz"
			elseif i % 3 == 0 and i % 5 == 0 then
				fizzbuzz = "fizzbuzz"
			else
				fizzbuzz = i
			end
		end
	end

	function FizzBuzzLocals( self, n )
		local fizzbuzz
		for i = 1, n do
			if i % 3 == 0 then
				fizzbuzz = "fizz"
			elseif i % 5 == 0 then
				fizzbuzz = "buzz"
			elseif i % 3 == 0 and i % 5 == 0 then
				fizzbuzz = "fizzbuzz"
			else
				fizzbuzz = i
			end
		end
	end

	function FizzBuzzShared( self, n )
		for i = 1, n do
			if i % 3 == 0 then
				shared.fizzbuzz = "fizz"
			elseif i % 5 == 0 then
				shared.fizzbuzz = "buzz"
			elseif i % 3 == 0 and i % 5 == 0 then
				shared.fizzbuzz = "fizzbuzz"
			else
				shared.fizzbuzz = i
			end
		end
	end

	function InterfaceA_A( self )
	end

	function InterfaceA_B( self )
	end

	function InterfaceB_A( self )
	end

	function InterfaceB_B( self )
	end

	function InterfaceC_A( self )
	end

	function InterfaceC_B( self )
	end

	function __GC( self )
		self.thing = 0
		shared.thing = 0
	end
end