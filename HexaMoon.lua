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
hxm.neighbors = {}  --  x,  y
hxm.neighbors["NE"] = { 1, -1}
hxm.neighbors["E"]  = { 1,  0}
hxm.neighbors["SE"] = { 0,  1}
hxm.neighbors["SW"] = {-1,  1}
hxm.neighbors["W"]  = {-1,  0}
hxm.neighbors["NW"] = { 0, -1}

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

-- Gets hexagon coordinate in a direction
function hxm.getHexCoordinate(dir, x, y)
	return x + hxm.neighbors[dir][1], y + hxm.neighbors[dir][2]
end

-- Gets hexagon coordinate from a pixel coordinate
function hxm.getHexFromPixel(px, py, radius, ox, oy)
	local x = (1/3*sqrt(3) * (px-ox) - 1/3 * (py-oy))/radius
	local y = 2/3 * (py-oy) / size

	local nx, ny = hxm.getNearestHex(x, y)
	return nx, ny
end

-- Round to the nearest hex
function hxm.getNearestHex(x, y)
	local cx = x
	local cy = -x-y
	local cz = y

	local rx = math.floor(cx+0.5)
	local ry = math.floor(cy+0.5)
	local rz = math.floor(cz+0.5)

	local x_err = math.abs(rx-cx)
	local y_err = math.abs(ry-cy)
	local z_err = math.abs(rz-cz)

	if x_err > y_err and x_err > z_err then
		rx = -ry-rz
	elseif y_err > z_err then
		ry = -rx-rz
	else
		rz = -rx-ry
	end

	local ax = rx
	local ay = rz

	return ax, ay
end

-- Creates rectangular shaped grid with origin at top left corner
function hxm.createRectGrid(width, height, obj)
	obj = obj or {__val=true}
	local grid = {}
	local w = math.ceil((width-1) + (height-1)/2)
	for y=1, height do
		grid[y] = {}
		for x=-(w-width), width do
			if x > -math.floor(y/2) and
			   x <= width - math.floor(y/2) then
				grid[y][x] = obj
			else
				grid[y][x] = nil
			end
		end
	end

	return {grid=grid, width=width, height=height}
end

-- Creates rhombus shaped grid with origin at top left corner
function hxm.createRhombusGrid(width, height, obj)
	obj = obj or {__val=true}
	local grid = {}
	for y=1, height do
		grid[y] = {}
		for x=1, width do
			grid[y][x] = obj
		end
	end

	return {grid=grid, width=width, height=height}
end

-- Generates coordinates of a hexagon based on axial coordinates x and y
function hxm.getCoordinates(rad, x, y, ox, oy)
	local height = 2*rad
	local width = (math.sqrt(3)/2)*height

	local rx = x*width + 0.5*y*width + ox
	local ry = 0.75*y*height + oy

	return {x=rx, y=ry}
end

-- Draws rectangular grid using a drawing function (must take arguments radius, vertices, grid object and other optional arguments)
function hxm.drawRectGrid(grid, drawFunction, radius, ox, oy, args)
	for y=1, grid.height do
		for x=-((math.ceil((grid.width-1)+(grid.height-1)/2))-grid.width), grid.width do
			if grid.grid[y][x] ~= nil then
				local hexCoords = HXM.getCoordinates(radius, x-1, y-1, ox, oy)
				local vertices = HXM.getHexVertices(radius, hexCoords.x, hexCoords.y)
				drawFunction(vertices, grid.grid[y][x], args)
			end
		end
	end
end

-- Draws rhombus grid using a drawing function (must take arguments radius, vertices, grid object and other optional arguments)
function hxm.drawRhombusGrid(grid, drawFunction, radius, ox, oy, args)
	for y=1, grid.height do
		for x=1, grid.width do
			local hexCoords = HXM.getCoordinates(radius, x-1, y-1, ox, oy)
			local vertices = HXM.getHexVertices(radius, hexCoords.x, hexCoords.y)
			drawFunction(vertices, grid.grid[y][x], args)
		end
	end
end

return hxm