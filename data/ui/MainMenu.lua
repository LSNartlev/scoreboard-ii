local MainMenu = {}

local element
local menuButtons, mainMenuTitle, footerText, elementOnFocus

function MainMenu:load()
  element = require("data.ui.design.Element")
  
  mainMenuTitle = image.fullLogo
  menuButtons = {
    element:newElement(
      "menuButtonBasketball", "MainMenu-Basketball",
      locale.basketball.label,
      480, 280,
      320, 60,
      image.mainMenu.basketball,
      sysFont.menuCommon, "center",
      "standby",
      locale.basketball.tooltip,
      "BasketballSetup"
    ),
    element:newElement(
      "menuButtonVolleyball", "MainMenu-Volleyball",
      locale.volleyball.label,
      480, 360,
      320, 60,
      image.mainMenu.volleyball,
      sysFont.menuCommon, "center",
      "standby",
      locale.volleyball.tooltip,
      "VolleyballSetup"
    ),
    element:newElement(
      "button", "MainMenu-Soundboard",
      locale.soundboard.label,
      480, 440,
      320, 60,
      image.mainMenu.soundboard,
      sysFont.menuCommon, "center",
      "standby",
      locale.soundboard.tooltip,
      "SoundboardSetup"
    ),
    element:newElement(
      "button", "MainMenu-Settings",
      locale.settings.label,
      480, 520,
      320, 60,
      image.mainMenu.settings,
      sysFont.menuCommon, "center",
      "standby",
      locale.settings.tooltip,
      "SettingsScreen"
    ),
    element:newElement(
      "button", "MainMenu-Help",
      locale.help.label,
      480, 600,
      320, 60,
      image.mainMenu.help,
      sysFont.menuCommon, "center",
      "standby",
      locale.help.tooltip,
      "HelpScreen"
    )
  }
end

function MainMenu:update(dt)
  local cursorX, cursorY = love.mouse.getPosition()
  elementOnFocus = ""
  footerText = locale.welcomeText
  for _, mb in ipairs(menuButtons) do
    if cursorX >= mb.x and cursorX <= mb.x+mb.width and 
      cursorY >= mb.y and cursorY <= mb.y+mb.height then
      elementOnFocus = mb.id
      footerText = mb.tooltip
    end
  end
end

function MainMenu:draw()
  love.graphics.setBackgroundColor(color.bgFallback)
  
  -- Main section
  love.graphics.draw(mainMenuTitle, 382, 60)
  drawElements(menuButtons, elementOnFocus)
  
  -- Footer section
  love.graphics.setFont(sysFont.footer)
  love.graphics.setColor(color.bgFooter)
  love.graphics.rectangle("fill", 0, 720, 1280, 48)
  love.graphics.setColor(color.fgWhite)
  love.graphics.printf(footerText, 0, 720, 1280, "center")
  love.graphics.setColor(1,1,1,1)
end

function MainMenu:mousepressed(x, y, button)
  if button == 1 then
    for _, b in ipairs(menuButtons) do
      if elementOnFocus == b.id then
        changeScreen(b.action)
      end
    end
  end
end

return MainMenu