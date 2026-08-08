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
    { id = "teamBScore", text = function() return ScoreboardState.teamB.nsScore[ScoreboardState.nsSet] end,
      x = 680, y = 210, width = 380, align = "center",
      font = function() return Fonts.score end, color = function() return Color.white end },
    { id = "timeoutsLabel", text = function() return "Timeout(s) Left" end,
      x = 520, y = 555, width = 240, align = "center",
      font = function() return Fonts.configTeam end, color = function() return Color.black end },
    { id = "set", text = function() return ".: " .. ScoreboardState.nsSet .. " :." end,
      x = 400, y = 615, width = 160, align = "center",
      font = function() return Fonts.nsSetScores end, color = function() return Color.white end },
    { id = "timeDisplay", text = function()
        return os.date("%I:%M %p"):gsub("^0", "")
      end,
      x = 560, y = 615, width = 320, align = "center",
      font = function() return Fonts.nsSetScores end, color = function() return Color.black end },
    { id = "teamAServeLabel", text = function() return "Serve Time" end,
      x = 40, y = 555, width = 170, align = "center",
      font = function() return Fonts.configTeam end, color = function()
        if ScoreboardState.serveTimerState > 0 and ScoreboardState.teamA.nsService == true then
          return Color.black
        end
        return Color.alpha
      end },
    { id = "teamAServeTimer", text = function() return ScoreboardState.serveTimer.displayText end,
      x = 40, y = 595, width = 170, align = "center",
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
      x = 1070, y = 555, width = 170, align = "center",
      font = function() return Fonts.configTeam end, color = function()
        if ScoreboardState.serveTimerState > 0 and ScoreboardState.teamB.nsService == true then
          return Color.black
        end
        return Color.alpha
      end },
    { id = "teamBServeTimer", text = function() return ScoreboardState.serveTimer.displayText end,
      x = 1070, y = 595, width = 170, align = "center",
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
  setScores = {
    texts = {
      {
        id = "labelA1", text = function()
          if ScoreboardState.nsSummary.teamA[1] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamA[1] .. " :."
        end,
        x = 40, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamA[1] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[1] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelA2", text = function()
          if ScoreboardState.nsSummary.teamA[2] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamA[2] .. " :."
        end,
        x = 154, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamA[2] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[2] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelA3", text = function()
          if ScoreboardState.nsSummary.teamA[3] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamA[3] .. " :."
        end,
        x = 268, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamA[3] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[3] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelA4", text = function()
          if ScoreboardState.nsSummary.teamA[4] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamA[4] .. " :."
        end,
        x = 382, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamA[4] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[4] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelA5", text = function()
          if ScoreboardState.nsSummary.teamA[5] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamA[5] .. " :."
        end,
        x = 496, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamA[5] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[5] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelB1", text = function()
          if ScoreboardState.nsSummary.teamB[1] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamB[1] .. " :."
        end,
        x = 680, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamB[1] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[1] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelB2", text = function()
          if ScoreboardState.nsSummary.teamB[2] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamB[2] .. " :."
        end,
        x = 794, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamB[2] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[2] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelB3", text = function()
          if ScoreboardState.nsSummary.teamB[3] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamB[3] .. " :."
        end,
        x = 908, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamB[3] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[3] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelB4", text = function()
          if ScoreboardState.nsSummary.teamB[4] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamB[4] .. " :."
        end,
        x = 1022, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamB[4] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[4] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelB5", text = function()
          if ScoreboardState.nsSummary.teamB[5] == 0 then return "" end
          return ".: " .. ScoreboardState.nsSummary.teamB[5] .. " :."
        end,
        x = 1136, y = 425, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSummary.teamB[5] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[5] == ScoreboardState.nsSet then return Color.black end
          return Color.white
        end
      },
      {
        id = "scoreA1", text = function()
          if ScoreboardState.nsSummary.teamA[1] == 0 then return "" end
          return ScoreboardState.teamA.nsScore[ScoreboardState.nsSummary.teamA[1]]
        end,
        x = 40, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamA[1]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamA.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      },
      {
        id = "scoreA2", text = function()
          if ScoreboardState.nsSummary.teamA[2] == 0 then return "" end
          return ScoreboardState.teamA.nsScore[ScoreboardState.nsSummary.teamA[2]]
        end,
        x = 154, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamA[2]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamA.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      },
      {
        id = "scoreA3", text = function()
          if ScoreboardState.nsSummary.teamA[3] == 0 then return "" end
          return ScoreboardState.teamA.nsScore[ScoreboardState.nsSummary.teamA[3]]
        end,
        x = 268, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamA[3]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamA.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      },
      {
        id = "scoreA4", text = function()
          if ScoreboardState.nsSummary.teamA[4] == 0 then return "" end
          return ScoreboardState.teamA.nsScore[ScoreboardState.nsSummary.teamA[4]]
        end,
        x = 382, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamA[4]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamA.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      },
      {
        id = "scoreA5", text = function()
          if ScoreboardState.nsSummary.teamA[5] == 0 then return "" end
          return ScoreboardState.teamA.nsScore[ScoreboardState.nsSummary.teamA[5]]
        end,
        x = 496, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamA[5]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamA.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      },
      {
        id = "scoreB1", text = function()
          if ScoreboardState.nsSummary.teamB[1] == 0 then return "" end
          return ScoreboardState.teamB.nsScore[ScoreboardState.nsSummary.teamB[1]]
        end,
        x = 680, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamB[1]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamB.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      },
      {
        id = "scoreB2", text = function()
          if ScoreboardState.nsSummary.teamB[2] == 0 then return "" end
          return ScoreboardState.teamB.nsScore[ScoreboardState.nsSummary.teamB[2]]
        end,
        x = 794, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamB[2]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamB.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      },
      {
        id = "scoreB3", text = function()
          if ScoreboardState.nsSummary.teamB[3] == 0 then return "" end
          return ScoreboardState.teamB.nsScore[ScoreboardState.nsSummary.teamB[3]]
        end,
        x = 908, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamB[3]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamB.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      },
      {
        id = "scoreB4", text = function()
          if ScoreboardState.nsSummary.teamB[4] == 0 then return "" end
          return ScoreboardState.teamB.nsScore[ScoreboardState.nsSummary.teamB[4]]
        end,
        x = 1022, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamB[4]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamB.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      },
      {
        id = "scoreB5", text = function()
          if ScoreboardState.nsSummary.teamB[5] == 0 then return "" end
          return ScoreboardState.teamB.nsScore[ScoreboardState.nsSummary.teamB[5]]
        end,
        x = 1136, y = 465, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          local i = ScoreboardState.nsSummary.teamB[5]
          if i == 0 then return Color.alpha
          elseif ScoreboardState.teamB.nsScore[i] == ScoreboardState.nsTargetScore[i] then return Color.yellow end
          return Color.white
        end
      }
    },
    rectangles = {
      { id = "labelA1", x = 40, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamA[1] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[1] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "labelA2", x = 154, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamA[2] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[2] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "labelA3", x = 268, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamA[3] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[3] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "labelA4", x = 382, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamA[4] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[4] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "labelA5", x = 496, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamA[5] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamA[5] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "labelB1", x = 680, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamB[1] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[1] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "labelB2", x = 794, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamB[2] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[2] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "labelB3", x = 908, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamB[3] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[3] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "labelB4", x = 1022, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamB[4] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[4] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "labelB5", x = 1136, y = 420, width = 104, height = 40, color = function()
          if ScoreboardState.nsSummary.teamB[5] == 0 then return Color.alpha
          elseif ScoreboardState.nsSummary.teamB[5] == ScoreboardState.nsSet then return Color.white end
          return Color.black
        end },
      { id = "scoreA1", x = 40, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamA[1] == 0 then return Color.alpha end return 0,0,0,0.7 end },
      { id = "scoreA2", x = 154, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamA[2] == 0 then return Color.alpha end return 0,0,0,0.7 end },
      { id = "scoreA3", x = 268, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamA[3] == 0 then return Color.alpha end return 0,0,0,0.7 end },
      { id = "scoreA4", x = 382, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamA[4] == 0 then return Color.alpha end return 0,0,0,0.7 end },
      { id = "scoreA5", x = 496, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamA[5] == 0 then return Color.alpha end return 0,0,0,0.7 end },
      { id = "scoreB1", x = 680, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamB[1] == 0 then return Color.alpha end return 0,0,0,0.7 end },
      { id = "scoreB2", x = 794, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamB[2] == 0 then return Color.alpha end return 0,0,0,0.7 end },
      { id = "scoreB3", x = 908, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamB[3] == 0 then return Color.alpha end return 0,0,0,0.7 end },
      { id = "scoreB4", x = 1022, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamB[4] == 0 then return Color.alpha end return 0,0,0,0.7 end },
      { id = "scoreB5", x = 1136, y = 460, width = 104, height = 70, color = function()
          if ScoreboardState.nsSummary.teamB[5] == 0 then return Color.alpha end return 0,0,0,0.7 end }
    }
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
    { id = "timeoutsLabel", x = 520, y = 550, width = 240, height = 40,
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