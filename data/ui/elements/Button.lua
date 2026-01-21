local Button = {}

local color = require("data.ui.design.Colors")

function Button:createButton(label, x, y, width, height, buttonClass, image, buttonState, tooltip, onClick)
    return {
      label = label,
      x = x,
      y = y,
      width = width,
      height = height,
      bgColor = getBgColor(buttonClass, false),
      bgColorFocus = getBgColor(buttonClass, true),
      bgColorDisabled = color.optionDisabled,
      fgColor = color.fgBlack,
      fgColorDisabled = color.fgOptionDisabled,
      image = image,
      buttonState = buttonState,
      tooltip = tooltip,
      onClick = onClick
    }
end

function getBgColor(buttonClass, isFocus)
  local toReturn
  if isFocus then
    if buttonClass == "menuBasketball" then
      toReturn = color.redFocus
    elseif buttonClass == "menuVolleyball" then
      toReturn = color.blueFocus
    else
      toReturn = color.optionFocus
    end
  else
    if buttonClass == "menuBasketball" then
      toReturn = color.red
    elseif buttonClass == "menuVolleyball" then
      toReturn = color.blue
    else
      toReturn = color.option
    end
  end
  
  return toReturn
end

return Button