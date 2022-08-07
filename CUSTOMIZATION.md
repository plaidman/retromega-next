# Customization and Manual Edits

## Adding New Systems
- see [DEVICES.md](DEVICES.md)

---

## Adding Background Music
- add .mp3 files into `/asssets/music/whatever.mp3`
- follow the instructions in `/components/resources/Music.qml` [on these lines](https://github.com/plaidman/retromega-next/blob/main/components/resources/Music.qml#L11-L13) to register the music files

---

## Removing Last Played and/or Favorites Collections
- remove [these lines](https://github.com/plaidman/retromega-next/blob/main/theme.qml#L140-L141) from `/theme.qml`

 ----

## Customizing Details Screen
- you can remove certain items from the game metadata section
- `/components/gameDetails/GameMetadata.qml` has [an array](https://github.com/plaidman/retromega-next/blob/main/components/gameDetails/GameMetadata.qml#L21-L25) where you can remove or reorder any items that you don't care to see

---

## Customizing Game List Metadata
- `/components/gameList/GameScroll.qml` has [some logic](https://github.com/plaidman/retromega-next/blob/main/components/gameList/GameScroll.qml#L21-L32) to decide what to show, depending on which sorting option you're using
- you can change this to

---

## Customizing Theme & Button Guides

- the files in `components/themes/` can be updated to change colors of elements for themes, or button labels if you use some other format of buttons on your controller.
