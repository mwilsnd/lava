do class "SharedChildB" : extends "SharedBase"
	{
		m_strMyValue = "SharedChildB",
	}

	accessor "MyValue->m_strMyValue"

	function Initialize( self )
	end

	function GetSharedValue( self )
		return super_shared.m_strCommonShared
	end

	function SetSharedValue( self, str )
		super_shared.m_strCommonShared = str
	end
end