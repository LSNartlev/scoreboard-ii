local BasketballScoreboard = {}
local ScoreboardState = require("data.ScoreboardState")
local Designer = require("ui.designs.BasketballScoreboardDesigner")
local Color = require("ui.designs.Colors")
local Fonts = require("ui.designs.Fonts")
local Lang = require("data.language.en")
local Controls = require("data.Controls")
local gradRect = require("ui.designs.GradientMesh")
local hornSound, periodTimerRun, shotClockRun, periodDT, shotDT, lastPeriodDT, lastShotDT
local teamAColors, teamBColors
local animatedBg, pointDiff, scoreAnim, isMatchOver

function BasketballScoreboard:load()
  ScoreboardState.tooltip = Lang.tooltips.scoreboardFallback
  hornSound = love.audio.newSource("assets/horn.wav", "static")
  hornSound:setLooping(true)
  hornSound:setVolume(0)
  hornSound:play()
  lastPeriodDT = 0
  lastShotDT = 0
  teamAColors = gradRect.new(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 0.7)
  teamBColors = gradRect.new(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 0.7)
  animatedBg = {
    movingX = { teamA = 0, teamB = 1280, teamBWidth = 0 },
    finalX = { teamA = 640, teamB = 640, teamBWidth = 640 }
  }
  pointDiff = 0
  scoreAnim = { teamA = 0, teamB = 0 }
  isMatchOver = false
end

function BasketballScoreboard:update(dt)
  if ScoreboardState.isPeriodTimerRunning == false then
    periodTimerRun = love.timer.getTime()*100
  else
    periodDT = (love.timer.getTime()*100 - periodTimerRun) % 10
    if periodDT <= lastPeriodDT then
      self.countdownPeriodTimer()
    end
    lastPeriodDT = periodDT
  end
  
  if ScoreboardState.isTimerAdjustmentEnabled then
    ScoreboardState.periodTimer.displayText = ScoreboardState.periodTimer.min
      .. ":" .. string.format("%02d", ScoreboardState.periodTimer.sec)
      .. "." .. ScoreboardState.periodTimer.dSec
  else
    if ScoreboardState.periodTimer.min >= 1 then
      ScoreboardState.periodTimer.displayText = ScoreboardState.periodTimer.min
        .. ":" .. string.format("%02d", ScoreboardState.periodTimer.sec)
    else
      ScoreboardState.periodTimer.displayText = ScoreboardState.periodTimer.sec
        .. "." .. ScoreboardState.periodTimer.dSec
    end
  end
  
  if ScoreboardState.isShotClockRunning == false then
    shotClockRun = love.timer.getTime()*100
  else
    shotDT = (love.timer.getTime()*100 - shotClockRun) % 10
    if shotDT <= lastShotDT then
      self.countdownShotClock()
    end
    lastShotDT = shotDT
  end
  
  if ScoreboardState.shotClock.sec >= 5 and ScoreboardState.isTimerAdjustmentEnabled == false then
    ScoreboardState.shotClock.displayText = ScoreboardState.shotClock.sec
  else
    ScoreboardState.shotClock.displayText = ScoreboardState.shotClock.sec
      .. "." .. ScoreboardState.shotClock.dSec
  end
  
  if isMatchOver then
      if ScoreboardState.teamA.bbScore > ScoreboardState.teamB.bbScore then
        pointDiff = 16
      else
        pointDiff = -16
      end
  else
    pointDiff = ScoreboardState.teamA.bbScore - ScoreboardState.teamB.bbScore
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

function BasketballScoreboard:draw()
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
  
  self.drawTeamFoulAndTimeoutMarkers()
  
  for _, v in ipairs(Designer.texts) do
    love.graphics.setFont(v.font())
    love.graphics.setColor(v.color())
    love.graphics.printf(v.text(), v.x, v.y, v.width, v.align)
    love.graphics.setColor(1,1,1,1)
  end
  
  if scoreAnim.teamA > 0 or scoreAnim.teamB > 0 or isMatchOver then
    self:drawScoreAnimation()
  end
