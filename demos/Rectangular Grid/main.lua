-- HexaMoon Demo (uses Love2D)

HXM = require "HexaMoon"

function love.load()
	width = 6
	height = 6
	hexGrid = HXM.createRectGrid(width, height, {color={255, 255, 255}})
end

function love.update()

end

function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.setLineWidth(2)
	HXM.drawRectGrid(hexGrid, drawHexagon, 10, 50, 50, {mode="line"})
end

function drawHexagon(vertices, obj, args)
	love.graphics.polygon(args.mode, vertices[1].x, vertices[1].y,
									 vertices[2].x, vertices[2].y,
									 vertices[3].x, vertices[3].y,
									 vertices[4].x, vertices[4].y,
									 vertices[5].x, vertices[5].y,
									 vertices[6].x, vertices[6].y)
end