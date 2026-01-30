return {
  -- Main Menu and/or Screen Labels
  welcomeText = "Welcome to Scoreboard II.",
  basketball = {
    label = "Basketball",
    tooltip = "Setup the scoreboard for a basketball game."
  },
  volleyball = {
    label = "Volleyball",
    tooltip = "Setup the scoreboard for a volleyball game."
  },
  soundboard = {
    label = "Soundboard",
    tooltip = "Import and play sound effects."
  },
  settings = {
    label = "Settings",
    tooltip = "Adjust scoreboard settings or create display templates for up to 32 teams."
  },
  help = {
    label = "Help",
    tooltip = "Learn more about Scoreboard II."
  },
  backToMain = {
      label = "Back to Menu",
      tooltip = "Go back to the Main Menu."
  },
  
  basketballSetup = {
    default = "Setup the scoreboard for a basketball game.",
    newGame = "Set the team names, uniforms, and the match title of the game.",
    settings = "Adjust the period clock and shot clock, as well as the team foul and timeout rules per period.",
    controls = "Change which keys to use when operating the scoreboard.",
    soundEffects = "Aside from the horn buzzer, assign other sound effects that can be played during the game.",
  },
  volleyballSetup = {
    default = "Setup the scoreboard for a volleyball game.",
    newGame = "Set the team names, uniforms, and the match title of the game.",
    settings = "Adjust the number of points to win, serve time, and timeou rules per set.",
    controls = "Change which keys to use when operating the scoreboard.",
    soundEffects = "Aside from the horn buzzer, assign other sound effects that can be played during the game.",
  },
  soundboardSetup = {
    default = "Assign sound effects to each key. Make sure that your audio files are located in the UserSounds folder."
  },
  settingsScreen = {
    default = "From here, you may change the default rules to be followed by the scoreboard, or create display templates for up to 32 teams."
  },
  helpScreen = {
    default = "Click any of the tabs on the left to learn more about Scoreboard II."
  },
  
  newGame = {
    matchTitle = {
      label = "Match Title",
      tooltip = "Enter the title of the tournament/exhibition match."
    },
    matchTitleVisible = {
      label = "Show in scoreboard",
      tooltip = "Check if you want to display the Match Title on top of the screen during the game."
    },
    teamInfo = {
      textField = "Enter the name of the team.",
      uniform = "Edit the color(s) of this team's uniform.",
      switch = "Switch the courts of the teams."
    }
  }
}