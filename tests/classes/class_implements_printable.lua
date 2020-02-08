do class "ImplementsPrintable"
	: implements "Printable" : from "interfaces"
	{
		message = "",
	}

	function Initialize( self, message )
		self.message = message
	end

	function Print( self )
		print( self.message )
	end
end