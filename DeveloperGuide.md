# Packages

* `skytroops.defs` - The "parametrization" of everything (ships, bullets, levels...)
* `skytroops.enemies` - Enemy Ships
* `skytroops.gui` - GUI elements (button, label, coins, life bar...)
* `skytroops.levels` - Game levels
* `skytroops.screens` Game screens like (loading, menu, airport...)
* `skytroops.stuff` - In-game "stuff" (player ship, bullet, ...)
* `skytroops.*` - Core classes (game, resources, sound, input...)

# Tinkerer's guide

A lot of things are the same, just differently parametrized.
You can configure about anything in the game in the `skytroops.defs` package.
From the picture of the ships, to the velocity of the bullets, to the waves of ennemies for each level.


* Bullets
* Enemies
* Levels
* Upgrades


# skytroops.Game

This is the "orchestrating" class.
It handles the flow between the various screens, 
keeps track of the player's progress (levels, coins, upgrades...),
and triggers the core game loop when necessary.

# Core Stuff

The game is made out of various screens:

* skytroops.screens.Loading
* skytroops.screens.Menu
* skytroops.screens.Airport
* skytroops.screens.LevelSelect

And "levels":

* skytroops.levels.Grass
* skytroops.levels.Rocky
* skytroops.levels.Snow
* skytroops.levels.Desert
* skytroops.levels.Islands

Each level is almost the same, but is nevertheless an independent class in order to allow customization.

# Level

All of the levels are based on the base class `skytroops.levels.Level`.
It is the most important class, encapsulating the behavior of the game.

The method `update(dt)` defines the core loop, called on each frame, to update all the objects in the game.
In other words, the motion will be independent of the framerate.

This covers updating:

* Scrolling Background
* Player Ship
* Enemy Ships
* Player Bullets
* Enemy Bullets
* Checking Collisions
* Generating new enemy "waves"

The two ways to end a level are calling `onWin()` or `onDie()` within the level itself.

# Waves

Waves define or generate which enemies appear where, when and how.
A wave can be defined by:

* a delay (12.5s)
* an ennemy type (red plane)
* the formation (five in a diagonal line)
* the origin (from the top left corner)

Each time, the countdown of the wave will be decreased, until it reaches <# 0, which releases the enemies.
When ennemies are released, the method `onSpawn(ships)` is called.

Within a level, waves are declared based on delays between each other, so that updating/popping the first one is enough.
