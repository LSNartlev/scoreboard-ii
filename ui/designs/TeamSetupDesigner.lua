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
        return "Left Side"
      end,
      x = 470, y = 90, width = 120, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "editTeamB", text = function()
        if ScoreboardState.teamSetup.side == "" then
          return "" end
        return "Right Side" 
      end,
      x = 600, y = 90, width = 120, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "teamName", text = function() return ScoreboardState.teamSetup.name end,
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
    { id = "saveTeam", text = function() return "Save to List" end,
      x = 260, y = 675, width = 260, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "listPrev", text = function() return "< Prev" end,
      x = 800, y = 585, width = 100, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "listNext", text = function() return "Next >" end,
      x = 1160, y = 585, width = 100, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "toMatchSetup", text = function() 
        if ScoreboardState.teamSetup.side == "" then
          return "" end
        return "Back"
      end,
      x = 260, y = 675, width = 150, align = "center", font = Fonts.config, color = function() return Color.button.fg end },
    { id = "confirmTeam", text = function() 
        if ScoreboardState.teamSetup.side == "" then
          return "" end
        return "OK"
      end,
      x = 1110, y = 675, width = 120, align = "center", font = Fonts.config, color = function() return Color.button.fg end }
  },
  rectangles = {
    { id = "editTeamA", x = 470, y = 85, width = 120, height = 30, color = function()
        if ScoreboardState.teamSetup.side == "A" then
          return Color.button.bg.active
        elseif ScoreboardState.teamSetup.side == "B" then
          return Color.button.bg.enabled
        end
        return Color.alpha
      end },
    { id = "editTeamB", x = 600, y = 85, width = 120, height = 30, color = function()
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
    { id = "listPrev", x = 800, y = 580, width = 100, height = 30, color = function()
        if ScoreboardState.onMouseFocus == "listPrev" then
          return Color.button.bg.focus
        end
        return Color.button.bg.enabled
      end },
    { id = "listNext", x = 1160, y = 580, width = 100, height = 30, color = function()
        if ScoreboardState.onMouseFocus == "listNext" then
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
        if ScoreboardState.onEdit == "hue" then
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
        if ScoreboardState.onEdit == "hue" then
          return Color.button.bg.focus
        elseif ScoreboardState.onMouseFocus == "hueSlider" then
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
        if ScoreboardState.onEdit == "hue" then
          return Color.button.bg.focus
        elseif ScoreboardState.onMouseFocus == "hueSlider" then
          return Color.white
        end
        return Color.button.bg.enabled
      end
    }
  },
  mouseBounds = {
    
  }
}

return Designer