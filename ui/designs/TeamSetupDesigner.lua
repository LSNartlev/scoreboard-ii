local ScoreboardState = require("data.ScoreboardState")
local TextStrings = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")

local Designer = {
  texts = {
    { id = "tooltip", text = function() return ScoreboardState.tooltip end,
      x = 20, y = 730, width = 1000, align = "left",
      font = Fonts.tooltip, color = function() return Color.white end },
    { id = "teamNameLabel", text = function() return "Team Name" end,
      x = 260, y = 90, width = 200, align = "left", font = Fonts.config, color = function() return Color.white end },
    { id = "editTeamA", text = function()
        if ScoreboardState.teamSetup.side == "" then
          return "" end
        return "LEFT"
      end,
      x = 970, y = 90, width = 140, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "editTeamB", text = function()
        if ScoreboardState.teamSetup.side == "" then
          return "" end
        return "RIGHT" 
      end,
      x = 1120, y = 90, width = 140, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "selectCourtSide", text = function()
        if ScoreboardState.teamSetup.side == "" then
          return "" end
        return "Select Court Side" 
      end,
      x = 800, y = 90, width = 170, align = "left", font = Fonts.config, color = function() return Color.white end },
    { id = "teamName", text = function()
        if ScoreboardState.onEdit.id == "teamName" then
          return ScoreboardState.onEdit.value
        end return ScoreboardState.teamSetup.name
      end,
      x = 260, y = 125, width = 460, align = "center", font = Fonts.configTeam, color = function() return Color.white end },
    { id = "uniformColorsLabel", text = function() return "Uniform Colors" end,
      x = 260, y = 170, width = 460, align = "left", font = Fonts.config, color = function() return Color.white end },
    { id = "bg1Tab", text = function() return "Main Color" end,
      x = 260, y = 210, width = 130, align = "center", font = Fonts.config, color = function() return Color.white end },
    { id = "bg2Tab", text = function() return "2nd Color" end,
      x = 400, y = 210, width = 130, align = "center", font = Fonts.config, color = function() return Color.white end },
    { id = "fgTab", text = function() return "Name & Number" end,
      x = 540, y = 210, width = 180, align = "center", font = Fonts.config, color = function() return Color.white end },
    { id = "previewNum", text = function()
        if ScoreboardState.teamSetup.side == "A" then
          return "1"
        elseif ScoreboardState.teamSetup.side == "B" then
          return "2"
        end
        return "0"
      end,
      x = 460, y = 320, width = 260, align = "center", font = Fonts.score, color = function()
        local r, g, b = ScoreboardState.teamSetup.fgColor.r, ScoreboardState.teamSetup.fgColor.g, ScoreboardState.teamSetup.fgColor.b
        return { r, g, b }
      end },
    { id = "setAsSingleColor", text = function() return "Set As Single Color" end,
      x = 460, y = 585, width = 260, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "saveTeam", text = function()
        if ScoreboardState.onEdit.id == "saveTeam" then
          return "Cancel"
        end
        return "Save to List"
      end,
      x = 260, y = 675, width = 260, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "listPrevPage", text = function() return "< Prev" end,
      x = 800, y = 585, width = 100, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "listNextPage", text = function() return "Next >" end,
      x = 1160, y = 585, width = 100, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "toMatchSetup", text = function() 
        if ScoreboardState.teamSetup.side == "" then
          return "" end
        return "Back"
      end,
      x = 950, y = 675, width = 150, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "confirmTeam", text = function() 
        if ScoreboardState.teamSetup.side == "" then
          return "" end
        return "OK"
      end,
      x = 1110, y = 675, width = 150, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "listHeader", text = function()
        if ScoreboardState.onEdit.id == "saveTeam" then
          return TextStrings.teamSetup.saveTeamLabel
        end
        return TextStrings.teamSetup.listHeaderLabel
      end,
      x = 800, y = 140, width = 460, align = "left", font = Fonts.config, color = function()
        if ScoreboardState.onEdit.id == "saveTeam" then
          return Color.editGreen
        end
        return Color.white
      end }
  },
  rectangles = {
    { id = "editTeamA", x = 970, y = 85, width = 140, height = 30, color = function()
        if ScoreboardState.teamSetup.side == "A" then
          return Color.button.bg.active
        elseif ScoreboardState.teamSetup.side == "B" then
          return Color.button.bg.enabled
        end
        return Color.alpha
      end },
    { id = "editTeamB", x = 1120, y = 85, width = 140, height = 30, color = function()
        if ScoreboardState.teamSetup.side == "B" then
          return Color.button.bg.active
        elseif ScoreboardState.teamSetup.side == "A" then
          return Color.button.bg.enabled
        end
        return Color.alpha
      end },
    { id = "teamName", x = 260, y = 120, width = 460, height = 40, color = function() 
        if ScoreboardState.onEdit.id == "teamName" then
          return Color.textField.bg.active
        elseif ScoreboardState.onMouseFocus == "teamName" then
          return Color.textField.bg.focus
        end
        return Color.textField.bg.enabled
      end },
    { id = "bg1Tab", x = 260, y = 200, width = 130, height = 40, color = function() 
        if ScoreboardState.teamSetup.activeColorTab == "bg1" then
          return Color.tabButton.bg.active
        end
        return Color.tabButton.bg.enabled
      end },
    { id = "bg2Tab", x = 400, y = 200, width = 130, height = 40, color = function() 
        if ScoreboardState.teamSetup.activeColorTab == "bg2" then
          return Color.tabButton.bg.active
        end
        return Color.tabButton.bg.enabled
      end },
    { id = "fgTab", x = 540, y = 200, width = 180, height = 40, color = function() 
        if ScoreboardState.teamSetup.activeColorTab == "fg" then
          return Color.tabButton.bg.active
        end
        return Color.tabButton.bg.enabled
      end },
    { id = "horzDivider", x = 260, y = 235, width = 460, height = 5, color = function() return Color.tabButton.bg.active end },
    { id = "bg1Rect", x = 505, y = 250, width = 50, height = 30, color = function()
        local r, g, b = ScoreboardState.teamSetup.bgColor1.r, ScoreboardState.teamSetup.bgColor1.g, ScoreboardState.teamSetup.bgColor1.b
        return { r, g, b }
      end },
    { id = "bg2Rect", x = 565, y = 250, width = 50, height = 30, color = function()
        local r, g, b = ScoreboardState.teamSetup.bgColor2.r, ScoreboardState.teamSetup.bgColor2.g, ScoreboardState.teamSetup.bgColor2.b
        return { r, g, b }
      end },
    { id = "fgRect", x = 625, y = 250, width = 50, height = 30, color = function()
        local r, g, b = ScoreboardState.teamSetup.fgColor.r, ScoreboardState.teamSetup.fgColor.g, ScoreboardState.teamSetup.fgColor.b
        return { r, g, b }
      end },
    { id = "setAsSingleColor", x = 460, y = 580, width = 260, height = 30, color = function()
        if ScoreboardState.onMouseFocus == "setAsSingleColor" then
          return Color.button.bg.focus
        end
        return Color.button.bg.enabled
      end },
    { id = "saveTeam", x = 260, y = 670, width = 260, height = 30, color = function()
        if ScoreboardState.onMouseFocus == "saveTeam" then
          return Color.button.bg.focus
        end
        return Color.button.bg.enabled
      end },
    { id = "listPrevPage", x = 800, y = 580, width = 100, height = 30, color = function()
        if ScoreboardState.onMouseFocus == "listPrevPage" then
          return Color.button.bg.focus
        end
        return Color.button.bg.enabled
      end },
    { id = "listNextPage", x = 1160, y = 580, width = 100, height = 30, color = function()
        if ScoreboardState.onMouseFocus == "listNextPage" then
          return Color.button.bg.focus
        end
        return Color.button.bg.enabled
      end },
    { id = "toMatchSetup", x = 950, y = 670, width = 150, height = 30, color = function()
        if ScoreboardState.onMouseFocus == "toMatchSetup" then
          return Color.button.bg.focus
        end
        return Color.button.bg.enabled
      end },
    { id = "confirmTeam", x = 1110, y = 670, width = 150, height = 30, color = function()
        if ScoreboardState.onMouseFocus == "confirmTeam" then
          return Color.button.bg.focus
        end
        return Color.button.bg.enabled
      end }
  },
  circles = {
    { x = 925, y = 595, radius = 10, color = function()
        if ScoreboardState.teamSetup.listPage == 1 then
          return Color.button.bg.active
        elseif ScoreboardState.onMouseFocus == "page1" then
          return Color.button.bg.focus
        end
        return Color.textField.bg.enabled
      end },
    { x = 955, y = 595, radius = 10, color = function()
        if ScoreboardState.teamSetup.listPage == 2 then
          return Color.button.bg.active
        elseif ScoreboardState.onMouseFocus == "page2" then
          return Color.button.bg.focus
        end
        return Color.textField.bg.enabled
      end },
    { x = 985, y = 595, radius = 10, color = function()
        if ScoreboardState.teamSetup.listPage == 3 then
          return Color.button.bg.active
        elseif ScoreboardState.onMouseFocus == "page3" then
          return Color.button.bg.focus
        end
        return Color.textField.bg.enabled
      end },
    { x = 1015, y = 595, radius = 10, color = function()
        if ScoreboardState.teamSetup.listPage == 4 then
          return Color.button.bg.active
        elseif ScoreboardState.onMouseFocus == "page4" then
          return Color.button.bg.focus
        end
        return Color.textField.bg.enabled
      end },
    { x = 1045, y = 595, radius = 10, color = function()
        if ScoreboardState.teamSetup.listPage == 5 then
          return Color.button.bg.active
        elseif ScoreboardState.onMouseFocus == "page5" then
          return Color.button.bg.focus
        end
        return Color.textField.bg.enabled
      end },
    { x = 1075, y = 595, radius = 10, color = function()
        if ScoreboardState.teamSetup.listPage == 6 then
          return Color.button.bg.active
        elseif ScoreboardState.onMouseFocus == "page6" then
          return Color.button.bg.focus
        end
        return Color.textField.bg.enabled
      end },
    { x = 1105, y = 595, radius = 10, color = function()
        if ScoreboardState.teamSetup.listPage == 7 then
          return Color.button.bg.active
        elseif ScoreboardState.onMouseFocus == "page7" then
          return Color.button.bg.focus
        end
        return Color.textField.bg.enabled
      end },
    { x = 1135, y = 595, radius = 10, color = function()
        if ScoreboardState.teamSetup.listPage == 8 then
          return Color.button.bg.active
        elseif ScoreboardState.onMouseFocus == "page8" then
          return Color.button.bg.focus
        end
        return Color.textField.bg.enabled
      end }
  },
  sliderThumbs = {
    { id = "hueThumb", x = 260,
      y = function()
        local thumbPoss = 245
        if ScoreboardState.teamSetup.activeColorTab == "bg1" then
          thumbPoss = thumbPoss + ScoreboardState.teamSetup.hsl.bg1[1]
        elseif ScoreboardState.teamSetup.activeColorTab == "bg2" then
          thumbPoss = thumbPoss + ScoreboardState.teamSetup.hsl.bg2[1]
        else
          thumbPoss = thumbPoss + ScoreboardState.teamSetup.hsl.fg[1]
        end
        return thumbPoss
      end,
      width = 50, height = 10,
      color = function()
        if ScoreboardState.onEdit.id == "hueSlider" then
          return Color.button.bg.focus
        elseif ScoreboardState.onMouseFocus == "hueSlider" then
          return Color.white
        end
        return Color.button.bg.enabled
      end
    },
    { id = "satThumb", x = 320,
      y = function()
        local thumbPoss = 245
        if ScoreboardState.teamSetup.activeColorTab == "bg1" then
          thumbPoss = thumbPoss + (360 - ScoreboardState.teamSetup.hsl.bg1[2])
        elseif ScoreboardState.teamSetup.activeColorTab == "bg2" then
          thumbPoss = thumbPoss + (360 - ScoreboardState.teamSetup.hsl.bg2[2])
        else
          thumbPoss = thumbPoss + (360 - ScoreboardState.teamSetup.hsl.fg[2])
        end
        return thumbPoss
      end,
      width = 50, height = 10,
      color = function()
        if ScoreboardState.onEdit.id == "satSlider" then
          return Color.button.bg.focus
        elseif ScoreboardState.onMouseFocus == "satSlider" then
          return Color.white
        end
        return Color.button.bg.enabled
      end
    },
    { id = "lightThumb", x = 380,
      y = function()
        local thumbPoss = 245
        if ScoreboardState.teamSetup.activeColorTab == "bg1" then
          thumbPoss = thumbPoss + (360 - ScoreboardState.teamSetup.hsl.bg1[3])
        elseif ScoreboardState.teamSetup.activeColorTab == "bg2" then
          thumbPoss = thumbPoss + (360 - ScoreboardState.teamSetup.hsl.bg2[3])
        else
          thumbPoss = thumbPoss + (360 - ScoreboardState.teamSetup.hsl.fg[3])
        end
        return thumbPoss
      end,
      width = 50, height = 10,
      color = function()
        if ScoreboardState.onEdit.id == "lightSlider" then
          return Color.button.bg.focus
        elseif ScoreboardState.onMouseFocus == "lightSlider" then
          return Color.white
        end
        return Color.button.bg.enabled
      end
    }
  },
  mouseBounds = {
    -- config tabs
    { id = "matchSetup", x1 = 20, y1 = 80, x2 = 240, y2 = 120 },
    { id = "bbSettings", x1 = 20, y1 = 130, x2 = 240, y2 = 170 },
    { id = "bbControls", x1 = 20, y1 = 180, x2 = 240, y2 = 220 },
    { id = "nsSettings", x1 = 20, y1 = 230, x2 = 240, y2 = 270 },
    { id = "nsControls", x1 = 20, y1 = 280, x2 = 240, y2 = 320 },
    { id = "teamsList", x1 = 20, y1 = 330, x2 = 240, y2 = 370 },
    { id = "soundsList", x1 = 20, y1 = 380, x2 = 240, y2 = 420 },
    -- TeamSetup elements
    { id = "editTeamA", x1 = 970, y1 = 85, x2 = 1110, y2 = 115 },
    { id = "editTeamB", x1 = 120, y1 = 85, x2 = 1260, y2 = 115 },
    { id = "teamName", x1 = 260, y1 = 120, x2 = 720, y2 = 160 },
    { id = "bg1Tab", x1 = 260, y1 = 200, x2 = 390, y2 = 240 },
    { id = "bg2Tab", x1 = 400, y1 = 200, x2 = 530, y2 = 240 },
    { id = "fgTab", x1 = 540, y1 = 200, x2 = 720, y2 = 240 },
    { id = "hueSlider", x1 = 260, y1 = 250, x2 = 310, y2 = 610 },
    { id = "satSlider", x1 = 320, y1 = 250, x2 = 370, y2 = 610 },
    { id = "lightSlider", x1 = 380, y1 = 250, x2 = 430, y2 = 610 },
    { id = "bg1Rect", x1 = 505, y1 = 250, x2 = 555, y2 = 280 },
    { id = "bg2Rect", x1 = 565, y1 = 250, x2 = 615, y2 = 280 },
    { id = "fgRect", x1 = 625, y1 = 250, x2 = 675, y2 = 280 },
    { id = "previewRect", x1 = 460, y1 = 290, x2 = 720, y2 = 550 },
    { id = "setAsSingleColor", x1 = 460, y1 = 580, x2 = 720, y2 = 610 },
    { id = "saveTeam", x1 = 260, y1 = 670, x2 = 520, y2 = 700 },
    { id = "listPrevPage", x1 = 800, y1 = 580, x2 = 900, y2 = 610 },
    { id = "listEntry1", x1 = 800, y1 = 175, x2 = 1260, y2 = 215 },
    { id = "listEntry2", x1 = 800, y1 = 225, x2 = 1260, y2 = 265 },
    { id = "listEntry3", x1 = 800, y1 = 275, x2 = 1260, y2 = 315 },
    { id = "listEntry4", x1 = 800, y1 = 325, x2 = 1260, y2 = 365 },
    { id = "listEntry5", x1 = 800, y1 = 375, x2 = 1260, y2 = 415 },
    { id = "listEntry6", x1 = 800, y1 = 425, x2 = 1260, y2 = 465 },
    { id = "listEntry7", x1 = 800, y1 = 475, x2 = 1260, y2 = 515 },
    { id = "listEntry8", x1 = 800, y1 = 525, x2 = 1260, y2 = 565 },
    { id = "page1", x1 = 915, y1 = 585, x2 = 935, y2 = 605 },
    { id = "page2", x1 = 945, y1 = 585, x2 = 965, y2 = 605 },
    { id = "page3", x1 = 975, y1 = 585, x2 = 995, y2 = 605 },
    { id = "page4", x1 = 1005, y1 = 585, x2 = 1025, y2 = 605 },
    { id = "page5", x1 = 1035, y1 = 585, x2 = 1055, y2 = 605 },
    { id = "page6", x1 = 1065, y1 = 585, x2 = 1085, y2 = 605 },
    { id = "page7", x1 = 1095, y1 = 585, x2 = 1115, y2 = 605 },
    { id = "page8", x1 = 1125, y1 = 585, x2 = 1145, y2 = 605 },
    { id = "listNextPage", x1 = 1160, y1 = 580, x2 = 1260, y2 = 610 },
    { id = "toMatchSetup", x1 = 950, y1 = 670, x2 = 1100, y2 = 700 },
    { id = "confirmTeam", x1 = 1110, y1 = 670, x2 = 1260, y2 = 700 },
    -- footer tabs
    { id = "bbTab", x1 = 1030, y1 = 720, x2 = 1090, y2 = 800 },
    { id = "nsTab", x1 = 1090, y1 = 720, x2 = 1150, y2 = 800 },
    { id = "configTab", x1 = 1150, y1 = 720, x2 = 1210, y2 = 800 },
    { id = "aboutTab", x1 = 1210, y1 = 720, x2 = 1270, y2 = 800 }
  }
}

return Designer