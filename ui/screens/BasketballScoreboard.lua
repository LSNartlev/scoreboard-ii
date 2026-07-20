local BasketballScoreboard = {}
local ScoreboardState = require("data.ScoreboardState")
local Designer = require("ui.designs.BasketballScoreboardDesigner")
local Controls = require("data.Controls")
local gradRect = require("ui.designs.GradientRectangle")
local periodTimerRun, shotClockRun, periodDT, shotDT, lastPeriodDT, lastShotDT
local bgTeamA, bgTeamAName, bgTeamB, bgTeamBName

function BasketballScoreboard:load()
  lastPeriodDT = 0
  lastShotDT = 0
  bgTeamA = love.graphics.newMesh(gradRect:newGradRect(0, 0, 640, 720,
    { ScoreboardState.teamA.bgColor1.r,ScoreboardState.teamA.bgColor1.g,ScoreboardState.teamA.bgColor1.b },
    { ScoreboardState.teamA.bgColor2.r,ScoreboardState.teamA.bgColor2.g,ScoreboardState.teamA.bgColor2.b },
    0.8, true
  ))
  bgTeamAName = love.graphics.newMesh(gradRect:newGradRect(40, 120, 560, 60,
    { ScoreboardState.teamA.bgColor1.r,ScoreboardState.teamA.bgColor1.g,ScoreboardState.teamA.bgColor1.b },
    { ScoreboardState.teamA.bgColor2.r,ScoreboardState.teamA.bgColor2.g,ScoreboardState.teamA.bgColor2.b },
    1, true
  ))
  bgTeamB = love.graphics.newMesh(gradRect:newGradRect(640, 0, 640, 720,
    { ScoreboardState.teamB.bgColor1.r,ScoreboardState.teamB.bgColor1.g,ScoreboardState.teamB.bgColor1.b },
    { ScoreboardState.teamB.bgColor2.r,ScoreboardState.teamB.bgColor2.g,ScoreboardState.teamB.bgColor2.b },
    0.8, true
  ))
  bgTeamBName = love.graphics.newMesh(gradRect:newGradRect(680, 120, 560, 60,
    { ScoreboardState.teamB.bgColor1.r,ScoreboardState.teamB.bgColor1.g,ScoreboardState.teamB.bgColor1.b },
    { ScoreboardState.teamB.bgColor2.r,ScoreboardState.teamB.bgColor2.g,ScoreboardState.teamB.bgColor2.b },
    1, true
  ))
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
  
  if ScoreboardState.periodTimer.min >= 1 then
    ScoreboardState.periodTimer.displayText = ScoreboardState.periodTimer.min
      .. ":" .. string.format("%02d", ScoreboardState.periodTimer.sec)
  else
    ScoreboardState.periodTimer.displayText = ScoreboardState.periodTimer.sec
      .. "." .. ScoreboardState.periodTimer.dSec
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
  
  if ScoreboardState.shotClock.sec >= 5 then
    ScoreboardState.shotClock.displayText = ScoreboardState.shotClock.sec
  else
    ScoreboardState.shotClock.displayText = ScoreboardState.shotClock.sec
      .. "." .. ScoreboardState.shotClock.dSec
  end
end

function BasketballScoreboard:draw()
  love.graphics.draw(bgTeamA)
  love.graphics.draw(bgTeamAName)
  love.graphics.draw(bgTeamB)
  love.graphics.draw(bgTeamBName)
  
  for _, v in ipairs(Designer.rectangles) do
    love.graphics.setColor(v.color())
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    love.graphics.setColor(0,0,0,0)
  end
  
  for _, v in ipairs(Designer.triangles) do
    love.graphics.setColor(v.color())
    love.graphics.polygon("fill", v.x1, v.y1, v.x2, v.y2, v.x3, v.y3)
    love.graphics.setColor(0,0,0,0)
  end
  
  for _, v in ipairs(Designer.texts) do
    love.graphics.setFont(v.font())
    love.graphics.setColor(v.color())
    love.graphics.printf(v.text(), v.x, v.y, v.width, v.align)
    love.graphics.setColor(0,0,0,0)
  end
  
  
  
  
end

function BasketballScoreboard:keypressed(key, scancode, isrepeat)
  if key == Controls.bb.togglePeriodTimer then
    if ScoreboardState.isPeriodTimerRunning then 
      ScoreboardState.isPeriodTimerRunning = false
    else ScoreboardState.isPeriodTimerRunning = true
    end
  elseif key == Controls.bb.toggleShotClock then
    if ScoreboardState.isShotClockRunning then 
      ScoreboardState.isShotClockRunning = false
    else ScoreboardState.isShotClockRunning = true
    end
  elseif key == Controls.bb.resetShotClockShort then
    ScoreboardState.shotClock.sec = ScoreboardState.config.bb.shotClock.resetShort
    ScoreboardState.shotClock.dSec = 0
    ScoreboardState.isShotClockRunning = false
  elseif key == Controls.bb.resetShotClockFull then
    ScoreboardState.shotClock.sec = ScoreboardState.config.bb.shotClock.resetFull
    ScoreboardState.shotClock.dSec = 0
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
  end
  
  if key == Controls.bb.scoreTeamB then
    if love.keyboard.isDown("lshift","rshift") then
      if ScoreboardState.teamB.bbScore > 0 then
        ScoreboardState.teamB.bbScore = ScoreboardState.teamB.bbScore - 1
      end
    else
      if ScoreboardState.teamB.bbScore < 999 then
        ScoreboardState.teamB.bbScore = ScoreboardState.teamB.bbScore + 1
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
  end
  
end

function BasketballScoreboard:keyreleased(key, scancode)
  if key == Controls.bb.hornSound then
    ScoreboardState.isHornSoundPlaying = false
    -- and if the horn is playing while period timer is 0, proceed to next period
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
      if ScoreboardState.isPeriodTimerRunning then
        ScoreboardState.isPeriodTimerRunning = false
      end
    end
  end
end

return BasketballScoreboard