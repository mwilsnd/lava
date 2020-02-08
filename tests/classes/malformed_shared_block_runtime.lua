do class "MalformedSharedBlockRuntime"
	{}

	function Initialize( self )
	end

	function DoError( self )
		shared_block {}
	end
end