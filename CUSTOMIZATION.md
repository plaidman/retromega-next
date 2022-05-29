# Customization and Manual Edits

## Adding New Systems
- add controller files into `/assets/images/devices/shortname.png`
- add new metadata into `/components/resources/CollectionData.qml`
- both of these steps are optional, you will be able to play any system without them

## Adding Background Music
- add .mp3 files into `/asssets/music/whatever.mp3`
- follow the instructions in `/components/resources/Music.qml` [on lines 10-12](https://github.com/plaidman/retromega-next/blob/24may2022/components/resources/Music.qml#L10-L12) to register the music files

## Removing Last Played and Favorites Collections
- remove [these lines](https://github.com/plaidman/retromega-next/blob/24may2022/theme.qml#L127-L128) from `/theme.qml`

## Customizing Details Screen
- you can remove certain items from the game metadata section
- [here is an array](https://github.com/plaidman/retromega-next/blob/24may2022/components/gameDetails/GameMetadata.qml#L86) where you can remove any items that you don't care to see
