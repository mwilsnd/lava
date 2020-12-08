do class "Counter" : namespace "testCounter"
	{}

	setter "GCCB->m_fnGcCB"

	function Initialize( self )
		self.m_pNumbers = util.FIFO:New()
	end

	function Run( self, n )
		for i = 1, n do
			self.m_pNumbers:Push( i )
		end

		for i = 1, n do
			assert( self.m_pNumbers:Pop() == i )
		end
	end

	function SetFIFOGC( self, fn )
		self.m_pNumbers:SetGCCB( fn )
	end

	function __GC( self )
		self.m_fnGcCB()
	end
end