local MatchLog = {}
MatchLog.__index = MatchLog

function MatchLog.new(ScoreboardState, gamePlayed, matchStatus)
  local self = setmetatable({}, MatchLog)
  self.matchRecord = os.time()
  self.gamePlayed = gamePlayed
  self.ScoreboardState = ScoreboardState
  self.matchStatus = matchStatus
  return self
end

return MatchLog