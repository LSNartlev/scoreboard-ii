local MatchSetup = {}
local utf8 = require("utf8") -- see MatchSetup:keypressed()
local ScreenManager = require("ui.ScreenManager")
local ScoreboardState = require("data.ScoreboardState")
local Designer = require("ui.designs.MatchSetupDesigner")
local ConfigDesigner = require("ui.designs.ConfigDesigner")
local Color = require("ui.designs.Colors")
local Lang = require("data.language.en")
local gradRect = require("ui.designs.GradientMesh")
local json = require("ext.rxi-json.json")
local teamAColors, teamBColors, openDialogBoxFor, rawSaveData, saveOK

function MatchSetup:load()
  ScoreboardState.onDisplay = "MatchSetup"
  ScoreboardState.tooltip = Lang.tooltips.matchSetup
  teamAColors = gradRect.new(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 1)
  teamBColors = gradRect.new(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 1)
  openDialogBoxFor = ""
  saveOK = 0
end

function MatchSetup:update(dt)
  saveOK = saveOK - 0.1
end

function MatchSetup:draw()
  for _, v in ipairs(ConfigDesigner.bg) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(ConfigDesigner.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(ConfigDesigner.texts) do
    love.graphics.setFont(v.font())
    love.graphics.setColor(v.color())
    love.graphics.printf(v.text, v.x, v.y, v.width, v.align)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(ConfigDesigner.tabButtons) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(v.icon(), v.x, v.y+10, 0, 60/v.icon():getWidth(), 60/v.icon():getHeight())
  end
  
  love.graphics.draw(teamAColors.mesh, 400, 205, 0, 260, 260)
  love.graphics.draw(teamBColors.mesh, 860, 205, 0, 260, 260)
  
  for _, v in ipairs(Designer.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
    if string.find(v.id, "bg") or string.find(v.id, "fg") then
      love.graphics.setLineWidth(1)
      love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
      love.graphics.setLineWidth(0)
    end
  end
  for _, v in ipairs(Designer.texts) do
    love.graphics.setFont(v.font)
    love.graphics.setColor(v.color())
    if v.id == "matchTitle" or v.id == "teamAName" or v.id == "teamBName" then
      love.graphics.setScissor(v.x, v.y, v.width, 30)
    end
    if ScoreboardState.onEdit.id == v.id then
      local sec = math.floor((love.timer.getTime()*10)%8)
      local cursorColor = function()
        if sec < 4 then return {0,0,0,0}
        else return Color.orange
        end
      end
      love.graphics.printf(
      {
        v.color(), v.text(),
        cursorColor(), "_"
      },
      v.x, v.y, v.width, v.align)
    else
      love.graphics.printf(v.text(), v.x, v.y, v.width, v.align)
    end
    love.graphics.setScissor()
    love.graphics.setColor(1,1,1,1)
  end
  
  if saveOK > 0 then
    love.graphics.setColor(Color.button.bg.active)
    love.graphics.rectangle("fill", 260, 670, 290, 30)
    love.graphics.setColor(Color.black)
    love.graphics.printf("Match Setup saved!", 260, 675, 290, "center")
  end
  
  if openDialogBoxFor ~= "" then
    self:drawDialogBox()
  end
end

function MatchSetup:keypressed(key, scancode, isrepeat)
  if ScoreboardState.onEdit.id ~= "" then
    if key == "escape" then
      love.keyboard.setTextInput(false)
      ScoreboardState.onEdit.id = ""
      ScoreboardState.onEdit.value = ""
    elseif key == "backspace" then
      --[[
      implementation based on the snippet from LÖVE wiki
      Source: https://love2d.org/wiki/love.textinput
      ]]
      local byteOffset = utf8.offset(ScoreboardState.onEdit.value, -1)
      if byteOffset then
        ScoreboardState.onEdit.value = string.sub(ScoreboardState.onEdit.value, 1, byteOffset-1)
      end
    elseif key == "return" then
      self:finishEditing()
    end
  end
end

function MatchSetup:textinput(text)
  ScoreboardState.onEdit.value = ScoreboardState.onEdit.value .. text
end

function MatchSetup:mousemoved(x, y, dx, dy, istouch)
  ScoreboardState.tooltip = Lang.tooltips.matchSetup
  if openDialogBoxFor ~= "" then
    for _, v in ipairs(Designer.mouseBounds.dialogBox) do
      if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
        ScoreboardState.onMouseFocus = v.id
        break
      else
        ScoreboardState.onMouseFocus = ""
      end
    end
  else
    for _, v in ipairs(Designer.mouseBounds.default) do
      if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
        ScoreboardState.onMouseFocus = v.id
        if Lang.matchSetup[ScoreboardState.onMouseFocus] then
          ScoreboardState.tooltip = Lang.matchSetup[ScoreboardState.onMouseFocus]
          break
        elseif Lang.config.tabTooltip[ScoreboardState.onMouseFocus] then
          ScoreboardState.tooltip = Lang.config.tabTooltip[ScoreboardState.onMouseFocus]
          break
        elseif ScoreboardState.onEdit.id ~= "" then
          ScoreboardState.tooltip = Lang.matchSetup.onEdit
        end
      else
        ScoreboardState.onMouseFocus = ""
      end
    end
  end
end

function MatchSetup:mousepressed(x, y, button)
  if openDialogBoxFor ~= "" then
    for _, v in ipairs(Designer.mouseBounds.dialogBox) do
      if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
        self:performClickAction(v.id)
        break
      end
    end
  else
    for _, v in ipairs(Designer.mouseBounds.default) do
      if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
        self:performClickAction(v.id)
        break
      end
    end
  end
end

function MatchSetup:drawDialogBox()
  for _, v in ipairs(Designer.dialogBox.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    if v.id == "message" then
      love.graphics.setColor(Color.yellow)
      love.graphics.setLineWidth(2)
      love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
      love.graphics.setLineWidth(0)
    end
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(Designer.dialogBox.texts) do
    love.graphics.setFont(v.font)
    love.graphics.setColor(v.color())
    love.graphics.printf(v.text(), v.x, v.y, v.width, v.align)
    love.graphics.setColor(1,1,1,1)
  end
end

function MatchSetup:performClickAction(elementId)
  self:finishEditing()
  if elementId == "switchSides" then
    ScoreboardState.teamA, ScoreboardState.teamB = ScoreboardState.teamB, ScoreboardState.teamA
    teamAColors.mesh, teamBColors.mesh = teamBColors.mesh, teamAColors.mesh
  elseif elementId == "matchTitle" then
    ScoreboardState.onEdit.id = elementId
    ScoreboardState.onEdit.value = ScoreboardState.matchTitle
    love.keyboard.setTextInput(true)
  elseif elementId == "teamAName" then
    ScoreboardState.onEdit.id = elementId
    ScoreboardState.onEdit.value = ScoreboardState.teamA.name
    love.keyboard.setTextInput(true)
  elseif elementId == "teamBName" then
    ScoreboardState.onEdit.id = elementId
    ScoreboardState.onEdit.value = ScoreboardState.teamB.name
    love.keyboard.setTextInput(true)
  elseif elementId == "bbTab" or elementId == "toBasketball" then
    if ScoreboardState.matchStatus == 0 then
      ScoreboardState.onDisplay = "BasketballScoreboard"
      ScreenManager.changeScreen("BasketballScoreboard")
    elseif ScoreboardState.matchStatus == 1 then
      openDialogBoxFor = "continueBasketball"
    elseif ScoreboardState.matchStatus == 2 then
      openDialogBoxFor = "continueNetSport"
    end
  elseif elementId == "changeTeamA" then
    ScoreboardState.teamSetup.side = "A"
    ScoreboardState.onDisplay = "TeamSetup"
    ScreenManager.changeScreen("TeamSetup")
  elseif elementId == "changeTeamB" then
    ScoreboardState.teamSetup.side = "B"
    ScoreboardState.onDisplay = "TeamSetup"
    ScreenManager.changeScreen("TeamSetup")
  elseif elementId == "saveAsDefault" then
    ScoreboardState.config.matchSetup.matchTitle = ScoreboardState.matchTitle
    ScoreboardState.config.matchSetup.teamA.name = ScoreboardState.teamA.name
    ScoreboardState.config.matchSetup.teamA.bgColor1 = ScoreboardState.teamA.bgColor1
    ScoreboardState.config.matchSetup.teamA.bgColor2 = ScoreboardState.teamA.bgColor2
    ScoreboardState.config.matchSetup.teamA.fgColor = ScoreboardState.teamA.fgColor
    ScoreboardState.config.matchSetup.teamA.hsl = ScoreboardState.teamA.hsl
    ScoreboardState.config.matchSetup.teamB.name = ScoreboardState.teamB.name
    ScoreboardState.config.matchSetup.teamB.bgColor1 = ScoreboardState.teamB.bgColor1
    ScoreboardState.config.matchSetup.teamB.bgColor2 = ScoreboardState.teamB.bgColor2
    ScoreboardState.config.matchSetup.teamB.fgColor = ScoreboardState.teamB.fgColor
    ScoreboardState.config.matchSetup.teamB.hsl = ScoreboardState.teamB.hsl
    if love.filesystem.getInfo("SavedTeams.json") ~= nil then
      rawSaveData = json.encode(ScoreboardState.config)
      success, message = love.filesystem.write("SavedConfig.json", rawSaveData)
    end
    saveOK = 5
  elseif elementId == "nsTab" or elementId == "toNetSport" then
    if ScoreboardState.matchStatus == 0 then
      ScoreboardState.onDisplay = "NetSportScoreboard"
      ScreenManager.changeScreen("NetSportScoreboard")
    elseif ScoreboardState.matchStatus == 1 then
      openDialogBoxFor = "continueBasketball"
    elseif ScoreboardState.matchStatus == 2 then
      openDialogBoxFor = "continueNetSport"
    end
  elseif elementId == "continue" or elementId == "startNew" then
    if elementId == "startNew" then
      ScoreboardState.matchStatus = 0
    end
    if openDialogBoxFor == "continueBasketball" then
      ScoreboardState.onDisplay = "BasketballScoreboard"
      ScreenManager.changeScreen("BasketballScoreboard")
    else
      ScoreboardState.onDisplay = "NetSportScoreboard"
      ScreenManager.changeScreen("NetSportScoreboard")
    end
  elseif elementId == "exitDialog" then
    openDialogBoxFor = ""
  end
end

function MatchSetup:finishEditing()
  love.keyboard.setTextInput(false)
  if ScoreboardState.onEdit.id == "matchTitle" then
    ScoreboardState.matchTitle = ScoreboardState.onEdit.value
  elseif ScoreboardState.onEdit.id == "teamAName" then
    ScoreboardState.teamA.name = ScoreboardState.onEdit.value
  elseif ScoreboardState.onEdit.id == "teamBName" then
    ScoreboardState.teamB.name = ScoreboardState.onEdit.value
  end
  ScoreboardState.onEdit.id = ""
  ScoreboardState.onEdit.value = ""
end

function MatchSetup:attemptExitScreen()
  ScoreboardState.onMouseFocus = ""
  ScoreboardState.onEdit.id = ""
  ScoreboardState.onEdit.value = ""
end

return MatchSetup