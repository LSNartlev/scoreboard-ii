local TeamSetup = {}
local utf8 = require("utf8") -- see MatchSetup:keypressed()
local ScreenManager = require("ui.ScreenManager")
local ScoreboardState = require("data.ScoreboardState")
local ConfigDesigner = require("ui.designs.ConfigDesigner")
local Designer = require("ui.designs.TeamSetupDesigner")
local Color = require("ui.designs.Colors")
local TeamsList = require("data.TeamsList")
local json = require("ext.rxi-json.json")
local Lang = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local gradRect = require("ui.designs.GradientMesh")
local team = require("data.TeamDetails")
local hsl = require("ext.HSLtoRGB")
local hueSlider, activeSlider
local gradToDraw, teamList, rawSaveData

function TeamSetup:load()
  ScoreboardState.tooltip = Lang.tooltips.teamSetup
  hueSlider = love.graphics.newImage("assets/hueSlider.png", { mipmaps = true })
  rawSaveData = love.filesystem.read("SavedTeams.json")
  TeamsList = json.decode(rawSaveData)
  ScoreboardState.teamSetup.listPage = 1
  self:loadTeamList()
  if ScoreboardState.teamSetup.side == "" then
    ScoreboardState.config.tabs.isSelectable = true
    ScoreboardState.teamSetup.name = teamList[1].name
    ScoreboardState.teamSetup.hsl = teamList[1].hsl
    ScoreboardState.teamSetup.bgColor1 = teamList[1].bgColor1
    ScoreboardState.teamSetup.bgColor2 = teamList[1].bgColor2
    ScoreboardState.teamSetup.fgColor = teamList[1].fgColor
  elseif ScoreboardState.teamSetup.side == "A" then
    ScoreboardState.config.tabs.isSelectable = false
    ScoreboardState.teamSetup.name = ScoreboardState.teamA.name
    ScoreboardState.teamSetup.hsl = ScoreboardState.teamA.hsl
    ScoreboardState.teamSetup.bgColor1 = ScoreboardState.teamA.bgColor1
    ScoreboardState.teamSetup.bgColor2 = ScoreboardState.teamA.bgColor2
    ScoreboardState.teamSetup.fgColor = ScoreboardState.teamA.fgColor
  elseif ScoreboardState.teamSetup.side == "B" then
    ScoreboardState.config.tabs.isSelectable = false
    ScoreboardState.teamSetup.name = ScoreboardState.teamB.name
    ScoreboardState.teamSetup.hsl = ScoreboardState.teamB.hsl
    ScoreboardState.teamSetup.bgColor1 = ScoreboardState.teamB.bgColor1
    ScoreboardState.teamSetup.bgColor2 = ScoreboardState.teamB.bgColor2
    ScoreboardState.teamSetup.fgColor = ScoreboardState.teamB.fgColor
  end
  activeSlider = ""
end

function TeamSetup:update(dt)
  local mouseY = love.mouse.getY()
  local minThumbY, maxThumbY = 245, 605
  if activeSlider == "hueSlider" then
    if mouseY <= minThumbY then
      ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][1] = 0
    elseif mouseY >= maxThumbY then
      ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][1] = 360
    else
      ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][1] = mouseY - minThumbY
    end
  elseif activeSlider == "satSlider" then
    if mouseY <= minThumbY then
      ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][2] = 360
    elseif mouseY >= maxThumbY then
      ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][2] = 0
    else
      ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][2] = maxThumbY - mouseY
    end
  elseif activeSlider == "lightSlider" then
    if mouseY <= minThumbY then
      ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][3] = 360
    elseif mouseY >= maxThumbY then
      ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][3] = 0
    else
      ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][3] = maxThumbY - mouseY
    end
  end
  local r, g, b = hsl:toRGB(ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][1], 
    ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][2], ScoreboardState.teamSetup.hsl[ScoreboardState.teamSetup.activeColorTab][3])
  if ScoreboardState.teamSetup.activeColorTab == "bg1" then
    ScoreboardState.teamSetup.bgColor1.r, ScoreboardState.teamSetup.bgColor1.g, ScoreboardState.teamSetup.bgColor1.b = r, g, b
  elseif ScoreboardState.teamSetup.activeColorTab == "bg2" then
    ScoreboardState.teamSetup.bgColor2.r, ScoreboardState.teamSetup.bgColor2.g, ScoreboardState.teamSetup.bgColor2.b = r, g, b
  elseif ScoreboardState.teamSetup.activeColorTab == "fg" then
    ScoreboardState.teamSetup.fgColor.r, ScoreboardState.teamSetup.fgColor.g, ScoreboardState.teamSetup.fgColor.b = r, g, b
  end
