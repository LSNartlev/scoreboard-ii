local NetSportScoreboard = {}
local ScreenManager = require("ui.ScreenManager")
local ScoreboardState = require("data.ScoreboardState")
local Designer = require("ui.designs.NetSportDesigner")
local Actions = require("ui.functions.NetSportActions")
local Color = require("ui.designs.Colors")
local Fonts = require("ui.designs.Fonts")
local Icons = require("ui.designs.Icons")
local Lang = require("data.language.en")
local Controls = require("data.Controls")
local sfx = require("ui.functions.SoundEffectActions")
local hsl = require("ext.HSLtoRGB")
local gradRect = require("ui.designs.GradientMesh")
local hornSound, serveTimerRun, serveDT, lastServeDT, teamAColors, teamBColors, setWinColor
local animatedBg, pointDiff, scoreAnim, isMatchOver

function NetSportScoreboard:load()
  ScoreboardState.onDisplay = "NetSportScoreboard"
  ScoreboardState.tooltip = Lang.tooltips.scoreboardFallback
  hornSound = love.audio.newSource("assets/horn.wav", "static")
  hornSound:setLooping(true)
  hornSound:setVolume(0)
  hornSound:play()
  lastServeDT = 0
  serveTimerRun = 0
  teamAColors = gradRect.new(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 0.6)
  teamBColors = gradRect.new(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 0.6)
  setWinColor = gradRect.new({r=1, g=0.75, b=0}, {r=1, g=1, b=0}, 1)
  animatedBg = {
    movingX = { teamA = 0, teamB = 1280, teamBWidth = 0 },
    finalX = { teamA = 640, teamB = 640, teamBWidth = 640 }
  }
  pointDiff = 0
  scoreAnim = { teamA = 0, teamB = 0 }
  Actions:updateSetScoresView()
  if ScoreboardState.matchStatus == 0 then
    Actions:startNewMatch()
  end
  isMatchOver = false
  for _, v in ipairs(Icons) do
    v:setFilter("linear", "linear")
  end
end

function NetSportScoreboard:update(dt)
  ScoreboardState.timeDisplay.displayText = Actions:getMatchDuration(love.timer.getTime())
  if ScoreboardState.serveTimerState == 0 then
    serveTimerRun = love.timer.getTime()*100
  else
    serveDT = (love.timer.getTime()*100 - serveTimerRun) % 10
    if serveDT <= lastServeDT then
      self.countdownServeTimer()
    end
    lastServeDT = serveDT
  end
  
  if ScoreboardState.serveTimer.sec >= 10 then
    ScoreboardState.serveTimer.displayText = ScoreboardState.serveTimer.sec
  else
    ScoreboardState.serveTimer.displayText = ScoreboardState.serveTimer.sec
      .. "." .. ScoreboardState.serveTimer.dSec
  end
  
  if ScoreboardState.isHornSoundPlaying then
    hornSound:setVolume(1)
  else
    hornSound:setVolume(0)
  end
  
  if isMatchOver then
      if ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] > ScoreboardState.teamB.nsScore[ScoreboardState.nsSet] then
        pointDiff = 8
      else
        pointDiff = -8
      end
  else
    pointDiff = ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] - ScoreboardState.teamB.nsScore[ScoreboardState.nsSet]
  end
  
  if pointDiff < -8 then pointDiff = -8
  elseif pointDiff > 8 then pointDiff = 8
  end

  animatedBg.finalX.teamA = 80*(8+pointDiff)
  animatedBg.finalX.teamB = animatedBg.finalX.teamA
  animatedBg.finalX.teamBWidth = 1280-animatedBg.finalX.teamA
  if animatedBg.movingX.teamA < animatedBg.finalX.teamA then
    animatedBg.movingX.teamA = animatedBg.movingX.teamA + 5 end
  if animatedBg.movingX.teamA > animatedBg.finalX.teamA then
    animatedBg.movingX.teamA = animatedBg.movingX.teamA - 5 end
  if animatedBg.movingX.teamB < animatedBg.finalX.teamB then
    animatedBg.movingX.teamB = animatedBg.movingX.teamB + 5 end
  if animatedBg.movingX.teamB > animatedBg.finalX.teamB then
    animatedBg.movingX.teamB = animatedBg.movingX.teamB - 5 end
  if animatedBg.movingX.teamBWidth < animatedBg.finalX.teamBWidth then
    animatedBg.movingX.teamBWidth = animatedBg.movingX.teamBWidth + 5 end
  if animatedBg.movingX.teamBWidth > animatedBg.finalX.teamBWidth then
    animatedBg.movingX.teamBWidth = animatedBg.movingX.teamBWidth - 5 end
    
  if scoreAnim.teamA > 0 then
    scoreAnim.teamA = scoreAnim.teamA - 0.01 end
  if scoreAnim.teamB > 0 then
    scoreAnim.teamB = scoreAnim.teamB - 0.01 end
