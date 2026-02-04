local element = require("data.ui.design.Element")
local Subpanel = {}

function Subpanel:newSubpanel(gameType)
  return {
    element:newElement(
      "label","NewGame-MatchTitle",
      "Match Title",
      270,90,
      130,40,
      nil,
      sysFont.setupCommon, "left",
      "standby",
      locale.newGame.matchTitle.tooltip,
      "editMatchTitle"
    ),
    element:newElement(
      "textField","NewGame-MatchTitle",
      Subpanel:getMatchTitle(gameType),
      400,90,
      600,40,
      nil,
      sysFont.setupCommon, "left",
      "standby",
      locale.newGame.matchTitle.tooltip,
      "editMatchTitle"
    ),
    element:newElement(
      "checkbox","NewGame-Checkbox-MatchTitleVisible",
      Subpanel:getMatchTitleVisible(gameType),
      1015,95,
      30,30,
      nil,
      sysFont.setupCommon, "center",
      "standby",
      locale.newGame.matchTitleVisible.tooltip,
      "toggleMatchTitleVisible"
    ),
    element:newElement(
      "label","NewGame-MatchTitleVisible",
      "Show in scoreboard",
      1050,90,
      220,40,
      nil,
      sysFont.setupCommon, "left",
      "standby",
      locale.newGame.matchTitleVisible.tooltip,
      "toggleMatchTitleVisible"
    ),
    element:newElement(
      "label","NewGame-Court",
      "",
      530,160,
      470,250,
      Subpanel:getCourtImage(gameType),
      sysFont.setupCommon, "center",
      "standby",
      locale.setupTab.newGame.tooltip,
      nil
    ),
    element:newElement(
      "label","NewGame-LSide",
      "Team on Left Side",
      270,390,
      220,30,
      nil,
      sysFont.setupCommon, "left",
      "standby",
      locale.newGame.teamInfo.textField,
      nil
    ),
    element:newElement(
      "label","NewGame-RSide",
      "Team on Right Side",
      1040,390,
      220,30,
      nil,
      sysFont.setupCommon, "right",
      "standby",
      locale.newGame.teamInfo.textField,
      nil
    ),
    element:newElement(
      "textField","NewGame-LSide-TeamName",
      Subpanel:getTeamName(gameType, "left"),
      270,420,
      460,40,
      nil,
      sysFont.setupCommon, "center",
      "standby",
      locale.newGame.teamInfo.textField,
      "editLsideTeamName"
    ),
    element:newElement(
      "textField","NewGame-RSide-TeamName",
      Subpanel:getTeamName(gameType, "right"),
      800,420,
      460,40,
      nil,
      sysFont.setupCommon, "center",
      "standby",
      locale.newGame.teamInfo.textField,
      "editRsideTeamName"
    ),
    element:newElement(
      "button","NewGame-SwitchSides",
      "<->",
      740, 420,
      50, 40,
      nil,
      sysFont.setupCommon, "center",
      "standby",
      locale.newGame.teamInfo.switch,
      "teamsSwitchCourtSides"
    )
  }
end

function Subpanel:getMatchTitle(gameType)
  if gameType == "basketball" then
    return rawValue.saved.basketball.matchTitle
  else
    return rawValue.saved.volleyball.matchTitle
  end
end

function Subpanel:getMatchTitleVisible(gameType)
  local isVisible
  if gameType == "basketball" then
    isVisible = rawValue.saved.basketball.isMatchTitleVisible
  else
    isVisible = rawValue.saved.volleyball.isMatchTitleVisible
  end
  return isVisible
end

function Subpanel:getCourtImage(gameType)
  local court
  if gameType == "basketball" then
    court = image.court.basketball
  else
    court = image.court.volleyball
  end
  return court
end

function Subpanel:getTeamName(gameType, side)
  local teamName
  if gameType == "basketball" and side == "left" then
    teamName = rawValue.saved.basketball.teamL.name
  elseif gameType == "basketball" and side == "right" then
    teamName = rawValue.saved.basketball.teamR.name
  elseif gameType == "volleyball" and side == "left" then
    teamName = rawValue.saved.volleyball.teamL.name
  elseif gameType == "volleyball" and side == "right" then
    teamName = rawValue.saved.volleyball.teamR.name
  end
  return teamName
end

function Subpanel:mousepressed(x, y, button)
  if button == 1 then
    if 
end

return Subpanel