end

function TeamSetup:draw()
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
    if ScoreboardState.teamSetup.side == "" then
      love.graphics.setColor(1,1,1,1)
    else
      love.graphics.setColor(0.5,0.5,0.5,0.5)
    end
    love.graphics.draw(v.icon(), v.x, v.y+10, 0, 60/v.icon():getWidth(), 60/v.icon():getHeight())
  end
  
  for _, v in ipairs(Designer.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  love.graphics.draw(hueSlider, 260, 250)
  self:drawElementsWithGradientColors()
  
  for _, v in ipairs(Designer.circles) do
    love.graphics.setColor(v.color())
    love.graphics.circle("fill", v.x, v.y, v.radius)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(Designer.sliderThumbs) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y(), v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  for _, v in ipairs(Designer.texts) do
    love.graphics.setFont(v.font)
    love.graphics.setColor(v.color())
    if v.id == "teamName" then
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
  
end

function TeamSetup:textinput(text)
  ScoreboardState.onEdit.value = ScoreboardState.onEdit.value .. text
end

function TeamSetup:mousemoved(x, y, dx, dy, istouch)
  if ScoreboardState.onEdit.id == "" then
    ScoreboardState.tooltip = Lang.tooltips.teamSetup
  elseif ScoreboardState.onEdit.id == "teamName" then
    ScoreboardState.tooltip = Lang.teamSetup.onEdit.teamName
  elseif ScoreboardState.onEdit.id == "saveTeam" then
    ScoreboardState.tooltip = Lang.teamSetup.onEdit.saveTeam
  end
  for _, v in ipairs(Designer.mouseBounds) do
    if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
      ScoreboardState.onMouseFocus = v.id
      break
    end
  end
end

function TeamSetup:mousepressed(x, y, button)
  for _, v in ipairs(Designer.mouseBounds) do
    if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
      self:performClickAction(v.id)
      break
    end
  end
end

function TeamSetup:mousereleased(x, y, button, istouch, presses)
  if button == 1 and activeSlider ~= "" then
    activeSlider = ""
    ScoreboardState.onEdit.id = ""
  end
end

function TeamSetup:keypressed(key, scancode, isrepeat)
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

function TeamSetup:textinput(text)
  ScoreboardState.onEdit.value = ScoreboardState.onEdit.value .. text
end

function TeamSetup:drawElementsWithGradientColors()
  local bgColorTop = { r = 0, g = 0, b = 0 }
  local bgColorMid = { r = 0, g = 0, b = 0 }
  local bgColorBot = { r = 0, g = 0, b = 0 }
  gradToDraw = gradRect.new(ScoreboardState.teamSetup.bgColor1, ScoreboardState.teamSetup.bgColor2, 1)
  love.graphics.draw(gradToDraw.mesh, 460, 290, 0, 260, 260)
  
  -- saturation slider
  if ScoreboardState.teamSetup.activeColorTab == "bg1" then
    bgColorTop.r, bgColorTop.g, bgColorTop.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg1[1], 360, ScoreboardState.teamSetup.hsl.bg1[3])
    bgColorMid.r, bgColorMid.g, bgColorMid.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg1[1], 180, ScoreboardState.teamSetup.hsl.bg1[3])
    bgColorBot.r, bgColorBot.g, bgColorBot.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg1[1], 0, ScoreboardState.teamSetup.hsl.bg1[3])
  elseif ScoreboardState.teamSetup.activeColorTab == "bg2" then
    bgColorTop.r, bgColorTop.g, bgColorTop.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg2[1], 360, ScoreboardState.teamSetup.hsl.bg2[3])
    bgColorMid.r, bgColorMid.g, bgColorMid.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg2[1], 180, ScoreboardState.teamSetup.hsl.bg2[3])
    bgColorBot.r, bgColorBot.g, bgColorBot.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg2[1], 0, ScoreboardState.teamSetup.hsl.bg2[3])
  elseif ScoreboardState.teamSetup.activeColorTab == "fg" then
    bgColorTop.r, bgColorTop.g, bgColorTop.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.fg[1], 360, ScoreboardState.teamSetup.hsl.fg[3])
    bgColorMid.r, bgColorMid.g, bgColorMid.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.fg[1], 180, ScoreboardState.teamSetup.hsl.fg[3])
    bgColorBot.r, bgColorBot.g, bgColorBot.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.fg[1], 0, ScoreboardState.teamSetup.hsl.fg[3])
  end
  gradToDraw:updateBgColors(bgColorTop, bgColorMid, 1)
  love.graphics.draw(gradToDraw.mesh, 330, 250, 0, 30, 180)
  gradToDraw:updateBgColors(bgColorMid, bgColorBot, 1)
  love.graphics.draw(gradToDraw.mesh, 330, 430, 0, 30, 180)
  
  -- lightness slider
  if ScoreboardState.teamSetup.activeColorTab == "bg1" then
    bgColorTop.r, bgColorTop.g, bgColorTop.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg1[1], ScoreboardState.teamSetup.hsl.bg1[2], 360)
    bgColorMid.r, bgColorMid.g, bgColorMid.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg1[1], ScoreboardState.teamSetup.hsl.bg1[2], 180)
    bgColorBot.r, bgColorBot.g, bgColorBot.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg1[1], ScoreboardState.teamSetup.hsl.bg1[2], 0)
  elseif ScoreboardState.teamSetup.activeColorTab == "bg2" then
    bgColorTop.r, bgColorTop.g, bgColorTop.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg2[1], ScoreboardState.teamSetup.hsl.bg2[2], 360)
    bgColorMid.r, bgColorMid.g, bgColorMid.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg2[1], ScoreboardState.teamSetup.hsl.bg2[2], 180)
    bgColorBot.r, bgColorBot.g, bgColorBot.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.bg2[1], ScoreboardState.teamSetup.hsl.bg2[2], 0)
  elseif ScoreboardState.teamSetup.activeColorTab == "fg" then
    bgColorTop.r, bgColorTop.g, bgColorTop.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.fg[1], ScoreboardState.teamSetup.hsl.fg[2], 360)
    bgColorMid.r, bgColorMid.g, bgColorMid.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.fg[1], ScoreboardState.teamSetup.hsl.fg[2], 180)
    bgColorBot.r, bgColorBot.g, bgColorBot.b = hsl:toRGB(ScoreboardState.teamSetup.hsl.fg[1], ScoreboardState.teamSetup.hsl.fg[2], 0)
  end
  gradToDraw:updateBgColors(bgColorTop, bgColorMid, 1)
  love.graphics.draw(gradToDraw.mesh, 390, 250, 0, 30, 180)
  gradToDraw:updateBgColors(bgColorMid, bgColorBot, 1)
  love.graphics.draw(gradToDraw.mesh, 390, 430, 0, 30, 180)
  
  -- list of teams (8 entries at a time)
  local entryY = 175 -- y-position of first entry in list
  for i = 1, 8, 1 do
    gradToDraw:updateBgColors(teamList[i].bgColor1, teamList[i].bgColor2, 1)
    love.graphics.draw(gradToDraw.mesh, 800, entryY, 0, 460, 40)
    love.graphics.setScissor(800, entryY, 460, 40)
    entryY = entryY + 5
    love.graphics.setFont(Fonts.configTeam)
    love.graphics.setColor(teamList[i].fgColor.r, teamList[i].fgColor.g, teamList[i].fgColor.b)
    love.graphics.printf(teamList[i].name, 800, entryY, 460, "center")
    entryY = entryY + 45
    love.graphics.setScissor()
    love.graphics.setColor(1,1,1,1)
  end
