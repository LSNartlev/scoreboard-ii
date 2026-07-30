local MatchSetup = {}
local ScreenManager = require("ui.ScreenManager")
local ScoreboardState = require("data.ScoreboardState")
local Designer = require("ui.designs.MatchSetupDesigner")
local ConfigDesigner = require("ui.designs.ConfigDesigner")
local Lang = require("data.language.en")
local gradRect = require("ui.designs.GradientMesh")
local teamAColors, teamBColors

function MatchSetup:load()
  ScoreboardState.onDisplay = "MatchSetup"
  ScoreboardState.tooltip = Lang.tooltips.matchSetup
  teamAColors = gradRect.new(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 1)
  teamBColors = gradRect.new(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 1)
end

function MatchSetup:update(dt)
  
end

function MatchSetup:draw()
  for _, v in ipairs(ConfigDesigner.bg) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(ConfigDesigner.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(ConfigDesigner.texts) do
    love.graphics.setFont(v.font())
    love.graphics.setColor(v.color())
    love.graphics.printf(v.text, v.x, v.y, v.width, v.align)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(ConfigDesigner.tabButtons) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(v.icon(), v.x, v.y+10, 0, 60/v.icon():getWidth(), 60/v.icon():getHeight())
  end
  
  love.graphics.draw(teamAColors.mesh, 400, 205, 0, 260, 260)
  love.graphics.draw(teamBColors.mesh, 860, 205, 0, 260, 260)
  
  for _, v in ipairs(Designer.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
    if string.find(v.id, "bg") or string.find(v.id, "fg") then
      love.graphics.setLineWidth(1)
      love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
      love.graphics.setLineWidth(0)
    end
  end
  for _, v in ipairs(Designer.texts) do
    love.graphics.setFont(v.font)
    love.graphics.setColor(v.color())
    if v.id == "matchTitle" or v.id == "teamAName" or v.id == "teamBName" then
      love.graphics.setScissor(v.x, v.y, v.width, 30)
    end
    love.graphics.printf(v.text(), v.x, v.y, v.width, v.align)
    love.graphics.setScissor()
    love.graphics.setColor(1,1,1,1)
  end
end

function MatchSetup:keypressed(key, scancode, isrepeat)
  
end

function MatchSetup:textinput()
  
end

function MatchSetup:mousemoved(x, y, dx, dy, istouch)
  ScoreboardState.tooltip = Lang.tooltips.matchSetup
  for _,v in ipairs(Designer.mouseBounds.default) do
    if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
      ScoreboardState.onMouseFocus = v.id
      -- show tooltip
      if Lang.matchSetup[ScoreboardState.onMouseFocus] then
        ScoreboardState.tooltip = Lang.matchSetup[ScoreboardState.onMouseFocus]
        break
      elseif Lang.config.tabTooltip[ScoreboardState.onMouseFocus] then
        ScoreboardState.tooltip = Lang.config.tabTooltip[ScoreboardState.onMouseFocus]
        break
      elseif ScoreboardState.onEdit.id ~= "" then
        ScoreboardState.tooltip = Lang.matchSetup.onEdit
      end
      -- if textfield or button, change to focus color
    else
      ScoreboardState.onMouseFocus = ""
    end
  end
end

function MatchSetup:mousepressed(x, y, button)
  
  --ScoreboardState.onDisplay = "BasketballScoreboard"
  --ScreenManager.changeScreen("BasketballScoreboard")
end

return MatchSetup