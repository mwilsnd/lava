do class "BasicMixinClassMalformed3"
	: mixin "Basic" : from "mixins"
	: mixin "Basic2" : from "mixins"
	{
		x = "hey!",
	}

	function Initialize( self )
	end
end