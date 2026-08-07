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
local gradRect = require("ui.designs.GradientMesh")
local serveTimerRun, serveDT, lastServeDT, teamAColors, teamBColors
local animatedBg, pointDiff, scoreAnim, isMatchOver

function NetSportScoreboard:load()
  ScoreboardState.onDisplay = "BasketballScoreboard"
  ScoreboardState.tooltip = Lang.tooltips.scoreboardFallback
  hornSound = love.audio.newSource("assets/horn.wav", "static")
  hornSound:setLooping(true)
  hornSound:setVolume(0)
  hornSound:play()
  lastServeDT = 0
  serveTimerRun = 0
  teamAColors = gradRect.new(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 0.7)
  teamBColors = gradRect.new(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 0.7)
  animatedBg = {
    movingX = { teamA = 0, teamB = 1280, teamBWidth = 0 },
    finalX = { teamA = 640, teamB = 640, teamBWidth = 640 }
  }
  pointDiff = 0
  scoreAnim = { teamA = 0, teamB = 0 }
  if ScoreboardState.matchStatus == 0 then
    Actions:startNewMatch()
  end
  isMatchOver = false
  for _, v in ipairs(Icons) do
    v:setFilter("linear", "linear")
  end
end

function NetSportScoreboard:update(dt)
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
  
  if pointDiff < -16 then pointDiff = -16
  elseif pointDiff > 16 then pointDiff = 16
  end

  animatedBg.finalX.teamA = 40*(16+pointDiff)
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
    scoreAnim.teamA = scoreAnim.teamA - 0.025 end
  if scoreAnim.teamB > 0 then
    scoreAnim.teamB = scoreAnim.teamB - 0.025 end
end

function NetSportScoreboard:draw()
  teamAColors:updateBgColors(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 0.7)
  teamBColors:updateBgColors(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 0.7)
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
  
  for _, v in ipairs(Designer.triangles) do
    love.graphics.setColor(v.color())
    love.graphics.polygon("fill", v.x1, v.y1, v.x2, v.y2, v.x3, v.y3)
    love.graphics.setColor(1,1,1,1)
  end
  
  for _, v in ipairs(Designer.texts) do
    love.graphics.setFont(v.font())
    love.graphics.setColor(v.color())
    if v.id == "teamAName" or v.id == "teamBName" then
      love.graphics.setScissor(v.x, v.y, v.width, 40)
    end
    love.graphics.printf(v.text(), v.x, v.y, v.width, v.align)
    love.graphics.setScissor()
    love.graphics.setColor(1,1,1,1)
  end
  
  for _, v in ipairs(Designer.tabButtons) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(v.icon(), v.x, v.y+10, 0, 60/v.icon():getWidth(), 60/v.icon():getHeight())
  end
end

function NetSportScoreboard:mousemoved(x, y, dx, dy, istouch)
  
end

function NetSportScoreboard:mousepressed(x, y, button)
  
end

function NetSportScoreboard:keypressed(key, scancode, isrepeat)
  
end

function NetSportScoreboard:keyreleased(key, scancode)
  
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
      ScoreboardState.isHornSoundPlaying = true
      hornSound:setVolume(1)
    end
  end
end

function NetSportScoreboard:attemptExitScreen()
  
end

return NetSportScoreboard