end

function BasketballScoreboard:keypressed(key, scancode, isrepeat)
  if ScoreboardState.isTimerAdjustmentEnabled then
    self:timerAdjustmentAction(key)
  else
    self:regularKeyAction(key)
  end
end

function BasketballScoreboard:keyreleased(key, scancode)
  if key == Controls.bb.hornSound then
    ScoreboardState.isHornSoundPlaying = false
    hornSound:setVolume(0)
    if ScoreboardState.periodTimer.displayText == "0.0" then
      self:prepareNextPeriod()
    end
  end
end

function BasketballScoreboard:regularKeyAction(key)
  if key == Controls.bb.togglePeriodTimer then
    if ScoreboardState.isPeriodTimerRunning then 
      ScoreboardState.isPeriodTimerRunning = false
    elseif ScoreboardState.isPeriodTimerEnabled then
      ScoreboardState.isPeriodTimerRunning = true
    end
  elseif key == Controls.bb.toggleShotClock then
    if ScoreboardState.isShotClockRunning then 
      ScoreboardState.isShotClockRunning = false
    elseif ScoreboardState.isShotClockEnabled then
      ScoreboardState.isShotClockRunning = true
    end
  elseif key == Controls.bb.resetShotClockShort then
    if (ScoreboardState.periodTimer.min*60) + ScoreboardState.periodTimer.sec
      + (ScoreboardState.periodTimer.dSec/10) >= ScoreboardState.config.bb.shotClock.resetShort then 
      ScoreboardState.isShotClockEnabled = true
      ScoreboardState.shotClock.sec = ScoreboardState.config.bb.shotClock.resetShort
      ScoreboardState.shotClock.dSec = 0
    else
      ScoreboardState.isShotClockEnabled = false
    end
    ScoreboardState.isShotClockRunning = false
  elseif key == Controls.bb.resetShotClockFull then
    if (ScoreboardState.periodTimer.min*60) + ScoreboardState.periodTimer.sec
      + (ScoreboardState.periodTimer.dSec/10) >= ScoreboardState.config.bb.shotClock.resetFull then 
      ScoreboardState.isShotClockEnabled = true
      ScoreboardState.shotClock.sec = ScoreboardState.config.bb.shotClock.resetFull
      ScoreboardState.shotClock.dSec = 0
    else
      ScoreboardState.isShotClockEnabled = false
    end
    ScoreboardState.isShotClockRunning = false
  end
  
  if key == Controls.bb.scoreTeamA then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.teamA.bbScore > 0 then
        ScoreboardState.teamA.bbScore = ScoreboardState.teamA.bbScore - 1
      end
    else 
      if ScoreboardState.teamA.bbScore < 999 then
        ScoreboardState.teamA.bbScore = ScoreboardState.teamA.bbScore + 1
        scoreAnim.teamA = 1.25
      end
    end
  elseif key == Controls.bb.foulTeamA then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.teamA.bbTeamFouls > 0 then
        ScoreboardState.teamA.bbTeamFouls = ScoreboardState.teamA.bbTeamFouls - 1
      end
    else
      if ScoreboardState.teamA.bbTeamFouls < ScoreboardState.config.bb.maxTeamFouls then
        ScoreboardState.teamA.bbTeamFouls = ScoreboardState.teamA.bbTeamFouls + 1
      end
    end
  elseif key == Controls.bb.timeoutTeamA then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.teamA.bbTimeouts < ScoreboardState.config.bb.maxTimeouts then
        ScoreboardState.teamA.bbTimeouts = ScoreboardState.teamA.bbTimeouts + 1
      end
    else
      if ScoreboardState.teamA.bbTimeouts > 0 then
        ScoreboardState.teamA.bbTimeouts = ScoreboardState.teamA.bbTimeouts - 1
      end
    end
  elseif key == Controls.bb.ballPossTeamA then
    if ScoreboardState.teamA.bbBallPoss == true then
      ScoreboardState.teamA.bbBallPoss = false
    else
      ScoreboardState.teamA.bbBallPoss = true
    end
    ScoreboardState.teamB.bbBallPoss = false
  elseif key == Controls.bb.scoreTeamB then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.teamB.bbScore > 0 then
        ScoreboardState.teamB.bbScore = ScoreboardState.teamB.bbScore - 1
      end
    else
      if ScoreboardState.teamB.bbScore < 999 then
        ScoreboardState.teamB.bbScore = ScoreboardState.teamB.bbScore + 1
        scoreAnim.teamB = 1.25
      end
    end
  elseif key == Controls.bb.foulTeamB then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.teamB.bbTeamFouls > 0 then
        ScoreboardState.teamB.bbTeamFouls = ScoreboardState.teamB.bbTeamFouls - 1
      end
    else
      if ScoreboardState.teamB.bbTeamFouls < ScoreboardState.config.bb.maxTeamFouls then
        ScoreboardState.teamB.bbTeamFouls = ScoreboardState.teamB.bbTeamFouls + 1
      end
    end
  elseif key == Controls.bb.timeoutTeamB then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.teamB.bbTimeouts < ScoreboardState.config.bb.maxTimeouts then
        ScoreboardState.teamB.bbTimeouts = ScoreboardState.teamB.bbTimeouts + 1
      end
    else
      if ScoreboardState.teamB.bbTimeouts > 0 then
        ScoreboardState.teamB.bbTimeouts = ScoreboardState.teamB.bbTimeouts - 1
      end
    end
  elseif key == Controls.bb.ballPossTeamB then
    if ScoreboardState.teamB.bbBallPoss == true then
      ScoreboardState.teamB.bbBallPoss = false
    else
      ScoreboardState.teamB.bbBallPoss = true
    end
    ScoreboardState.teamA.bbBallPoss = false
  end
  
  if love.keyboard.isDown(Controls.bb.hornSound) then
    ScoreboardState.isHornSoundPlaying = true
    hornSound:setVolume(1)
  end
  
  if key == Controls.bb.prevPeriod and ScoreboardState.bbPeriod > 1 then
    ScoreboardState.bbPeriod = ScoreboardState.bbPeriod - 1
  end
  
  if key == Controls.bb.nextPeriod and ScoreboardState.bbPeriod < 5 then
    ScoreboardState.bbPeriod = ScoreboardState.bbPeriod + 1
  end
  
  if key == Controls.bb.changeCourt then
    self.changeCourt()
  end
  
  if key == Controls.bb.toggleTimerAdjust then
    ScoreboardState.isPeriodTimerRunning = false
    ScoreboardState.isShotClockRunning = false
    ScoreboardState.isTimerAdjustmentEnabled = true
  end
