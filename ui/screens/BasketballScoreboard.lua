local BasketballScoreboard = {}
local ScoreboardState = require("data.ScoreboardState")
local Designer = require("ui.designs.BasketballScoreboardDesigner")
local Controls = require("data.Controls")
local periodTimerRun, shotClockRun, periodDT, shotDT, lastPeriodDT, lastShotDT

function BasketballScoreboard:load()
  lastPeriodDT = 0
  lastShotDT = 0
  -- load saved configs, overriding fallback values on ScoreboardState
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
    if ScoreboardState.teamA.ballPoss == true then
      ScoreboardState.teamA.ballPoss = false
    else
      ScoreboardState.teamA.ballPoss = true
    end
    ScoreboardState.teamB.ballPoss = false
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
    if ScoreboardState.teamB.ballPoss == true then
      ScoreboardState.teamB.ballPoss = false
    else
      ScoreboardState.teamB.ballPoss = true
    end
    ScoreboardState.teamA.ballPoss = false
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
      if ScoreboardState.isPeriodTimerRunning then
        ScoreboardState.isPeriodTimerRunning = false
      end
    end
  end
end

return BasketballScoreboard