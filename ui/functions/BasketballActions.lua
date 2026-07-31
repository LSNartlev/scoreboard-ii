local BasketballActions = {}
local ScoreboardState = require("data.ScoreboardState")

function BasketballActions:togglePeriodTimerEnabled()
  if ScoreboardState.isPeriodTimerEnabled then
    ScoreboardState.isPeriodTimerEnabled = false
  else
    ScoreboardState.isPeriodTimerEnabled = true
  end
end

function BasketballActions:togglePeriodTimer()
  if ScoreboardState.isPeriodTimerRunning then 
    ScoreboardState.isPeriodTimerRunning = false
    if ScoreboardState.isShotClockRunning then
      ScoreboardState.isShotClockRunning = false
    end
  elseif ScoreboardState.isPeriodTimerEnabled then
    ScoreboardState.isPeriodTimerRunning = true
    if ScoreboardState.isShotClockEnabled then
      ScoreboardState.isShotClockRunning = true
    end
  end
end

function BasketballActions:toggleShotClockEnabled()
  if ScoreboardState.isShotClockEnabled then
    ScoreboardState.isShotClockEnabled = false
  else
    ScoreboardState.isShotClockEnabled = true
  end
end

function BasketballActions:toggleShotClock()
  if ScoreboardState.isShotClockRunning then 
    ScoreboardState.isShotClockRunning = false
  elseif ScoreboardState.isShotClockEnabled and ScoreboardState.isPeriodTimerRunning then
    ScoreboardState.isShotClockRunning = true
  end
end

function BasketballActions:resetShotClock(shotSec)
  local timerSec = (ScoreboardState.periodTimer.min*60) + ScoreboardState.periodTimer.sec + (ScoreboardState.periodTimer.dSec/10)
  if timerSec >= shotSec then 
    ScoreboardState.isShotClockEnabled = true
    ScoreboardState.shotClock.sec = shotSec
    ScoreboardState.shotClock.dSec = 0
  else
    ScoreboardState.isShotClockEnabled = false
  end
  ScoreboardState.isShotClockRunning = false
end

function BasketballActions:score(team, points)
  if team == "A" then
    if ScoreboardState.teamA.bbScore + points >= 0
      and ScoreboardState.teamA.bbScore + points <= 999 then
      ScoreboardState.teamA.bbScore = ScoreboardState.teamA.bbScore + points
    end
  elseif team == "B" then
    if ScoreboardState.teamB.bbScore + points >= 0
      and ScoreboardState.teamB.bbScore + points <= 999 then
      ScoreboardState.teamB.bbScore = ScoreboardState.teamB.bbScore + points
    end
  end
end

function BasketballActions:foul(team, points)
  if team == "A" then
    if ScoreboardState.teamA.bbTeamFouls + points >= 0
      and ScoreboardState.teamA.bbTeamFouls + points <= ScoreboardState.config.bb.maxTeamFouls then
      ScoreboardState.teamA.bbTeamFouls = ScoreboardState.teamA.bbTeamFouls + points
    end
  elseif team == "B" then
    if ScoreboardState.teamB.bbTeamFouls + points >= 0
      and ScoreboardState.teamB.bbTeamFouls + points <= ScoreboardState.config.bb.maxTeamFouls then
      ScoreboardState.teamB.bbTeamFouls = ScoreboardState.teamB.bbTeamFouls + points
    end
  end
end

function BasketballActions:timeout(team, points)
  if team == "A" then
    if ScoreboardState.teamA.bbTimeouts + points >= 0
      and ScoreboardState.teamA.bbTimeouts + points <= ScoreboardState.config.bb.maxTimeouts then
      ScoreboardState.teamA.bbTimeouts = ScoreboardState.teamA.bbTimeouts + points
    end
  elseif team == "B" then
    if ScoreboardState.teamB.bbTimeouts + points >= 0
      and ScoreboardState.teamB.bbTimeouts + points <= ScoreboardState.config.bb.maxTimeouts then
      ScoreboardState.teamB.bbTimeouts = ScoreboardState.teamB.bbTimeouts + points
    end
  end
end

function BasketballActions:toggleBallPossession(team)
  if team == "A" then
    if ScoreboardState.teamA.bbBallPoss == true then
      ScoreboardState.teamA.bbBallPoss = false
    else
      ScoreboardState.teamA.bbBallPoss = true
    end
    ScoreboardState.teamB.bbBallPoss = false
  elseif team == "B" then
    if ScoreboardState.teamB.bbBallPoss == true then
      ScoreboardState.teamB.bbBallPoss = false
    else
      ScoreboardState.teamB.bbBallPoss = true
    end
    ScoreboardState.teamA.bbBallPoss = false
  end
end