end

function BasketballScoreboard:timerAdjustmentAction(key)
  if key == Controls.bb.timerAdjust.togglePeriodTimerEnabled then
    if ScoreboardState.isPeriodTimerEnabled then
      ScoreboardState.isPeriodTimerEnabled = false
    else
      ScoreboardState.isPeriodTimerEnabled = true
    end
  elseif key == Controls.bb.timerAdjust.toggleShotClockEnabled then
    if ScoreboardState.isShotClockEnabled then
      ScoreboardState.isShotClockEnabled = false
    else
      ScoreboardState.isShotClockEnabled = true
    end
  end
  
  if key == Controls.bb.timerAdjust.periodMin then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.periodTimer.min > 0 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min - 1
      end
    else
      if ScoreboardState.periodTimer.min < 99 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min + 1
      end
    end
  elseif key == Controls.bb.timerAdjust.periodSec then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.periodTimer.sec > 0 then
        ScoreboardState.periodTimer.sec = ScoreboardState.periodTimer.sec - 1
      elseif ScoreboardState.periodTimer.min > 0 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min - 1
        ScoreboardState.periodTimer.sec = 59
      end
    else
      if ScoreboardState.periodTimer.sec < 59 then
        ScoreboardState.periodTimer.sec = ScoreboardState.periodTimer.sec + 1
      elseif ScoreboardState.periodTimer.min < 99 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min + 1
        ScoreboardState.periodTimer.sec = 0
      end
    end
  elseif key == Controls.bb.timerAdjust.periodDsec then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.periodTimer.dSec > 0 then
        ScoreboardState.periodTimer.dSec = ScoreboardState.periodTimer.dSec - 1
      elseif ScoreboardState.periodTimer.sec > 0 then
        ScoreboardState.periodTimer.sec = ScoreboardState.periodTimer.sec - 1
        ScoreboardState.periodTimer.dSec = 9
      elseif ScoreboardState.periodTimer.min > 0 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min - 1
        ScoreboardState.periodTimer.sec = 59
        ScoreboardState.periodTimer.dSec = 9
      end
    else
      if ScoreboardState.periodTimer.dSec < 9 then
        ScoreboardState.periodTimer.dSec = ScoreboardState.periodTimer.dSec + 1
      elseif ScoreboardState.periodTimer.sec < 59 then
        ScoreboardState.periodTimer.sec = ScoreboardState.periodTimer.sec + 1
        ScoreboardState.periodTimer.dSec = 0
      elseif ScoreboardState.periodTimer.min < 99 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min + 1
        ScoreboardState.periodTimer.sec = 0
        ScoreboardState.periodTimer.dSec = 0
      end
    end
  end
  
  if key == Controls.bb.timerAdjust.shotSec then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.shotClock.sec > 0 then
        ScoreboardState.shotClock.sec = ScoreboardState.shotClock.sec - 1
      end
    else
      if ScoreboardState.shotClock.sec < 99 then
        ScoreboardState.shotClock.sec = ScoreboardState.shotClock.sec + 1
      end
    end
  elseif key == Controls.bb.timerAdjust.shotDsec then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.shotClock.dSec > 0 then
        ScoreboardState.shotClock.dSec = ScoreboardState.shotClock.dSec - 1
      elseif ScoreboardState.shotClock.sec > 0 then
        ScoreboardState.shotClock.sec = ScoreboardState.shotClock.sec - 1
        ScoreboardState.shotClock.dSec = 9
      end
    else
      if ScoreboardState.shotClock.dSec < 9 then
        ScoreboardState.shotClock.dSec = ScoreboardState.shotClock.dSec + 1
      elseif ScoreboardState.shotClock.sec < 99 then
        ScoreboardState.shotClock.sec = ScoreboardState.shotClock.sec + 1
        ScoreboardState.shotClock.dSec = 0
      end
    end
  end
  
  if key == Controls.bb.toggleTimerAdjust or key == "escape" then
    ScoreboardState.isTimerAdjustmentEnabled = false
    if (ScoreboardState.periodTimer.min*60 + ScoreboardState.periodTimer.sec + 
      ScoreboardState.periodTimer.dSec/10) > 0 then
      isMatchOver = false
      ScoreboardState.tooltip = Lang.tooltips.scoreboardFallback
    end
  end
