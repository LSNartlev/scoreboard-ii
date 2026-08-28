local ScreenManager = require("ui.ScreenManager")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local Icons = require("ui.designs.Icons")
local ScoreboardState = require("data.ScoreboardState")
local Controls = require("data.Controls")
local Sounds = require("data.CustomSounds")
local TeamsList = require("data.TeamsList")
local json = require("ext.rxi-json.json")
function love.load()
  -- Load TeamsList.lua, SavedTeams.json
  local file, path, rawSaveData, success, message
  path = "SaveData/TeamsList.json"
  file = io.open(path, "r")
  if not file then
    file = io.open(path, "w")
    if file then
      file:write(json.encode(TeamsList))
      file:close()
      file = io.open(path, "r")
    else
      error("Failed to load TeamsList...")
    end
  end
  if file then
    rawSaveData = file:read("*a")
    file:close()
    TeamsList = json.decode(rawSaveData)
  end
  path = "SaveData/Config.json"
  file = io.open(path, "r")
  if not file then
    file = io.open(path, "w")
    if file then
      file:write(json.encode(ScoreboardState.config))
      file:close()
      file = io.open(path, "r")
    else
      error("Failed to load Scoreboard configurations...")
    end
  end
  if file then
    rawSaveData = file:read("*a")
    file:close()
    ScoreboardState.config = json.decode(rawSaveData)
  end
  --[[
  if love.filesystem.getInfo("SavedTeams.json") == nil then
    rawSaveData = json.encode(TeamsList)
    success, message = love.filesystem.write("SavedTeams.json", rawSaveData)
  end
  -- Load SavedConfig.json
  if love.filesystem.getInfo("SavedConfig.json") == nil then
    rawSaveData = json.encode(ScoreboardState.config)
    success, message = love.filesystem.write("SavedConfig.json", rawSaveData)
  end
  rawSaveData = love.filesystem.read("SavedConfig.json")
  ]]
  -- Load Sounds
  for _, v in pairs(Sounds) do
    path = "CustomSounds/" .. v.filename
    local file = io.open(path, "rb")
    if not file then
      v.soundSource = love.audio.newSource("assets/blank.wav", "static")
    else
      local rawData = file:read("*all")
      file:close()
      local fileData = love.filesystem.newFileData(rawData, v.filename)
      v.soundSource = love.audio.newSource(fileData, "static")
    end
    v.soundSource:setVolume(v.volume)
  end
  local configData = json.decode(rawSaveData)
  ScoreboardState.matchTitle = configData.matchSetup.matchTitle
  ScoreboardState.teamA.name = configData.matchSetup.teamA.name
  ScoreboardState.teamA.bgColor1 = configData.matchSetup.teamA.bgColor1
  ScoreboardState.teamA.bgColor2 = configData.matchSetup.teamA.bgColor2
  ScoreboardState.teamA.fgColor = configData.matchSetup.teamA.fgColor
  ScoreboardState.teamA.hsl = configData.matchSetup.teamA.hsl
  ScoreboardState.teamB.name = configData.matchSetup.teamB.name
  ScoreboardState.teamB.bgColor1 = configData.matchSetup.teamB.bgColor1
  ScoreboardState.teamB.bgColor2 = configData.matchSetup.teamB.bgColor2
  ScoreboardState.teamB.fgColor = configData.matchSetup.teamB.fgColor
  ScoreboardState.teamB.hsl = configData.matchSetup.teamB.hsl
  
  love.keyboard.setKeyRepeat(true)
  ScreenManager.changeScreen("MatchSetup")
end

function love.update(dt)
  ScreenManager.onDisplay:update(dt)
end

function love.draw()
  ScreenManager.onDisplay:draw()
end

function love.textinput(text)
  if ScreenManager.onDisplay.textinput then
    ScreenManager.onDisplay:textinput(text)
  end
end

function love.mousemoved(x, y, dx, dy, istouch)
  if ScreenManager.onDisplay.mousemoved then
    ScreenManager.onDisplay:mousemoved(x, y, dx, dy, istouch)
  end
end

function love.mousepressed(x, y, button)
  if ScreenManager.onDisplay.mousepressed then
    ScreenManager.onDisplay:mousepressed(x, y, button)
  end
end

function love.mousereleased(x, y, button, istouch, presses)
  if ScreenManager.onDisplay.mousereleased then
    ScreenManager.onDisplay:mousereleased(x, y, button, istouch, presses)
  end
end

function love.keypressed(key, scancode, isrepeat)
  if ScreenManager.onDisplay.keypressed then
    ScreenManager.onDisplay:keypressed(key, scancode, isrepeat)
  end
end

function love.keyreleased(key, scancode)
  if ScreenManager.onDisplay.keyreleased then
    ScreenManager.onDisplay:keyreleased(key, scancode)
  end
end