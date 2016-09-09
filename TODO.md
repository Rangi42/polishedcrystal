## Use or remove

* Use EMOTE_QUESTION, EMOTE_HAPPY, EMOTE_SAD, and EMOTE_SLEEP somewhere


## Bugs

* Nuzlocke mode sometimes turns on by itself
* Move Reminder doesn't list all possible moves
* Thief permanently steals held items
* TMs refresh PP
* Headbutt overworld animation looks weird (wrong tile ID?)
* Protect prints (sometimes?) "X is protecting itself! Y's attack missed!"
* Dig sometimes prints that both Pokémon dug a hole
* Per-turn status animations might not always work
* Some trainers use X Spcl. Atk (seems to involve their second item slot, e.g. Lance's Full Restore)
* Thick Club + Swords Dance Marowak Attack overflow (only in link battles?)
* Pokémon overuse Baton Pass (still?)
* Sleep lasts [2–4 turns](https://github.com/roukaour/pokecrystal/commit/252817539482c1fc3fe8dd24c484a74234a0b89a#commitcomment-18349313) (still?)
* Delay before last text box when Wonder Trading (still?)


## Battle mechanics

* http://smogon.site/forums/threads/gsc-mechanics.3542417/
* Gen III critical hit mechanics (ignore -Atk and +Def stat changes, don't ignore burn)
* Defrosted Pokémon can attack on that turn (like waking up)
* Substitute does not block sound-based moves
* Substitute prevents building Rage
* Drain Kiss drains 75% HP
* Avalanche doubles damage if user is hit first (description claims it does this already)
* Hurricane cannot miss in rain (ignores accuracy and evasion)
* Blizzard cannot miss in hail (ignores accuracy and evasion)
* Thunder ignores accuracy and evasion in rain (not just 100% accuracy)
* Low Kick's power is based on weight
* Grass-type Pokémon are immune to PoisonPowder, Stun Spore, Sleep Powder, and Spore
* Ghost-type Pokémon are immune to the trapping effects of Mean Look, Clamp, Fire Spin, Whirlpool, and Wrap
* Rock Smash breaks screens instead of lowering Defense (like Brick Break) (non-Faithful)


## Other mechanics

* Catch rate formula from Gen III
* Show stat changes and then absolute values on level up
* Healing items activate at 1/3 HP, not 1/2 (edit HandleHPHealingItem)
* Select reorders Pokémon in party menu
* Send gift Pokémon to the PC if the party is full
* More frequently successful Headbutting
* More likely to find roaming Pokémon when on the correct route
* Give female trainers better DVs, and use the new unique DVs feature to make certain Pokémon female
* Add OT genders to Wonder Trade


## Aesthetic updates

* Animate new Pokémon sprites (Sylveon, Pikachu, etc)
* Design custom animations for new moves
* Show Pokémon portraits when using field moves (refer to TPPAC)
* Color party and day-care sprites by species
* Support nicknames for NPC trainers' Pokémon
* Yellow Pikachu Surfing music
* Big roofs like Pewter Museum on Silph Co. and Pokémon Tower?
* Goldenrod Dept. Store and Celadon Mansion roofs should have dark sky at night
* Add umbrellas to Olivine City benches
* Add boats to Goldenrod Harbor
* Merge gray and roof colors on Faraway Island to make room for grass-green
* Edit SPRITE_DRAGON with Dragonite's side view
* Factor SPRITE_BIRD into Farfetch'd, Pidgey, and Pidgeot
* Make overworld sprites darker at night?
* Briefly beep to warn of low HP
* Custom overworld sprites for Rocket Executives


## New content

* Larger Kanto maps, like in RBY (particularly the routes to and below Fuchsia City)
* Elite Four have different rematch dialog
* Use Mmmmmm's B/W Route 12 music for a new location
* Use White Treehollow music somewhere if possible
* Use some of Soloo93's HG/SS Gym Leader [sprite devamps](https://hax.iimarck.us/post/36679/#p36679)?
* Add wild Pokémon to Navel Rock?
* Battle with Giovanni either in Radio Tower or with Celebi time traveling
* Battle Caitlin and Darach somewhere, possibly around the Battle Tower (reward: ?)
* Battle [En and Madoka](http://bulbapedia.bulbagarden.net/wiki/The_Legendary_Rotation_Battle!) somewhere (Mt. Quena, after completing the Pokédex?)
* Battle with Veteran/Hacker Rangi in Celadon Mansion basement once a day?
* Add some of {Drill Run, Sucker Punch}?


## New features

* Fourth stat screen showing Poké Seer's data (refer to TPPAC)
* Restore [unused memory game](http://iimarck.us/i/memory/) ([more info](https://tcrf.net/Pok%C3%A9mon_Gold_and_Silver#Unused_Memory_Game))
* Restore the Safari Game (some functionality, like HandleSafariAngerEatingStatus, already exists)
* Add [Sweet Honey trees](http://iimarck.us/i/sweet-honey/) for Munchlax (replace Sweet Scent)
* Pickup ability for Meowth, Teddiursa, and/or Phanpy
* Use the News Machine for something (Mystery Gift?)
* Separate radio channels for March and Lullaby, available every day
* More Bag pockets (split Items into Items, Medicine, and Berries)
* Press Start to auto-sort items
* Longer player and rival names
* Sometimes wild Pokémon know an egg move
* Use a proper menu for resurrecting Fossils
