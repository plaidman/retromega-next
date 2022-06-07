# Customization and Manual Edits

## Adding New Systems
- add controller files into `/assets/images/devices/shortname.png`
- add new metadata into `/components/resources/CollectionData.qml`
- both of these steps are optional, you will be able to play any system without them
- `CollectionData.qml` notes
    - color: background color for the collection page
    - vendor: name of the manufacturer
    - year: years of production
    - image: which image to use
        - useful if multiple collections share an image, like sega32x/segacd
    - alias: defines alternate shortnames for systems
        - useful if a collection can be known by multiple shortnames, like dc/dreamcast
- I've supplied alternate collection image packages
    - place the .png files in `/assets/images/devices/`
    - this includes alternate qml files that are better suited to each set of images
        - replace `/components/resources/CollectionData.qml`
        - and `/components/collectionList/CollectionItem.qml`
    - the `*-alt.zip` files include extra images if you're looking for some alternate options

---

## Adding Background Music
- add .mp3 files into `/asssets/music/whatever.mp3`
- follow the instructions in `/components/resources/Music.qml` [on lines 10-12](https://github.com/plaidman/retromega-next/blob/24may2022/components/resources/Music.qml#L10-L12) to register the music files

---

## Removing Last Played and/or Favorites Collections
- remove [these lines](https://github.com/plaidman/retromega-next/blob/24may2022/theme.qml#L127-L128) from `/theme.qml`

 ----

## Customizing Details Screen
- you can remove certain items from the game metadata section
- [here is an array](https://github.com/plaidman/retromega-next/blob/24may2022/components/gameDetails/GameMetadata.qml#L86) where you can remove or reorder any items that you don't care to see

---

## Customizing Game List Metadata
- [here is the logic](https://github.com/plaidman/retromega-next/blob/main/components/gameList/GameScroll.qml#L19-L32) to decide what to show
- you can adjust the logic to only show one item no matter what sort is being used
