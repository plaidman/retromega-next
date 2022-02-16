# Retro Mega Next
[Pegasus](https://pegasus-frontend.org) theme for the Retroid Pocket 2/2+.

Adapted from [David Fumberger's RetroMega](https://github.com/djfumberger/retromega) theme. Completely rewritten from scratch to simplify code and allow me to add new features easier.

## Installation
[Download](https://github.com/plaidman/retromega/archive/main.zip) and extract to your [theme directory](http://pegasus-frontend.org/docs/user-guide/installing-themes) under the folder retromega. You can then select the theme in the settings menu of Pegasus.

The theme uses `boxart2dfront` on the games list, and `screenshot` in the game detail view.

To get Pegasus setup on your Retroid Pocket 2/2+ there's a great written guide [available here](https://basvroegop.nl/pegasus) or a great video guide [available here](https://www.youtube.com/watch?v=fGWve7YYwGQ). You can also use [DragoonDorise's pegasus installer](https://www.pegasus-installer.com/) to scrape files on your device easier.

## Features
- optimised for handheld devices with small screens
- rewritten code from scratch
- controller support
- touch support
- random game selection
- 24/12 hour clock (tap the clock to switch)
- background music and navigation sounds

## Adding New Systems
- add controller files into `/assets/images/devices/shortname.png`
- add new colors and companies into `/components/resources/SystemData.qml`

## Adding Background Music
- add .mp3 files into `/asssets/music/whatever.mp3`
- follow the instructions [on lines 10-12](https://github.com/plaidman/retromega-next/blob/master/components/resources/Music.qml#L23-L25) to register the music files in `/components/resources/Music.qml`

## Planned Updates
- options panel toggles
    - 12/24 hour
    - dark mode
    - nav sounds
    - bg music
- continuing to implement missed features from rewrite
    - game details screen
    - favorites filter
    - search by name
    - sorting games list
- zoomed out system view
- dark mode support

## Version History
### Next -
- added support for other handhelds (e.g. Odin, RG552)
    - new scaling code to make icons look better in all resolutions
    - fonts, images, and spacing scale to screen resolution
- improve boxart rendering code
    - more natural DropShadow instad of a hacky shadow.png file
    - more straightforward scaling logic
    - images that fail to load will fail more gracefully
    - very tall images will no longer affect other elements on the page
- new systems
    - pico-8
    - lynx
    - ports
- settings screen
    - 24/12 hour clock
    - dark mode
    - navigation sounds
    - background music
- general code improvements and cleanup

### Next - Jan 26th
- rewrote all views and functionality from scratch
    - break up folder structure and code to make it easier to edit
    - greatly simplified the view logic in collection list and especially game list
    - deleted unused assets and inert code
    - organized external resource files (collections and music) for easy editing
    - consolidated input code to clean up any potential double-presses
- new features
    - random game selection
    - touch support
    - background music
    - added ps2, wii collections and artwork
    - touched up wswan, arcade, android, gc, nds, vboy artwork
- bug fixes
    - fixed black screen when cancelling multi-file select or if game launch fails
    - fixed back and forward sound effects not properly playing
    - fixed title screen dropshadow overlapping 'g' and 'y' letters
    - fixed miscolored favorite icon when game is highlighted
    - fixed a layout bug when you un-favorite a game while on the favorites list
    - removed pokemini and wswancolor for now until I can find better art

### Next - Jan 15th
- updated arcade controller
- added android controller
- improved the clock widget
    - tap to toggle 24/12 hour
    - updates time correctly

### Next - Jan 12th
- added many new controller images
- started bg music support

## License

[![CC-BY-NC-SA](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)
