local TeamSetup = {}
local utf8 = require("utf8") -- see MatchSetup:keypressed()
local ScreenManager = require("ui.ScreenManager")
local ScoreboardState = require("data.ScoreboardState")
local ConfigDesigner = require("ui.designs.ConfigDesigner")
local Designer = require("ui.designs.TeamSetupDesigner")
local TeamsList = require("data.TeamsList")
local Lang = require("data.language.en")
local gradRect = require("ui.designs.GradientMesh")
local team = require("data.TeamDetails")
local hueSlider
local gradToDraw, teamList

function TeamSetup:load()
  if ScoreboardState.teamSetup.side ~= "" then
    ScoreboardState.config.tabs.isSelectable = false
  end
  hueSlider = love.graphics.newImage("assets/hueSlider.png", { mipmaps = true })
  teamList = {
    
  }
end

function TeamSetup:update(dt)
end

function TeamSetup:draw()
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
  
  for _, v in ipairs(Designer.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  love.graphics.draw(hueSlider, 260, 250)
  
  for _, v in ipairs(Designer.circles) do
    love.graphics.setColor(v.color())
    love.graphics.circle("fill", v.x, v.y, v.radius)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(Designer.sliderThumbs) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y(), v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(Designer.texts) do
    love.graphics.setFont(v.font)
    love.graphics.setColor(v.color())
    if v.id == "teamName" then
      love.graphics.setScissor(v.x, v.y, v.width, 30)
    end
    if ScoreboardState.onEdit.id == v.id then
      local sec = math.floor((love.timer.getTime()*10)%8)
      local cursorColor = function()
        if sec < 4 then return {0,0,0,0}
        else return Color.orange
        end
      end
      love.graphics.printf(
      {
        v.color(), v.text(),
        cursorColor(), "_"
      },
      v.x, v.y, v.width, v.align)
    else
      love.graphics.printf(v.text(), v.x, v.y, v.width, v.align)
    end
    love.graphics.setScissor()
    love.graphics.setColor(1,1,1,1)
  end
  
end

function TeamSetup:textinput(text)
end

function TeamSetup:mousemoved(x, y, dx, dy, istouch)
end

function TeamSetup:mousepressed(x, y, button)
end

return TeamSetup