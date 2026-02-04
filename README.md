![Scoreboard II - Made with LÖVE](https://github.com/LSNartlev/scoreboard-ii/blob/main/assets/images/menutitle.png?raw=true)

Lua/LÖVE-based Scoreboard for Basketball and Volleyball -- a hobby project by LSNartlev

### Features
- Use the mouse or assign keybinds to control the scoreboard
- Scoreboard features:
  - Background and text customization corresponding to team uniforms. Can save up to 32 preset teams.
  - Adjustable scoreboard parameters compatible to FIBA, NBA, FIVB, or your own basketball/volleyball rules.
- Supports custom sound effects*
  - Only the horn buzzer is included. Supported (tested) formats: .mp3, .ogg, .wav.
  - Import your custom sound effects by storing them in the UserSounds folder.
  
## How to Use
- Select the game to play: **Basketball** or **Volleyball**
- Enter the names of the playing teams. You may also enter the color of their uniforms.
- Mouse controls (Basketball and Volleyball):
  - Hover the mouse on any score counter or timer, then scroll up/down to increase/decrease the value.
  - Left click to play/pause any timer. For basketball shot clock, double click to reset to 24, or right click to reset to 14.
- Basic keyboard controls (adjustable in Settings):
  - **F** or **J** = Score +1 (and hold **Shift** for Score -1)
  - **D** or **K** = Team Foul +1 (and hold **Shift** for Team Foul -1)
  - **S** or **L** = Timeout +1 (and hold **Shift** for Timeout -1)
  - **A** or **;** = Toggle Team with Ball Possession (or Service)
  - **Space** = Play/Pause Period Clock
  - **B** = Play/Pause Shot Clock (or Serving Timer)
  - **V** = Reset Shot Clock to 14 (or Show/Hide Serving Timer)
  - **N** = Reset Shot Clock to 24 (or Reset Serving Timer to 8)
  - **Backspace** = Hold to sound horn buzzer
  - **0** to **9** = Play custom sound effects
  - **F1** = Show/Hide Keyboard Control Hints
  - **F2** = Toggle Scoreboard Edit Mode
  - **F3** = Go to Previous Period/Set
  - **F4** = Go to Next Period/Set
  - **F5** = Switch Court Sides

## Third Party Attributions
Third-party assets and libraries are included under their respective licenses:

- **json.lua**

  Copyright ©2019 rxi

  License: MIT License


- **Quantico**

  Copyright ©2011 Matthew Desmond (https://www.madtype.com | mattdesmond@gmail.com)
  with Reserved Font Name "Quantico"

  License: SIL Open Font License, Version 1.1
  https://openfontlicense.org/


- All emojis designed by **OpenMoji**  (https://openmoji.org) – the open-source emoji and icon project.

  License: Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
  https://creativecommons.org/licenses/by-sa/4.0/
