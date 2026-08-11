local ScoreboardState = require("data.ScoreboardState")
local TextStrings = require("data.language.en")
local Fonts = require("ui.designs.Fonts")
local Color = require("ui.designs.Colors")
local Icons = require("ui.designs.Icons")
local Designer = {
  texts = {
    {
      id = "headerText", text = "Scoreboard II", x = 20, y = 20, width = 300, align = "left",
      font = function() return Fonts.matchInfo end , color = function() return Color.white end 
    },
    { 
      id = "matchSetup", text = TextStrings.config.tab.matchSetup, x = 20, y = 90, width = 210, align = "right",
      font = function() return Fonts.config end , color = function()
      if ScoreboardState.config.tabs.activeTab == "matchSetup" or ScoreboardState.config.tabs.isSelectable then return Color.white end
      return Color.textField.fg.disabled end
    },
    {
      id = "bbSettings", text = TextStrings.config.tab.bbSettings, x = 20, y = 140, width = 210, align = "right",
      font = function() return Fonts.config end , color = function()
      if ScoreboardState.config.tabs.activeTab == "bbSettings" or ScoreboardState.config.tabs.isSelectable then return Color.white end
      return Color.textField.fg.disabled end
    },
    {
      id = "bbControls", text = TextStrings.config.tab.bbControls, x = 20, y = 190, width = 210, align = "right",
      font = function() return Fonts.config end , color = function()
      if ScoreboardState.config.tabs.activeTab == "bbControls" or ScoreboardState.config.tabs.isSelectable then return Color.white end
      return Color.textField.fg.disabled end
    },
    {
      id = "nsSettings", text = TextStrings.config.tab.nsSettings, x = 20, y = 240, width = 210, align = "right",
      font = function() return Fonts.config end , color = function()
      if ScoreboardState.config.tabs.activeTab == "nsSettings" or ScoreboardState.config.tabs.isSelectable then return Color.white end
      return Color.textField.fg.disabled end
    },
    {
      id = "nsControls", text = TextStrings.config.tab.nsControls, x = 20, y = 290, width = 210, align = "right",
      font = function() return Fonts.config end , color = function()
      if ScoreboardState.config.tabs.activeTab == "nsControls" or ScoreboardState.config.tabs.isSelectable then return Color.white end
      return Color.textField.fg.disabled end
    },
    {
      id = "teamsList", text = TextStrings.config.tab.teamsList, x = 20, y = 340, width = 210, align = "right",
      font = function() return Fonts.config end , color = function()
      if ScoreboardState.config.tabs.activeTab == "teamsList" or ScoreboardState.config.tabs.isSelectable then return Color.white end
      return Color.textField.fg.disabled end
    },
    {
      id = "soundsList", text = TextStrings.config.tab.soundsList, x = 20, y = 390, width = 210, align = "right",
      font = function() return Fonts.config end , color = function()
      if ScoreboardState.config.tabs.activeTab == "soundsList" or ScoreboardState.config.tabs.isSelectable then return Color.white end
      return Color.textField.fg.disabled end
    }
  },
  rectangles = {
    {
      id = "matchSetup", x = 20, y = 80, width = 220, height = 40, color = function() 
        if ScoreboardState.config.tabs.activeTab == "matchSetup" then return Color.tabButton.bg.active
        elseif ScoreboardState.config.tabs.isSelectable then return Color.tabButton.bg.enabled
        else return Color.tabButton.bg.disabled end
      end
    },
    {
      id = "bbSettings", x = 20, y = 130, width = 220, height = 40, color = function() 
        if ScoreboardState.config.tabs.activeTab == "bbSettings" then return Color.tabButton.bg.active
        elseif ScoreboardState.config.tabs.isSelectable then return Color.tabButton.bg.enabled
        else return Color.tabButton.bg.disabled end
      end
    },
    {
      id = "bbControls", x = 20, y = 180, width = 220, height = 40, color = function() 
        if ScoreboardState.config.tabs.activeTab == "bbControls" then return Color.tabButton.bg.active
        elseif ScoreboardState.config.tabs.isSelectable then return Color.tabButton.bg.enabled
        else return Color.tabButton.bg.disabled end
      end
    },
    {
      id = "nsSettings", x = 20, y = 230, width = 220, height = 40, color = function() 
        if ScoreboardState.config.tabs.activeTab == "nsSettings" then return Color.tabButton.bg.active
        elseif ScoreboardState.config.tabs.isSelectable then return Color.tabButton.bg.enabled
        else return Color.tabButton.bg.disabled end
      end
    },
    {
      id = "nsControls", x = 20, y = 280, width = 220, height = 40, color = function() 
        if ScoreboardState.config.tabs.activeTab == "nsControls" then return Color.tabButton.bg.active
        elseif ScoreboardState.config.tabs.isSelectable then return Color.tabButton.bg.enabled
        else return Color.tabButton.bg.disabled end
      end
    },
    {
      id = "teamsList", x = 20, y = 330, width = 220, height = 40, color = function() 
        if ScoreboardState.config.tabs.activeTab == "teamsList" then return Color.tabButton.bg.active
        elseif ScoreboardState.config.tabs.isSelectable then return Color.tabButton.bg.enabled
        else return Color.tabButton.bg.disabled end
      end
    },
    {
      id = "soundsList", x = 20, y = 380, width = 220, height = 40, color = function() 
        if ScoreboardState.config.tabs.activeTab == "soundsList" then return Color.tabButton.bg.active
        elseif ScoreboardState.config.tabs.isSelectable then return Color.tabButton.bg.enabled
        else return Color.tabButton.bg.disabled end
      end
    },
    { id = "vertDivider", x = 240, y = 80, width = 5, height = 620,
      color = function() return Color.tabButton.bg.active end }
  },
  tabButtons = {
    {
      id = "bbTab", x = 1030, y = 720, width = 60, height = 80, icon = function() return Icons.basketball end,
      color = function() return Color.textField.bg.enabled end
    },
    {
      id = "nsTab", x = 1090, y = 720, width = 60, height = 80, icon = function() 
        if ScoreboardState.config.ns.sportToPlay == "volleyball" then return Icons.volleyball
        elseif ScoreboardState.config.ns.sportToPlay == "badminton" then return Icons.badminton
        elseif ScoreboardState.config.ns.sportToPlay == "table tennis" then return Icons.tabletennis
        else return Icons.pickleball end
      end,
      color = function() return Color.textField.bg.enabled end
    },
    {
      id = "configTab", x = 1150, y = 720, width = 60, height = 80, icon = function() return Icons.config end,
      color = function() return Color.tabButton.bg.active end
    },
    {
      id = "aboutTab", x = 1210, y = 720, width = 60, height = 80, icon = function() return Icons.about end,
      color = function() return Color.textField.bg.enabled end
    },
  },
  bg = {
    { id = "bgFallback", x = 0, y = 0, width = 1280, height = 720, color = function() return Color.screenFallbackBG end },
    { id = "footer", x = 0, y = 720, width = 1280, height = 80, color = function() return Color.footerBG end }
  }
}

return Designer