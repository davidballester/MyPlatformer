# Principles

Godot allows you to do things in may ways. It is so flexible, that it can feel a bit overwhelming. Should I create scenes using the editor, or via code? Should I have global state or pass local state around? Well, there is no definite answer to any of these questions, but I've decided to stick to a set of commong principles and rules to make things easier for me.

First of all, I advice you to dive into [Godot's offical documentation](https://docs.godotengine.org/en/stable/). It is an amazing resource, definitely worth reading.

Second of all, these are the basic principles I'll be applying to my project:

- **DRY** (_Don't Repeat Yourself_)
- **KISS** (_Keep It Simple, Stupid_)

## Hierarchy

Godot is hierarchical by nature. You have a tree of Nodes. A node in the tree can be a scene, that itself contains other nodes and scenes.

Keeping dependencies tidy will keep the code organized, maintainable and extensible. Because of that, I'll follow some simple rules:

- **Parents know about their children.** They can set properties or call methods on them.
- **Children do not know about their parents.** If they need to communicate something, a button being pressed, for example, they'll emit a signal, and it'll be the responsibility of the parent to react to that signal.

## Conventions

- Lower case folder names.
- A dedicated folder for assets.
- Scripts next to their scenes, with the same name.
