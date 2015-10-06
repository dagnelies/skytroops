The game is programmed in Haxe and based on the Createjs library.

# Why? Why not?

It is basically a historical reason.
The code was based on a space shooter prototype made in mid-2013.
At that time, HTML5 and related technologies were still fairly young and Haxe/createjs were chosen.

# Thoughts

Developing with Haxe and Createjs still is a solid choice.
Both are mature and working well.

However, it has strong drawbacks too.
The main one is that they are fairly exotic technologies.
As such, you're often "left alone": libraries that are not up to date, low IDE support, few tutorials, few developers, etc.

A prime example is the Haxe Createjs wrapper. It's not up to date, not even remotely, and the guy taking care of it is just a guy like you and me who doesn't have much time to devote to it.
As a consequence, you have not only to develop the game, but also to submit patches to the libraries and hope they'll be pulled some day.

It's a bit of a shame Haxe is still such an outlier, it's really a good language IMHO.
I would even say the best I've encountered so far (java,c#,javascript,python,ruby,c++,haskell,lisp...) but this is merely my personal opinion so please avoid any flame war.
You've everything you need in it. However the ecosystem (community, tools, libs) is severly lacking due to its low exposure.

# Alternatives #

I think having a statically typed language is a great help.
It provides mainly code safety and better code structure.
But also tooling support like better autocompletion, refactoring, etc.

I think the best alternative to Haxe currently is TypeScript.
This is "javascript specific" but has more wind in its sails because it's backed by major players like Microsoft and partly Google.

The truth is that a technology doesn't get adopted because it's good but because money is pumped into it.
This will raise awareness and people will flock around it.

But since I'm very happy with Haxe, I would prefer contributing to its ecosystem rather than the other way round, even if it means more work.
