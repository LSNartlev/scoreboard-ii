local BasketballSetup = {}

local element, getElementBg
local elementList, headerImage, footerText, elementOnFocus
local newGameSub, settingsSub, controlsSub, soundEffectsSub, subpanelList, activeSubpanel

function BasketballSetup:load()
  element = require("data.ui.design.Element")
  newGameSub = require("data.ui.subpanels.NewGame")
  headerImage = image.header.basketball
  elementList = {
    element:newElement(
      "button","BB-Setup-BackToMain",
      locale.backToMain.label,
      20, 660,
      210, 40,
      nil,
      sysFont.menuCommon, "center",
      "standby",
      locale.backToMain.tooltip,
      "MainMenu"
    ),
    element:newElement(
      "tab","BB-Setup-NewGame",
      locale.setupTab.newGame.label,
      20, 90,
      220, 40,
      nil,
      sysFont.setupCommon, "right",
      "standby",
      locale.setupTab.newGame.tooltip,
      "activateNewGameTab"
    ),
    element:newElement(
      "tab","BB-Setup-Settings",
      locale.setupTab.settings.basketball.label,
      20, 140,
      220, 40,
      nil,
      sysFont.setupCommon, "right",
      "standby",
      locale.setupTab.settings.basketball.tooltip,
      "activateSettingsTab"
    ),
    element:newElement(
      "tab","BB-Setup-Controls",
      locale.setupTab.controls.label,
      20, 190,
      220, 40,
      nil,
      sysFont.setupCommon, "right",
      "standby",
      locale.setupTab.controls.tooltip,
      "activateControlsTab"
    ),
    element:newElement(
      "tab","BB-Setup-SoundEffects",
      locale.setupTab.soundEffects.label,
      20, 240,
      220, 40,
      nil,
      sysFont.setupCommon, "right",
      "standby",
      locale.setupTab.soundEffects.tooltip,
      "activateSoundEffectsTab"
    )
  }
  activeSubpanel = "New Game"
  
  subpanelList = {
    newGameElementList = newGameSub:newSubpanel("basketball")
  }
  BasketballSetup:updateActiveTab()
end

function BasketballSetup:update(dt)
  local cursorX, cursorY = love.mouse.getPosition()
  elementOnFocus = ""
  footerText = locale.basketballSetup.default
  for _, e in ipairs(elementList) do
    if cursorX >= e.x and cursorX <= e.x+e.width and cursorY >= e.y and cursorY <= e.y+e.height then
      elementOnFocus = e.id
      footerText = e.tooltip
    end
  end
  if activeSubpanel == "New Game" then
    for _, e in ipairs(subpanelList.newGame) do
      if cursorX >= e.x and cursorX <= e.x+e.width and cursorY >= e.y and cursorY <= e.y+e.height then
        elementOnFocus = e.id
        footerText = e.tooltip
      end
    end
  end
end

function BasketballSetup:draw()
  love.graphics.setBackgroundColor(color.bgFallback)
  
  -- Main section
  love.graphics.draw(headerImage, 20, 20)
  love.graphics.setFont(sysFont.header)
  love.graphics.print(locale.basketballSetup.header, 80, 20)
  drawElements(elementList, elementOnFocus)
  love.graphics.setColor(color.bgActive)
  love.graphics.rectangle("fill", 240, 90, 5, 610)
  
  -- Subpanel
  if activeSubpanel == "New Game" then
    drawElements(subpanelList.newGame, elementOnFocus)
  end
  
  -- Footer section
  love.graphics.setFont(sysFont.footer)
  love.graphics.setColor(color.bgFooter)
  love.graphics.rectangle("fill", 0, 720, 1280, 48)
  love.graphics.setColor(color.fgWhite)
  love.graphics.printf(footerText, 0, 720, 1280, "center")
  love.graphics.setColor(1,1,1,1)
end

function BasketballSetup:mousepressed(x, y, button)
  if button == 1 then
    for _, e in ipairs(elementList) do
      if elementOnFocus == e.id then 
        if e.action == "MainMenu" then
          changeScreen(e.action)
        elseif e.action == "activateNewGameTab" then
          activeSubpanel = "New Game"
        elseif e.action == "activateSettingsTab" then
          activeSubpanel = "Settings"
        elseif e.action == "activateControlsTab" then
          activeSubpanel = "Controls"
        elseif e.action == "activateSoundEffectsTab" then
          activeSubpanel = "Sound Effects"
        end
        BasketballSetup:updateActiveTab()
      end
    end
    if activeSubpanel == "New Game" then
      for _, e in ipairs(subpanelList.newGameElementList) do
        if e.action == "editMatchTitle" then
          if e.id == "NewGame-TextField-MatchTitle" then
            e.status = "active"
          end
        end
      end
    end
  end
end

function BasketballSetup:keypressed(key)
  
end

function BasketballSetup:updateActiveTab()
  for _, e in ipairs(elementList) do
    if activeSubpanel == "New Game" and e.id == "BB-Setup-NewGame" then
      e.status = "active"
    elseif activeSubpanel == "Settings" and e.id == "BB-Setup-Settings" then
      e.status = "active"
    elseif activeSubpanel == "Controls" and e.id == "BB-Setup-Controls" then
      e.status = "active"
    elseif activeSubpanel == "Sound Effects" and e.id == "BB-Setup-SoundEffects" then
      e.status = "active"
    else
      e.status = "standby"
    end
  end
end

return BasketballSetup