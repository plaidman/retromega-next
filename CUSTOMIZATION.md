# Customization and Manual Edits

## Adding New Systems
- add controller files into `/assets/images/devices/shortname.png`
- add new metadata into `/components/resources/CollectionData.qml`
- both of these steps are optional, you will be able to play any system without them

## Adding Background Music
- add .mp3 files into `/asssets/music/whatever.mp3`
- follow the instructions in `/components/resources/Music.qml` [on lines 10-12](https://github.com/plaidman/retromega-next/blob/acf48548ad30fec9dd0308c7847fa1af1fead77d/components/resources/Music.qml#L10-L12) to register the music files

## Removing Last Played and Favorites Collections
- remove [these lines](https://github.com/plaidman/retromega-next/blob/acf48548ad30fec9dd0308c7847fa1af1fead77d/theme.qml#L120-L121) from `/theme.qml`
