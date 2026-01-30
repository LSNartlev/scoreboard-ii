local function newSubpanel()
  local element = require("data.ui.design.Element")
  local elementsList = {
    element:newElement(
      "label","NewGame-MatchTitle",
      "Match Title",
      400,90,
      590,40,
      nil,
      sysFont.setupCommon, "left",
      "standby",
      locale.newGame.matchTitle.tooltip,
      "editMatchTitle"
    ),
    element:newElement(
      "textField","NewGame-MatchTitle",
      "(insert Match Title here)",
      400,90,
      590,40,
      nil,
      sysFont.setupCommon, "left",
      "standby",
      locale.newGame.matchTitle.tooltip,
      "editMatchTitle"
    )
  }
  return elementsList
end

return drawPanel