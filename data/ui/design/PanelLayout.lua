local function drawElements(elementList, elementOnFocus)
  for _, e in ipairs(elementList) do
    if e.status == "disabled" then love.graphics.setColor(e.bgColorDisabled)
    elseif elementOnFocus == e.id then
      if e.status == "standby" then love.graphics.setColor(e.bgColorStandbyFocus) end
      if e.status == "active" then love.graphics.setColor(e.bgColorActiveFocus) end
    else
      if e.status == "standby" then love.graphics.setColor(e.bgColorStandby) end
      if e.status == "active" then love.graphics.setColor(e.bgColorActive) end
    end
    love.graphics.rectangle("fill", e.x, e.y, e.width, e.height)
    
    love.graphics.setFont(e.font)
    if e.image then
      love.graphics.setColor(1,1,1,1)
      love.graphics.draw(
        e.image,
        e.x+(e.height*0.1), e.y+(e.height*0.1)
      )
      love.graphics.setColor(e.fgColor)
      love.graphics.printf(
        e.text,
        e.x+(e.height*0.9)+5, e.y+(e.height-love.graphics.getFont():getHeight())/2,
        e.width-e.height-10, e.textAlign
      )
    else
      love.graphics.setColor(e.fgColor)
      love.graphics.printf(
        e.text,
        e.x+5, e.y+(e.height-love.graphics.getFont():getHeight())/2,
        e.width-10, e.textAlign
      )
    end
    
    love.graphics.setColor(1,1,1,1)
  end
end

return drawElements