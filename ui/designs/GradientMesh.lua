local gradMesh = function (bgColor1, bgColor2, opacity)
  return love.graphics.newMesh({
    { 0, 0, 0, 0, bgColor1.r, bgColor1.g, bgColor1.b, opacity },
    { 1, 0, 1, 0, bgColor1.r, bgColor1.g, bgColor1.b, opacity },
    { 1, 1, 1, 1, bgColor2.r, bgColor2.g, bgColor2.b, opacity },
    { 0, 1, 0, 1, bgColor2.r, bgColor2.g, bgColor2.b, opacity }
  }, "fan")
end

return gradMesh