local SoundEffectActions = {}
local Sounds = require("data.CustomSounds")

function SoundEffectActions:playSound(soundNum)
  if soundNum == 1 then Sounds.sfx1.soundSource:stop() Sounds.sfx1.soundSource:play() end
  if soundNum == 2 then Sounds.sfx2.soundSource:stop() Sounds.sfx2.soundSource:play() end
  if soundNum == 3 then Sounds.sfx3.soundSource:stop() Sounds.sfx3.soundSource:play() end
  if soundNum == 4 then Sounds.sfx4.soundSource:stop() Sounds.sfx4.soundSource:play() end
  if soundNum == 5 then Sounds.sfx5.soundSource:stop() Sounds.sfx5.soundSource:play() end
  if soundNum == 6 then Sounds.sfx6.soundSource:stop() Sounds.sfx6.soundSource:play() end
  if soundNum == 7 then Sounds.sfx7.soundSource:stop() Sounds.sfx7.soundSource:play() end
  if soundNum == 8 then Sounds.sfx8.soundSource:stop() Sounds.sfx8.soundSource:play() end
  if soundNum == 9 then Sounds.sfx9.soundSource:stop() Sounds.sfx9.soundSource:play() end
  if soundNum == 10 then Sounds.sfx10.soundSource:stop() Sounds.sfx10.soundSource:play() end
end

function SoundEffectActions:stopSound(soundNum)
  if soundNum == 1 then Sounds.sfx1.soundSource:stop() end
  if soundNum == 2 then Sounds.sfx2.soundSource:stop() end
  if soundNum == 3 then Sounds.sfx3.soundSource:stop() end
  if soundNum == 4 then Sounds.sfx4.soundSource:stop() end
  if soundNum == 5 then Sounds.sfx5.soundSource:stop() end
  if soundNum == 6 then Sounds.sfx6.soundSource:stop() end
  if soundNum == 7 then Sounds.sfx7.soundSource:stop() end
  if soundNum == 8 then Sounds.sfx8.soundSource:stop() end
  if soundNum == 9 then Sounds.sfx9.soundSource:stop() end
  if soundNum == 10 then Sounds.sfx10.soundSource:stop() end
end

return SoundEffectActions