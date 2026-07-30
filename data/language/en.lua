local ScoreboardState = require("data.ScoreboardState")
local Controls = require("data.Controls")

local languagePack = {
  tooltips = {
    scoreboardFallback = "Welcome to Scoreboard II.\nPress [ESC] to setup a match. For details on how to use, point your mouse over the parts of the scoreboard.",
    matchSetup = "MATCH SETUP\nYou may edit the Match Title or the names of the teams here. To change or adjust any of the uniform colors, click \"Change Team / Color\".",
    matchEnd = { basketball = "The match has concluded. To setup a new match, press [ESC]. If this match is still not over, adjust the period timer to keep playing.",
      netSport = "The match has concluded.\nTo setup a new match, press [ESC]. If this match is still not over, roll back the scores on this set/game to keep playing." }
  },
  bbPeriod = { "1st", "2nd", "3rd", "4th", "OT" },
  bbScoreboard = {
    timerAdjustment = "TIMER ADJUSTMENT MODE IS ENABLED.\nYou may now manually adjust or disable/enable the period timer and shot clock, but other controls are disabled.\n"
    .."To disable Timer Adjustment Mode and resume to the game, press [ESC] or [" .. string.upper(Controls.bb.toggleTimerAdjust) .. "].",
    timerAdjustmentMode = {
      periodTimer = "To adjust minutes: press [Shift]+[" .. string.upper(Controls.bb.timerAdjust.periodMin) .. "] to decrease, or [" 
      .. string.upper(Controls.bb.timerAdjust.periodMin) .. "] to increase. To adjust seconds: press [Shift]+[".. string.upper(Controls.bb.timerAdjust.periodSec)
      .. "] to decrease, or [" .. string.upper(Controls.bb.timerAdjust.periodSec) .. "] to increase.\nTo adjust by 0.1 seconds: press [Shift]+["
      .. string.upper(Controls.bb.timerAdjust.periodDsec) .. "] to decrease, or [" .. string.upper(Controls.bb.timerAdjust.periodDsec)
      .. "] to increase. To enable or disable the timer, press [" .. string.upper(Controls.bb.timerAdjust.togglePeriodTimerEnabled)
      .. "].\nTo disable Timer Adjustment Mode and resume to the game, press [ESC] or [" .. string.upper(Controls.bb.toggleTimerAdjust) .. "].",
      shotClock = "To adjust seconds: press [Shift]+[".. string.upper(Controls.bb.timerAdjust.shotSec) .. "] to decrease, or ["
      .. string.upper(Controls.bb.timerAdjust.shotSec) .. "] to increase. To adjust by 0.1 seconds: press [Shift]+["
      .. string.upper(Controls.bb.timerAdjust.shotDsec) .. "] to decrease, or [" .. string.upper(Controls.bb.timerAdjust.shotDsec) 
      .. "] to increase.\nTo enable or disable the shot clock, press [" .. string.upper(Controls.bb.timerAdjust.toggleShotClockEnabled) 
      .. "].\nTo disable Timer Adjustment Mode and resume to the game, press [ESC] or [" .. string.upper(Controls.bb.toggleTimerAdjust) .. "]."
    },
    matchTitle = "The title of this basketball event.\nTo edit this title or change other info, click here or press [ESC].",
    teamAName = "The name of the team on the left side of the court.\nTo edit the team name or change its colors, click here or press [ESC].",
    teamBName = "The name of the team on the right side of the court.\nTo edit the team name or change its colors, click here or press [ESC].",
    teamAScore = "Score of " .. ScoreboardState.teamA.name .. ".\nTo add 1 point, press [" .. string.upper(Controls.bb.scoreTeamA) 
    .. "].\nTo decrease 1 point, press [Shift]+["  .. string.upper(Controls.bb.scoreTeamA) .. "].",
    teamBScore = "Score of " .. ScoreboardState.teamB.name .. ".\nTo add 1 point, press [" .. string.upper(Controls.bb.scoreTeamB)
    .. "].\nTo decrease 1 point, press [Shift]+["  .. string.upper(Controls.bb.scoreTeamB) .. "].",
    teamAFouls = "Team Fouls of " .. ScoreboardState.teamA.name .. " for this period.\nTo add 1 team foul, press [" 
    .. string.upper(Controls.bb.foulTeamA) .. "].\nTo decrease 1 team foul, press [Shift]+["  .. string.upper(Controls.bb.foulTeamA) .. "].",
    teamBFouls = "Team Fouls of " .. ScoreboardState.teamB.name .. " for this period.\nTo add 1 team foul, press ["
    .. string.upper(Controls.bb.foulTeamB) .. "].\nTo decrease 1 team foul, press [Shift]+["  .. string.upper(Controls.bb.foulTeamB) .. "].",
    teamATimeouts = "Remaining timeouts of " .. ScoreboardState.teamA.name .. " for this period.\nTo use 1 timeout, press ["
    .. string.upper(Controls.bb.timeoutTeamA) .. "].\nTo add 1 timeout, press [Shift]+["  .. string.upper(Controls.bb.timeoutTeamA) .. "].",
    teamBTimeouts = "Remaining timeouts of " .. ScoreboardState.teamB.name .. " for this period.\nTo use 1 timeout, press ["
    .. string.upper(Controls.bb.timeoutTeamB) .. "].\nTo add 1 timeout, press [Shift]+["  .. string.upper(Controls.bb.timeoutTeamB) .. "].",
    teamABallPoss = "If there is a visible arrow here, it indicates that " .. ScoreboardState.teamA.name
    .. " shall have the next ball possession on the next jump ball.\nTo show or hide the arrow pointing here, press [" .. string.upper(Controls.bb.ballPossTeamA) .. "].",
    teamBBallPoss = "If there is a visible arrow here, it indicates that " .. ScoreboardState.teamB.name
    .. " shall have the next ball possession on the next jump ball.\nTo show or hide the arrow pointing here, press [" .. string.upper(Controls.bb.ballPossTeamB) .. "].",
    period = "The current period for this match. Automatically proceeds to the next period when the period timer runs out.\nTo manually adjust the current period, press ["
    .. string.upper(Controls.bb.prevPeriod) .. "] or [" .. string.upper(Controls.bb.nextPeriod)
    .. "].\nTo sound the horn buzzer, press and hold [" .. string.upper(Controls.bb.hornSound) .. "]. To make both teams switch sides, press ["
    .. string.upper(Controls.bb.changeCourt) .. "].",
    periodTimer = "The remaining time for this period.\nTo run or stop the timer, press [" .. string.upper(Controls.bb.togglePeriodTimer)
    .. "]. If the shot clock is enabled, the shot clock will run and/or stop with the timer.\nTo manually adjust this timer or the shot clock, press ["
    .. string.upper(Controls.bb.toggleTimerAdjust) .. "] to activate Timer Adjustment Mode.",
    shotClock = "The shot clock, which is the remaining time for the team to attempt for a goal.\nTo run or stop the shot clock while the timer is running, press ["
    .. string.upper(Controls.bb.toggleShotClock) .. "]. Note: You cannot run the shot clock if the timer is stopped or disabled.\nTo reset the shot clock to "
    .. ScoreboardState.config.bb.shotClock.resetShort .. " seconds, press [" .. string.upper(Controls.bb.resetShotClockShort) .. "]. To reset the shot clock to "
    .. ScoreboardState.config.bb.shotClock.resetFull .. " seconds, press [" .. string.upper(Controls.bb.resetShotClockFull) .. "]. Resetting will also stop the shot clock.",
    bbTab = "You are now using a Basketball scoreboard.",
    nsTab = "Click to switch into a scoreboard for Volleyball, Badminton, Table Tennis, or Pickleball.",
    configTab = "Click to change the settings.",
    aboutTab = "Click to learn more about Scoreboard II."
  },
  matchSetup = {
    matchTitle = "The name of the match or tournament. Click to edit.",
    teamAName = "The name of the team on the left side of the court. Click to edit.",
    teamAName = "The name of the team on the right side of the court. Click to edit.",
    switchSides = "Make both teams switch sides.",
    changeTeamA = "The uniform colors of " .. ScoreboardState.teamA.name .. ". Click to edit these colors and more.",
    changeTeamB = "The uniform colors of " .. ScoreboardState.teamB.name .. ". Click to edit these colors and more.",
    saveAsDefault = "Save this match setup for the scoreboard to use everytime Scoreboard II launches.",
    toBasketball = "Save this match setup and proceed to the basketball match.\nChoose whether to resume the current match with this setup or start a new match.",
    toNetSport = "Save this match setup and proceed to the net sport match.\nChoose whether to resume the current match with this setup or start a new match.",
    bbTab = "Save this match setup and proceed to the basketball match.\nChoose whether to resume the current match with this setup or start a new match.",
    nsTab = "Save this match setup and proceed to the net sport match.\nChoose whether to resume the current match with this setup or start a new match.",
    aboutTab = "Click to learn more about Scoreboard II."
    onEdit = "Now editing the selected text field. Other functions are temporarily disabled.\nTo confirm changes, press [RETURN]. To cancel editing, press [ESC].",
  },
  dialogBox = {
    continueBasketball = "A basketball match is currently in progress.\nThe updated settings will apply if you continue.\n\nWould you like to continue the match?",
    continueNetSport = "A net sport match is currently in progress.\nThe updated settings will apply if you continue.\n\nWould you like to continue the match?",
    savedAsDefault = "These settings will now apply by default on launch.",
    invalidKeybind = "Invalid keybind\n\nThis key is reserved." -- for attempting to use Esc, Shift, Super/Windows key
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
    },
    tabTooltip = {
      matchSetup = "Click to edit the title of the match/tournament or change the details of the competing teams.",
      bbSettings = "Click to adjust options on what rules the basketball scoreboard should follow.",
      bbControls = "Click to adjust which keys to press when operating the basketball scoreboard.",
      nsSettings = "Click to adjust options on what supported sport or rules the net sport scoreboard should follow.",
      nsControls = "Click to adjust which keys to press when operating the net sport scoreboard.",
      teamsList = "Click to organize the teams that the scoreboard operator facilitates.",
      soundsList = "Click to organize the additional sound effects the scoreboard operator can play during matches."
    }
  }
}

return languagePack