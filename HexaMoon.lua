-- HexaMoon, a Hexagonal Grid library for Lua
-- License: See License File

local hxm = {}
local hxm.grid = {}

function hxm.grid:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

return hxm