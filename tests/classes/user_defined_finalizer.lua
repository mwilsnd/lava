do singleton "UserFinalizer"
	{
	}

	function Initialize( self )
	end

	finally( function()
		_G.userFinalizerSingleton = this:New()
	end )
end