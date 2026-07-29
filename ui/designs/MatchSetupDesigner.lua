local ScoreboardState = require("data.ScoreboardState")
local TextStrings = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local Designer = {
  texts = {
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
    { id = "switchSides", text = function() return "Switch Court Sides" end,
      x = 670, y = 130, width = 180, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "teamAPreview", text = function() return "1" end,
      x = 400, y = 245, width = 260, align = "center", font = Fonts.score, color = function()
        local r, g, b = ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, ScoreboardState.teamA.fgColor.b
        return { r, g, b }
      end },
    { id = "teamBPreview", text = function() return "2" end,
      x = 860, y = 245, width = 260, align = "center", font = Fonts.score, color = function()
        local r, g, b = ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, ScoreboardState.teamA.fgColor.b
        return { r, g, b }
      end },
    { id = "changeTeamA", text = function() return "Change Team / Colors" end,
      x = 400, y = 480, width = 260, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "changeTeamB", text = function() return "Change Team / Colors" end,
      x = 860, y = 480, width = 260, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "saveAsDefault", text = function() return "Save As Default Match Setup" end,
      x = 260, y = 675, width = 290, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "toBasketball", text = function() return "Start Basketball" end,
      x = 850, y = 675, width = 200, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "toNetSport", text = function() return "Start Net Sport" end,
      x = 1060, y = 675, width = 200, align = "center", font = Fonts.config, color = function() return Color.button.fg end }
  }
}

return Designer