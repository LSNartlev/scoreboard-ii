local Button = {}

function Button:createButton(label, x, y, width, height, buttonType, image, buttonState, tooltip, onClick)
    return {
      label = label,
      x = x,
      y = y,
      width = width,
      height = height,
      bgColor = getBgColor(buttonType, false),
      bgColorFocus = getBgColor(buttonType, true),
      bgColorDisabled = color.optionDisabled,
      fgColor = color.fgBlack,
      fgColorDisabled = color.fgOptionDisabled,
      image = image,
      buttonState = buttonState,
      tooltip = tooltip,
      onClick = onClick
    }
end

function getBgColor(buttonType, isFocus)
  local toReturn
  if isFocus then
    if buttonType == "menuBasketball" then
      toReturn = color.redFocus
    elseif buttonType == "menuVolleyball" then
      toReturn = color.blueFocus
    else
      toReturn = color.optionFocus
    end
  else
    if buttonType == "menuBasketball" then
      toReturn = color.red
    elseif buttonType == "menuVolleyball" then
      toReturn = color.blue
    else
      toReturn = color.option
    end
  end
  
  return toReturn
end

return Button