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
      bgColorSelected = color.optionSelected,
      bgColorSelectedFocus = color.optionSelectedFocus,
      fgColor = color.fgBlack,
      fgColorDisabled = color.fgOptionDisabled,
      image = image,
      buttonState = buttonState,
      tooltip = tooltip,
      onClick = onClick
    }
end

function getBgColor(buttonType, isFocus)
  local bgColor
  if isFocus then
    if buttonType == "menuBasketball" then
      bgColor = color.redFocus
    elseif buttonType == "menuVolleyball" then
      bgColor = color.blueFocus
    else
      bgColor = color.optionFocus
    end
  else
    if buttonType == "menuBasketball" then
      bgColor = color.red
    elseif buttonType == "menuVolleyball" then
      bgColor = color.blue
    else
      bgColor = color.option
    end
  end
  return bgColor
end

return Button