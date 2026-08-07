local ScoreboardState = require("data.ScoreboardState")
local TextStrings = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local Icons = require("ui.designs.Icons")

local Designer = {
  texts = {
    { id = "tooltip", text = function() return ScoreboardState.tooltip end,
      x = 20, y = 730, width = 1000, align = "left",
      font = function() return Fonts.tooltip end, color = function() return Color.white end },
    { id = "matchTitle",
      text = function() return ScoreboardState.matchTitle end,
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
    { id = "teamAScore", text = function() return ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] end,
      x = 220, y = 210, width = 380, align = "center",
      font = function() return Fonts.score end, color = function() return Color.white end },
    { id = "teamBScore", text = function() return ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] end,
      x = 680, y = 210, width = 380, align = "center",
      font = function() return Fonts.score end, color = function() return Color.white end },
    { id = "timeoutsLabel", text = function() return "Timeout(s) Left" end,
      x = 496, y = 550, width = 288, align = "center",
      font = function() return Fonts.counterLabel end, color = function() return Color.black end },
    { id = "set", text = function() return ".: " .. ScoreboardState.nsSet .. " :." end,
      x = 400, y = 615, width = 160, align = "center",
      font = function() return Fonts.nsSetScores end, color = function() return Color.white end },
    { id = "timeDisplay", text = function()
        return os.date("%I:%M %p"):gsub("^0", "")
      end,
      x = 560, y = 615, width = 320, align = "center",
      font = function() return Fonts.nsSetScores end, color = function() return Color.black end },
    { id = "teamAServeLabel", text = function() return "Serve Time" end,
      x = 40, y = 550, width = 170, align = "center",
      font = function() return Fonts.configTeam end, color = function()
        if ScoreboardState.serveTimerState > 0 and ScoreboardState.teamA.nsService == true then
          return Color.black
        end
        return Color.alpha
      end },
    { id = "teamAServeTimer", text = function() return ScoreboardState.serveTimer.displayText end,
      x = 40, y = 600, width = 170, align = "center",
      font = function() return Fonts.serveTimer end, color = function()
        if ScoreboardState.serveTimer.displayText ~= "0.0" and ScoreboardState.serveTimerState > 0
          and ScoreboardState.teamA.nsService == true then
          return Color.red
        elseif ScoreboardState.serveTimer.displayText == "0.0" and ScoreboardState.serveTimerState > 0
          and ScoreboardState.teamA.nsService == true then
          return Color.black
        end
        return Color.alpha
      end },
    { id = "teamBServeLabel", text = function() return "Serve Time" end,
      x = 1070, y = 550, width = 170, align = "center",
      font = function() return Fonts.configTeam end, color = function()
        if ScoreboardState.serveTimerState > 0 and ScoreboardState.teamB.nsService == true then
          return Color.black
        end
        return Color.alpha
      end },
    { id = "teamBServeTimer", text = function() return ScoreboardState.serveTimer.displayText end,
      x = 1070, y = 600, width = 170, align = "center",
      font = function() return Fonts.serveTimer end, color = function()
        if ScoreboardState.serveTimer.displayText ~= "0.0" and ScoreboardState.serveTimerState > 0
          and ScoreboardState.teamB.nsService == true then
          return Color.red
        elseif ScoreboardState.serveTimer.displayText == "0.0" and ScoreboardState.serveTimerState > 0
          and ScoreboardState.teamB.nsService == true then
          return Color.black
        end
        return Color.alpha
      end }
  },
  triangles = {
    {
      id = "teamAService", x1 = 40, y1 = 300, x2 = 120, y2 = 260, x3 = 120, y3 = 340,
      color = function()
        if ScoreboardState.teamA.nsService == true then return Color.white end
        return Color.alpha
      end
    },
    {
      id = "teamBService", x1 = 1240, y1 = 300, x2 = 1160, y2 = 260, x3 = 1160, y3 = 340,
      color = function()
        if ScoreboardState.teamB.nsService == true then return Color.white end
        return Color.alpha
      end
    }
  },
  tabButtons = {
    {
      id = "bbTab", x = 1030, y = 720, width = 60, height = 80, icon = function() return Icons.basketball end,
      color = function() return Color.textField.bg.enabled end
    },
    {
      id = "nsTab", x = 1090, y = 720, width = 60, height = 80, icon = function() 
        if ScoreboardState.config.ns.sportToPlay == "volleyball" then return Icons.volleyball
        elseif ScoreboardState.config.ns.sportToPlay == "badminton" then return Icons.badminton
        elseif ScoreboardState.config.ns.sportToPlay == "tabletennis" then return Icons.tabletennis
        else return Icons.pickleball end
      end,
      color = function() return Color.tabButton.bg.active end
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
    { id = "matchTitle", x = 40, y = 40, width = 1200, height = 60,
      color = function() return Color.white end },
    { id = "vsLabel", x = 600, y = 120, width = 80, height = 60,
      color = function() return Color.white end },
    { id = "teamAScore", x = 220, y = 200, width = 380, height = 200,
      color = function() return Color.black end },
    { id = "teamBScore", x = 680, y = 200, width = 380, height = 200,
      color = function() return Color.black end },
    { id = "timeoutsLabel", x = 496, y = 540, width = 288, height = 50,
      color = function() return Color.white end },
    { id = "set", x = 400, y = 610, width = 160, height = 70,
      color = function() return Color.black end },
    { id = "timeDisplay", x = 560, y = 610, width = 320, height = 70,
      color = function() return Color.white end },
    { id = "teamAServeLabel", x = 40, y = 550, width = 170, height = 40,
      color = function() 
        if ScoreboardState.serveTimerState > 0 and ScoreboardState.teamA.nsService == true then
          return Color.white
        end
        return Color.alpha
      end },
    { id = "teamAServeTimer", x = 40, y = 590, width = 170, height = 90,
      color = function() 
        if ScoreboardState.serveTimer.displayText ~= "0.0" and ScoreboardState.serveTimerState > 0
          and ScoreboardState.teamA.nsService == true then
          return Color.black
        elseif ScoreboardState.serveTimer.displayText == "0.0" and ScoreboardState.serveTimerState > 0
          and ScoreboardState.teamA.nsService == true then
          return Color.red
        end
        return Color.alpha
      end },
    { id = "teamBServeLabel", x = 1070, y = 550, width = 170, height = 40,
      color = function() 
        if ScoreboardState.serveTimerState > 0 and ScoreboardState.teamB.nsService == true then
          return Color.white
        end
        return Color.alpha
      end },
    { id = "teamBServeTimer", x = 1070, y = 590, width = 170, height = 90,
      color = function() 
        if ScoreboardState.serveTimer.displayText ~= "0.0" and ScoreboardState.serveTimerState > 0
          and ScoreboardState.teamB.nsService == true then
          return Color.black
        elseif ScoreboardState.serveTimer.displayText == "0.0" and ScoreboardState.serveTimerState > 0
          and ScoreboardState.teamB.nsService == true then
          return Color.red
        end
        return Color.alpha
      end }
  },
  mouseBounds = {
    
  }
}

return Designer