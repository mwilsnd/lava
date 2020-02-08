do class "SharedClass"
	{
		m_strMyValue = "SharedClass",
	}

	shared_block {
		m_strOurValue = "Hello World!",
	}

	accessor "MyValue->m_strMyValue"

	function Initialize( self )
	end

	function GetSharedValue( self )
		return shared.m_strOurValue
	end

	function SetSharedValue( self, str )
		shared.m_strOurValue = str
	end
end