do mixin "Transform" : namespace "mixins"
	{
		m_vecPos = nil,
		m_vecScale = nil,
		m_nRotation = 0,
	}

	getter "Pos->m_vecPos"
	getter "Scale->m_vecScale"
	accessor "Rotation->m_nRotation"

	-- See the readme for why we create member instances here rather than in the members block
	function InitializePosition( self )
		self.m_vecPos = math.Vector2:New()
		self.m_vecScale = math.Vector2:New( 1, 1 )
	end

	function SetPos( self, nXorVec, nY )
		if lava.validClass( nXorVec ) and lava.is_a( nXorVec, math.Vector2 ) then
			self.m_vecPos = nXorVec
		else
			self.m_vecPos.x = nXorVec
			self.m_vecPos.y = nY
		end
	end

	function SetScale( self, nXorVec, nY )
		if lava.validClass( nXorVec ) and lava.is_a( nXorVec, math.Vector2 ) then
			self.m_vecScale = nXorVec
		else
			self.m_vecScale.x = nXorVec
			self.m_vecScale.y = nY
		end
	end
end