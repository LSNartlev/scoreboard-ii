local ScoreboardState = require("data.ScoreboardState")
local TextStrings = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local Icons = require("ui.designs.Icons")

local Designer = {
  texts = {
    -- id, text, x, y, width, align, font, color
    { id = "tooltip", text = function() return ScoreboardState.tooltip end,
      x = 20, y = 730, width = 1000, align = "left",
      font = function() return Fonts.tooltip end, color = function() return Color.white end },
    { id = "matchTitle",
      text = function() 
        if ScoreboardState.isTimerAdjustmentEnabled then
          return "Adjusting Timers. Please wait..."
        end
        return ScoreboardState.matchTitle 
      end,
      x = 40, y = 50, width = 1200, align = "center",
      font = function() return Fonts.matchInfo end, color = function() return Color.black end },
    { id = "teamAName", text = function() return ScoreboardState.teamA.name end,
      x = 40, y = 130, width = 560, align = "center",
      font = function() return Fonts.matchInfo end,
      color = function()
        local r, g, b = ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, ScoreboardState.teamA.fgColor.b
        return { r, g, b }
      end },
    { id = "vsLabel", text = function() return "VS" end,
      x = 600, y = 130, width = 80, align = "center",
      font = function() return Fonts.matchInfo end, color = function() return Color.black end },
    { id = "teamBName", text = function() return ScoreboardState.teamB.name end,
      x = 680, y = 130, width = 560, align = "center",
      font = function() return Fonts.matchInfo end,
      color = function()
        local r, g, b = ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, ScoreboardState.teamB.fgColor.b
        return { r, g, b }
      end },
    { id = "teamFoulsLabel", text = function() return "Team Fouls" end,
      x = 500, y = 430, width = 280, align = "center",
      font = function() return Fonts.counterLabel end, color = function() return Color.black end },
    { id = "timeoutsLabel", text = function() return "Timeout(s) Left" end,
      x = 500, y = 490, width = 280, align = "center",
      font = function() return Fonts.counterLabel end, color = function() return Color.black end },
    { id = "teamAScore", text = function() return ScoreboardState.teamA.bbScore end,
      x = 150, y = 210, width = 450, align = "center",
      font = function() return Fonts.score end, color = function() return Color.white end },
    { id = "teamBScore", text = function() return ScoreboardState.teamB.bbScore end,
      x = 680, y = 210, width = 450, align = "center",
      font = function() return Fonts.score end, color = function() return Color.white end },
    { id = "period", text = function() return TextStrings.bbPeriod[ScoreboardState.bbPeriod] end,
      x = 150, y = 555, width = 280, align = "center",
      font = function() return Fonts.bbTimer end, color = function() return Color.white end } ,
    {
      id = "periodTimer", text = function() return ScoreboardState.periodTimer.displayText end,
      x = 440, y = 555, width = 400, align = "center",
      font = function()
        if ScoreboardState.isTimerAdjustmentEnabled then
          return Fonts.bbTimerEdit
        end
        return Fonts.bbTimer
      end,
      color = function()
        if ScoreboardState.isPeriodTimerEnabled then return Color.black
        else return Color.alpha
        end
      end
    },
    {
      id = "shotClock", text = function() return ScoreboardState.shotClock.displayText end,
      x = 850, y = 555, width = 280, align = "center",
      font = function()
        if ScoreboardState.isTimerAdjustmentEnabled then return Fonts.bbTimerEdit end
        return Fonts.bbTimer
      end,
      color = function()
        if ScoreboardState.isShotClockEnabled == false then return Color.alpha
        elseif ScoreboardState.shotClock.displayText == "0.0" then return Color.black
        elseif ScoreboardState.isTimerAdjustmentEnabled then return Color.blue
        else return Color.red
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
        if ScoreboardState.isHornSoundPlaying then return Color.white end
        return Color.alpha
      end
    },
    {
      id = "periodTimer", x1 = 810, y1 = 680, x2 = 840, y2 = 650, x3 = 840, y3 = 680,
      color = function()
        if ScoreboardState.isPeriodTimerEnabled == false then return Color.alpha 
        elseif ScoreboardState.isPeriodTimerRunning == false then return Color.red
        end
        return Color.alpha
      end
    },
    {
      id = "shotClock", x1 = 1100, y1 = 680, x2 = 1130, y2 = 650, x3 = 1130, y3 = 680,
      color = function()
        if ScoreboardState.isShotClockRunning == false and ScoreboardState.isShotClockEnabled == true then
          return Color.red
        end
        return Color.alpha
      end
    }
  },
  tabButtons = {
    {
      id = "bbTab", x = 1030, y = 720, width = 60, height = 80, icon = function() return Icons.basketball end,
      color = function() return Color.tabButton.bg.active end
    },
    {
      id = "nsTab", x = 1090, y = 720, width = 60, height = 80, icon = function() 
        if ScoreboardState.config.ns.sportToPlay == "Volleyball" then return Icons.volleyball
        elseif ScoreboardState.config.ns.sportToPlay == "Badminton" then return Icons.badminton
        elseif ScoreboardState.config.ns.sportToPlay == "Table Tennis" then return Icons.tabletennis
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
      color = function() return Color.textField.bg.enabled end
    }
  },
  rectangles = {
    -- id, x, y, width, height, color
    {
      id = "matchTitle", x = 40, y = 40, width = 1200, height = 60,
      color = function()
        if ScoreboardState.isTimerAdjustmentEnabled then return Color.blue end
        return Color.white
      end
    },
    { id = "vsLabel", x = 600, y = 120, width = 80, height = 60,
      color = function() return Color.white end },
    { id = "teamAScore", x = 150, y = 200, width = 450, height = 200,
      color = function() return Color.black end },
    { id = "teamBScore", x = 680, y = 200, width = 450, height = 200,
      color = function() return Color.black end },
    { id = "teamFoulsLabel", x = 500, y = 420, width = 280, height = 50,
      color = function() return Color.white end },
    { id = "timeoutsLabel", x = 500, y = 480, width = 280, height = 50,
      color = function() return Color.white end },
    { id = "period", x = 150, y = 550, width = 280, height = 130,
      color = function() return Color.black end },
    { id = "periodTimer", x = 440, y = 550, width = 400, height = 130,
      color = function()
        if ScoreboardState.isTimerAdjustmentEnabled then return Color.blue
        elseif ScoreboardState.periodTimer.displayText == "0.0" then return Color.red
        elseif (ScoreboardState.periodTimer.min*60 + ScoreboardState.periodTimer.sec +
          ScoreboardState.periodTimer.dSec/10) <= 120.9 and ScoreboardState.bbPeriod >= 4 then
          return Color.yellow
        end
        return Color.white
      end
    },
    {
      id = "shotClock", x = 850, y = 550, width = 280, height = 130,
      color = function()
        if ScoreboardState.shotClock.displayText == "0.0" then return Color.red end
        return Color.black
      end
    },
    { id = "footer", x = 0, y = 720, width = 1280, height = 80,
      color = function() return Color.footerBG end }
  },
  mouseBounds = {
    { id = "matchTitle", x1 = 40, y1 = 40, x2 = 1240, y2 = 100 },
    { id = "teamAName", x1 = 40, y1 = 120, x2 = 600, y2 = 180 },
    { id = "teamBName", x1 = 680, y1 = 120, x2 = 1240, y2 = 180 },
    { id = "teamAScore", x1 = 150, y1 = 200, x2 = 600, y2 = 400 },
    { id = "teamBScore", x1 = 680, y1 = 200, x2 = 1130, y2 = 400 },
    { id = "teamABallPoss", x1 = 40, y1 = 260, x2 = 120, y2 = 340 },
    { id = "teamBBallPoss", x1 = 1160, y1 = 260, x2 = 1240, y2 = 340 },
    { id = "teamAFouls", x1 = 150, y1 = 420, x2 = 490, y2 = 470 },
    { id = "teamBFouls", x1 = 790, y1 = 420, x2 = 1130, y2 = 470 },
    { id = "teamATimeouts", x1 = 150, y1 = 480, x2 = 490, y2 = 530 },
    { id = "teamBTimeouts", x1 = 790, y1 = 480, x2 = 1130, y2 = 530 },
    { id = "period", x1 = 150, y1 = 550, x2 = 430, y2 = 680 },
    { id = "periodTimer", x1 = 440, y1 = 550, x2 = 840, y2 = 680 },
    { id = "shotClock", x1 = 850, y1 = 550, x2 = 1130, y2 = 680 },
    { id = "bbTab", x1 = 1030, y1 = 720, x2 = 1090, y2 = 800 },
    { id = "nsTab", x1 = 1090, y1 = 720, x2 = 1150, y2 = 800 },
    { id = "configTab", x1 = 1150, y1 = 720, x2 = 1210, y2 = 800 },
    { id = "aboutTab", x1 = 1210, y1 = 720, x2 = 1270, y2 = 800 }
  }
}

return Designer