end

function TeamSetup:performClickAction(elementId)
  if ScoreboardState.onEdit.id == "teamName" then
    self:finishEditing()
  elseif ScoreboardState.onEdit.id == "saveTeam" then
    local page = ScoreboardState.teamSetup.listPage
    if elementId == "listEntry1" then
      self:saveTeam(((page-1)*8)+1)
    elseif elementId == "listEntry2" then
      self:saveTeam(((page-1)*8)+2)
    elseif elementId == "listEntry3" then
      self:saveTeam(((page-1)*8)+3)
    elseif elementId == "listEntry4" then
      self:saveTeam(((page-1)*8)+4)
    elseif elementId == "listEntry5" then
      self:saveTeam(((page-1)*8)+5)
    elseif elementId == "listEntry6" then
      self:saveTeam(((page-1)*8)+6)
    elseif elementId == "listEntry7" then
      self:saveTeam(((page-1)*8)+7)
    elseif elementId == "listEntry8" then
      self:saveTeam(((page-1)*8)+8)
    end
    ScoreboardState.onEdit.id = ""
  else
    if elementId == "hueSlider" or elementId == "satSlider" or elementId == "lightSlider" then
      activeSlider = elementId
      ScoreboardState.onEdit.id = elementId
    elseif elementId == "bg1Tab" then
      ScoreboardState.teamSetup.activeColorTab = "bg1"
    elseif elementId == "bg2Tab" then
      ScoreboardState.teamSetup.activeColorTab = "bg2"
    elseif elementId == "fgTab" then
      ScoreboardState.teamSetup.activeColorTab = "fg"
    elseif elementId == "teamName" then
      ScoreboardState.onEdit.id = elementId
      ScoreboardState.onEdit.value = ScoreboardState.teamSetup.name
      love.keyboard.setTextInput(true)
    elseif elementId == "toMatchSetup" or elementId == "confirmTeam" then
      self:finishEditing()
      if elementId == "confirmTeam" then
        if ScoreboardState.teamSetup.side == "A" then
          self:saveTeam("A")
        elseif ScoreboardState.teamSetup.side == "B" then
          self:saveTeam("B")
        end  
      end
      ScreenManager.changeScreen("MatchSetup")
    elseif elementId == "saveTeam" then
      ScoreboardState.onEdit.id = elementId
    elseif elementId == "listEntry1" then
      self:loadTeam(1)
    elseif elementId == "listEntry2" then
      self:loadTeam(2)
    elseif elementId == "listEntry3" then
      self:loadTeam(3)
    elseif elementId == "listEntry4" then
      self:loadTeam(4)
    elseif elementId == "listEntry5" then
      self:loadTeam(5)
    elseif elementId == "listEntry6" then
      self:loadTeam(6)
    elseif elementId == "listEntry7" then
      self:loadTeam(7)
    elseif elementId == "listEntry8" then
      self:loadTeam(8)
    elseif elementId == "editTeamB" and ScoreboardState.teamSetup.side == "A" then
      self:finishEditing()
      self:saveTeam("A")
      ScoreboardState.teamSetup.side = "B"
      ScoreboardState.teamSetup.name = ScoreboardState.teamB.name
      ScoreboardState.teamSetup.hsl = ScoreboardState.teamB.hsl
      ScoreboardState.teamSetup.bgColor1 = ScoreboardState.teamB.bgColor1
      ScoreboardState.teamSetup.bgColor2 = ScoreboardState.teamB.bgColor2
      ScoreboardState.teamSetup.fgColor = ScoreboardState.teamB.fgColor
    elseif elementId == "editTeamA" and ScoreboardState.teamSetup.side == "B" then
      self:finishEditing()
      self:saveTeam("B")
      ScoreboardState.teamSetup.side = "A"
      ScoreboardState.teamSetup.name = ScoreboardState.teamA.name
      ScoreboardState.teamSetup.hsl = ScoreboardState.teamA.hsl
      ScoreboardState.teamSetup.bgColor1 = ScoreboardState.teamA.bgColor1
      ScoreboardState.teamSetup.bgColor2 = ScoreboardState.teamA.bgColor2
      ScoreboardState.teamSetup.fgColor = ScoreboardState.teamA.fgColor
    end
  end
  if elementId == "listPrevPage" and ScoreboardState.teamSetup.listPage > 1 then
    ScoreboardState.teamSetup.listPage = ScoreboardState.teamSetup.listPage - 1
    self:loadTeamList()
  elseif elementId == "listNextPage" and ScoreboardState.teamSetup.listPage < 8 then
    ScoreboardState.teamSetup.listPage = ScoreboardState.teamSetup.listPage + 1
    self:loadTeamList()
  elseif elementId == "page1" then
    ScoreboardState.teamSetup.listPage = 1
    self:loadTeamList()
  elseif elementId == "page2" then
    ScoreboardState.teamSetup.listPage = 2
    self:loadTeamList()
  elseif elementId == "page3" then
    ScoreboardState.teamSetup.listPage = 3
    self:loadTeamList()
  elseif elementId == "page4" then
    ScoreboardState.teamSetup.listPage = 4
    self:loadTeamList()
  elseif elementId == "page5" then
    ScoreboardState.teamSetup.listPage = 5
    self:loadTeamList()
  elseif elementId == "page6" then
    ScoreboardState.teamSetup.listPage = 6
    self:loadTeamList()
  elseif elementId == "page7" then
    ScoreboardState.teamSetup.listPage = 7
    self:loadTeamList()
  elseif elementId == "page8" then
    ScoreboardState.teamSetup.listPage = 8
    self:loadTeamList()
  end
