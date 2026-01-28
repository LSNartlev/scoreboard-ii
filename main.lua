function love.load()
  locale = require("data.locales.en")
  sysFont = require("data.ui.design.FontsList")
  color = require("data.ui.design.ColorsList")
  scaleImage = require("data.ui.design.ScaledImage")
  image = require("data.ui.design.ImageList")
  changeScreen("MainMenu")
end

function love.update(dt)
  if OnScreen.update then
    OnScreen:update(dt)
  end
end

function love.draw()
  if OnScreen.draw then
    OnScreen:draw()
  end
end

function changeScreen(nextScreen)
  OnScreen = require("data.ui." .. nextScreen)
  if OnScreen.load then 
    OnScreen:load()
  end
end

function love.mousepressed(x, y, button)
  if OnScreen.mousepressed then
    OnScreen:mousepressed(x, y, button)
  end
end

function love.keypressed(key, scancode, isrepeat)
  if OnScreen.keypressed then
    OnScreen:keypressed(key, scancode, isrepeat)
  end
end