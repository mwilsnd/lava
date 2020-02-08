do class "Vector2" : namespace "math"
	{
		x = 0,
		y = 0,
	}

	function Initialize( self, x, y )
		self.x = x or 0
		self.y = y or 0
	end

	function __add( self, other )
		if lava.validClass( other ) and lava.is_a( other, this ) then
			return this:New( self.x + other.x, self.y + other.y )
		else
			return this:New( self.x + other, self.y + other )
		end
	end

	function __sub( self, other )
		if lava.validClass( other ) and lava.is_a( other, this ) then
			return this:New( self.x - other.x, self.y - other.y )
		else
			return this:New( self.x - other, self.y - other )
		end
	end

	function __eq( self, other )
		return self.x == other.x and self.y == other.y
	end

	function __unm( self )
		return this:New( -self.x, -self.y )
	end

	function __mul( self, other )
		if lava.validClass( other ) and lava.is_a( other, this ) then
			return this:New( self.x * other.x, self.y * other.y )
		else
			return this:New( self.x * other, self.y * other )
		end
	end

	function __div( self, other )
		if lava.validClass( other ) and lava.is_a( other, this ) then
			return this:New( self.x / other.x, self.y / other.y )
		else
			return this:New( self.x * other, self.y * other )
		end
	end

	function __tostring( self )
		return ("Vector2(%.3f, %.3f)"):format( self.x, self.y )
	end

	function clone( self )
		return this:New( self.x, self.y )
	end
end