end

function TeamSetup:finishEditing()
  love.keyboard.setTextInput(false)
  if ScoreboardState.onEdit.id == "teamName" then
    ScoreboardState.teamSetup.name = ScoreboardState.onEdit.value
  end
  ScoreboardState.onEdit.id = ""
  ScoreboardState.onEdit.value = ""
end

function TeamSetup:loadTeam(listEntry)
  local page = ScoreboardState.teamSetup.listPage
  ScoreboardState.teamSetup.name = teamList[listEntry].name
  ScoreboardState.teamSetup.hsl = teamList[listEntry].hsl
  ScoreboardState.teamSetup.bgColor1 = teamList[listEntry].bgColor1
  ScoreboardState.teamSetup.bgColor2 = teamList[listEntry].bgColor2
  ScoreboardState.teamSetup.fgColor = teamList[listEntry].fgColor
  self:loadTeamList()
  self:finishEditing()
end

function TeamSetup:loadTeamList()
  local page = ScoreboardState.teamSetup.listPage
  teamList = {
    team.new(TeamsList[((page-1)*8)+1].name, TeamsList[((page-1)*8)+1].bg1,
      TeamsList[((page-1)*8)+1].bg2, TeamsList[((page-1)*8)+1].fg),
    team.new(TeamsList[((page-1)*8)+2].name, TeamsList[((page-1)*8)+2].bg1,
      TeamsList[((page-1)*8)+2].bg2, TeamsList[((page-1)*8)+2].fg),
    team.new(TeamsList[((page-1)*8)+3].name, TeamsList[((page-1)*8)+3].bg1,
      TeamsList[((page-1)*8)+3].bg2, TeamsList[((page-1)*8)+3].fg),
    team.new(TeamsList[((page-1)*8)+4].name, TeamsList[((page-1)*8)+4].bg1,
      TeamsList[((page-1)*8)+4].bg2, TeamsList[((page-1)*8)+4].fg),
    team.new(TeamsList[((page-1)*8)+5].name, TeamsList[((page-1)*8)+5].bg1,
      TeamsList[((page-1)*8)+5].bg2, TeamsList[((page-1)*8)+5].fg),
    team.new(TeamsList[((page-1)*8)+6].name, TeamsList[((page-1)*8)+6].bg1,
      TeamsList[((page-1)*8)+6].bg2, TeamsList[((page-1)*8)+6].fg),
    team.new(TeamsList[((page-1)*8)+7].name, TeamsList[((page-1)*8)+7].bg1,
      TeamsList[((page-1)*8)+7].bg2, TeamsList[((page-1)*8)+7].fg),
    team.new(TeamsList[((page-1)*8)+8].name, TeamsList[((page-1)*8)+8].bg1,
      TeamsList[((page-1)*8)+8].bg2, TeamsList[((page-1)*8)+8].fg)
  }
