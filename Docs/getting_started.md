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

## Music

I've decided to use a single track list for the whole game. For that purpose, I've used [Seth_Makes_Sounds](https://freesound.org/people/Seth_Makes_Sounds/) songs, and played them in a loop right under the _Game_ scene.
