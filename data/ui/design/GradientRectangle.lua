local function newGradientRectangle(x, y, width, height, color1, color2, isTopToBottom)
  local mesh
  local vertices
  local colorTopRight, colorBottomLeft
  
  if isTopToBottom then
    colorTopRight = color1
    colorBottomLeft = color2
  else
    colorTopRight = color2
    colorBottomLeft = color1
  end
  vertices = {
    { x, y, 0, 0, color1[1], color1[2], color1[3], 1 },
    { x+width, y, 1, 0, colorTopRight[1], colorTopRight[2], colorTopRight[3], 1 },
    { x, y+height, 0, 1, colorBottomLeft[1], colorBottomLeft[2], colorBottomLeft[3], 1 },
    { x+width, y+height, 1, 1, color2[1], color2[2], color2[3], 1 },
  }
  mesh = love.graphics.newMesh(vertices, "fan", "dynamic")
  
  return mesh
end

return newGradientRectangle