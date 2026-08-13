local ScoreboardState = {
  matchTitle = ".: Scoreboard II :.",
  matchStatus = 0, -- cycle between {0, 1, 2}: 0 = new match, 1 = Basketball match in progess, 2 = Net Sport match in progress
  tooltip = "",
  onDisplay = "BasketballScoreboard",
  onEdit = { id = "", value = "" },
  onMouseFocus = "",
  isHornSoundPlaying = false,
  bbPeriod = 0,
  periodTimer = { min = 0, sec = 0, dSec = 1, displayText = "" },
  isPeriodTimerEnabled = true,
  isPeriodTimerRunning = false,
  shotClock = { sec = 0, dSec = 1, displayText = "" },
  isShotClockEnabled = true,
  isShotClockRunning = false,
  isTimerAdjustmentEnabled = false,
  nsSet = 1,
  timeDisplay = { start = nil, mode = "time", displayText = "" },
  serveTimer = { sec = 8, dSec = 0, displayText = "" },
  serveTimerState = 1, -- cycle between {0, 1, 2}: 0 = hidden & stopped, 1 = visible & stopped, 2 = visible & running
  nsTargetScore = { 25, 25, 15, 999, 999, 999, 999, 999, 999 },
  nsSummary = { teamA = { 0, 0, 1, 2, 3 }, teamB = { 1, 2, 3, 0, 0 } },
  config = {
    matchSetup = {
      matchTitle = ".: Scoreboard II :.",
      teamA = {
        name = "TEAM RED",
        bgColor1 = { r = 0.6392, g = 0.0706, b = 0.0431 },
        bgColor2 = { r = 0.9608, g = 0.4275, b = 0.4000 },
        fgColor = { r = 1.0000, g = 1.0000, b = 1.0000 },
        hsl = {
          bg1 = { 3, 315, 123 },
          bg2 = { 3, 316, 246 },
          fg = { 0, 0, 360 }
        }
      },
      teamB = {
        name = "TEAM BLUE",
        bgColor1 = { r = 0.0431, g = 0.0745, b = 0.6471 },
        bgColor2 = { r = 0.4275, g = 0.7373, b = 0.9608 },
        fgColor = { r = 1.0000, g = 1.0000, b = 1.0000 },
        hsl = {
          bg1 = { 237, 315, 124 },
          bg2 = { 206, 313, 250 },
          fg = { 0, 0, 360 }
        }
      }
    },
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
      sportToPlay = "volleyball",
      maxSets = 3,
      maxTimeouts = 2,
      maxTimeoutsLast = 2,
      targetScore = 25,
      targetScoreLast = 15,
      advantage = 2,
      advantageLast = 2,
      goldenPoint = { enabled = false, value = 30 },
      goldenPointLast = { enabled = false, value = 30 },
      serveTimer = { enabled = true, reset = 8, hornSoundOnZero = false }
    },
    tabs = {
      activeTab = "matchSetup",
      isSelectable = true
    }
  },
  teamSetup = {
    side = "",
    name = "(no team selected)",
    activeColorTab = "bg1",
    bgColor1 = { r = 0.3333, g = 0.3333, b = 0.3333 },
    bgColor2 = { r = 0.5000, g = 0.5000, b = 0.5000 },
    fgColor = { r = 0.4167, g = 0.4167, b = 0.4167 },
    hsl = {
      bg1 = { 0, 0, 120 },
      bg2 = { 0, 0, 120 },
      fg = { 0, 0, 150 }
    },
    listPage = 1
  },
  teamA = {
    name = "TEAM RED",
    bgColor1 = { r = 0.6392, g = 0.0706, b = 0.0431 },
    bgColor2 = { r = 0.9608, g = 0.4275, b = 0.4000 },
    fgColor = { r = 1.0000, g = 1.0000, b = 1.0000 },
    hsl = {
      bg1 = { 3, 315, 123 },
      bg2 = { 3, 316, 246 },
      fg = { 0, 0, 360 }
    },
    bbScore = 0,
    bbTeamFouls = 0,
    bbTimeouts = 0,
    bbBallPoss = false,
    nsScore = { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    nsSetWins = 0,
    nsTimeouts = { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    nsService = false
  },
  teamB = {
    name = "TEAM BLUE",
    bgColor1 = { r = 0.0431, g = 0.0745, b = 0.6471 },
    bgColor2 = { r = 0.4275, g = 0.7373, b = 0.9608 },
    fgColor = { r = 1.0000, g = 1.0000, b = 1.0000 },
    hsl = {
      bg1 = { 237, 315, 124 },
      bg2 = { 206, 313, 250 },
      fg = { 0, 0, 360 }
    },
    bbScore = 0,
    bbTeamFouls = 0,
    bbTimeouts = 0,
    bbBallPoss = false,
    nsScore = { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    nsSetWins = 0,
    nsTimeouts = { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    nsService = false
  }
}

return ScoreboardState