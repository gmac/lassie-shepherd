# Building a player

The "player" FLA files get old and cease to open in Adobe Animate. Periodic rebuilding is necessary, and isn't too difficult given that the player is mostly an empty Flash file. Do the following:

- New black canvas, sized to game:
  - WMYT 900x675
  - Stitch 1024x768 (?)

- Add one MovieClip to the library called "DebuggerText"
  - Linkage specifies a class name of "DebuggerText", base class of "Sprite"
  - Add a dynamic text field within called "outputText"
  - Add an input text field within called "inputText"

- Under publish settings:
  - Select ActionScript 3, and click config button next to it
  - Assign a stage class of "com.lassie.player.LassiePlayer"
  - Select (only) Mac Projector and Win Projector output formats

Publish the document, and drop the built executable into a directory with game "/lib" and "/xml".