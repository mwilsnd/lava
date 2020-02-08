do class "BasicClassA"
	{
		m_bBool = false,
		m_strString = "Hello World",
		m_nNumber = 1,
	}

	getter "Bool->m_bBool"
	getter "String->m_strString"
	getter "Number->m_nNumber"

	function Initialize( self )
	end

	function __GC( self )
		self.m_bBool = false
	end
end