# Retro Mega Next
[Pegasus](https://pegasus-frontend.org) theme for the Retroid Pocket 2/2+.

Adapted from [David Fumberger's RetroMega](https://github.com/djfumberger/retromega) theme. Completely rewritten from scratch to simplify code and allow me to add new features easier.

## Installation and Scraping
[Download](https://github.com/plaidman/retromega/archive/main.zip) and extract to your [theme directory](http://pegasus-frontend.org/docs/user-guide/installing-themes) under the folder retromega. You can then select the theme in the settings menu of Pegasus.

The theme uses `boxart2dfront` on the games list, and `screenshot` in the game detail view.

To get Pegasus setup on your Retroid Pocket 2/2+ there's a great written guide [available here](https://basvroegop.nl/pegasus) or a great video guide [available here](https://www.youtube.com/watch?v=fGWve7YYwGQ). You can also use [DragoonDorise's pegasus installer](https://www.pegasus-installer.com/) to scrape files on your device easier.

## Features
- optimized for handheld devices with small screens
- rewritten code from scratch
- controller support
- touch support
- random game selection
- 24/12 hour clock (tap the clock to switch)
- background music and navigation sounds
- settings screen
- dark mode

## Controls
[controls](CONTROLS.md)

## Adding New Systems
- add controller files into `/assets/images/devices/shortname.png`
- add new colors and companies into `/components/resources/SystemData.qml`

## Adding Background Music
- add .mp3 files into `/asssets/music/whatever.mp3`
- follow the instructions [on lines 10-12](https://github.com/plaidman/retromega-next/blob/master/components/resources/Music.qml#L23-L25) to register the music files in `/components/resources/Music.qml`

## Version History and Planned Features
[changelog](CHANGELOG.md)

## Credits
- original theme: [DJFumberger](https://github.com/djfumberger/retromega)
- improvements: plaidman

## License
[![CC-BY-NC-SA](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

## Screenshots
---
![collection list 4:3](.meta/screenshots/genesis43.png)
---
![dark mode 4:3](.meta/screenshots/dark43.png)
---
![game list 4:3](.meta/screenshots/light43.png)
---
![collection list 6:9](.meta/screenshots/snes169.png)
---
![dark mode 6:9](.meta/screenshots/dark169.png)
---
![game list 6:9](.meta/screenshots/light169.png)
