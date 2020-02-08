do class "Player" : namespace "ents" : extends "Entity" : final()
	{
		m_strName = "",
	}

	getter "Name->m_strName"

	shared_block {
		m_tblAllPlayers = {},
	}

	function Initialize( self, nID, strName )
		super.Initialize( self, nID )
		self.m_strName = strName
		shared.m_tblAllPlayers[self] = true
	end

	function OnRemove( self )
		-- If we are the very last instance, this table will be cleaned up for us
		if shared.m_tblAllPlayers then
			shared.m_tblAllPlayers[self] = nil
		end
		super.OnRemove( self )
	end

	function Update( self, vecMoveDirection, nRotation )
		self:SetPos( self:GetPos() + vecMoveDirection )
		self:SetRotation( nRotation )
	end

	-- Return true if we are the only player instance
	function IsOnlyPlayer( self )
		for instance, _ in pairs( shared.m_tblAllPlayers ) do
			if instance ~= self then
				return false
			end
		end

		return true
	end

	-- A simple test to ensure the parent's shared_block is working
	function IsInEntityRegistry( self )
		return self:GetRegistry()[self]
	end
end