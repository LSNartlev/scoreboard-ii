local NetSportActions = {}
local ScoreboardState = require("data.ScoreboardState")

function NetSportActions:score(team, points)
  if team == "A" then
    if ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] + points >= 0
      and ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] + points <= ScoreboardState.nsTargetScore[ScoreboardState.nsSet] then
      ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] = ScoreboardState.teamA.nsScore[ScoreboardState.nsSet] + points
      if ScoreboardState.config.ns.serveTimer.enabled then
        ScoreboardState.teamB.nsService = false
        ScoreboardState.teamA.nsService = true
        ScoreboardState.serveTimer.sec = ScoreboardState.config.ns.serveTimer.reset
        ScoreboardState.serveTimer.dSec = 0
        ScoreboardState.serveTimerState = 1
      end
    end
  elseif team == "B" then
    if ScoreboardState.teamB.nsScore[ScoreboardState.nsSet] + points >= 0
      and ScoreboardState.teamB.nsScore[ScoreboardState.nsSet] + points <= ScoreboardState.nsTargetScore[ScoreboardState.nsSet] then
      ScoreboardState.teamB.nsScore[ScoreboardState.nsSet] = ScoreboardState.teamB.nsScore[ScoreboardState.nsSet] + points
      if ScoreboardState.config.ns.serveTimer.enabled then
        ScoreboardState.teamA.nsService = false
        ScoreboardState.teamB.nsService = true
        ScoreboardState.serveTimer.sec = ScoreboardState.config.ns.serveTimer.reset
        ScoreboardState.serveTimer.dSec = 0
        ScoreboardState.serveTimerState = 1
      end
    end
  end
  self:updateTargetScore(ScoreboardState.nsSet)
  self:updateSetWins()
end

function NetSportActions:timeout(team, points)
  if team == "A" then
    if ScoreboardState.teamA.nsTimeouts[ScoreboardState.nsSet] + points >= 0
      and ScoreboardState.teamA.nsTimeouts[ScoreboardState.nsSet] + points <= ScoreboardState.config.ns.maxTimeouts then
      ScoreboardState.teamA.nsTimeouts[ScoreboardState.nsSet] = ScoreboardState.teamA.nsTimeouts[ScoreboardState.nsSet] + points
    end
  elseif team == "B" then
    if ScoreboardState.teamB.nsTimeouts[ScoreboardState.nsSet] + points >= 0
      and ScoreboardState.teamB.nsTimeouts[ScoreboardState.nsSet] + points <= ScoreboardState.config.ns.maxTimeouts then
      ScoreboardState.teamB.nsTimeouts[ScoreboardState.nsSet] = ScoreboardState.teamB.nsTimeouts[ScoreboardState.nsSet] + points
    end
  end
end

function NetSportActions:toggleService(team)
  if team == "A" then
    if ScoreboardState.teamA.nsService == true then
      ScoreboardState.teamA.nsService = false
    else
      ScoreboardState.teamA.nsService = true
    end
    ScoreboardState.teamB.nsService = false
  elseif team == "B" then
    if ScoreboardState.teamB.nsService == true then
      ScoreboardState.teamB.nsService = false
    else
      ScoreboardState.teamB.nsService = true
    end
    ScoreboardState.teamA.nsService = false
  end
end

function NetSportActions:toggleServeTimer()
  if ScoreboardState.serveTimerState == 0 then
    ScoreboardState.serveTimerState = 1
  elseif ScoreboardState.serveTimerState == 1 and ScoreboardState.serveTimer.sec == 0
    and ScoreboardState.serveTimer.dSec == 0 then
    ScoreboardState.serveTimerState = 0
    ScoreboardState.serveTimer.sec = ScoreboardState.config.ns.serveTimer.reset
    ScoreboardState.serveTimer.dSec = 0
  elseif ScoreboardState.serveTimerState == 1 then
    ScoreboardState.serveTimerState = 2
  elseif ScoreboardState.serveTimerState == 2 then
    ScoreboardState.serveTimerState = 0
    ScoreboardState.serveTimer.sec = ScoreboardState.config.ns.serveTimer.reset
    ScoreboardState.serveTimer.dSec = 0
  end
end

