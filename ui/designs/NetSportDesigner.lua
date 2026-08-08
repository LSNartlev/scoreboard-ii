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
          if ScoreboardState.config.ns.maxSets < 5 then return ""
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            local toDisplay = ScoreboardState.nsSet - 4
            if ScoreboardState.nsSet > 5 then return ".: " .. toDisplay .. " :."
            else return ".: 1 :." end
          end
        end,
        x = 40, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.config.ns.maxSets < 5 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet == 1 then return Color.black end
          end
          return Color.white
        end
      },
      {
        id = "labelA2", text = function()
          if ScoreboardState.config.ns.maxSets < 5 then return ""
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            local toDisplay = ScoreboardState.nsSet - 3
            if ScoreboardState.nsSet > 5 then return ".: " .. toDisplay .. " :." end
            return ".: 2 :."
          end
        end,
        x = 154, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.config.ns.maxSets < 5 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet == 2 then return Color.black end
          end
          return Color.white
        end
      },
      {
        id = "labelA3", text = function()
          if ScoreboardState.config.ns.maxSets == 3 then return ".: 1 :."
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            local toDisplay = ScoreboardState.nsSet - 2
            if ScoreboardState.nsSet > 5 then return ".: " .. toDisplay .. " :." end
            return ".: 3 :."
          end
        end,
        x = 268, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.config.ns.maxSets < 3 then return Color.alpha
          elseif (ScoreboardState.config.ns.maxSets == 3 and ScoreboardState.nsSet == 1)
            or (ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet == 3) then
            return Color.black
          end
          return Color.white
        end
      },
      {
        id = "labelA4", text = function()
          if ScoreboardState.config.ns.maxSets == 3 then return ".: 2 :."
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            local toDisplay = ScoreboardState.nsSet - 1
            if ScoreboardState.nsSet > 5 then return ".: " .. toDisplay .. " :." end
            return ".: 4 :."
          end
        end,
        x = 382, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.config.ns.maxSets < 3 then return Color.alpha
          elseif (ScoreboardState.config.ns.maxSets == 3 and ScoreboardState.nsSet == 2)
            or (ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet == 4) then
            return Color.black
          end
          return Color.white
        end
      },
      {
        id = "labelA5", text = function()
          if ScoreboardState.config.ns.maxSets == 3 then return ".: 3 :."
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet >= 5 then return ".: " .. ScoreboardState.nsSet .. " :." end
            return ".: 5 :."
          end
        end,
        x = 496, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.config.ns.maxSets < 3 then return Color.alpha
          elseif (ScoreboardState.config.ns.maxSets == 3 and ScoreboardState.nsSet == 3)
            or (ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet >= 5) then
            return Color.black
          end
          return Color.white
        end
      },
      {
        id = "labelB1", text = function()
          if ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            local toDisplay = ScoreboardState.nsSet - 4
            return ".: " .. toDisplay .. " :." end
          return ".: 1 :."
        end,
        x = 680, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSet == 1 then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelB2", text = function()
          if ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            local toDisplay = ScoreboardState.nsSet - 3
            return ".: " .. toDisplay .. " :." end
          return ".: 2 :."
        end,
        x = 794, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSet == 2 then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelB3", text = function()
          if ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            local toDisplay = ScoreboardState.nsSet - 2
            return ".: " .. toDisplay .. " :." end
          return ".: 3 :."
        end,
        x = 908, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.nsSet == 3 then return Color.black end
          return Color.white
        end
      },
      {
        id = "labelB4", text = function()
          if ScoreboardState.config.ns.maxSets <= 3 then return ""
          elseif ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            local toDisplay = ScoreboardState.nsSet - 1
            return ".: " .. toDisplay .. " :."
          else return ".: 4 :." end
        end,
        x = 1022, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.config.ns.maxSets < 5 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet == 4 then return Color.black end
            return Color.white
          end
        end
      },
      {
        id = "labelB5", text = function()
          if ScoreboardState.config.ns.maxSets <= 3 then return ""
          elseif ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            return ".: " .. ScoreboardState.nsSet .. " :."
          else return ".: 5 :." end
        end,
        x = 1136, y = 420, width = 104, align = "center", font = Fonts.counterLabel, color = function()
          if ScoreboardState.config.ns.maxSets < 5 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet >= 5 then return Color.black end
            return Color.white
          end
        end
      },
      {
        id = "scoreA1", text = function()
          if ScoreboardState.config.ns.maxSets < 5 then return ""
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet > 5 then return ScoreboardState.teamA.nsScore[ScoreboardState.nsSet-4] end
            return ScoreboardState.teamA.nsScore[1]
          end
        end,
        x = 40, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets < 5 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet > 5 and
              ScoreboardState.teamA.nsScore[ScoreboardState.nsSet-4] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet-4] then
              return Color.yellow end
            return Color.white
          end
        end
      },
      {
        id = "scoreA2", text = function()
          if ScoreboardState.config.ns.maxSets < 5 then return ""
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet < 2 then return "" end
            if ScoreboardState.nsSet > 5 then return ScoreboardState.teamA.nsScore[ScoreboardState.nsSet-3] end
            return ScoreboardState.teamA.nsScore[2]
          end
        end,
        x = 154, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets < 5 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet > 5 and
              ScoreboardState.teamA.nsScore[ScoreboardState.nsSet-3] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet-3] then
              return Color.yellow end
            return Color.white
          end
        end
      },
      {
        id = "scoreA3", text = function()
          if ScoreboardState.config.ns.maxSets < 3 then return ""
          elseif ScoreboardState.config.ns.maxSets == 3 then return ScoreboardState.teamA.nsScore[1]
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet < 3 then return "" end
            if ScoreboardState.nsSet > 5 then return ScoreboardState.teamA.nsScore[ScoreboardState.nsSet-2]
            else return ScoreboardState.teamA.nsScore[3] end
          end
        end,
        x = 268, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets < 3 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 3 then
            if (ScoreboardState.nsSet > 5 and
              ScoreboardState.teamA.nsScore[ScoreboardState.nsSet-2] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet-2])
              or (ScoreboardState.nsSet == 5 and
              ScoreboardState.teamA.nsScore[3] == ScoreboardState.nsTargetScore[3])
              or (ScoreboardState.nsSet == 3 and
              ScoreboardState.teamA.nsScore[1] == ScoreboardState.nsTargetScore[1]) then
              return Color.yellow end
            return Color.white
          end
        end
      },
      {
        id = "scoreA4", text = function()
          if ScoreboardState.config.ns.maxSets < 3 then return ""
          elseif ScoreboardState.config.ns.maxSets == 3 then 
            if ScoreboardState.nsSet < 2 then return "" end
            return ScoreboardState.teamA.nsScore[2]
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet < 4 then return "" end
            if ScoreboardState.nsSet > 5 then return ScoreboardState.teamA.nsScore[ScoreboardState.nsSet-1]
            else return ScoreboardState.teamA.nsScore[4] end
          end
        end,
        x = 382, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets < 3 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 3 then
            if (ScoreboardState.nsSet > 5 and
              ScoreboardState.teamA.nsScore[ScoreboardState.nsSet-1] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet-1])
              or (ScoreboardState.nsSet == 5 and
              ScoreboardState.teamA.nsScore[4] == ScoreboardState.nsTargetScore[4])
              or (ScoreboardState.nsSet == 3 and
              ScoreboardState.teamA.nsScore[2] == ScoreboardState.nsTargetScore[2]) then
              return Color.yellow end
            return Color.white
          end
        end
      },
      {
        id = "scoreA5", text = function()
          if ScoreboardState.config.ns.maxSets < 3 then return ""
          elseif ScoreboardState.config.ns.maxSets == 3 then
            if ScoreboardState.nsSet < 3 then return "" end
            return ScoreboardState.teamA.nsScore[3]
          elseif ScoreboardState.config.ns.maxSets >= 5 then
            if ScoreboardState.nsSet < 5 then return "" end
            if ScoreboardState.nsSet > 5 then return ScoreboardState.teamA.nsScore[ScoreboardState.nsSet]
            else return ScoreboardState.teamA.nsScore[5] end
          end
        end,
        x = 496, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets < 3 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 3 then
            if (ScoreboardState.nsSet > 5 and
              ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet])
              or (ScoreboardState.nsSet == 5 and
              ScoreboardState.teamA.nsScore[5] == ScoreboardState.nsTargetScore[5])
              or (ScoreboardState.nsSet == 3 and
              ScoreboardState.teamA.nsScore[3] == ScoreboardState.nsTargetScore[3]) then
              return Color.yellow end
            return Color.white
          end
        end
      },
      {
        id = "scoreB1", text = function()
          if ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            return ScoreboardState.teamB.nsScore[ScoreboardState.nsSet-4] end
          return ScoreboardState.teamB.nsScore[1]
        end,
        x = 680, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets < 3 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 3 then
            if (ScoreboardState.nsSet > 5 and
              ScoreboardState.teamB.nsScore[ScoreboardState.nsSet-4] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet-4])
              or (ScoreboardState.nsSet == 1 and
              ScoreboardState.teamB.nsScore[1] == ScoreboardState.nsTargetScore[1]) then
              return Color.yellow end
            return Color.white  
          end
        end
      },
      {
        id = "scoreB2", text = function()
          if ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            return ScoreboardState.teamB.nsScore[ScoreboardState.nsSet-3] end
          if ScoreboardState.nsSet < 2 then return "" end
          return ScoreboardState.teamB.nsScore[2]
        end,
        x = 794, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets < 3 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 3 then
            if (ScoreboardState.nsSet > 5 and
              ScoreboardState.teamB.nsScore[ScoreboardState.nsSet-3] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet-3])
              or (ScoreboardState.nsSet == 2 and
              ScoreboardState.teamB.nsScore[2] == ScoreboardState.nsTargetScore[2]) then
              return Color.yellow end
            return Color.white  
          end
        end
      },
      {
        id = "scoreB3", text = function()
          if ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            return ScoreboardState.teamB.nsScore[ScoreboardState.nsSet-2] end
          if ScoreboardState.nsSet < 3 then return "" end
          return ScoreboardState.teamB.nsScore[3]
        end,
        x = 908, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets < 3 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets >= 3 then
            if (ScoreboardState.nsSet > 5 and
              ScoreboardState.teamB.nsScore[ScoreboardState.nsSet-2] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet-2])
              or (ScoreboardState.nsSet == 3 and
              ScoreboardState.teamB.nsScore[3] == ScoreboardState.nsTargetScore[3]) then
              return Color.yellow end
            return Color.white  
          end
        end
      },
      {
        id = "scoreB4", text = function()
          if ScoreboardState.config.ns.maxSets == 3 then return ""
          elseif ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            return ScoreboardState.teamB.nsScore[ScoreboardState.nsSet-1]
          elseif ScoreboardState.config.ns.maxSets >= 5 then 
            if ScoreboardState.nsSet < 4 then return "" end
            return ScoreboardState.teamB.nsScore[4]
          end
        end,
        x = 1022, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets <= 3 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets > 3 then
            if (ScoreboardState.nsSet > 5 and
              ScoreboardState.teamB.nsScore[ScoreboardState.nsSet-1] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet-1])
              or (ScoreboardState.nsSet == 4 and
              ScoreboardState.teamB.nsScore[4] == ScoreboardState.nsTargetScore[4]) then
              return Color.yellow end
            return Color.white  
          end
        end
      },
      {
        id = "scoreB5", text = function()
          if ScoreboardState.config.ns.maxSets == 3 then return ""
          elseif ScoreboardState.config.ns.maxSets >= 5 and ScoreboardState.nsSet > 5 then
            return ScoreboardState.teamB.nsScore[ScoreboardState.nsSet]
          elseif ScoreboardState.config.ns.maxSets >= 5 then 
            if ScoreboardState.nsSet < 5 then return "" end
            return ScoreboardState.teamB.nsScore[5]
          end
        end,
        x = 1136, y = 460, width = 104, align = "center", font = Fonts.nsSetScores, color = function()
          if ScoreboardState.config.ns.maxSets <= 3 then return Color.alpha
          elseif ScoreboardState.config.ns.maxSets > 3 then
            if (ScoreboardState.nsSet > 5 and
              ScoreboardState.teamB.nsScore[ScoreboardState.nsSet] == ScoreboardState.nsTargetScore[ScoreboardState.nsSet])
              or (ScoreboardState.nsSet == 5 and
              ScoreboardState.teamB.nsScore[5] == ScoreboardState.nsTargetScore[5]) then
              return Color.yellow end
            return Color.white  
          end
        end
      }
    },
    rectangles = {
      { id = "matchTitle", x = 40, y = 40, width = 1200, height = 60,
      color = function() return Color.white end },
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