local MatchSetup = {}
local ScoreboardState = require("data.ScoreboardState")
local ConfigElements = require("ui.designs.ConfigDesigner")
local gradRect = require("ui.designs.GradientMesh")
local teamAColors, teamBColors

function MatchSetup:load()
  teamAColors = gradRect.new(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 1)
  teamBColors = gradRect.new(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 1)
end

function MatchSetup:update(dt)
  
end

function MatchSetup:draw()
  for _, v in ipairs(ConfigElements.bg) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(ConfigElements.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(ConfigElements.texts) do
    love.graphics.setFont(v.font())
    love.graphics.setColor(v.color())
    love.graphics.printf(v.text, v.x, v.y, v.width, v.align)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(ConfigElements.tabButtons) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(v.icon(), v.x, v.y+10, 0, 60/v.icon():getWidth(), 60/v.icon():getHeight())
  end
end

function MatchSetup:textinput()
  
end

function MatchSetup:mousepressed(x, y, button)
  
end

return MatchSetup