local ScoreboardState = require("data.ScoreboardState")
local TextStrings = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local Designer = {
  texts = {
    { id = "tooltip", text = function() return ScoreboardState.tooltip end,
      x = 20, y = 730, width = 1000, align = "left",
      font = Fonts.tooltip, color = function() return Color.white end },
    { id = "matchTitleLabel", text = function() return "Match Title" end,
      x = 260, y = 90, width = 140, align = "left", font = Fonts.config, color = function() return Color.white end },
    { id = "teamNamesLabel", text = function() return "Team Names" end,
      x = 260, y = 130, width = 140, align = "left", font = Fonts.config, color = function() return Color.white end },
    { id = "matchTitle", text = function()
        if ScoreboardState.onEdit.id == "matchTitle" then
          return ScoreboardState.onEdit.value
        end return ScoreboardState.matchTitle
      end,
      x = 410, y = 90, width = 700, align = "left", font = Fonts.config, color = function() return Color.white end },
    { id = "teamAName", text = function()
        if ScoreboardState.onEdit.id == "teamAName" then
          return ScoreboardState.onEdit.value
        end return ScoreboardState.teamA.name
      end,
      x = 400, y = 130, width = 260, align = "center", font = Fonts.config, color = function() return Color.white end },
    { id = "teamBName", text = function()
        if ScoreboardState.onEdit.id == "teamBName" then
          return ScoreboardState.onEdit.value
        end return ScoreboardState.teamB.name
      end,
      x = 860, y = 130, width = 260, align = "center", font = Fonts.config, color = function() return Color.white end },
    { id = "switchSides", text = function() return "Switch Sides" end,
      x = 670, y = 130, width = 180, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "teamAPreview", text = function() return "1" end,
      x = 400, y = 245, width = 260, align = "center", font = Fonts.score, color = function()
        local r, g, b = ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, ScoreboardState.teamA.fgColor.b
        return { r, g, b }
      end },
    { id = "teamBPreview", text = function() return "2" end,
      x = 860, y = 245, width = 260, align = "center", font = Fonts.score, color = function()
        local r, g, b = ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, ScoreboardState.teamB.fgColor.b
        return { r, g, b }
      end },
    { id = "changeTeamA", text = function() return "Change Team / Colors" end,
      x = 400, y = 480, width = 260, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "changeTeamB", text = function() return "Change Team / Colors" end,
      x = 860, y = 480, width = 260, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "saveAsDefault", text = function() return "Save As Default Match Setup" end,
      x = 260, y = 675, width = 290, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "toBasketball", text = function() return "Play Basketball" end,
      x = 850, y = 675, width = 200, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "toNetSport", text = function() return "Play Net Sport" end,
      x = 1060, y = 675, width = 200, align = "center", font = Fonts.config, color = function() return Color.button.fg end }
  },
  rectangles = {
    -- text fields
    { id = "matchTitle", x = 400, y = 85, width = 720, height = 30, color = function()
        if ScoreboardState.onEdit.id == "matchTitle" then
          return Color.textField.bg.active
        elseif ScoreboardState.onMouseFocus == "matchTitle" then
          return Color.textField.bg.focus
        end
          return Color.textField.bg.enabled
        end },
    { id = "teamAName", x = 400, y = 125, width = 260, height = 30, color = function()
        if ScoreboardState.onEdit.id == "teamAName" then
          return Color.textField.bg.active
        elseif ScoreboardState.onMouseFocus == "teamAName" then
          return Color.textField.bg.focus
        end
          return Color.textField.bg.enabled
        end },
    { id = "teamBName", x = 860, y = 125, width = 260, height = 30, color = function()
        if ScoreboardState.onEdit.id == "teamBName" then
          return Color.textField.bg.active
        elseif ScoreboardState.onMouseFocus == "teamBName" then
          return Color.textField.bg.focus
        end
          return Color.textField.bg.enabled
        end },
    -- buttons
    { id = "switchSides", x = 670, y = 125, width = 180, height = 30, color = function()
          if ScoreboardState.onMouseFocus == "switchSides" then
            return Color.button.bg.focus end
          return Color.button.bg.enabled
        end },
    { id = "changeTeamA", x = 400, y = 475, width = 260, height = 30, color = function()
          if ScoreboardState.onMouseFocus == "changeTeamA" then
            return Color.button.bg.focus end
          return Color.button.bg.enabled
        end },
    { id = "changeTeamB", x = 860, y = 475, width = 260, height = 30, color = function()
          if ScoreboardState.onMouseFocus == "changeTeamB" then
            return Color.button.bg.focus end
          return Color.button.bg.enabled
        end },
    { id = "saveAsDefault", x = 260, y = 670, width = 290, height = 30, color = function()
          if ScoreboardState.onMouseFocus == "saveAsDefault" then
            return Color.button.bg.focus end
          return Color.button.bg.enabled
        end },
    { id = "toBasketball", x = 850, y = 670, width = 200, height = 30, color = function()
          if ScoreboardState.onMouseFocus == "toBasketball" then
            return Color.button.bg.focus end
          return Color.button.bg.enabled
        end },
    { id = "toNetSport", x = 1060, y = 670, width = 200, height = 30, color = function()
          if ScoreboardState.onMouseFocus == "toNetSport" then
            return Color.button.bg.focus end
          return Color.button.bg.enabled
        end },
    -- bordered rectangles
    { id = "teamAbg1", x = 445, y = 165, width = 50, height = 30, color = function()
        local r, g, b = ScoreboardState.teamA.bgColor1.r, ScoreboardState.teamA.bgColor1.g, ScoreboardState.teamA.bgColor1.b
        return { r, g, b }
      end },
    { id = "teamAbg2", x = 505, y = 165, width = 50, height = 30, color = function()
        local r, g, b = ScoreboardState.teamA.bgColor2.r, ScoreboardState.teamA.bgColor2.g, ScoreboardState.teamA.bgColor2.b
        return { r, g, b }
      end },
    { id = "teamAfg", x = 565, y = 165, width = 50, height = 30, color = function()
        local r, g, b = ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, ScoreboardState.teamA.fgColor.b
        return { r, g, b }
      end },
    { id = "teamBbg1", x = 905, y = 165, width = 50, height = 30, color = function()
        local r, g, b = ScoreboardState.teamB.bgColor1.r, ScoreboardState.teamB.bgColor1.g, ScoreboardState.teamB.bgColor1.b
        return { r, g, b }
      end },
    { id = "teamBbg2", x = 965, y = 165, width = 50, height = 30, color = function()
        local r, g, b = ScoreboardState.teamB.bgColor2.r, ScoreboardState.teamB.bgColor2.g, ScoreboardState.teamB.bgColor2.b
        return { r, g, b }
      end },
    { id = "teamBfg", x = 1025, y = 165, width = 50, height = 30, color = function()
        local r, g, b = ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, ScoreboardState.teamB.fgColor.b
        return { r, g, b }
      end }
  },
  dialogBox = {
    texts = {
      { id = "message", text = function()
          if ScoreboardState.matchStatus == 1 then
            return TextStrings.dialogBox.continueBasketball end
          return TextStrings.dialogBox.continueNetSport
        end,
        x = 395, y = 330, width = 490, align = "center", font = Fonts.config, color = function() return Color.white end },
      { id = "continue", text = function() return "Continue" end,
        x = 405, y = 465, width = 150, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
      { id = "startNew", text = function() return "Start New" end,
        x = 565, y = 465, width = 150, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
      { id = "exitDialog", text = function() return "Back" end,
        x = 725, y = 465, width = 150, align = "center", font = Fonts.config, color = function() return Color.button.fg end }
    },
    rectangles = {
      { id = "message", x = 395, y = 295, width = 490, height = 210, color = function() return Color.footerBG end },
      { id = "continue", x = 405, y = 455, width = 150, height = 40, color = function()
          if ScoreboardState.onMouseFocus == "continue" then
            return Color.button.bg.focus end
          return Color.button.bg.enabled
        end },
      { id = "startNew", x = 565, y = 455, width = 150, height = 40, color = function()
          if ScoreboardState.onMouseFocus == "startNew" then
            return Color.button.bg.focus end
          return Color.button.bg.enabled
        end },
      { id = "exitDialog", x = 725, y = 455, width = 150, height = 40, color = function()
          if ScoreboardState.onMouseFocus == "exitDialog" then
            return Color.button.bg.focus end
          return Color.button.bg.enabled
        end }
    }
  },
  mouseBounds = {
    default = {
      -- config tabs
      { id = "matchSetup", x1 = 20, y1 = 80, x2 = 240, y2 = 120 },
      { id = "bbSettings", x1 = 20, y1 = 130, x2 = 240, y2 = 170 },
      { id = "bbControls", x1 = 20, y1 = 180, x2 = 240, y2 = 220 },
      { id = "nsSettings", x1 = 20, y1 = 230, x2 = 240, y2 = 270 },
      { id = "nsControls", x1 = 20, y1 = 280, x2 = 240, y2 = 320 },
      { id = "teamsList", x1 = 20, y1 = 330, x2 = 240, y2 = 370 },
      { id = "soundsList", x1 = 20, y1 = 380, x2 = 240, y2 = 420 },
      -- MatchSetup elements
      { id = "matchTitle", x1 = 260, y1 = 85, x2 = 1120, y2 = 115 },
      { id = "teamAName", x1 = 400, y1 = 125, x2 = 660, y2 = 155 },
      { id = "teamBName", x1 = 860, y1 = 125, x2 = 1120, y2 = 155 },
      { id = "switchSides", x1 = 670, y1 = 125, x2 = 850, y2 = 155 },
      { id = "changeTeamA", x1 = 400, y1 = 165, x2 = 660, y2 = 505 },
      { id = "changeTeamB", x1 = 860, y1 = 165, x2 = 1120, y2 = 505 },
      { id = "saveAsDefault", x1 = 260, y1 = 670, x2 = 550, y2 = 700 },
      { id = "toBasketball", x1 = 850, y1 = 670, x2 = 1050, y2 = 700 },
      { id = "toNetSport", x1 = 1060, y1 = 670, x2 = 1260, y2 = 700 },
      -- footer tabs
      { id = "bbTab", x1 = 1030, y1 = 720, x2 = 1090, y2 = 800 },
      { id = "nsTab", x1 = 1090, y1 = 720, x2 = 1150, y2 = 800 },
      { id = "configTab", x1 = 1150, y1 = 720, x2 = 1210, y2 = 800 },
      { id = "aboutTab", x1 = 1210, y1 = 720, x2 = 1270, y2 = 800 }
    },
    dialogBox = {
      { id = "continue", x1 = 405, y1 = 455, x2 = 555, y2 = 495 },
      { id = "startNew", x1 = 565, y1 = 455, x2 = 715, y2 = 495 },
      { id = "exitDialog", x1 = 725, y1 = 455, x2 = 875, y2 = 495 }
    }
  }
}

return Designer