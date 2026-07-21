local ScoreboardState = require("data.ScoreboardState")
local Controls = require("data.Controls")

local languagePack = {
  tooltips = {
    scoreboardFallback = "Welcome to Scoreboard II. Press [ESC] to setup a match. For details on how to use, move the mouse cursor to any part of the scoreboard.",
    matchInfo = "The name/title of the tournament or match. Click this to setup the scoreboard for a game.",
    teamAName = "The name of the team on the left side of the court. Click this to edit this team name.",
    teamBName = "The name of the team on the right side of the court. Click this to edit this team name.",
    changeCourt = {"Click here to switch the court sides of the teams. Alternatively, press [","]."},
    score = {"The total points scored by ",". Press [","] to add a point, or [Shift]+[","] to remove a point."},
    setScore = {"The total points scored by "," for this set. Press [","] to add a point, or [Shift]+[","] to remove a point."},
    gameScore = {"The total points scored by "," for this game. Press [","] to add a point, or [Shift]+[","] to remove a point."},
    teamFoul = {"The number of fouls charged to ",". Press [","] to add a team foul, or [Shift]+[","] to remove a team foul."},
    timeout = {"The number of remaining timeouts for ",". Press [","] to use a timeout, or [Shift]+[","] to add back a timeout."},
    period = {"The current period being played. If the time runs out, the horn buzzer will automatically sound. Press [",
      "] to stop the horn and the game will automatically proceed to the next period (or overtime if the scores are tied on the last period)."},
    periodTimer = {"The time remaining for this period. Press [","] to start and/or stop running the timer."},
    shotClock = {"The time remaining for the team possessing the ball to attempt for a goal. Press [","] to start and/or stop running the shot clock, [",
      "] to reset the shot clock to "," second(s), or [","] to reset the shot clock to "," second(s)."},
    serveClock = {"The time remaining for the player to serve. Press [","] to toggle between start/stop/hide/show the serve clock."},
    timeDisplay = "The time now is ",
    matchWinner = {"The winner is ","! Congratulations!"},
    setWinner = {"The winner of this set is ","! To proceed to the next set, press [","]."},
    gameWinner = {"The winner of this game is ","! To proceed to the next game, press [","]."}
  },
  bbPeriod = { "1st", "2nd", "3rd", "4th", "OT" }
}

return languagePack