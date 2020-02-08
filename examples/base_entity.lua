do class "Entity" : namespace "ents"
	: mixin "Transform" : from "mixins"
	{
		m_nID = 0,
	}

	getter "ID->m_nID"

	shared_block {
		m_tblAllEnts = {},
	}

	function Initialize( self, nID )
		self.m_nID = nID
		shared.m_tblAllEnts[self] = true
		self:InitializePosition()
	end

	function OnRemove( self )
		if shared.m_tblAllEnts then
			shared.m_tblAllEnts[self] = nil
		end
	end

	function GetRegistry( self )
		return shared.m_tblAllEnts
	end

	function GetNumEnts( self )
		local n = 0
		for _, _ in pairs( shared.m_tblAllEnts ) do
			n = n +1
		end
		return n
	end

	function __tostring( self )
		return ("Entity [%d]"):format( self.m_nID )
	end
end