function NetSportActions:updateTargetScore(set)
  local isDraw = ScoreboardState.teamA.nsScore[set] == ScoreboardState.teamB.nsScore[set]
  local drawScore = ScoreboardState.teamA.nsScore[set]
  if set < ScoreboardState.config.ns.maxSets then
    if ScoreboardState.teamA.nsScore[set] + ScoreboardState.config.ns.advantage < ScoreboardState.nsTargetScore[set]
      and ScoreboardState.teamB.nsScore[set] + ScoreboardState.config.ns.advantage < ScoreboardState.nsTargetScore[set]
      and ScoreboardState.nsTargetScore[set] > ScoreboardState.config.ns.targetScore then
      ScoreboardState.nsTargetScore[set] = ScoreboardState.config.ns.targetScore
    end
    if isDraw and ScoreboardState.nsTargetScore[set] - drawScore < ScoreboardState.config.ns.advantage then
      if ScoreboardState.config.ns.goldenPoint.enabled == false or
        (ScoreboardState.config.ns.goldenPoint.enabled == true and
        drawScore + ScoreboardState.config.ns.advantage <= ScoreboardState.config.ns.goldenPoint.value) then
        ScoreboardState.nsTargetScore[set] = drawScore + ScoreboardState.config.ns.advantage
      end
    end
  elseif set >= ScoreboardState.config.ns.maxSets then
    if ScoreboardState.teamA.nsScore[set] + ScoreboardState.config.ns.advantageLast < ScoreboardState.nsTargetScore[set]
      and ScoreboardState.teamB.nsScore[set] + ScoreboardState.config.ns.advantageLast < ScoreboardState.nsTargetScore[set]
      and ScoreboardState.nsTargetScore[set] > ScoreboardState.config.ns.targetScoreLast then
      ScoreboardState.nsTargetScore[set] = ScoreboardState.config.ns.targetScoreLast
    end
    if isDraw and ScoreboardState.nsTargetScore[set] - drawScore < ScoreboardState.config.ns.advantageLast then
      if ScoreboardState.config.ns.goldenPointLast.enabled == false or
        (ScoreboardState.config.ns.goldenPointLast.enabled == true and
        drawScore + ScoreboardState.config.ns.advantageLast <= ScoreboardState.config.ns.goldenPointLast.value) then
        ScoreboardState.nsTargetScore[set] = drawScore + ScoreboardState.config.ns.advantageLast
      end
    end
  end
end

function NetSportActions:updateSetWins()
  local aWins, bWins = 0, 0
  for i = 1, ScoreboardState.config.ns.maxSets, 1 do
    if ScoreboardState.teamA.nsScore[i] >= ScoreboardState.nsTargetScore[i] then
      aWins = aWins + 1 end
    if ScoreboardState.teamB.nsScore[i] >= ScoreboardState.nsTargetScore[i] then
      bWins = bWins + 1 end
  end
  ScoreboardState.teamA.nsSetWins = aWins
  ScoreboardState.teamB.nsSetWins = bWins
end