function BasketballActions:adjustPeriodTimer(unit, value)
  if unit == "min" then
    if value == -1 then
      if ScoreboardState.periodTimer.min > 0 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min - 1
        if ScoreboardState.periodTimer.min == 0 and ScoreboardState.periodTimer.sec == 0
          and ScoreboardState.periodTimer.dSec == 0 then
          ScoreboardState.periodTimer.dSec = 1
        end
      end
    elseif value == 1 then
      if ScoreboardState.periodTimer.min < 99 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min + 1
      end
    end
  elseif unit == "sec" then
    if value == -1 then
      if ScoreboardState.periodTimer.sec > 0 then
        ScoreboardState.periodTimer.sec = ScoreboardState.periodTimer.sec - 1
        if ScoreboardState.periodTimer.min == 0 and ScoreboardState.periodTimer.sec == 0
          and ScoreboardState.periodTimer.dSec == 0 then
          ScoreboardState.periodTimer.dSec = 1
        end
      elseif ScoreboardState.periodTimer.min > 0 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min - 1
        ScoreboardState.periodTimer.sec = 59
      end
    elseif value == 1 then
      if ScoreboardState.periodTimer.sec < 59 then
        ScoreboardState.periodTimer.sec = ScoreboardState.periodTimer.sec + 1
      elseif ScoreboardState.periodTimer.min < 99 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min + 1
        ScoreboardState.periodTimer.sec = 0
      end
    end
  elseif unit == "dSec" then
    if value == -1 then
      if ScoreboardState.periodTimer.dSec > 0 then
        ScoreboardState.periodTimer.dSec = ScoreboardState.periodTimer.dSec - 1
        if ScoreboardState.periodTimer.min == 0 and ScoreboardState.periodTimer.sec == 0
          and ScoreboardState.periodTimer.dSec == 0 then
          ScoreboardState.periodTimer.dSec = 1
        end
      elseif ScoreboardState.periodTimer.sec > 0 then
        ScoreboardState.periodTimer.sec = ScoreboardState.periodTimer.sec - 1
        ScoreboardState.periodTimer.dSec = 9
      elseif ScoreboardState.periodTimer.min > 0 then
        ScoreboardState.periodTimer.min = ScoreboardState.periodTimer.min - 1
        ScoreboardState.periodTimer.sec = 59
        ScoreboardState.periodTimer.dSec = 9
      end
    elseif value == 1 then
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
end

function BasketballActions:adjustShotClock(unit, value)
  if unit == "sec" then
    if value == -1 then
      if ScoreboardState.shotClock.sec > 0 then
        ScoreboardState.shotClock.sec = ScoreboardState.shotClock.sec - 1
        if ScoreboardState.shotClock.sec == 0 and ScoreboardState.shotClock.dSec == 0 then
          ScoreboardState.shotClock.dSec = 1
        end
      end
    elseif value == 1 then
      if ScoreboardState.shotClock.sec < 99 then
        ScoreboardState.shotClock.sec = ScoreboardState.shotClock.sec + 1
      end
    end
  elseif unit == "dSec" then
    if value == -1 then
      if ScoreboardState.shotClock.dSec > 0 then
        ScoreboardState.shotClock.dSec = ScoreboardState.shotClock.dSec - 1
        if ScoreboardState.shotClock.sec == 0 and ScoreboardState.shotClock.dSec == 0 then
          ScoreboardState.shotClock.dSec = 1
        end
      elseif ScoreboardState.shotClock.sec > 0 then
        ScoreboardState.shotClock.sec = ScoreboardState.shotClock.sec - 1
        ScoreboardState.shotClock.dSec = 9
      end
    elseif value == 1 then
      if ScoreboardState.shotClock.dSec < 9 then
        ScoreboardState.shotClock.dSec = ScoreboardState.shotClock.dSec + 1
      elseif ScoreboardState.shotClock.sec < 99 then
        ScoreboardState.shotClock.sec = ScoreboardState.shotClock.sec + 1
        ScoreboardState.shotClock.dSec = 0
      end
    end
  end
end


function BasketballActions:startNewMatch()
  ScoreboardState.teamA.bbScore = 0
  ScoreboardState.teamB.bbScore = 0
  ScoreboardState.teamA.bbTeamFouls = 0
  ScoreboardState.teamB.bbTeamFouls = 0
  ScoreboardState.teamA.bbTimeouts = ScoreboardState.config.bb.givenTimeouts[1]
  ScoreboardState.teamB.bbTimeouts = ScoreboardState.config.bb.givenTimeouts[1]
  ScoreboardState.teamA.bbBallPoss = false
  ScoreboardState.teamB.bbBallPoss = false
  ScoreboardState.bbPeriod = 1
  ScoreboardState.isPeriodTimerEnabled = true
  ScoreboardState.periodTimer.min = ScoreboardState.config.bb.periodTimer.reset
  ScoreboardState.periodTimer.sec = 0
  ScoreboardState.periodTimer.dSec = 0
  ScoreboardState.isShotClockEnabled = true
  ScoreboardState.shotClock.sec = ScoreboardState.config.bb.shotClock.resetFull
  ScoreboardState.shotClock.dSec = 0
end

return BasketballActions