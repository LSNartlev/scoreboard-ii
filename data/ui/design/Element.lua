local Element = {}

function Element:newElement(elementType, id, text,
    x, y, width, height, image, status, tooltip, action)
  return {
    elementType = elementType,
    id = id,
    text = text,
    x = x,
    y = y,
    width = width,
    height = height,
    bgColorStandby = getBgColor(elementType, 1),
    bgColorStandbyFocus = getBgColor(elementType, 2),
    bgColorActive = getBgColor(elementType, 3),
    bgColorActiveFocus = getBgColor(elementType, 4),
    bgColorDisabled = getBgColor(elementType, 0),
    fgColor = getFgColor(elementType, true),
    fgColorActive = color.fgBlack, -- only used by tabs
    fgColorInvalid = color.fgInvalid, -- only used by text fields
    fgColorDisabled = getFgColor(elementType, false),
    image = image,
    status = status,
    tooltip = tooltip,
    action = action
  }
end

-- will figure out to implement this with more finesse, trust
function getBgColor(elementType, statusNum)
  local bgColor
  
  if elementType == "tab" then
    if statusNum == 1 then bgColor = color.bgStandbyTab
    elseif statusNum == 2 then bgColor = color.bgStandbyFocusTab
    elseif statusNum == 3 then bgColor = color.bgActive
    elseif statusNum == 4 then bgColor = color.bgActiveFocus
    else bgColor = color.bgDisabled
    end
  elseif elementType == "textField" then
    if statusNum == 1 then bgColor = color.bgStandbyTextField
    elseif statusNum == 2 then bgColor = color.bgStandbyFocusTextField
    elseif statusNum > 2 then bgColor = color.bgActiveTextField
    else bgColor = color.bgDisabledTextField
  end
  elseif elementType == "menuButtonBasketball" then
    if statusNum % 2 == 1 then bgColor = color.menuBasketball
    else bgColor = color.menuBasketballFocus
    end
  elseif elementType == "menuButtonVolleyball" then
    if statusNum % 2 == 1 then bgColor = color.menuVolleyball
    else bgColor = color.menuVolleyballFocus
    end
  else
    if statusNum == 1 then bgColor = color.bgStandby
    elseif statusNum == 2 then bgColor = color.bgStandbyFocus
    elseif statusNum == 3 then bgColor = color.bgActive
    elseif statusNum == 4 then bgColor = color.bgActiveFocus
    else bgColor = color.bgDisabled
    end
  end
  
  return bgColor
end

function getFgColor(elementType, isEnabled)
  local fgColor
  
  if isEnabled then
    if elementType == "tab" or elementType == "textField" then
      fgColor = color.fgWhite
    else
      fgColor = color.fgBlack
    end
  else
    fgColor = color.fgDisabled
  end
  
  return fgColor
end

return Element