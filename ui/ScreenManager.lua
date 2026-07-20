local ScreenManager = {}

local screens = {
  BasketballScoreboard = require("ui.screens.BasketballScoreboard")
}

ScreenManager.onDisplay = nil

function ScreenManager.changeScreen(nextScreen)
  -- Stop running timers and playing sounds before proceeding to next screen
  if ScreenManager.onDisplay and ScreenManager.onDisplay.attemptExitScreen then
    ScreenManager.onDisplay:attemptExitScreen()
  end
  
  ScreenManager.onDisplay = screens[nextScreen]
  
  if ScreenManager.onDisplay.load then
    ScreenManager.onDisplay:load()
  end
end
  
return ScreenManager