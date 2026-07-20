local ScoreboardState = require("data.ScoreboardState")
local TextStrings = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local Designer = {
  texts = {
    -- id, text, x, y, width, align, font
    { id = "tooltip", text = function() return ScoreboardState.tooltip end,
      x = 20, y = 730, width = 1000, align = "left",
      font = function() return Fonts.tooltip end, color = Color.white },
    { id = "matchInfo", text = function() return ScoreboardState.matchTitle end,
      x = 40, y = 40, width = 1200, align = "center",
      font = function() return Fonts.matchInfo end, color = Color.black },
    { id = "teamAName", text = function() return ScoreboardState.teamA.name end,
      x = 40, y = 120, width = 560, align = "center",
      font = function() return Fonts.matchInfo end,
      color = { ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, ScoreboardState.teamA.fgColor.b} },
    { id = "vsLabel", text = function() return "VS" end,
      x = 600, y = 120, width = 80, align = "center",
      font = function() return Fonts.matchInfo end, color = Color.black },
    { id = "teamBName", text = function() return ScoreboardState.teamB.name end,
      x = 680, y = 120, width = 560, align = "center",
      font = function() return Fonts.matchInfo end,
      color = { ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, ScoreboardState.teamB.fgColor.b} },
    { id = "teamFoulsLabel", text = function() return "Team Fouls" end,
      x = 500, y = 420, width = 280, align = "center",
      font = function() return Fonts.counterLabel end, color = Color.black },
    { id = "timeoutsLabel", text = function() return "Timeout(s) Left" end,
      x = 500, y = 480, width = 280, align = "center",
      font = function() return Fonts.counterLabel end, color = Color.black },
    { id = "teamAScore", text = function() return ScoreboardState.teamA.bbScore end,
      x = 150, y = 200, width = 450, align = "center",
      font = function() return Fonts.score end, color = Color.white },
    { id = "teamBScore", text = function() return ScoreboardState.teamB.bbScore end,
      x = 680, y = 200, width = 450, align = "center",
      font = function() return Fonts.score end, color = Color.white },
    { id = "periodText", text = function() return TextStrings.bbPeriod[ScoreboardState.bbPeriod] end,
      x = 150, y = 550, width = 280, align = "center",
      font = function() return Fonts.bbTimer end, color = Color.white } ,
    {
      id = "periodTimer", text = function() return ScoreboardState.periodTimer.displayText end,
      x = 440, y = 550, width = 400, align = "center",
      font = function()
        if ScoreboardState.isTimerAdjustmentEnabled then
          return Fonts.bbTimer
        end
        return Fonts.bbTimerEdit
      end,
      color = function()
        if ScoreboardState.isTimerAdjustmentEnabled then
          return Color.black
        end
        return Color.white
      end
    },
    {
      id = "shotClock", text = function() return ScoreboardState.shotClock.displayText end,
      x = 850, y = 550, width = 280, align = "center",
      font = function()
        if ScoreboardState.isTimerAdjustmentEnabled then return Fonts.bbTimer end
        return Fonts.bbTimerEdit
      end,
      color = function()
        if ScoreboardState.isTimerAdjustmentEnabled then return Color.blue
        elseif ScoreboardState.shotClock.displayText == "0.0" then return Color.black
        elseif ScoreboardState.isShotClockEnabled then return Color.red
        else return Color.alpha
        end
      end
    }
  },
  triangles = {
    -- id, x1, y1, x2, y2, x3, y3, color
    
  },
  markers = {
  },
  tabButtons = {
  },
  rectangles = {
  },
  backgrounds = {
  }
}

return Designer