local ScoreboardState = require("data.ScoreboardState")
local Controls = require("data.Controls")

local languagePack = {
  tooltips = {
    scoreboardFallback = "Welcome to Scoreboard II. Press [ESC] to setup a match. For details on how to use, click the gear icon, or press [F1] to show controls.",
    matchInfo = "The name/title of the tournament or match. Click to setup the scoreboard for a game.",
    teamAName = "The name of the team on the left side of the court. Click to edit this team name.",
    teamBName = "The name of the team on the right side of the court. Click to edit this team name.",
    matchEnd = { basketball = "The match has concluded. To setup a new match, press [ESC]. If this match is still not over, adjust the period timer to keep playing.",
      netSport = "The match has concluded. To setup a new match, press [ESC]. If this match is still not over, roll back the scores on this set/game to keep playing." }
  },
  bbPeriod = { "1st", "2nd", "3rd", "4th", "OT" },
  bbScoreboard = {
    timerAdjustment = "TIMER ADJUSTMENT MODE IS ENABLED. You may now manually adjust or disable/enable the period timer and shot clock, but other controls are disabled. To disable Timer Adjustment Mode and resume to the game, press [ESC].",
    
  },
  config = {
    tab = {
      matchSetup = "Match Setup",
      bbSettings = "Basketball Settings",
      bbControls = "Basketball Controls",
      nsSettings = "Net Sport Settings",
      nsControls = "Net Sport Controls",
      teamsList = "List of Saved Teams",
      soundsList = "Custom Sounds"
    }
  }
}

return languagePack