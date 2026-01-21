local ImageUtil = {}

local canvas
local baseImage
  
function ImageUtil:getScaledImage(imagePath, targetWidth, targetHeight)
  baseImage = love.graphics.newImage(imagePath, {mipmaps = true})
  baseImage:setFilter("linear","linear")
  local scaleX = targetWidth / baseImage:getWidth()
  local scaleY = targetHeight / baseImage:getHeight()
  
  canvas = love.graphics.newCanvas(targetWidth, targetHeight)
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.draw(baseImage, 0, 0, 0, scaleX, scaleY)
  love.graphics.setCanvas()
  
  return canvas
end

return ImageUtil