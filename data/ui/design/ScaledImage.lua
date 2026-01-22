local function scaleImage(imagePath, targetWidth, targetHeight)
  local baseImage = love.graphics.newImage(imagePath, {mipmaps = true})
  local scaleX = targetWidth / baseImage:getWidth()
  local scaleY = targetHeight / baseImage:getHeight()
  local canvas = love.graphics.newCanvas(targetWidth, targetHeight)
  baseImage:setFilter("linear","linear")
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.draw(baseImage, 0, 0, 0, scaleX, scaleY)
  love.graphics.setCanvas()
  return canvas
end

return scaleImage