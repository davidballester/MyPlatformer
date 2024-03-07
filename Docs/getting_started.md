# Getting started

I'll be making a 2D platformer using pixel art. I started following [Coco Code's brilliant tutorials](https://www.youtube.com/playlist?list=PL1aAeF6bPTB4o7LSEWjIM5gwklEj9VpB_), and built from there to keep learning how to use this amazing game engine that is Godot.

The pixel art assets are by [Pixel Frog](https://twitter.com/PixelFrogStudio), and you can find them [here](https://pixelfrog-assets.itch.io/pixel-adventure-1). Many thanks to Pixel Frog for these amazing assets!

## Source control

First things first, source control. I'm going to use Git. I know there are fancy plugins for Godot, but other than the initial `.gitattributes` and `.gitignore`, I'd rather deal with the source control myself via the terminal. Call me old-fashioned.

I'll be commiting everything to `main`. Each complete step will be a commit. Main menu? Commit. Initial player? Commit. Simple.

## Project settings

I'll be making a 2D platformer using in _Compatibility_ mode, that is, capable of running in the browser. I'll define the viewport size as 800x600, because I think that'll look just fine.

## General conventions

First, some general conventions:

- First level folders, capitalized.
- Scenes via editor, when static. Via code, when dynamic.
- A main scene, that will never change.

## Setup

I'll start with a main scene, _Game_. Attached to it, there'll be a script that contains the data for the current game, such as the current level and the score.

Then, I'll move to the Main Menu.

## Main menu

I'll start with a background that cover the entire viewport. I won't be manually dragging it, but using transform to input the dimensions.

In the main menu, I want the player to choose which character to use. For that purpose, I've created a _Character_ scene that accepts a `SpriteFrames` via `@export` and sets it to its internal `AnimatedSprite2D`. This allows me to create multiple characters at once to showcase them in the main menu.

I've used some custom logic to allow toggling of a single button in the main menu, and a signal to notify to the main scene, _Game_, that the user is ready to start the game.

The font I've used is [vini's](https://twitter.com/vmenezio) [monogram](https://datagoblin.itch.io/monogram).

## Music

I've decided to use a single track list for the whole game. For that purpose, I've used [Seth_Makes_Sounds](https://freesound.org/people/Seth_Makes_Sounds/) songs, and played them in a loop right under the _Game_ scene.

## HUD

The HUD is very basic, an icon with a number of points. I've created a method to set the points, which effectively just sets the text of the label. Then, I added the HUD directly under _Game_, hidden by default. When starting the game, it is displayed programmatically.

## Level loading

I've created a base _Level_ component. Each individual level will be created via the editor extending this base scene.

The _Game_ script loads the levels dynamically, when needed. The character is also dynamically added to the level.

## Movement

For the movement of the characters in the level, I've extended the _CharacterBody2D: Basic Movement_ template. In terms of behavior, I've added some inertia to the movement, so that running does not feel snappy, and the possibility of jumping within a 150ms. time window right after falling off an edge, for a more satisfying experience.

Architecturally, the most interesting thing about this is I've created a dedicated component, _CharacterMovementInputComponent_ (quite a mouthfull, I know), that accepts a _Character_ as input and handles its position based in the input, and also the animation via an exposed `set_animation` method on said _Character_.

The reason why I've detached this logic from the _Character_ script is that it feels quite isolated and specific, so I wanted it in its own script. And is not part of the _Character_ scene directly, because I'm using _Character_ in situations in which I do not want any input, such as the initial character selection on the main menu. Instead, I instantiate a _CharacterMovementInputComponent_ during the level creation, add it to my _Character_ and configure it.

## State machine

I dived into building a state machine for the character. This is an alternate model to an omniscient controller that completely handles state for the character, and as such, more modular, more extensible and way more complex.

I went all in: a state machine abstract class, a state abstract class and a specific implementation for my _Character_. Possible states were children of a _CharacterStateMachine_ scene, and each state was responsible for handling inputs, invoking methods on an exported `character` variable and transitioning to another states.

Way too complex for such a simple manager, maybe, but it allows extensibility and it is quite clear, once you know what you're doing.

## Traps

For my first trap, a simple fire trap, I decided to use a state machine as well!
