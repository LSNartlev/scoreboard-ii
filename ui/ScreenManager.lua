local ScreenManager = {}

local screens = {}

ScreenManager.onDisplay = nil

function ScreenManager.changeScreen(nextScreen)
  -- Stop running timers and playing sounds before proceeding to next screen
  if ScreenManager.onDisplay and ScreenManager.onDisplay.attemptExitScreen then
    ScreenManager.onDisplay:attemptExitScreen()
  end
  
  if not screens[nextScreen] then
    screens[nextScreen] = require("ui.screens." .. nextScreen)
  end
  
  ScreenManager.onDisplay = screens[nextScreen]
  
  if ScreenManager.onDisplay.load then
    ScreenManager.onDisplay:load()
  end
end
  
return ScreenManager