do class "FIFO" : namespace "util"
	: implements "Countable" : from "interfaces"
	{
		m_tbl = {},
	}

	setter "GCCB->m_fnGcCB"

	function Initialize( self )
	end

	function Push( self, var )
		self.m_tbl[#self.m_tbl+1] = var
	end

	function Pop( self )
		assert( #self.m_tbl > 0 )
		local r = self:Next()
		table.remove( self.m_tbl, 1 )
		return r
	end

	function Next( self )
		return self.m_tbl[1]
	end

	function Clear( self )
		self.m_tbl = {}
	end

	function Count( self )
		return #self.m_tbl
	end

	function __len( self )
		return #self.m_tbl
	end

	function __GC( self )
		self.m_fnGcCB()
	end
end