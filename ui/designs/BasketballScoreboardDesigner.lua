local ScoreboardState = require("data.ScoreboardState")
local TextStrings = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local gradRect = require("ui.designs.GradientRectangle")
local Designer = {
  texts = {
    -- id, text, x, y, width, align, font
    { id = "tooltip", text = function() return ScoreboardState.tooltip end,
      x = 20, y = 730, width = 1000, align = "left",
      font = function() return Fonts.tooltip end, color = function() return Color.white end },
    { id = "matchInfo", text = function() return ScoreboardState.matchTitle end,
      x = 40, y = 40, width = 1200, align = "center",
      font = function() return Fonts.matchInfo end, color = function() return Color.black end },
    { id = "teamAName", text = function() return ScoreboardState.teamA.name end,
      x = 40, y = 120, width = 560, align = "center",
      font = function() return Fonts.matchInfo end,
      color = function() return { ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, ScoreboardState.teamA.fgColor.b} end },
    { id = "vsLabel", text = function() return "VS" end,
      x = 600, y = 120, width = 80, align = "center",
      font = function() return Fonts.matchInfo end, color = function() return Color.black end },
    { id = "teamBName", text = function() return ScoreboardState.teamB.name end,
      x = 680, y = 120, width = 560, align = "center",
      font = function() return Fonts.matchInfo end,
      color = function() return { ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, ScoreboardState.teamB.fgColor.b} end },
    { id = "teamFoulsLabel", text = function() return "Team Fouls" end,
      x = 500, y = 420, width = 280, align = "center",
      font = function() return Fonts.counterLabel end, color = function() return Color.black end },
    { id = "timeoutsLabel", text = function() return "Timeout(s) Left" end,
      x = 500, y = 480, width = 280, align = "center",
      font = function() return Fonts.counterLabel end, color = function() return Color.black end },
    { id = "teamAScore", text = function() return ScoreboardState.teamA.bbScore end,
      x = 150, y = 200, width = 450, align = "center",
      font = function() return Fonts.score end, color = function() return Color.white end },
    { id = "teamBScore", text = function() return ScoreboardState.teamB.bbScore end,
      x = 680, y = 200, width = 450, align = "center",
      font = function() return Fonts.score end, color = function() return Color.white end },
    { id = "period", text = function() return TextStrings.bbPeriod[ScoreboardState.bbPeriod] end,
      x = 150, y = 550, width = 280, align = "center",
      font = function() return Fonts.bbTimer end, color = function() return Color.white end } ,
    {
      id = "periodTimer", text = function() return ScoreboardState.periodTimer.displayText end,
      x = 440, y = 550, width = 400, align = "center",
      font = function()
        if ScoreboardState.isTimerAdjustmentEnabled then
          return Fonts.bbTimerEdit
        end
        return Fonts.bbTimer
      end,
      color = function()
        if ScoreboardState.isTimerAdjustmentEnabled then
          return Color.blue
        end
        return Color.black
      end
    },
    {
      id = "shotClock", text = function() return ScoreboardState.shotClock.displayText end,
      x = 850, y = 550, width = 280, align = "center",
      font = function()
        if ScoreboardState.isTimerAdjustmentEnabled then return Fonts.bbTimerEdit end
        return Fonts.bbTimer
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
    {
      id = "teamABallPoss", x1 = 40, y1 = 300, x2 = 120, y2 = 260, x3 = 120, y3 = 340,
      color = function()
        if ScoreboardState.teamA.bbBallPoss == true then return Color.white end
        return Color.alpha
      end
    },
    {
      id = "teamBBallPoss", x1 = 1240, y1 = 300, x2 = 1160, y2 = 260, x3 = 1160, y3 = 340,
      color = function()
        if ScoreboardState.teamB.bbBallPoss == true then return Color.white end
        return Color.alpha
      end
    },
    {
      id = "period", x1 = 400, y1 = 680, x2 = 430, y2 = 650, x3 = 430, y3 = 680,
      color = function()
        if ScoreboardState.isHornSoundPlaying then return Color.yellow end
        return Color.alpha
      end
    },
    {
      id = "periodTimer", x1 = 810, y1 = 680, x2 = 840, y2 = 650, x3 = 840, y3 = 680,
      color = function()
        if ScoreboardState.isPeriodTimerRunning == false then return Color.red end
        return Color.alpha
      end
    },
    {
      id = "shotClock", x1 = 1100, y1 = 680, x2 = 1130, y2 = 650, x3 = 1130, y3 = 680,
      color = function()
        if ScoreboardState.isShotClockRunning == false then return Color.red end
        return Color.alpha
      end
    }
  },
  markers = {
  },
  tabButtons = {
  },
  rectangles = {
    -- id, x, y, width, height, color
    {
      id = "matchInfo", x = 40, y = 40, width = 1200, height = 60,
      color = function()
        if ScoreboardState.isTimerAdjustmentEnabled then return Color.blue end
        return Color.white
      end
    },
    { id = "vsLabel", x = 600, y = 120, width = 80, height = 60,
      color = function() return Color.white end },
    { id = "teamAScore", x = 150, y = 120, width = 450, height = 200,
      color = function() return Color.black end },
    { id = "teamBScore", x = 680, y = 200, width = 450, height = 200,
      color = function() return Color.black end },
    { id = "teamFoulsLabel", x = 500, y = 420, width = 280, height = 50,
      color = function() return Color.white end },
    { id = "timeoutsLabel", x = 500, y = 480, width = 280, height = 50,
      color = function() return Color.white end },
    { id = "period", x = 150, y = 550, width = 280, height = 130,
      color = function() return Color.black end },
    {
      id = "periodTimer", x = 440, y = 550, width = 400, height = 130,
      color = function()
        if ScoreboardState.isTimerAdjustmentEnabled then return Color.blue end
        return Color.white
      end
    },
    {
      id = "shotClock", x = 850, y = 550, width = 280, height = 130,
      color = function()
        if ScoreboardState.isTimerAdjustmentEnabled then return Color.black
        elseif ScoreboardState.shotClock.displayText == "0.0" then return Color.red
        elseif ScoreboardState.isShotClockEnabled then return Color.black
        else return Color.alpha
        end
      end
    },
    { id = "footer", x = 0, y = 720, width = 1280, height = 80,
      color = function() return Color.footerBG end },
  },
  backgrounds = {
  }
}

return Designer