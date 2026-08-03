local GradientMesh = {}
GradientMesh.__index = GradientMesh

function GradientMesh.new(bgColor1, bgColor2, opacity)
  local self = setmetatable({}, GradientMesh)
  self.mesh = love.graphics.newMesh({
    { 0, 0, 0, 0, bgColor1.r, bgColor1.g, bgColor1.b, opacity },
    { 1, 0, 1, 0, bgColor1.r, bgColor1.g, bgColor1.b, opacity },
    { 1, 1, 1, 1, bgColor2.r, bgColor2.g, bgColor2.b, opacity },
    { 0, 1, 0, 1, bgColor2.r, bgColor2.g, bgColor2.b, opacity }
  }, "fan")
  return self
end

function GradientMesh:updateBgColor1(bgColor1, opacity)
  self.mesh:setVertex(1, 0, 0, 0, 0, bgColor1.r, bgColor1.g, bgColor1.b, opacity)
  self.mesh:setVertex(2, 1, 0, 1, 0, bgColor1.r, bgColor1.g, bgColor1.b, opacity)
end

function GradientMesh:updateBgColor2(bgColor2, opacity)
  self.mesh:setVertex(3, 1, 1, 1, 1, bgColor2.r, bgColor2.g, bgColor2.b, opacity)
  self.mesh:setVertex(4, 0, 1, 0, 1, bgColor2.r, bgColor2.g, bgColor2.b, opacity)
end

function GradientMesh:updateBgColors(bgColor1, bgColor2, opacity)
  self.mesh:setVertex(1, 0, 0, 0, 0, bgColor1.r, bgColor1.g, bgColor1.b, opacity)
  self.mesh:setVertex(2, 1, 0, 1, 0, bgColor1.r, bgColor1.g, bgColor1.b, opacity)
  self.mesh:setVertex(3, 1, 1, 1, 1, bgColor2.r, bgColor2.g, bgColor2.b, opacity)
  self.mesh:setVertex(4, 0, 1, 0, 1, bgColor2.r, bgColor2.g, bgColor2.b, opacity)
end

return GradientMesh