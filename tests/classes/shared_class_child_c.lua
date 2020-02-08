do class "SharedChildC" : extends "SharedChildB"
	{
		m_strMyValue = "SharedChildC",
	}

	function Initialize( self )
	end

	function GetSharedValue( self )
		return super.GetSharedValue( self )
	end

	function SetSharedValue( self, str )
		super.SetSharedValue( self, str )
	end
end