end

function BasketballScoreboard:prepareNextPeriod()
  if isMatchOver == false then
    if ScoreboardState.config.bb.isTimeoutCarryover[ScoreboardState.bbPeriod] then
      ScoreboardState.teamA.bbTimeouts = ScoreboardState.teamA.bbTimeouts
        + ScoreboardState.config.bb.givenTimeouts[ScoreboardState.bbPeriod]
      ScoreboardState.teamB.bbTimeouts = ScoreboardState.teamB.bbTimeouts
        + ScoreboardState.config.bb.givenTimeouts[ScoreboardState.bbPeriod]
    else
      ScoreboardState.teamA.bbTimeouts = ScoreboardState.config.bb.givenTimeouts[ScoreboardState.bbPeriod]
      ScoreboardState.teamB.bbTimeouts = ScoreboardState.config.bb.givenTimeouts[ScoreboardState.bbPeriod]
    end
    ScoreboardState.isShotClockEnabled = true 
  end
  if ScoreboardState.bbPeriod < 4 then
    ScoreboardState.bbPeriod = ScoreboardState.bbPeriod + 1
    ScoreboardState.periodTimer.min = ScoreboardState.config.bb.periodTimer.reset
    ScoreboardState.periodTimer.dSec = 0
    ScoreboardState.teamA.bbTeamFouls = 0
    ScoreboardState.teamB.bbTeamFouls = 0
  elseif ScoreboardState.bbPeriod >= 4 then
    if ScoreboardState.teamA.bbScore > ScoreboardState.teamB.bbScore or
      ScoreboardState.teamA.bbScore < ScoreboardState.teamB.bbScore then
      isMatchOver = true
    else
      ScoreboardState.bbPeriod = 5
      ScoreboardState.periodTimer.min = ScoreboardState.config.bb.overtime.reset
      ScoreboardState.periodTimer.dSec = 0
    end
  end
  ScoreboardState.shotClock.sec = ScoreboardState.config.bb.shotClock.resetFull
  ScoreboardState.shotClock.dSec = 0