function NetSportActions:updateSetScoresView()
  if ScoreboardState.config.ns.maxSets == 1 then 
    ScoreboardState.nsSummary.teamA[1] = 0
    ScoreboardState.nsSummary.teamA[2] = 0
    ScoreboardState.nsSummary.teamA[3] = 0
    ScoreboardState.nsSummary.teamA[4] = 0
    ScoreboardState.nsSummary.teamA[5] = 0
    ScoreboardState.nsSummary.teamB[1] = 0
    ScoreboardState.nsSummary.teamB[2] = 0
    ScoreboardState.nsSummary.teamB[3] = 0
    ScoreboardState.nsSummary.teamB[4] = 0
    ScoreboardState.nsSummary.teamB[5] = 0
  elseif ScoreboardState.config.ns.maxSets == 3 then
    ScoreboardState.nsSummary.teamA[1] = 0
    ScoreboardState.nsSummary.teamA[2] = 0
    ScoreboardState.nsSummary.teamA[3] = 1
    ScoreboardState.nsSummary.teamA[4] = 2
    ScoreboardState.nsSummary.teamA[5] = 3
    ScoreboardState.nsSummary.teamB[1] = 1
    ScoreboardState.nsSummary.teamB[2] = 2
    ScoreboardState.nsSummary.teamB[3] = 3
    ScoreboardState.nsSummary.teamB[4] = 0
    ScoreboardState.nsSummary.teamB[5] = 0
  elseif ScoreboardState.config.ns.maxSets > 5 and ScoreboardState.nsSet >=5 then 
    local set = ScoreboardState.nsSet
    ScoreboardState.nsSummary.teamA[1] = set-4
    ScoreboardState.nsSummary.teamA[2] = set-3
    ScoreboardState.nsSummary.teamA[3] = set-2
    ScoreboardState.nsSummary.teamA[4] = set-1
    ScoreboardState.nsSummary.teamA[5] = set
    ScoreboardState.nsSummary.teamB[1] = set-4
    ScoreboardState.nsSummary.teamB[2] = set-3
    ScoreboardState.nsSummary.teamB[3] = set-2
    ScoreboardState.nsSummary.teamB[4] = set-1
    ScoreboardState.nsSummary.teamB[5] = set
  elseif ScoreboardState.config.ns.maxSets >= 5 then 
    ScoreboardState.nsSummary.teamA[1] = 1
    ScoreboardState.nsSummary.teamA[2] = 2
    ScoreboardState.nsSummary.teamA[3] = 3
    ScoreboardState.nsSummary.teamA[4] = 4
    ScoreboardState.nsSummary.teamA[5] = 5
    ScoreboardState.nsSummary.teamB[1] = 1
    ScoreboardState.nsSummary.teamB[2] = 2
    ScoreboardState.nsSummary.teamB[3] = 3
    ScoreboardState.nsSummary.teamB[4] = 4
    ScoreboardState.nsSummary.teamB[5] = 5
  end
end

function NetSportActions:getMatchDuration(currentTime)
  local rawSeconds = 0
  if ScoreboardState.timeDisplay.start then 
    rawSeconds = math.floor(currentTime - ScoreboardState.timeDisplay.start)
  end
  local toDisplay = ""
  if math.floor(rawSeconds / (60*60)) > 0 then
    toDisplay = toDisplay .. math.floor(rawSeconds / (60*60)) .. ":" 
    .. string.format("%02d", math.floor(rawSeconds/60) % 60) .. ":"
  else
    toDisplay = toDisplay .. math.floor(rawSeconds/60) % 60 .. ":"
  end
  toDisplay = toDisplay .. string.format("%02d", rawSeconds % 60)
  return toDisplay
end

function NetSportActions:startNewMatch()
  for i=1, 9, 1 do
    ScoreboardState.teamA.nsScore[i] = 0
    ScoreboardState.teamB.nsScore[i] = 0
    if i < ScoreboardState.config.ns.maxSets then
      ScoreboardState.nsTargetScore[i] = ScoreboardState.config.ns.targetScore
      ScoreboardState.teamA.nsTimeouts[i] = ScoreboardState.config.ns.maxTimeouts
      ScoreboardState.teamB.nsTimeouts[i] = ScoreboardState.config.ns.maxTimeouts
    elseif i == ScoreboardState.config.ns.maxSets then
      ScoreboardState.nsTargetScore[i] = ScoreboardState.config.ns.targetScoreLast
      ScoreboardState.teamA.nsTimeouts[i] = ScoreboardState.config.ns.maxTimeoutsLast
      ScoreboardState.teamB.nsTimeouts[i] = ScoreboardState.config.ns.maxTimeoutsLast
    else
      ScoreboardState.nsTargetScore[i] = 999
      ScoreboardState.teamA.nsTimeouts[i] = 0
      ScoreboardState.teamB.nsTimeouts[i] = 0
    end
  end
  ScoreboardState.nsSet = 1
  ScoreboardState.teamA.nsSetWins = 0
  ScoreboardState.teamB.nsSetWins = 0
  ScoreboardState.teamA.nsService = false
  ScoreboardState.teamB.nsService = false
  ScoreboardState.serveTimer.sec = ScoreboardState.config.ns.serveTimer.reset
  ScoreboardState.serveTimer.dSec = 0
  if ScoreboardState.config.ns.serveTimer.enabled == true then
    ScoreboardState.serveTimerState = 1
  else
    ScoreboardState.serveTimerState = 0
  end
  ScoreboardState.timeStart = nil
end

return NetSportActions