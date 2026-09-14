local Rulesets = {
  bb = {
    fiba = {
      maxPeriods = 4,
      periodTimer = { enabled = true, reset = 10 },
      overtime = { reset = 5 },
      shotClock = { enabled = true, resetFull = 24, resetShort = 14 },
      maxTeamFouls = 5,
      maxTimeouts = 3,
      givenTimeouts = { 1, 1, 1, 2, 1 },
      isTimeoutCarryover = { true, false, true, false, false }
    },
    fiba3x3 = {
      maxPeriods = 1,
      periodTimer = { enabled = true, reset = 10 },
      overtime = { reset = 999999999 }, -- no time limit on overtime
      shotClock = { enabled = true, resetFull = 12, resetShort = 12 },
      maxTeamFouls = 7,
      maxTimeouts = 1,
      givenTimeouts = { 1, 0, 0, 0, 0 },
      isTimeoutCarryover = { true, true, true, true, true }
    },
    nba = {
      maxPeriods = 4,
      periodTimer = { enabled = true, reset = 12 },
      overtime = { reset = 5 },
      shotClock = { enabled = true, resetFull = 24, resetShort = 14 },
      maxTeamFouls = 5,
      maxTimeouts = 7,
      givenTimeouts = { 7, 0, 0, 0, 2 },
      isTimeoutCarryover = { true, true, true, false, false }
    }
  },
  ns = {
    volleyball = {
      sportToPlay = "Volleyball",
      maxSets = 5,
      maxTimeouts = 2,
      maxTimeoutsLast = 2,
      targetScore = 25,
      targetScoreLast = 15,
      advantage = 2,
      advantageLast = 2,
      goldenPoint = { enabled = false, value = 999 },
      goldenPointLast = { enabled = false, value = 999 },
      serveTimer = { enabled = true, reset = 8, hornSoundOnZero = false }
    },
    beach = {
      sportToPlay = "Volleyball",
      maxSets = 3,
      maxTimeouts = 2,
      maxTimeoutsLast = 2,
      targetScore = 21,
      targetScoreLast = 15,
      advantage = 2,
      advantageLast = 2,
      goldenPoint = { enabled = false, value = 999 },
      goldenPointLast = { enabled = false, value = 999 },
      serveTimer = { enabled = true, reset = 5, hornSoundOnZero = false }
    },
    badminton = {
      sportToPlay = "Badminton",
      maxSets = 3,
      maxTimeouts = 1,
      maxTimeoutsLast = 1,
      targetScore = 21,
      targetScoreLast = 21,
      advantage = 2,
      advantageLast = 2,
      goldenPoint = { enabled = true, value = 30 },
      goldenPointLast = { enabled = true, value = 30 },
      serveTimer = { enabled = true, reset = 25, hornSoundOnZero = true }
    },
    tabletennis = {
      sportToPlay = "Table Tennis",
      maxSets = 3,
      maxTimeouts = 1,
      maxTimeoutsLast = 1,
      targetScore = 11,
      targetScoreLast = 11,
      advantage = 2,
      advantageLast = 2,
      goldenPoint = { enabled = false, value = 999 },
      goldenPointLast = { enabled = false, value = 999 },
      serveTimer = { enabled = false, reset = 99, hornSoundOnZero = false }
    },
    pickleball = {
      sportToPlay = "Pickleball",
      maxSets = 1,
      maxTimeouts = 3,
      maxTimeoutsLast = 3,
      targetScore = 21,
      targetScoreLast = 21,
      advantage = 2,
      advantageLast = 2,
      goldenPoint = { enabled = false, value = 999 },
      goldenPointLast = { enabled = false, value = 999 },
      serveTimer = { enabled = true, reset = 10, hornSoundOnZero = false }
    }
  }
}

return Rulesets