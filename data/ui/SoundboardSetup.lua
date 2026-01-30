local SoundboardSetup = {}

local element
local elementList, headerImage, footerText, elementOnFocus, activeSubpanel

function SoundboardSetup:load()
  element = require("data.ui.design.Element")
  
  headerImage = image.header.soundboard
  elementList = {
    element:newElement(
      "button","Sound-Setup-BackToMain",
      locale.backToMain.label,
      20, 660,
      210, 40,
      nil,
      sysFont.menuCommon, "center",
      "standby",
      locale.backToMain.tooltip,
      "MainMenu"
    )
  }
end

function SoundboardSetup:update(dt)
  local cursorX, cursorY = love.mouse.getPosition()
  elementOnFocus = ""
  footerText = locale.soundboardSetup.default
  for _, e in ipairs(elementList) do
    if cursorX >= e.x and cursorX <= e.x+e.width and cursorY >= e.y and cursorY <= e.y+e.height then
      elementOnFocus = e.id
      footerText = e.tooltip
    end
  end
end

function SoundboardSetup:draw()
  love.graphics.setBackgroundColor(color.bgFallback)
  
  -- Main section
  love.graphics.draw(headerImage, 20, 20)
  love.graphics.setFont(sysFont.header)
  love.graphics.print(locale.soundboard.label, 80, 20)
  drawElements(elementList, elementOnFocus)
  
  -- Subpanel
  
  -- Footer section
  love.graphics.setFont(sysFont.footer)
  love.graphics.setColor(color.bgFooter)
  love.graphics.rectangle("fill", 0, 720, 1280, 48)
  love.graphics.setColor(color.fgWhite)
  love.graphics.printf(footerText, 0, 720, 1280, "center")
  love.graphics.setColor(1,1,1,1)
end

function SoundboardSetup:mousepressed(x, y, button)
  if button == 1 then
    for _, e in ipairs(elementList) do
      if elementOnFocus == e.id and e.action == "MainMenu" then
        changeScreen(e.action)
      end
    end
  end
end

return SoundboardSetup