local function drawElements(elementList, elementOnFocus)
  local textX, textY, textWrapWidth
  for _, e in ipairs(elementList) do
    if e.status == "disabled" then love.graphics.setColor(e.bgColorDisabled)
    elseif elementOnFocus == e.id then
      if e.status == "standby" or (e.elementType == "checkbox" and e.text == false) then 
        love.graphics.setColor(e.bgColorStandbyFocus) end
      if e.status == "active" or (e.elementType == "checkbox" and e.text == true) then
        love.graphics.setColor(e.bgColorActiveFocus) end
    else
      if e.status == "standby" or (e.elementType == "checkbox" and e.text == false) then 
        love.graphics.setColor(e.bgColorStandby) end
      if e.status == "active" or (e.elementType == "checkbox" and e.text == true) then
        love.graphics.setColor(e.bgColorActive) end
    end
    love.graphics.rectangle("fill", e.x, e.y, e.width, e.height)
    if e.elementType == "textField" then
      if e.status == "invalid" then
        love.graphics.setColor(e.fgColorInvalid)
        love.graphics.rectangle("line", e.x, e.y, e.width, e.height)
      elseif e.status == "active" then
        love.graphics.rectangle("line", e.x, e.y, e.width, e.height)
      end
    end
    if e.elementType == "checkbox" and e.text == true then
      love.graphics.setColor(1,1,1,1)
      love.graphics.draw(image.checkmark, e.x, e.y)
    end
    love.graphics.setFont(e.font)
    if e.image and e.elementType == "label" then
      love.graphics.setColor(1,1,1,1)
      love.graphics.draw(e.image, e.x, e.y)
    elseif e.image then
      love.graphics.setColor(1,1,1,1)
      love.graphics.draw(
        e.image,
        e.x+(e.height*0.1), e.y+(e.height*0.1)
      )
      textX = e.x+(e.height*0.9)+5
      textY = e.y+(e.height-love.graphics.getFont():getHeight())/2
      textWrapWidth = e.width-e.height-10
    else
      textX = e.x+5
      textY = e.y+(e.height-love.graphics.getFont():getHeight())/2
      textWrapWidth = e.width-10
    end
    if e.status == "standby" then love.graphics.setColor(e.fgColor) end
    if e.status == "active" then love.graphics.setColor(e.fgColorActive) end
    if e.status == "invalid" then love.graphics.setColor(e.fgColorInvalid) end
    if e.status == "disabled" then love.graphics.setColor(e.fgColorDisabled) end
    if e.elementType ~= "checkbox" then
      love.graphics.printf(e.text, textX, textY, textWrapWidth, e.textAlign)
    end
    love.graphics.setColor(1,1,1,1)
  end
end

return drawElements