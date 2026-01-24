local MainMenu = {}

local sysFont, menuButtonFont, locale, scaleImage, buttonUtil
local menuButtons
local mainMenuTitle, tooltipText, elementOnFocus

function MainMenu:load()
  scaleImage = require("data.ui.design.ScaledImage")
  buttonUtil = require("data.ui.elements.Button")
  locale = require("data.locales.en")
  
  mainMenuTitle = scaleImage("assets/images/menutitle.png", 516, 152)
  sysFont = love.graphics.newFont("ext/fonts/Quantico/Quantico-Regular.ttf", 14)
  
  menuButtonFont = love.graphics.newFont("ext/fonts/Quantico/Quantico-Regular.ttf", 28)
  menuButtons = {
    buttonUtil:createButton(
      locale.basketball.label,
      480, 280,
      320, 60,
      "menuBasketball",
      scaleImage("ext/openmoji/bball.png", 48, 48),
      "changeScreen",
      locale.basketball.tooltip,
      "BasketballSetup"
    ),
    buttonUtil:createButton(
      locale.volleyball.label,
      480, 360,
      320, 60,
      "menuVolleyball",
      scaleImage("ext/openmoji/vball.png", 48, 48),
      "changeScreen",
      locale.volleyball.tooltip,
      "VolleyballSetup"
    ),
    buttonUtil:createButton(
      locale.soundboard.label,
      480, 440,
      320, 60,
      "option",
      scaleImage("ext/openmoji/sound.png", 48, 48),
      "changeScreen",
      locale.soundboard.tooltip,
      "SoundboardSetup"
    ),
    buttonUtil:createButton(
      locale.settings.label,
      480, 520,
      320, 60,
      "option",
      scaleImage("ext/openmoji/settings.png", 48, 48),
      "changeScreen",
      locale.settings.tooltip,
      "SettingsScreen"
    ),
    buttonUtil:createButton(
      locale.help.label,
      480, 600,
      320, 60,
      "option",
      scaleImage("ext/openmoji/help.png", 48, 48),
      "changeScreen",
      locale.help.tooltip,
      "HelpScreen"
    )
  }
end

function MainMenu:update(dt)
  local cursorX, cursorY = love.mouse.getPosition()
  elementOnFocus = ""
  tooltipText = locale.welcomeText
  for _, b in ipairs(menuButtons) do
    if cursorX >= b.x and cursorX <= b.x+b.width and 
      cursorY >= b.y and cursorY <= b.y+b.height then
      elementOnFocus = b.label
      tooltipText = b.tooltip
    end
  end
end

function MainMenu:draw()
  love.graphics.setBackgroundColor(color.bgFallback)
  
  -- Main section
  love.graphics.draw(mainMenuTitle, 382, 60)
  for _, b in ipairs(menuButtons) do
    love.graphics.setColor(b.bgColor)
    if elementOnFocus == b.label then
      love.graphics.setColor(b.bgColorFocus)
    end
    love.graphics.rectangle("fill", b.x, b.y, b.width, b.height)
    love.graphics.setFont(menuButtonFont)
    love.graphics.setColor(b.fgColor)
    love.graphics.printf(
      b.label,
      b.x+(b.height*0.9), b.y+(b.height-menuButtonFont:getHeight())/2,
      b.width-b.height, "center"
    )
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(b.image,
      b.x+(b.height*0.1), b.y+(b.height*0.1))
  end
  
  -- Footer section
  love.graphics.setFont(sysFont)
  love.graphics.setColor(color.bgFooter)
  love.graphics.rectangle("fill", 0, 720, 1280, 48)
  love.graphics.setColor(color.fgWhite)
  love.graphics.printf(tooltipText, 0, 720, 1280, "center")
  love.graphics.setColor(1,1,1,1)
end

function MainMenu:mousepressed(x, y, button)
  if button == 1 then
    for _, b in ipairs(menuButtons) do
      if elementOnFocus == b.label then
        changeScreen(b.onClick)
      end
    end
  end
end

return MainMenu