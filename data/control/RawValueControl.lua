function teamsSwitchCourtSides(gameType)
  if gameType == "basketball" then
    -- Team Info
    rawValue.saved.basketball.teamL.name, rawValue.saved.basketball.teamR.name 
      = rawValue.saved.basketball.teamR.name, rawValue.saved.basketball.teamL.name
    rawValue.saved.basketball.teamL.bgColor1, rawValue.saved.basketball.teamR.bgColor1 
      = rawValue.saved.basketball.teamR.bgColor1, rawValue.saved.basketball.teamL.bgColor1
    rawValue.saved.basketball.teamL.bgColor2, rawValue.saved.basketball.teamR.bgColor2 
      = rawValue.saved.basketball.teamR.bgColor2, rawValue.saved.basketball.teamL.bgColor2
    rawValue.saved.basketball.teamL.textColor, rawValue.saved.basketball.teamR.textColor 
      = rawValue.saved.basketball.teamR.textColor, rawValue.saved.basketball.teamL.textColor
  
    -- Game State
    rawValue.saved.basketball.gameState.teamL.score, rawValue.saved.basketball.gameState.teamR.score 
      = rawValue.saved.basketball.gameState.teamR.score, rawValue.saved.basketball.gameState.teamL.score
    rawValue.saved.basketball.gameState.teamL.teamFouls, rawValue.saved.basketball.gameState.teamR.teamFouls 
      = rawValue.saved.basketball.gameState.teamR.teamFouls, rawValue.saved.basketball.gameState.teamL.teamFouls
    rawValue.saved.basketball.gameState.teamL.timeouts, rawValue.saved.basketball.gameState.teamR.timeouts 
      = rawValue.saved.basketball.gameState.teamR.timeouts, rawValue.saved.basketball.gameState.teamL.timeouts
    rawValue.saved.basketball.gameState.teamL.ballPossession, rawValue.saved.basketball.gameState.teamR.ballPossession 
      = rawValue.saved.basketball.gameState.teamR.ballPossession, rawValue.saved.basketball.gameState.teamL.ballPossession
  else
    -- Team Info
    rawValue.saved.volleyball.teamL.name, rawValue.saved.volleyball.teamR.name 
      = rawValue.saved.volleyball.teamR.name, rawValue.saved.volleyball.teamL.name
    rawValue.saved.volleyball.teamL.bgColor1, rawValue.saved.volleyball.teamR.bgColor1 
      = rawValue.saved.volleyball.teamR.bgColor1, rawValue.saved.volleyball.teamL.bgColor1
    rawValue.saved.volleyball.teamL.bgColor2, rawValue.saved.volleyball.teamR.bgColor2 
      = rawValue.saved.volleyball.teamR.bgColor2, rawValue.saved.volleyball.teamL.bgColor2
    rawValue.saved.volleyball.teamL.textColor, rawValue.saved.volleyball.teamR.textColor 
      = rawValue.saved.volleyball.teamR.textColor, rawValue.saved.volleyball.teamL.textColor
  
    -- Game State
    rawValue.saved.volleyball.gameState.teamL.score, rawValue.saved.volleyball.gameState.teamR.score 
      = rawValue.saved.volleyball.gameState.teamR.score, rawValue.saved.volleyball.gameState.teamL.score
    rawValue.saved.volleyball.gameState.teamL.timeouts, rawValue.saved.volleyball.gameState.teamR.timeouts 
      = rawValue.saved.volleyball.gameState.teamR.timeouts, rawValue.saved.volleyball.gameState.teamL.timeouts
    rawValue.saved.volleyball.gameState.teamL.ballService, rawValue.saved.volleyball.gameState.teamR.ballService
      = rawValue.saved.volleyball.gameState.teamR.ballService, rawValue.saved.volleyball.gameState.teamL.ballService
  end
end
