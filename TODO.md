## Bugs

See the [Issues](issues/) page.


## Mechanics

* Generate Battle Tower Pokémon
* Update breeding with the new data structure (engine/breeding/egg.asm and event/daycare.asm)
* Wild Ghosts and the SilphScope2
* More location-unique wild moves
* DVs to vary palettes for trainers' duplicate Pokémon (e.g. Clair's Dragonairs)


## Aesthetics

* Add separate throwing animation graphics for more Poké Ball designs
* Play Pokémon cry+animation when they escape a Poké Ball, and shiny flash when they're caught
* Make Eggs use their Pokémon's palette
* Animate item activations like Quick Claw
* Use a side view for Falkner's Pidgeotto in Dark Cave


## Events

* Soul House + Radio Tower event to get Expn Card
* Battle Tower merchants selling items for BP


## Characters

* Inver in Route 16 house
* Pay Day tutor in Goldenrod Game Corner
* Man in Silver Cave Pokémon Center gives Expert Belt for reading all the Journals
* Silph Co. mart
* Battle Elm to get S.S. Ticket
* Rematch Eusine and Bill somehow
* Battle Ivy on Valencia Island

Shamouti Island:

* Caitlin and Darach in Beautiful Beach villa
* Body Slam tutor in Warm Beach house
* Trendy phrase guy in hotel lobby
* Looker in hotel room (not S.S. Aqua)
* Sightseer in hotel mentions that Bottle Caps can be used for Hyper Training in Alola


## Maps

Maps need NPCs, trainers (with [dialog](https://docs.google.com/document/d/1_IDuWAP-QBRC5l4grKZKKlfWKQ2BjC2Yo0aynmli1Ac/view)), visible and hidden items, wild Pokémon, and unique wild moves.

* Soul House
* Lavender Radio Tower
* Saffron City Trainer Fan Club
* Valencia Island
* Route 49

Shamouti Island:

* Shamouti Island (outdoor market instead of Mart)
* Shamouti Hotel (haunted room)
* Shamouti Restaurant (works like Seven Stars Restaurant)

Route leaders:

* Route 37: Ace Trainer♀, gives Binding Band
* Route 39: Cowgirl, gives PP Max
* Lighthouse: Battle Girl, gives protect Pads
* Route 43: Ace Trainer♀, gives Flame Orb
* Route 44: Veteran♂, gives Rocky Helmet
* Route 46: Dragon Tamer, gives Focus Sash


## Abilities

Out-of-battle effects:

* Static
* Suction Cups
* Intimidate
* Synchronize (wild Pokémon done, gift Pokémon not yet done)
* Lightning Rod
* Magnet Pull
* Pressure
* Keen Eye
* Hustle
* Cute Charm
* Sticky Hold
* Vital Spirit

## Items

In-battle effects:

* Figy Berry (activate at 25% HP, not 50%)
* {Liechi, Ganlon, Salac, Petaya, Apicot} Berry

Out-of-battle effects:

* Ability Cap(sule)
* Destiny Knot
* Oval Charm
* Figy Berry
* {Liechi, Ganlon, Salac, Petaya, Apicot} Berry


## Move effects

* Low Kick's power is based on weight
* Body Slam does double damage against Minimize
* Stomp and Body Slam never miss against Minimize
* Destiny Bond's success chance halves every successive turn it's used (Gen VII)
* Ghost-type Pokémon are immune to the trapping effects of Mean Look, Clamp, Fire Spin, Whirlpool, and Wrap
* Rock Smash breaks screens instead of lowering Defense (like Brick Break) (non-Faithful)


## Move animations

Refer to [B/W animations with sound effects](https://www.youtube.com/watch?v=TFDV0HeBz_0).

* Aerial Ace
* Aqua Tail
* Avalanche
* DazzlinGleam
* Disarm Voice
* Earth Power
* Extrasensory
* Facade
* Giga Impact
* Gunk Shot
* Hex
* Hone Claws
* Ice Shard
* Icicle Crash
* Icicle Spear
* Metal Sound
* Scald
* Stone Edge
* Sucker Punch
* U-turn
* Volt Switch
* Water Pulse


## Post-3.0

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
   * Nidoran♂ and Nidoran♀ as separate forms, freeing up another slot
* More Pokémon
   * Rewrite Eggs to use the IsEgg bitflag instead of $fe
   * Rewrite Bill's PC to not use $ff as a terminator
   * Rewrite everything to use two-byte IDs, allowing 65,534 Pokémon
   * Restore Shuckle as the Cianwood guy's Pokémon
   * Restore Stantler as a Normal/Psychic type, and make Girafarig Psychic/Dark
* More music
   * R/S/E Route 119
   * R/S/E Route 120
   * S/M Malie City (Day) (for Shamouti Shrine)
* First Pokémon walks behind you ([comet's prototype](https://hax.iimarck.us/topic/6248/) and [diff](https://github.com/yenatch/pokecrystal/commit/dbc5cd2025a0214c5b2cd1e3330f50603a0bb9d1))
* 60 FPS via [doublespeed](https://github.com/FredrIQ/polishedcrystal/tree/doublespeed) mode
* Evening (intervals: morn 4–11, day 11–6, eve 6–9, nite 9–4)
* Seasons with appropriate day/night lengths from B/W (affects palettes, tiles, wild Pokémon, dialog, accessible areas, etc)
* Dive areas
* Rock Climb areas
* Inverse Battles
* Battle Factory
* Medals for achievements
* Something like Habitat Lists or DexNav via the Town Map
* Restore [unused memory game](http://iimarck.us/i/memory/) ([more info](https://tcrf.net/Pok%C3%A9mon_Gold_and_Silver#Unused_Memory_Game))
* Restore the Safari Game (some functionality, like HandleSafariAngerEatingStatus, already exists)
* Restore the Pikachu's beach minigame
* Add [Sweet Honey trees](http://iimarck.us/i/sweet-honey/) for Munchlax (replace Sweet Scent)
* Use the News Machine for something (Mystery Gift?)
* Championship title defense like in Gen VII (challengers: rival, Lyra, Lance, Prof.Oak, Prof.Elm, Clair, Blue, Eusine, Kimono Girl Naoko, Palmer, Lorelei, Agatha, Steven, Cynthia, Caitlin, and Lawrence)
* Phone uses a bitfield to allow storing all numbers
* Make more trainers rematchable
* Variety Channel with daily unique music
* Separate radio channels for March and Lullaby, available every day
* Either add a 510 EV limit, or replace the 6 Power items with more useful Berries
* Update breeding to Gen VII, including Destiny Knot, Everstone, and Oval Charm effects
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
* Evolution Guru says how your lead Pokémon can evolve
* Sometimes wild Pokémon know an egg move
* Get better Wonder Trade items at higher levels
* Press Start to auto-sort items in Bag
* Select reorders Pokémon in party menu
* Battle [En and Madoka](http://bulbapedia.bulbagarden.net/wiki/The_Legendary_Rotation_Battle!) somewhere (Trainer House after catching the legendary trios, different trainer each day?)
* Show walking animation faster when running
* Faster Bicycle, or slower Running Shoes
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
