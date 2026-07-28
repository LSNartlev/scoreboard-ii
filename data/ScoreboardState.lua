local ScoreboardState = {
  matchTitle = "Scoreboard II",
  tooltip = "",
  onDisplay = "BasketballScoreboard",
  onEdit = { id = "", value = nil },
  isHornSoundPlaying = false,
  bbPeriod = 1,
  periodTimer = { min = 10, sec = 0, dSec = 0, displayText = "10:00" },
  isPeriodTimerEnabled = true,
  isPeriodTimerRunning = false,
  shotClock = { sec = 24, dSec = 0, displayText = "24" },
  isShotClockEnabled = true,
  isShotClockRunning = false,
  isTimerAdjustmentEnabled = false,
  nsSet = 1,
  serveTimer = { sec = 8, dSec = 0 },
  serveTimerState = 1, -- cycle between {0, 1, 2}: 0 = hidden & stopped, 1 = visible & stopped, 2 = visible & running
  vbTargetScores = { 25, 25, 25, 25, 15, 11, 11 },
  config = {
    bb = {
      maxPeriods = 4,
      periodTimer = { enabled = true, reset = 10 },
      overtime = { reset = 5 },
      shotClock = { enabled = true, resetFull = 24, resetShort = 14 },
      maxTeamFouls = 5,
      maxTimeouts = 3,
      givenTimeouts = { 1, 1, 1, 2, 1 },
      isTimeoutCarryover = { true, false, true, false, false }
    },
    ns = {
      maxSets = 5,
      maxTimeouts = 2,
      targetScore = 25,
      targetScoreLast = 15,
      goldenPoint = { enabled = false, targetScore = 30, targetScoreLast = 30 },
      advantage = 2,
      advantageLast = 2,
      serveTimer = { enabled = true, reset = 8 }
    },
    tabs = {
      activeTab = "matchSetup",
      isSelectable = true
    }
  },
  teamA = {
    name = "TEAM RED",
    bgColor1 = { r = 163/255, g = 18/255, b = 11/255 },
    bgColor2 = { r = 245/255, g = 109/255, b = 102/255 },
    fgColor = { r = 255/255, g = 255/255, b = 255/255 },
    bbScore = 0,
    bbTeamFouls = 0,
    bbTimeouts = 1,
    bbBallPoss = false,
    nsScores = { 0, 0, 0, 0, 0, 0, 0 },
    nsSetWins = 0,
    nsTimeouts = 2,
    nsBallServe = false
  },
  teamB = {
    name = "TEAM BLUE",
    bgColor1 = { r = 11/255, g = 99/255, b = 165/255 },
    bgColor2 = { r = 109/255, g = 188/255, b = 245/255 },
    fgColor = { r = 255/255, g = 255/255, b = 255/255 },
    bbScore = 0,
    bbTeamFouls = 0,
    bbTimeouts = 1,
    bbBallPoss = false,
    nsScores = { 0, 0, 0, 0, 0, 0, 0 },
    nsSetWins = 0,
    nsTimeouts = 2,
    nsBallServe = false
  }
}

return ScoreboardState