Disclaimer: everything here may not be up to date!
This is intended to be a rough overview, to get an idea of the code's organization and where to start.

# Packages

* `skytroops.defs` - The "parametrization" of everything (ships, bullets, levels...)
* `skytroops.gui` - GUI elements (button, label, coins, life bar...)
* `skytroops.screens` Game screens like (loading, menu, airport...)
* `skytroops.game` - In-game objects (player ship, bullet, ...)
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
* the amount (five of them)
* the formation (forming a diagonal line)
* the origin (from the top left corner)

Each time, the countdown of the wave will be decreased, until it reaches <# 0, which releases the enemies.
When ennemies are released, the method `onSpawn(ships)` is called.

# Levels

Levels are basically a background and a collection of waves.

That way, everything is perfectly customizable. Which ennemy comes from where.

Once all the waves have been elapsed and no ennemy is on screen anymore, the player wins.

Within a level, waves are declared based on delays between each other, so that updating/popping the first one is enough.

In order to increase a bit replayability and because its tiresome to plan every wave for every level, it might be easier to generate them pseudo-randomly.

Difficulty increases with:

* the type of enemy
* the amount of them
* the frequency of arrival

Increasing each factor together leads to an exponential difficulty (tougher ennemies, many at once, every second). Therefore, it's a balancing play between Increasing an aspect and reducing another.

Assessing the difficulty of a wave is relatively straightforward: N * ship.xp

We suggest to delay the next wave proportionally to this difficulty.
That way, its balanced, either more frequent easy waves or a tough one once in a while.

Until X seconds are elapsed:
	pick one of all possible foes / formations in the level
	delay = N * ship.xp * level_difficulty * random(0.8,1.2)?
	