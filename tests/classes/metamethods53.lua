do class "MetamethodTester"
	{
		val = 2,
		cbClose = nil,
	}

	function Initialize(self, nVal, fnCloseCallback)
		if nVal ~= nil then
			self.val = nVal
		end

		self.cbClose = fnCloseCallback
	end

	function __close(self, err)
		self.cbClose(err)
	end
	
	function __name(self)
		return "MetamethodTester __name"
	end

	function __tostring(self)
		return "MetamethodTester __tostring"
	end

	function __call(self)
		return 42
	end

	function __add(lhs, rhs)
		if isA(rhs, this) then
			return lhs + rhs.val
		else
			return lhs.val + rhs
		end
	end

	function __sub(lhs, rhs)
		if isA(rhs, this) then
			return lhs - rhs.val
		else
			return lhs.val - rhs
		end
	end

	function __mul(lhs, rhs)
		if isA(rhs, this) then
			return lhs * rhs.val
		else
			return lhs.val * rhs
		end
	end

	function __div(lhs, rhs)
		if isA(rhs, this) then
			return lhs / rhs.val
		else
			return lhs.val / rhs
		end
	end

	function __mod(lhs, rhs)
		if isA(rhs, this) then
			return lhs % rhs.val
		else
			return lhs.val % rhs
		end
	end

	function __pow(lhs, rhs)
		if isA(rhs, this) then
			return lhs ^ rhs.val
		else
			return lhs.val ^ rhs
		end
	end

	function __unm(self)
		return -self.val
	end

	function __concat(lhs, rhs)
		if isA(rhs, this) then
			return lhs.. tostring(rhs)
		else
			return tostring(lhs).. rhs
		end
	end

	function __len(lhs)
		return lhs.val
	end

	function __eq(lhs, rhs)
		if isA(rhs, this) then
			if isA(lhs, this) then
				return lhs.val == rhs.val
			else
				return lhs == rhs.val
			end
		else
			return lhs.val == rhs
		end
	end

	function __lt(lhs, rhs)
		return lhs.val < rhs.val
	end

	function __le(lhs, rhs)
		return lhs.val <= rhs.val
	end

	function __idiv(lhs, rhs)
		if isA(rhs, this) then
			return lhs // rhs.val
		else
			return lhs.val // rhs
		end
	end

	function __band(lhs, rhs)
		if isA(rhs, this) then
			return lhs & 0xFF
		else
			return 0xFF & rhs
		end
	end

	function __bor(lhs, rhs)
		if isA(rhs, this) then
			return lhs | 0xFF
		else
			return 0xFF | rhs
		end
	end

	function __bxor(lhs, rhs)
		if isA(rhs, this) then
			return lhs ~ 0xFF
		else
			return 0xFF ~ rhs
		end
	end

	function __bnot(self)
		return ~0xFF
	end

	function __shl(lhs, rhs)
		if isA(rhs, this) then
			return lhs << 2
		else
			return 0xFF << rhs
		end
	end

	function __shr(lhs, rhs)
		if isA(rhs, this) then
			return lhs >> 2
		else
			return 0xFF >> rhs
		end
	end
end