end

function BasketballScoreboard:drawTeamFoulAndTimeoutMarkers()
  local maxSlots = math.max(ScoreboardState.config.bb.maxTeamFouls, ScoreboardState.config.bb.maxTimeouts)
  local tfA = ScoreboardState.teamA.bbTeamFouls
  local tfB = ScoreboardState.teamB.bbTeamFouls
  local toA = ScoreboardState.teamA.bbTimeouts
  local toB = ScoreboardState.teamB.bbTimeouts
  local x
  local slotWidth
  if maxSlots > 5 then slotWidth = 340-(10*(maxSlots-1))/maxSlots
  else slotWidth = 60 end
  local warning = math.ceil(maxSlots*0.7)
  
  local function drawMarkers(team, tf, warning, to, i, x, width)
    if tf == ScoreboardState.config.bb.maxTeamFouls then
      love.graphics.setColor(Color.editRed)
    elseif tf >= warning and i >= warning and tf >= i then
      love.graphics.setColor(Color.orange)
    elseif tf >= i then
      love.graphics.setColor(Color.yellow)
    elseif i <= ScoreboardState.config.bb.maxTeamFouls then
      love.graphics.setColor(Color.black)
    else love.graphics.setColor(0,0,0,0) end
    love.graphics.rectangle("fill", x, 420, width, 50)
    love.graphics.setColor(1,1,1,1)
    if to >= i and team == "A" then
      love.graphics.draw(teamAColors.mesh, x, 480, 0, width, 50)
    elseif to >= i and team == "B" then
      love.graphics.draw(teamBColors.mesh, x, 480, 0, width, 50)
    elseif i <= ScoreboardState.config.bb.maxTimeouts then
      love.graphics.setColor(Color.black)
      love.graphics.rectangle("fill", x, 480, width, 50)
    end
  end
  
  for i=1, maxSlots, 1 do
    --Team A
    x = 490-(slotWidth*i)-(10*(i-1))
    drawMarkers("A", tfA, warning, toA, i, x, slotWidth)
    
    x = 790+(slotWidth*(i-1))+(10*(i-1))
    drawMarkers("B", tfB, warning, toB, i, x, slotWidth)
  end
end

