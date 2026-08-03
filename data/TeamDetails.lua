local hsl = require("ext.HSLtoRGB")
local TeamDetails = {}
TeamDetails.__index = TeamDetails

function TeamDetails.new(name, bg1, bg2, fg)
  local self = setmetatable({}, TeamDetails)
  self.name = name
  self.bgColor1 = { r = 0, g = 0, b = 0 }
  self.bgColor2 = { r = 0, g = 0, b = 0 }
  self.fgColor = { r = 0, g = 0, b = 0 }
  self.hsl.bg1 = bg1
  self.hsl.bg2 = bg2
  self.hsl.fg = fg
  self.bgColor1.r, self.bgColor1.g, self.bgColor1.b = hsl:toRGB(bg1[1], bg1[2], bg1[3])
  self.bgColor2.r, self.bgColor2.g, self.bgColor2.b = hsl:toRGB(bg2[1], bg2[2], bg2[3])
  self.fgColor.r, self.fgColor.g, self.fgColor.b = hsl:toRGB(fg[1], fg[2], fg[3])
  return self
end

function TeamDetails:convertTeamColors(bg1, bg2, fg)
  self.bgColor1.r, self.bgColor1.g, self.bgColor1.b = hsl:toRGB(bg1[1], bg1[2], bg1[3])
  self.bgColor2.r, self.bgColor2.g, self.bgColor2.b = hsl:toRGB(bg2[1], bg2[2], bg2[3])
  self.fgColor.r, self.fgColor.g, self.fgColor.b = hsl:toRGB(fg[1], fg[2], fg[3])
end

return TeamDetails