# Godot Architecture

## Scenes
- Game (Main Scene)
  - Node "Main" (main.gd)
    - Node2D "World" (game_world.gd)
    - Control "GUI" (gui.gd)

## Entities
- Player
- Monster (Opponent)
- Weapon
- Treasure Chest
  - Key
  - Munition
  - Bomb

## Entities in Detail
### Player
Properties
- Weapon
### Monster (Opponent)
### Treasure Chest
Properties
- Key
- Munition
- Bomb
### Bomb
Properties
- Countdown
Method
- count_down()
### Key
- Is required to open the door to win the game
### Weapon
- Munition
Methods
- shoot()
