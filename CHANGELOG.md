# Planned Features
- slightly delayed images for better performance
- improve game selection
    - games with long names
    - games with multiple files
- additional settings
    - carousel loop
    - game list loop
- "zoomed out" collection view
- add sort-related game data to game list below the game image

# Changes
## Next- Jun XXth
- new sorting option to sort by favorites
- setting to have favorites on top regardless of sorting option
- general system stability improvements to enhance the user's experience

## Next - May 29th
- attract mode
    - shows random videos which you can cycle through
    - start the shown game by pressing A
    - optionally show the game's title during the video
- general system stability improvements to enhance the user's experience

## Next - May 24th
- button to quickly scroll to the beginning and end of collection screen
- add name filter indicator in header
- setting to reset name filter when pegasus reopens
- fix for really small buttons on game detail screen
- general system stability improvements to enhance the user's experience

## Next - May 23rd
- new settings filters
    - filter games by title
    - filter games by multiplayer
    - recent games filter improvements
- add number of players to game details
- bug fixes
    - recent played games list showing random games
    - videos not resetting properly
- general system stability improvements to enhance the user's experience

## Next - Apr 28th
- game sorting screen
    - sort any collection by last played, release date, rating, title
    - toggle between ascending or descending
    - filter games by favorites
    - current sorting is displayed on collection and game list
- new data on game details page
    - added last played time and game rating
    - dynamic spacing if there are many things shown
    - hide 'more' button if there is no description
- bug fixes
    - small bug when picking a random game
    - improved navigation sounds
    - quicker changing settings with one tap
- general system stability improvements to enhance the user's experience

## Next - Apr 1st
- system year on collection list
- game details screen
    - show screenshot/video
    - buttons to start game and toggle favorite
    - long description view with touch scrolling
    - fixed a short-description rendering problem
- new settings
    - mute video
    - reduce the video delay
    - toggle video/image dropshadow
- bug fixes
    - loading collection images without metadata
    - made dropshadow optional for better performance and fix some display issues
    - system name in game list was cut off too short
- general system stability improvements to enhance the user's experience


## Next - Feb 28th
- new settings
    - small font for better experience on larger screens
    - video playback on game list
- more ways to return from the settings screen
    - X button
    - tap the settings icon
- bug fixes
    - silence navigation sound if the game selection doesn't move when pressing up or down
- general system stability improvements to enhance the user's experience

## Next - Feb 23rd
- improved compatibility with different shortnames for collections
    - compatible with pegasus standard
    - compatible with es standard
    - compatible with any other weird aliases I could think of

## Next - Feb 20th
- added support for other handhelds (e.g. Odin, RG552)
    - new scaling code to make icons look better in all resolutions
    - fonts, images, and spacing scale to screen resolution
- improve boxart rendering code
    - more natural generated DropShadow layer instad of an image file
    - more straightforward scaling logic
    - images that fail to load will fail more gracefully
    - very tall images will no longer affect other elements on the page
- new systems
    - pico-8
    - lynx
    - ports
    - atomiswave
- settings screen
    - 24/12 hour clock
    - dark mode
    - navigation sounds
    - background music
- added dark mode support to all existing screens
- general system stability improvements to enhance the user's experience

## Next - Jan 26th
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
- general system stability improvements to enhance the user's experience

## Next - Jan 15th
- updated arcade controller
- added android controller
- improved the clock widget
    - tap to toggle 24/12 hour
    - updates time correctly

## Next - Jan 12th
- added many new controller images
- started bg music support
