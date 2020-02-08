local m = {
	stack = {},
}

local gettime = os.clock
if IS_PLATFORM_WINDOWS and jit then
	local ffi = require "ffi"
	assert( ffi.abi "64bit" )

	ffi.cdef[[
		typedef int32_t  __int1632;
		typedef int64_t  __int3264;
		typedef uint32_t __uint1632;
		typedef uint64_t __uint3264;
	]]

	ffi.cdef[[
		typedef int BOOL;
		BOOL __stdcall QueryPerformanceFrequency(int64_t *lpFrequency);
		BOOL __stdcall QueryPerformanceCounter(int64_t *lpPerformanceCount);
	]]

	local freq, success
	local anum = ffi.new( "int64_t[1]" )
	gettime = function()
		success = ffi.C.QueryPerformanceFrequency( anum )
		if success == 0 then return nil end
		freq = tonumber( anum[0] )

		local success = ffi.C.QueryPerformanceCounter( anum )
		if success == 0 then return nil end
		count = tonumber( anum[0] )

		return count * (1 /freq)
	end
end

function m:pushScope( name )
	self.stack[#self.stack +1] = {
		name = name,
		time = gettime(),
	}
end

function m:popScope()
	local scope = self.stack[#self.stack]
	self.stack[#self.stack] = nil
	scope.duration = gettime() -scope.time
	return scope
end

return m