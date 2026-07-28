local font = {
  -- Tooltip text on the footer section
  tooltip = love.graphics.newFont("ext/fonts/Oxanium/static/Oxanium-Medium.ttf", 14),
  
  -- Uniform font size on Settings screens
  config = love.graphics.newFont("ext/fonts/Oxanium/static/Oxanium-Medium.ttf", 20),
  -- NOTE: Header Text of Settings screens shall also use font.matchInfo
  
  -- Scoreboard font sizes
  matchInfo = love.graphics.newFont("ext/fonts/Oxanium/static/Oxanium-Bold.ttf", 42),
  score = love.graphics.newFont("ext/fonts/Oxanium/static/Oxanium-Bold.ttf", 200),
  bbTimer = love.graphics.newFont("ext/fonts/Oxanium/static/Oxanium-Bold.ttf", 135),
  bbTimerEdit = love.graphics.newFont("ext/fonts/Oxanium/static/Oxanium-Bold.ttf", 108),
  counterLabel = love.graphics.newFont("ext/fonts/Oxanium/static/Oxanium-Bold.ttf", 32),
  serveTime = love.graphics.newFont("ext/fonts/Oxanium/static/Oxanium-Bold.ttf", 90),
  nsSetScores = love.graphics.newFont("ext/fonts/Oxanium/static/Oxanium-Bold.ttf", 64)
  -- NOTE: Text for the current time and set/game number for net sports shall also use font.nsSetScores
}

return font