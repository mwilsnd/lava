do mixin "Basic" : namespace "mixins"
	{
		x = 0,
		y = 0,
	}

	function SetPos( self, x, y )
		self.x = x
		self.y = y
	end

	function GetPos( self )
		return self.x, self.y
	end
end