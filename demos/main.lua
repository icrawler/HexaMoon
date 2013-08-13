-- HexaMoon Demo (uses Love2D)

HXM = require "HexaMoon"

function love.load()
	width = 12
	height = 12
	hexGrid = HXM.createRhombusGrid(width, height, {color={255, 255, 255}})
end

function love.update()

end

function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.setLine(2)
	for y=1, height do
		for x=1, math.ceil(width + height/2 - 1) do
			if hexGrid[y][x] ~= nil then
				local hexCoords = HXM.getCoordinates(20, x-1, y-1, 50, 100)
				local vertices = HXM.getHexVertices(20, hexCoords.x, hexCoords.y)
				love.graphics.polygon("line", vertices[1].x, vertices[1].y,
											  vertices[2].x, vertices[2].y,
											  vertices[3].x, vertices[3].y,
											  vertices[4].x, vertices[4].y,
											  vertices[5].x, vertices[5].y,
											  vertices[6].x, vertices[6].y)
			end
		end
	end
end