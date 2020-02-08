do class "ImplementsMany"
	: implements "Printable" : from "interfaces"
	: implements "Countable" : from "interfaces"
	: implements "Stringable" : from "interfaces"
	{
		message = "",
	}

	function Initialize( self, message )
		self.message = message
	end

	function Print( self )
		print( self.message )
	end

	function Count( self )
		return 42
	end

	function __len( self )
		return 42
	end

	function __tostring( self )
		return "Hello World!"
	end
end