end

function NetSportScoreboard:draw()
  teamAColors:updateBgColors(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 0.6)
  teamBColors:updateBgColors(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 0.6)
  love.graphics.draw(teamAColors.mesh, 0, 0, 0, animatedBg.movingX.teamA, 720)
  love.graphics.draw(teamBColors.mesh, animatedBg.movingX.teamB, 0, 0, animatedBg.movingX.teamBWidth, 720)
  teamAColors:updateBgColors(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 1)
  teamBColors:updateBgColors(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 1)
  love.graphics.draw(teamAColors.mesh, 40, 120, 0, 560, 60)
  love.graphics.draw(teamBColors.mesh, 680, 120, 0, 560, 60)
  
  for _, v in ipairs(Designer.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  
  for _, v in ipairs(Designer.setScores.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
  end
  
  for _, v in ipairs(Designer.triangles) do
    love.graphics.setColor(v.color())
    love.graphics.polygon("fill", v.x1, v.y1, v.x2, v.y2, v.x3, v.y3)
    love.graphics.setColor(1,1,1,1)
  end
  
  self.drawSetWinAndTimeoutMarkers()
  
  for _, v in ipairs(Designer.texts) do
    love.graphics.setFont(v.font())
    love.graphics.setColor(v.color())
    if v.id == "teamAName" or v.id == "teamBName" then
      love.graphics.setScissor(v.x, v.y-10, v.width, 50)
    end
    love.graphics.printf(v.text(), v.x, v.y, v.width, v.align)
    love.graphics.setScissor()
    love.graphics.setColor(1,1,1,1)
  end
  
  -- Time Display
  love.graphics.setFont(Fonts.nsSetScores)
  if ScoreboardState.timeDisplay.mode == "time" then
    local colonColor
    if math.floor(tonumber(os.date("%S"))) % 2 == 0 then colonColor = Color.black
    else colonColor = Color.alpha end
    love.graphics.printf({
        Color.black, tonumber(os.date("%I")),
        colonColor, ":",
        Color.black, os.date("%M %p")
      },
      560, 615, 320, "center"
    )
  else
    love.graphics.setColor(Color.black)
    love.graphics.printf(ScoreboardState.timeDisplay.displayText, 560, 615, 320, "center")
    love.graphics.setColor(1,1,1,1)
  end
  
  for _, v in ipairs(Designer.setScores.texts) do
    love.graphics.setFont(v.font)
    love.graphics.setColor(v.color())
    love.graphics.printf(v.text(), v.x, v.y, v.width, v.align)
    love.graphics.setColor(1,1,1,1)
  end
  
  for _, v in ipairs(Designer.tabButtons) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(v.icon(), v.x, v.y+10, 0, 60/v.icon():getWidth(), 60/v.icon():getHeight())
  end
  
  if scoreAnim.teamA > 0 or scoreAnim.teamB > 0 or isMatchOver then
    self:drawScoreAnimation()
  end
end

function NetSportScoreboard:mousemoved(x, y, dx, dy, istouch)
  ScoreboardState.tooltip = Lang.tooltips.scoreboardFallback
  for _,v in ipairs(Designer.mouseBounds) do
    if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
      ScoreboardState.onMouseFocus = v.id
      if Lang.nsScoreboard[ScoreboardState.onMouseFocus] then
        ScoreboardState.tooltip = Lang.nsScoreboard[ScoreboardState.onMouseFocus]
      end
      if (v.id == "teamAServeTimer" and ScoreboardState.teamA.nsService)
        or (v.id == "teamBServeTimer" and ScoreboardState.teamB.nsService) then
        ScoreboardState.tooltip = Lang.nsScoreboard.serveTimer
      end
    end
  end
end

function NetSportScoreboard:mousepressed(x, y, button)
  for _, v in ipairs(Designer.mouseBounds) do
    if x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
      self:performClickAction(v.id, button)
      if ScoreboardState.timeDisplay.start == nil then
        ScoreboardState.timeDisplay.start = love.timer.getTime()
      end
      ScoreboardState.matchStatus = 2
      break
    end
  end
  
end

function NetSportScoreboard:keypressed(key, scancode, isrepeat)
  if key == Controls.ns.scoreTeamA then
    if love.keyboard.isDown("lshift","rshift") then
      Actions:score("A", -1)
    else 
      Actions:score("A", 1)
      scoreAnim.teamA = 1.5
    end
  elseif key == Controls.ns.scoreTeamB then
    if love.keyboard.isDown("lshift","rshift") then
      Actions:score("B", -1)
    else 
      Actions:score("B", 1)
      scoreAnim.teamB = 1.5
    end
  elseif key == Controls.ns.timeoutTeamA then
    if love.keyboard.isDown("lshift","rshift") then
      Actions:timeout("A", 1)
    else 
      Actions:timeout("A", -1)
    end
  elseif key == Controls.ns.timeoutTeamB then
    if love.keyboard.isDown("lshift","rshift") then
      Actions:timeout("B", 1)
    else 
      Actions:timeout("B", -1)
    end
  elseif key == Controls.ns.serveTeamA then
    Actions:toggleService("A")
  elseif key == Controls.ns.serveTeamB then
    Actions:toggleService("B")
  end
  
  if key == Controls.ns.toggleServeTimer then
    if ScoreboardState.teamA.nsService or ScoreboardState.teamB.nsService then
      Actions:toggleServeTimer()
    end
  end
  
  if love.keyboard.isDown(Controls.bb.hornSound) then
    ScoreboardState.isHornSoundPlaying = true
    hornSound:setVolume(1)
  end
  
  if key == Controls.ns.prevSet and ScoreboardState.nsSet > 1 then
    ScoreboardState.nsSet = ScoreboardState.nsSet - 1
    Actions:updateSetScoresView()
  end
  
  if key == Controls.ns.nextSet and ScoreboardState.nsSet < ScoreboardState.config.ns.maxSets then
    ScoreboardState.nsSet = ScoreboardState.nsSet + 1
    Actions:updateSetScoresView()
  end
  
  if key == Controls.ns.changeCourt then
    self.changeCourt()
  end
  
  for i=1, 10, 1 do
    if key == Controls.sounds[i] then
      if love.keyboard.isDown("lshift","rshift") then
        sfx:stopSound(i)
      else sfx:playSound(i)
      end
    end
  end
  
  if key == "escape" then
    ScoreboardState.onDisplay = "MatchSetup"
    ScreenManager.changeScreen("MatchSetup")
  end
  
  if ScoreboardState.timeDisplay.start == nil then
    ScoreboardState.timeDisplay.start = love.timer.getTime()
  end
  ScoreboardState.matchStatus = 2
end

function NetSportScoreboard:keyreleased(key, scancode)
  if key == Controls.bb.hornSound then
    ScoreboardState.isHornSoundPlaying = false
  end
end

function NetSportScoreboard:performClickAction(elementId, button)
  if elementId == "matchTitle" or elementId == "teamAName" or elementId == "teamBName" then
      ScreenManager.changeScreen("MatchSetup")
  elseif elementId == "teamAScore" then
    if button == 1 then
      Actions:score("A", 1)
      scoreAnim.teamA = 1.5
    elseif button == 2 then
      Actions:score("A", -1)
    end
  elseif elementId == "teamBScore" then
    if button == 1 then
      Actions:score("B", 1)
      scoreAnim.teamB = 1.5
    elseif button == 2 then
      Actions:score("B", -1)
    end
  elseif elementId == "teamATimeouts" then
    if button == 1 then Actions:timeout("A", -1) elseif button == 2 then Actions:timeout("A", 1) end
  elseif elementId == "teamBTimeouts" then
    if button == 1 then Actions:timeout("B", -1) elseif button == 2 then Actions:timeout("B", 1) end
  elseif elementId == "teamAService" and button == 1 then
    Actions:toggleService("A")
  elseif elementId == "teamBService" and button == 1 then
    Actions:toggleService("B")
  elseif (elementId == "teamAServeTimer" or elementId == "teamBServeTimer") and button == 1 then
    Actions:toggleServeTimer()
  elseif elementId == "timeDisplay" then
    if ScoreboardState.timeDisplay.mode == "time" then
      ScoreboardState.timeDisplay.mode = "duration"
    else ScoreboardState.timeDisplay.mode = "time" end
  elseif elementId == "set" and button == 1 then
    self.changeCourt()
  elseif elementId == "bbTab" and button == 1  then
    ScreenManager.changeScreen("BasketballScoreboard")
  elseif elementId == "configTab" and button == 1  then
    ScreenManager.changeScreen("MatchSetup") -- temporary
    -- ScreenManager.changeScreen("NetSportControlsConfig") -- actual    
  elseif elementId == "aboutTab" then
      ScreenManager.changeScreen("AboutScreen")
  end
end

function NetSportScoreboard:countdownServeTimer()
  if ScoreboardState.serveTimerState == 2 then
    if ScoreboardState.serveTimer.dSec > 0 then
        ScoreboardState.serveTimer.dSec = ScoreboardState.serveTimer.dSec - 1
    elseif ScoreboardState.serveTimer.sec > 0 then
        ScoreboardState.serveTimer.sec = ScoreboardState.serveTimer.sec - 1
        ScoreboardState.serveTimer.dSec = 9
    end
    
    if ScoreboardState.serveTimer.dSec == 0
      and ScoreboardState.serveTimer.sec == 0 then
      ScoreboardState.serveTimerState = 1
      if ScoreboardState.config.ns.serveTimer.hornSoundOnZero == true then
        ScoreboardState.isHornSoundPlaying = true
      end
    end
  end
end

function NetSportScoreboard:drawSetWinAndTimeoutMarkers()
  local maxSlots
  local swA = ScoreboardState.teamA.nsSetWins
  local swB = ScoreboardState.teamB.nsSetWins
  local toA = ScoreboardState.teamA.nsTimeouts[ScoreboardState.nsSet]
  local toB = ScoreboardState.teamB.nsTimeouts[ScoreboardState.nsSet]
  local timeoutModColor = { r = 0, g = 0, b = 0 }
  local x, y, w, h
  local function drawSetWins(team, sw, i, x, y, h, maxSlots)
    if team == "A" then x = 140 else x = 1080 end
    if sw >= i and i <= maxSlots then 
      love.graphics.draw(setWinColor.mesh, x, y, 0, 60, h)
    else
      love.graphics.setColor(Color.black)
      love.graphics.rectangle("fill", x, y, 60, h)
    end
    love.graphics.setColor(1,1,1,1)
  end
  local function drawTimeouts(team, to, i, x, maxSlots)
    y = 555
    h = 30
    local m = 10
    if to >= i and team == "A" then
      if ScoreboardState.teamA.hsl.fg[3] < 180 then
        timeoutModColor.r, timeoutModColor.g, timeoutModColor.b = hsl:toRGB(ScoreboardState.teamA.hsl.fg[1], ScoreboardState.teamA.hsl.fg[2], 180)
        love.graphics.setColor(timeoutModColor.r, timeoutModColor.g, timeoutModColor.b)
      else
        love.graphics.setColor(ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, ScoreboardState.teamA.fgColor.b)
      end
      love.graphics.polygon("fill", x,y+(h/2), x+m,y, x+w-m,y, x+w,y+(h/2), x+w-m,y+h, x+m,y+h)
    elseif to >= i and team == "B" then
      if ScoreboardState.teamB.hsl.fg[3] < 180 then
        timeoutModColor.r, timeoutModColor.g, timeoutModColor.b = hsl:toRGB(ScoreboardState.teamB.hsl.fg[1], ScoreboardState.teamB.hsl.fg[2], 180)
        love.graphics.setColor(timeoutModColor.r, timeoutModColor.g, timeoutModColor.b)
      else
        love.graphics.setColor(ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, ScoreboardState.teamB.fgColor.b)
      end
      love.graphics.polygon("fill", x,y+(h/2), x+m,y, x+w-m,y, x+w,y+(h/2), x+w-m,y+h, x+m,y+h)
    elseif i <= maxSlots then
      love.graphics.setColor(Color.black)
      love.graphics.polygon("fill", x,y+(h/2), x+m,y, x+w-m,y, x+w,y+(h/2), x+w-m,y+h, x+m,y+h)
    end
    love.graphics.setColor(1,1,1,1)
  end
  
  maxSlots = math.ceil(ScoreboardState.config.ns.maxSets/2)
  local gap
  if maxSlots > 3 then
    h = math.floor(((200-(10*(maxSlots-1)))/maxSlots))
    gap = 10
  else
    h = 50
    gap = 15
  end
  local hMax = (h*maxSlots)+(gap*(maxSlots-1))
  local offset = 200+((200-hMax)/2)
  for i = 1, maxSlots, 1 do
    y = offset+((h+gap)*(i-1))
    drawSetWins("A", swA, i, x, y, h, maxSlots)
    drawSetWins("B", swB, i, x, y, h, maxSlots)
  end
  
  maxSlots = math.max(ScoreboardState.config.ns.maxTimeouts, ScoreboardState.config.ns.maxTimeoutsLast)
  if maxSlots > 4 then w = (270-(5*(maxSlots-1)))/maxSlots
  else w = 60 end
  for i = 1, maxSlots, 1 do
    x = 508-(w*i)-(5*(i-1))
    drawTimeouts("A", toA, i, x, w)
    x = 772+(w*(i-1))+(5*(i-1))
    drawTimeouts("B", toB, i, x, w, maxSlots)
  end
end

function NetSportScoreboard:drawScoreAnimation()
  if scoreAnim.teamA > 0 then
    teamAColors:updateBgColors(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, scoreAnim.teamA)
    if isMatchOver and ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] >= ScoreboardState.nsTargetScore[ScoreboardState.nsSet] then
      teamAColors:updateBgColors(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 1)
    end
    love.graphics.draw(teamAColors.mesh, 220, 200, 0, 380, 200)
    love.graphics.setColor(ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, 
      ScoreboardState.teamA.fgColor.b, scoreAnim.teamA)
    if isMatchOver and ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] >= ScoreboardState.nsTargetScore[ScoreboardState.nsSet] then
      love.graphics.setColor(ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, 
      ScoreboardState.teamA.fgColor.b, 1)
    end
    love.graphics.setFont(Fonts.score)
    love.graphics.printf(ScoreboardState.teamA.nsScore[ScoreboardState.nsSet], 220, 210, 380, "center")
    love.graphics.setColor(1,1,1,1)
  end
  if scoreAnim.teamB > 0 then
    teamBColors:updateBgColors(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, scoreAnim.teamB)
    if isMatchOver and ScoreboardState.teamB.nsScore[ScoreboardState.nsSet] >= ScoreboardState.nsTargetScore[ScoreboardState.nsSet] then
      teamBColors:updateBgColors(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 1)
    end
    love.graphics.draw(teamBColors.mesh, 680, 200, 0, 380, 200)
    love.graphics.setColor(ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, 
      ScoreboardState.teamB.fgColor.b, scoreAnim.teamB)
    if isMatchOver and ScoreboardState.teamB.nsScore[ScoreboardState.nsSet] >= ScoreboardState.nsTargetScore[ScoreboardState.nsSet] then
      love.graphics.setColor(ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, 
      ScoreboardState.teamB.fgColor.b, 1)
    end
    love.graphics.setFont(Fonts.score)
    love.graphics.printf(ScoreboardState.teamB.nsScore[ScoreboardState.nsSet], 680, 210, 380, "center")
    love.graphics.setColor(1,1,1,1)
  end
  if isMatchOver then
    ScoreboardState.tooltip = Lang.tooltips.matchEnd.basketball
  end
end

function NetSportScoreboard:changeCourt()
  ScoreboardState.teamA, ScoreboardState.teamB = ScoreboardState.teamB, ScoreboardState.teamA
  teamAColors.mesh, teamBColors.mesh = teamBColors.mesh, teamAColors.mesh
end

function NetSportScoreboard:attemptExitScreen()
  ScoreboardState.serveTimerState = 0
  ScoreboardState.isHornSoundPlaying = false
  ScoreboardState.onMouseFocus = ""
  ScoreboardState.onEdit.id = ""
  ScoreboardState.onEdit.value = ""
  hornSound:stop()
  sfx:stopAllSounds()
end

return NetSportScoreboard