function BasketballScoreboard:drawScoreAnimation()
  if scoreAnim.teamA > 0 then
    teamAColors:updateBgColors(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, scoreAnim.teamA)
    if isMatchOver and ScoreboardState.teamA.bbScore > ScoreboardState.teamB.bbScore then
      teamAColors:updateBgColors(ScoreboardState.teamA.bgColor1, ScoreboardState.teamA.bgColor2, 1)
    end
    love.graphics.draw(teamAColors.mesh, 150, 200, 0, 450, 200)
    love.graphics.setColor(ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, 
      ScoreboardState.teamA.fgColor.b, scoreAnim.teamA)
    if isMatchOver and ScoreboardState.teamA.bbScore > ScoreboardState.teamB.bbScore then
      love.graphics.setColor(ScoreboardState.teamA.fgColor.r, ScoreboardState.teamA.fgColor.g, 
      ScoreboardState.teamA.fgColor.b, 1)
    end
    love.graphics.setFont(Fonts.score)
    love.graphics.printf(ScoreboardState.teamA.bbScore, 150, 210, 450, "center")
    love.graphics.setColor(1,1,1,1)
  end
  if scoreAnim.teamB > 0 then
    teamBColors:updateBgColors(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, scoreAnim.teamB)
    if isMatchOver and ScoreboardState.teamB.bbScore > ScoreboardState.teamA.bbScore then
      teamAColors:updateBgColors(ScoreboardState.teamB.bgColor1, ScoreboardState.teamB.bgColor2, 1)
    end
    love.graphics.draw(teamBColors.mesh, 680, 200, 0, 450, 200)
    love.graphics.setColor(ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, 
      ScoreboardState.teamB.fgColor.b, scoreAnim.teamB)
    if isMatchOver and ScoreboardState.teamB.bbScore > ScoreboardState.teamA.bbScore then
      love.graphics.setColor(ScoreboardState.teamB.fgColor.r, ScoreboardState.teamB.fgColor.g, 
      ScoreboardState.teamB.fgColor.b, 1)
    end
    love.graphics.setFont(Fonts.score)
    love.graphics.printf(ScoreboardState.teamB.bbScore, 680, 210, 450, "center")
    love.graphics.setColor(1,1,1,1)
  end
  if isMatchOver then
    ScoreboardState.tooltip = Lang.tooltips.matchEnd.basketball
  end
end

function BasketballScoreboard:countdownPeriodTimer()
  if ScoreboardState.isPeriodTimerRunning then
    if ScoreboardState.periodTimer.dSec > 0 then
      ScoreboardState.periodTimer.dSec = ScoreboardState.periodTimer.dSec - 1
    else
      if ScoreboardState.periodTimer.sec > 0 then
        ScoreboardState.periodTimer.sec = ScoreboardState.periodTimer.sec - 1
        ScoreboardState.periodTimer.dSec = 9
      elseif ScoreboardState.periodTimer.min > 0 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min - 1
        ScoreboardState.periodTimer.sec = 59
        ScoreboardState.periodTimer.dSec = 9
      end
    end
    
    if ScoreboardState.periodTimer.dSec == 0
      and ScoreboardState.periodTimer.sec == 0
      and ScoreboardState.periodTimer.min == 0 then
      ScoreboardState.isPeriodTimerRunning = false
      ScoreboardState.isHornSoundPlaying = true
      hornSound:setVolume(1)
    end
  end
end

function BasketballScoreboard:countdownShotClock()
  if ScoreboardState.isShotClockRunning then
    if ScoreboardState.shotClock.dSec > 0 then
        ScoreboardState.shotClock.dSec = ScoreboardState.shotClock.dSec - 1
    elseif ScoreboardState.shotClock.sec > 0 then
        ScoreboardState.shotClock.sec = ScoreboardState.shotClock.sec - 1
        ScoreboardState.shotClock.dSec = 9
    end
    
    if ScoreboardState.shotClock.dSec == 0
      and ScoreboardState.shotClock.sec == 0 then
      ScoreboardState.isShotClockRunning = false
      ScoreboardState.isHornSoundPlaying = true
      hornSound:setVolume(1)
      if ScoreboardState.isPeriodTimerRunning then
        ScoreboardState.isPeriodTimerRunning = false
      end
    end
  end
end

function BasketballScoreboard:changeCourt()
  ScoreboardState.teamA, ScoreboardState.teamB = ScoreboardState.teamB, ScoreboardState.teamA
  teamAColors.mesh, teamBColors.mesh = teamBColors.mesh, teamAColors.mesh
end

function BasketballScoreboard:attemptExitScreen()
  ScoreboardState.isPeriodTimerRunning = false
  ScoreboardState.isShotClockRunning = false
  ScoreboardState.isHornSoundPlaying = false
  hornSound:stop()
end

return BasketballScoreboard