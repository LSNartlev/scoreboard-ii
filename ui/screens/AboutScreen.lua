local AboutScreen = {}
local ScoreboardState = require("data.ScoreboardState")
local ScreenManager = require("ui.ScreenManager")
local Lang = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local Icons = require("ui.designs.Icons")
local Designer, fullLogo

function AboutScreen:load()
  ScoreboardState.tooltip = Lang.about.tooltip
  Designer = {
    tabButtons = {
      {
        id = "bbTab", x = 1030, y = 720, width = 60, height = 80, icon = function() return Icons.basketball end,
        color = function() return Color.textField.bg.enabled end
      },
      {
        id = "nsTab", x = 1090, y = 720, width = 60, height = 80, icon = function() 
          if ScoreboardState.config.ns.sportToPlay == "volleyball" then return Icons.volleyball
          elseif ScoreboardState.config.ns.sportToPlay == "badminton" then return Icons.badminton
          elseif ScoreboardState.config.ns.sportToPlay == "table tennis" then return Icons.tabletennis
          else return Icons.pickleball end
        end,
        color = function() return Color.textField.bg.enabled end
      },
      {
        id = "configTab", x = 1150, y = 720, width = 60, height = 80, icon = function() return Icons.config end,
        color = function() return Color.textField.bg.enabled end
      },
      {
        id = "aboutTab", x = 1210, y = 720, width = 60, height = 80, icon = function() return Icons.about end,
        color = function() return Color.tabButton.bg.active end
      },
    },
    bg = {
      { id = "bgFallback", x = 0, y = 0, width = 1280, height = 720, color = function() return Color.screenFallbackBG end },
      { id = "footer", x = 0, y = 720, width = 1280, height = 80, color = function() return Color.footerBG end }
    },
    mouseBounds = {
      { id = "bbTab", x1 = 1030, y1 = 720, x2 = 1090, y2 = 800 },
      { id = "nsTab", x1 = 1090, y1 = 720, x2 = 1150, y2 = 800 },
      { id = "configTab", x1 = 1150, y1 = 720, x2 = 1210, y2 = 800 },
      { id = "aboutTab", x1 = 1210, y1 = 720, x2 = 1270, y2 = 800 }
    }
  }
  fullLogo = love.graphics.newImage("assets/fullLogo.png", { mipmaps = true })
end

function AboutScreen:update(dt)
end

function AboutScreen:draw()
  for _, v in ipairs(Designer.bg) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(Designer.tabButtons) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(v.icon(), v.x, v.y+10, 0, 60/v.icon():getWidth(), 60/v.icon():getHeight())
  end
  love.graphics.draw(fullLogo, 382, 40, 0, 1, 1)
  love.graphics.setFont(Fonts.about)
  love.graphics.printf(
    {
      Color.white, Lang.about.main .. "\n",
      Color.orange, Lang.about.free .. "\n\n\n",
      Color.blue, Lang.about.thirdParty .. "\n\n",
      Color.white, Lang.about.jsonlua .. "\n\n" .. Lang.about.oxanium .. "\n\n" .. Lang.about.openmoji, 
    },
    20, 240, 1240, "center"
  )
  love.graphics.setFont(Fonts.tooltip)
  love.graphics.printf(ScoreboardState.tooltip, 20, 730, 1000, "left")
end

function AboutScreen:mousepressed(x, y, button)
  for _, v in ipairs(Designer.mouseBounds) do
    if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
      if v.id == "bbTab" then
        ScreenManager.changeScreen("BasketballScoreboard")
      elseif v.id == "nsTab" then
        ScreenManager.changeScreen("NetSportScoreboard")
      elseif v.id == "configTab" then
        ScreenManager.changeScreen("MatchSetup")
      end
      break
    end
  end
end

return AboutScreen