end

function TeamSetup:saveTeam(saveTo)
  if type(saveTo) == "string" and saveTo == "A" then
    ScoreboardState.teamA.name = ScoreboardState.teamSetup.name
    ScoreboardState.teamA.bgColor1 = ScoreboardState.teamSetup.bgColor1
    ScoreboardState.teamA.bgColor2 = ScoreboardState.teamSetup.bgColor2
    ScoreboardState.teamA.fgColor = ScoreboardState.teamSetup.fgColor
    ScoreboardState.teamA.hsl = ScoreboardState.teamSetup.hsl
  elseif type(saveTo) == "string" and saveTo == "B" then
    ScoreboardState.teamB.name = ScoreboardState.teamSetup.name
    ScoreboardState.teamB.bgColor1 = ScoreboardState.teamSetup.bgColor1
    ScoreboardState.teamB.bgColor2 = ScoreboardState.teamSetup.bgColor2
    ScoreboardState.teamB.fgColor = ScoreboardState.teamSetup.fgColor
    ScoreboardState.teamB.hsl = ScoreboardState.teamSetup.hsl
  elseif type(saveTo) == "number" then
    TeamsList[saveTo].name = ScoreboardState.teamSetup.name
    TeamsList[saveTo].bg1 = ScoreboardState.teamSetup.hsl.bg1
    TeamsList[saveTo].bg2 = ScoreboardState.teamSetup.hsl.bg2
    TeamsList[saveTo].fg = ScoreboardState.teamSetup.hsl.fg
    if love.filesystem.getInfo("SavedTeams.json") ~= nil then
      rawSaveData = json.encode(TeamsList)
      success, message = love.filesystem.write("SavedTeams.json", rawSaveData)
    end
    self:loadTeamList()
  end
  ScoreboardState.onEdit.id = ""
end

function TeamSetup:attemptExitScreen()
  ScoreboardState.onMouseFocus = ""
  ScoreboardState.onEdit.id = ""
  ScoreboardState.onEdit.value = ""
  ScoreboardState.teamSetup.side = ""
end

return TeamSetup