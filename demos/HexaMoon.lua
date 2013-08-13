-- HexaMoon, a Hexagonal Grid library for Lua

-- Hexagonal Grid Library for Lua
-- Copyright (C) 2013  Phoenix Enero

-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.


local hxm = {}

-- Gets the Hexagon vertices for radius (distance from center to corner) and x/y coordinates of the center
function hxm.getHexVertices(rad, cx, cy)
	local vertices = {}
	for i=1, 6 do
		local angle = 2*math.pi/6 * (i+0.5)
		local x_i = cx + rad * math.cos(angle)
		local y_i = cy + rad * math.sin(angle)
		table.insert(vertices, {x=x_i, y=y_i})
	end
	return vertices
end

-- Creates rectangular shaped grid with origin at top left corner
function hxm.createRectGrid(width, height, obj)
	obj = obj or {__val=true}
	local grid = {}
	for i=1, height do
		grid[i] = {}
		for j=1, math.ceil(width + height/2 - 1) do
			if math.ceil(j + i/2 - 1) < math.ceil(width + height/2 - 1) then
				grid[i][j] = nil
			else
				grid[i][j] = obj
			end
		end
	end

	return grid
end

-- Generates coordinates of a hexagon based on q or r
function hxm.getCoordinates(rad, q, r, ox, oy)

end

-- Creates hexagonal shaped grid with origin at center
--[[
function hxm.createHexGrid(radius)
	obj = obj or {__val=true}
	local grid = {}
	for i=-radius, 2*radius do
		grid[i] = {}
		for j=-radius, 2*radius do
			if j+radius <  then
				grid[i][j] = nil
			else
				grid[i][j] = obj
			end
		end
	end
end
]]

return hxm