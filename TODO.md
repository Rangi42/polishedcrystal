## Missing content

The final, non-beta 3.0 release should include all of these.


### General

* Search for "TODO" in the code and finish it
* Fix bugs, including everything on the [Issues](/issues)
* Give NPCs better teams, using the new held items
* Trim egg moves to just leave the possible ones
* Adjust the difficulty curve as needed


### Mechanics

* Generate Battle Tower Pokémon
* Generate random team for Psychic Inver
* Wild Ghosts and the SilphScope2
* More location-unique wild moves (see [material/moves.txt](material/moves.txt))
* Finish wild rosters
* DVs to vary palettes for trainers' duplicate Pokémon (e.g. Clair's Dragonairs)


### Aesthetics

* Draw Kukui's overworld sprite
* Animation frames of Magikarp variants need their patterns
* Play a shiny flash when Pokémon are caught (from Prism)


### Events

* Bulldoze move tutor in Mt. Mortar (move the Defense Curl tutor elsewhere)
* Venoshock and Skill Swap tutors
* Soul House + Radio Tower event to get Expn Card (see [tentative dialog](https://docs.google.com/document/d/1_IDuWAP-QBRC5l4grKZKKlfWKQ2BjC2Yo0aynmli1Ac/view))
* Saffron Trainer Fan Club, where meeting certain conditions turns NPCs into you fan, whereupon they give you items (see [material/trainer-fan-club.txt](material/trainer-fan-club.txt))
* Rematch Eusine and Bill somehow
* Calling Lyra should have more varied messages (see [material/lyra-dialog.txt](material/lyra-dialog.txt))

Shamouti Island:

* Caitlin and Darach in Beautiful Beach villa (EVENT_BEAT_DARACH and EVENT_BEAT_CAITLIN)
* Looker in hotel room (not S.S. Aqua)


### Maps

Maps need signs, NPCs, trainers (with [dialog](https://docs.google.com/document/d/1_IDuWAP-QBRC5l4grKZKKlfWKQ2BjC2Yo0aynmli1Ac/view) (see also [material/pia-dialogue.txt](material/pia-dialogue.txt) and [material/pokeathlon-dialog.txt](material/pokeathlon-dialog.txt))), visible and hidden items, wild Pokémon, and unique wild moves.

* Soul House
* Lavender Radio Tower
* Saffron City Trainer Fan Club
* Valencia Island (signs and NPCs)
* Route 49 (wild Pokémon and unique wild moves)
* Safari Zone rest houses (NPCs and maybe trainers)

Shamouti Island:

* Shamouti Island
* Shamouti Hotel (haunted room) (EVENT_SAW_HAUNTED_ROOM)
* Shamouti Restaurant (works like Seven Stars Restaurant) (different subset of all trainers every day of the week)


### Move effects

* Low Kick's power is based on weight
* Body Slam does double damage against Minimize
* Stomp and Body Slam never miss against Minimize
* Destiny Bond's success chance halves every successive turn it's used (Gen VII)
* Ghost-type Pokémon are immune to the trapping effects of Mean Look, Clamp, Fire Spin, Whirlpool, and Wrap
* Rock Smash breaks screens instead of lowering Defense (like Brick Break) (non-Faithful)


### Move animations

Refer to [B/W animations with sound effects](https://www.youtube.com/watch?v=TFDV0HeBz_0).

High priority:

* Aqua Jet
* Giga Impact
* Skill Swap
* Stone Edge
* Sucker Punch
* U-turn
* Water Pulse

Low priority:

* Aerial Ace
* Aqua Tail
* Bulldoze
* Close Combat
* DazzlinGleam
* Disarm Voice
* Earth Power
* Extrasensory
* Facade
* Gunk Shot
* Hex
* Roost
* Toxic Spikes
* Venoshock
* Volt Switch


### Music player

* Fix the piano roll graphics "leaking" into the song list
* Use the UnlockedMusic flag_array to hide unheard song titles


### Optimizations

* Finish and merge the optimizations branch
* LZ-compress maps' .blk files, tilesets' metatiles and collision data, and various tilemaps
* Optimize battle command engine, including parameterized commands
* SIGNPOST_JUMPTEXT
* SIGNPOST_JUMPSTD (for picturebookshelf, difficultbookshelf, radio1, radio2, elevatorbutton, and teamrocketoath)
* PERSONTYPE_JUMPTEXTFP
* PERSONTYPE_JUMPSTD (for cuttree, smashrock, strengthboulder, pokecenternurse, gamecornercoinvendor, and happinesschecknpc)
* PERSONTYPE_ITEMBALL (no script needed)
* PERSONTYPE_TMHMBALL (no script needed)
* PERSONTYPE_MART
* PERSONTYPE_FRUITTREE
* PERSONTYPE_GENERICTRAINER
* PERSONTYPE_POKEMON (script pointer → text pointer, sight range → cry species)
* PERSONTYPE_TRADE (script pointer → trade ID)


## Postponed until 4.0

Some of these may never be added; they're just suggestions.

* Port pokecrystal changes since commit 7aef59841489ea449b9a34d424c681a4b48b88ab
* Alolan forms (update GetBaseData and everything that refers to EvosAttacksPointers)
   * Persian as a one-time trade from an Alolan tourist (you can breed it for more)
   * Rattata/Raticate in Kanto
   * Grimer/Muk in Goldenrod City (Celadon's Muk are a sign of its pollution, Goldenrod's Alolan Muk would be a sign that they manage pollution better)
   * Sandshrew/Sandslash and Vulpix/Ninetales in the Ice Path and/or Seafoam Islands
   * Diglett/Dugtrio on Cinnabar Island (right now I replaced all Diglett with the Alolan ones, with the explanation that the volcano affected climate everywhere, but I'd rather have the ones in Diglett's Cave be normal)
   * Geodude/Graveler/Golem in Rock Tunnel (the Lodestone there is already used to evolve Magnezone)
   * Marowak, Exeggutor, and Raichu evolve while holding the Odd Souvenir (bought on Shamouti Island)
* More Pokémon
   * Rewrite Eggs to use the IsEgg bitflag instead of $fe
   * Rewrite Bill's PC to not use $ff as a terminator
   * Rewrite everything to use two-byte IDs, allowing 65,534 Pokémon
   * Restore Shuckle as the Cianwood guy's Pokémon
   * Restore Stantler as a Normal/Psychic type, and make Girafarig Psychic/Dark
   * Add all the new babies and evolutions of Gen 1 and 2 Pokémon
      * Lickilicky
      * Ambipom
      * Azurill
      * Wynaut
      * Happiny
      * Bonsly
      * Mantyke
   * Add Gen 3 and 4 Pokémon from [Hoenn Sound](https://bulbapedia.bulbagarden.net/wiki/Hoenn_Sound#Hoenn_Sound) and [Sinnoh Sound](https://bulbapedia.bulbagarden.net/wiki/Hoenn_Sound#Sinnoh_Sound)
      * Zigzagoon → Linoone
      * Whismur → Loudred → Exploud
      * Makuhita → Hariyama
      * Plusle and Minun
      * Numel → Camerupt
      * Spoink → Grumpig
      * Spinda (with spotted forms from Pokémon Orange)
      * Absol
      * Meditite → Medicham
      * Bidoof → Bibarel
      * Shinx → Luxio → Luxray (retype to Electric/Dark)
      * Budew → Roselia → Roserade
      * Buizel → Floatzel
      * Chingling → Chimecho
      * Bronzor → Bronzong
      * Chatot
      * Carnivine
   * Add some Gen 3 and 4 legendaries in appropriate places; tentative ideas:
      * Regirock, Regice, and Registeel in new ruins like in Platinum
      * Regigigas in Mt. Silver after you catch the three Regis
      * Latios and Latias on Southern Island via the Eon Ticket
      * Groudon, Kyogre, and Rayquaza in the Embedded Tower
      * Deoxys in the crater on Route 3
      * Jirachi in some event involving a demixed [Per Aspera Ad Astra](https://www.youtube.com/watch?v=TJYiwDoCgd0)
      * Uxie, Mesprit, and Azelf in the Nameless Cavern near Lake of Rage
      * Dialga, Palkia, and Giratina in the Sinjoh Ruins
      * Cresselia in Red's bedroom
      * Darkrai in Blue's bedroom
      * Heatran?
      * Phione from an Egg given by Wallace
      * Victini on a cruise to Liberty Garden
      * Magearna in the Ruins of Alph
   * Add certain other Gen 3 and 4 Pokémon; Prism's dex is similar to my own taste
      * Ralts → Kirlia → Gardevoir / Gallade
      * Surskit → Masquerain (buff and retype to Bug/Water with Levitate)
      * Mawile and Sableye
      * Aron → Lairon → Aggron
      * Torkoal
      * Lunatone and Solrock
      * Feebas → Milotic
      * Snorunt → Glalie / Froslass
      * Relicanth
      * Bagon → Shelgon → Salamence
      * Beldum → Metang → Metagross
      * Spiritomb
      * Riolu → Lucario
      * Rotom (switch forms in Silph Co.)
      * Sigilyph in the Ruins of Alph grass
      * Litwick → Lampent → Chandelure
      * Pawniard → Bisharp
      * Skiddo → Gogoat
      * Mareanie → Toxapek (in Cherrygrove Bay with Corsola)
* More music
   * R/S/E Route 119
   * R/S/E Route 120
   * S/M Malie City (Day) (for Shamouti Shrine)
* More Orange Islands
* First Pokémon walks behind you ([comet's prototype](https://hax.iimarck.us/topic/6248/) and [diff](https://github.com/yenatch/pokecrystal/commit/dbc5cd2025a0214c5b2cd1e3330f50603a0bb9d1))
* 60 FPS via [doublespeed](https://github.com/FredrIQ/polishedcrystal/tree/doublespeed) mode
* Evening (intervals: morn 4–11, day 11–6, eve 6–9, nite 9–4)
* Seasons with appropriate day/night lengths from B/W (affects palettes, tiles, wild Pokémon, dialog, accessible areas, etc)
* Dive areas
* Rock Climb areas
* Battle Factory
* Medals for achievements
* Something like Habitat Lists or DexNav via the Town Map
* Something like Poké Radar or Pokéwalker
* Rarely wild Pokémon know an egg move (could be a bonus for DexNav or Poké Radar use)
* Restore [unused memory game](http://iimarck.us/i/memory/) ([more info](https://tcrf.net/Pok%C3%A9mon_Gold_and_Silver#Unused_Memory_Game))
* Restore the Safari Game (some functionality, like HandleSafariAngerEatingStatus, already exists)
* Restore the Pikachu's beach minigame
* Add [Sweet Honey trees](http://iimarck.us/i/sweet-honey/) for Munchlax (replace Sweet Scent)
* Level ranges for wild Pokémon, instead of single values
* Optional scaled experience formula from Gen V and Gen VII (port from [pokecrystal-speedchoice](https://github.com/Dabomstew/pokecrystal-speedchoice))
* Use the News Machine for something (Mystery Gift?)
* Championship title defense like in Gen VII (challengers: rival, Lyra, Lance, Prof.Oak, Prof.Elm, Clair, Blue, Eusine, Kimono Girl Naoko, Palmer, Lorelei, Agatha, Steven, Cynthia, Caitlin, and Lawrence)
* Phone uses a bitfield to allow storing all numbers
* Make more trainers rematchable
* Variety Channel with daily unique music
* Separate radio channels for March and Lullaby, available every day
* Ambient wild Pokémon cries from Gen III (see pokeruby and pokeemerald)
   * Ruby [sub_8054164](https://github.com/pret/pokeruby/blob/master/src/rom4.c#L937), Emerald [sub_8085B2C](https://github.com/pret/pokeemerald/blob/master/asm/rom4.s#L2662): picks the random wild Pokémon (called on map initialization and every step), stored in gUnknown_02029814
   * Ruby [sub_8054050](https://github.com/pret/pokeruby/blob/master/src/rom4.c#L893): plays the cry of gUnknown_02029814 if on a non-water encounter tile at volume 50–80 instead of the usual 125
   * Ruby [sub_80540D0](https://github.com/pret/pokeruby/blob/master/src/rom4.c#L906): might randomly play the cry (run with time-based events)
   * Emerald [wild_encounter_related](https://github.com/pret/pokeemerald/blob/master/asm/rom4.s#L2544): raises call probability for Swarm ability
* Either add a 510 EV limit, or replace the 6 Power items with more useful Berries
* Catch rate formula from Gen III
* Show move stats when overwriting one
* Show stat changes and then absolute values on level up
* Port critical captures from Prism
* Allow evolution during battle
* Itemfinder makes you face towards the item
* Itemfinder beeps N times for an item N steps away
* Send gift Pokémon to the PC if the party is full
* Kurt gives Balls right away once per day
* Replace the Apricorns with an Apricorn Box and add more Berries
* Add the improved PRNG from Prism
* Hidden Power Guru says your lead Pokémon's Hidden Power type (wife of the Stats Judge?)
* Evolution Guru says how your lead Pokémon can evolve
* Battle [En and Madoka](http://bulbapedia.bulbagarden.net/wiki/The_Legendary_Rotation_Battle!) somewhere (Trainer House after catching the legendary trios, different trainer each day?)
* Get better Wonder Trade items at higher levels
* Press Start to auto-sort items in Bag
* Select reorders Pokémon in party menu
* Use Mart interface for selling decorations, with a red sidebar
* Add separate throwing animation graphics for more Poké Ball designs
* Play Pokémon cry+animation when they escape a Poké Ball (from Prism)
* Make Eggs use their Pokémon's palette
* Use RBY's Surf and Bike themes in Kanto
* Add umbrellas to Olivine City benches

There are some features that I do *not* ever plan to add to Polished Crystal:

* All 802 Pokémon
* A third region with badges
* Mega Evolution
* Z-moves
* Ash-Greninja
* Ash Ketchum
* Gen VI Exp. Share
