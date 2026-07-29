local ScreenManager = require("ui.ScreenManager")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local Icons = require("ui.designs.Icons")
local ScoreboardState = require("data.ScoreboardState")
local bbDesigner = require("ui.designs.BasketballScoreboardDesigner")
local Controls = require("data.Controls")
function love.load()
  love.keyboard.setKeyRepeat(true)
  ScreenManager.changeScreen("BasketballScoreboard")
end

function love.update(dt)
  ScreenManager.onDisplay:update(dt)
end

function love.draw()
  ScreenManager.onDisplay:draw()
end

function love.textinput(t)
  if ScreenManager.onDisplay.textinput then
    ScreenManager.onDisplay:textinput(t)
  end
end

function love.mousemoved(x, y, dx, dy, istouch)
  if ScreenManager.onDisplay.mousemoved then
    ScreenManager.onDisplay:mousemoved(x, y, dx, dy, istouch)
  end
end

function love.mousepressed(x, y, button)
  if ScreenManager.onDisplay.mousepressed then
    ScreenManager.onDisplay:mousepressed(x, y, button)
  end
end

function love.keypressed(key, scancode, isrepeat)
  if ScreenManager.onDisplay.keypressed then
    ScreenManager.onDisplay:keypressed(key, scancode, isrepeat)
  end
end

function love.keyreleased(key, scancode)
  if ScreenManager.onDisplay.keyreleased then
    ScreenManager.onDisplay:keyreleased(key, scancode)
  end
end