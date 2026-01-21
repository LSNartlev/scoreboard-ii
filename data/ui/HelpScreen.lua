local HelpScreen = {}

local headerImage, elements, tooltipText, elementOnFocus
local locale, imageUtil, buttonUtil, color, headerFont, footerFont, subpanelsFont, optionFont

function HelpScreen:load()
  color = require("data.ui.design.Colors")
  imageUtil = require("data.ui.design.ImageUtil")
  buttonUtil = require("data.ui.elements.Button")
  locale = require("data.locales.en")
  
  headerImage = imageUtil:getScaledImage("ext/openmoji/help.png", 60, 60)
  headerFont = love.graphics.newFont("ext/fonts/Quantico/Quantico-Regular.ttf", 40)
  footerFont = love.graphics.newFont("ext/fonts/Quantico/Quantico-Regular.ttf", 14)
  -- For the subpanel buttons
  subpanelsFont = love.graphics.newFont("ext/fonts/Quantico/Quantico-Regular.ttf", 22)
  -- For the Back, Next, OK, and Cancel buttons
  optionFont = love.graphics.newFont("ext/fonts/Quantico/Quantico-Regular.ttf", 26)
  
  elements = {
    buttonUtil:createButton(
      locale.backToMain.label,
      20, 660,
      210, 40,
      "option",
      nil,
      "changeScreen",
      locale.backToMain.tooltip,
      "MainMenu"
    )
  }
end

function HelpScreen:update(dt)
  local cursorX, cursorY = love.mouse.getPosition()
  elementOnFocus = ""
  tooltipText = locale.helpScreen.default
  for _, e in ipairs(elements) do
    if cursorX >= e.x and cursorX <= e.x+e.width and cursorY >= e.y and cursorY <= e.y+e.height then
      elementOnFocus = e.label
      tooltipText = e.tooltip
    end
  end
end

function HelpScreen:draw()
  love.graphics.setBackgroundColor(color.bgFallback)
  
  -- Main section
  love.graphics.draw(headerImage, 20, 20)
  love.graphics.setFont(headerFont)
  love.graphics.print(locale.help.label, 80, 20)
  
  for _, e in ipairs(elements) do
    love.graphics.setColor(e.bgColor)
    if e.buttonState == "selected" then
      love.graphics.setColor(color.optionSelected)
    elseif elementOnFocus == e.label then
      love.graphics.setColor(e.bgColorFocus)
    end
    love.graphics.rectangle("fill", e.x, e.y, e.width, e.height)
    
    love.graphics.setFont(subpanelsFont)
    if e.buttonClass == "option" then
      love.graphics.setFont(optionFont)
    end
    love.graphics.setColor(e.fgColor)
    love.graphics.printf(
      e.label,
      e.x, e.y+(e.height-love.graphics.getFont():getHeight())/2,
      e.width, "center"
    )
    love.graphics.setColor(1,1,1,1)
  end
  
  -- Footer section
  love.graphics.setFont(footerFont)
  love.graphics.setColor(color.bgFooter)
  love.graphics.rectangle("fill", 0, 720, 1280, 48)
  love.graphics.setColor(color.fgWhite)
  love.graphics.printf(tooltipText, 0, 720, 1280, "center")
  love.graphics.setColor(1,1,1,1)
end

function HelpScreen:mousepressed(x, y, button)
  if button == 1 then
    for _, e in ipairs(elements) do
      if elementOnFocus == e.label and e.buttonState == "changeScreen" then
        changeScreen(e.onClick)
      end
    end
  end
end

return HelpScreen