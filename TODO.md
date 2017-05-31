## Bugs

* Running away sometimes fails
* Large Pokémon animations have backwards tiles in the stats screen
* Caught Pokémon sent to the PC become level 255
* Some caught Pokémon have wrong held items
* Dark types are not immune to moves whose priority was increased by Prankster
* Foe's Substitute makes your moves become something else
* In-battle item use messages show the wrong Pokémon name
* Some NPC trainers use wrong items
* After the low HP music plays, some of the instruments are missing
* Held Berries don't always disappear when used
* Weather and some ability animations trigger the last used animation too
* Air Balloon message doesn't print for the opponent's first Pokémon
* TMs refresh PP
* Nuzlocke mode sometimes turns on by itself (maybe)
* Dig sometimes prints that both Pokémon dug a hole
* Per-turn status animations might not always work
* Thick Club + Swords Dance Marowak Attack overflow (only in link battles?)
* Headbutt overworld animation looks weird (wrong tile ID?)


## Mechanics

* Generate Battle Tower Pokémon
* Update breeding with the new data structure (engine/breeding/egg.asm and event/daycare.asm)
* Wild Ghosts and the SilphScope2
* More location-unique wild moves
* DVs to vary palettes for trainers' duplicate Pokémon (e.g. Clair's Dragonairs)
* Pokédex Area supports Shamouti Island


## Aesthetics

* Use a side view for Falkner's Pidgeotto in Dark Cave
* Add separate throwing animation graphics for more Poké Ball designs
* Play Pokémon cry+animation when they escape a Poké Ball, and shiny flash when they're caught
* Make Eggs use their Pokémon's palette
* Animate item activations like Quick Claw


## Events

* Soul House + Radio Tower event to get Expn Card
* Battle Tower merchants selling items for BP
* Lost Pikablu (Marill) in Noisy Forest


## Characters

* Victor and Puka in Route 19 Beach House (needs trainer sprite)
* Inver in Route 16 house
* Pay Day tutor in Goldenrod Game Corner
* Man in Silver Cave Pokémon Center gives Expert Belt for reading all the Journals
* Silph Co. mart

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

Shamouti Island:

* Shamouti Island (outdoor market instead of Mart)
* Shamouti Hotel (haunted room)
* Shamouti Restaurant (works like Seven Stars Restaurant)

Route leaders:

* Route 34: Rich Boy, gives Big Nugget
* Route 37: Ace Trainer♀, gives Binding Band
* Route 39: Cowgirl, gives PP Max
* Lighthouse: Battle Girl, gives protect Pads
* Route 43: Ace Trainer♀, gives Flame Orb
* Route 44: Veteran♂, gives Rocky Helmet
* Route 46: Dragon Tamer, gives Focus Sash


## Abilities

In-battle effects:

* Guts, Hustle, and Solar Power shouldn't boost both physical and special moves
* Speed Boost activates inconsistently
* Harvest
* Magic Bounce
* Pickpocket
* Pickup
* Pixilate
* Rivalry
* Sturdy
* Unaware (accuracy/evasion done)
* Unburden

Out-of-battle effects:

* Static
* Suction Cups
* Intimidate
* Synchronize (wild Pokémon done, gift Pokémon not yet done)
* Lightning Rod
* Magma Armor
* Magnet Pull
* Pressure
* Flame Body
* Keen Eye
* Hustle
* Cute Charm
* Sticky Hold
* Vital Spirit

## Items

* Heal Ball
* Ability Capsule
* Air Balloon
* Assault Vest
* Big Root
* Binding Band
* Black Sludge
* Choice Band
* Choice Scarf
* Choice Specs
* Destiny Knot
* Expert Belt
* Flame Orb
* Focus Sash
* Life Orb
* Mental Herb
* Metronome
* Oval Charm
* Quick Powder
* Rocky Helmet
* Safe Goggles
* Shed Shell
* Shell Bell
* Toxic Orb
* Weak Policy
* White Herb
* Wide Lens
* Zoom Lens


## Move effects

* Avalanche does double damage if the user was hit first
* Acrobatics does double damage if the user has no held item
* Facade does double damage if the user is Psn, Brn, or Prz
* U-turn switches out
* Volt Switch switches out
* Sucker Punch fails if foe is not attacking
* Thief should either fail when wild Pokémon use it, or only apply during battle
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
   * HG/SS Spiky-Eared Pichu theme (for some Spiky-Eared Pichu event) (already exists)
   * R/S/E Route 119
   * R/S/E Route 120
   * B/W Dragonspiral Tower (for Embedded Tower)
   * B/W Black City (for Silph Co.)
   * B/W Battle! Elite Four (for Caitlin)
   * S/M Malie City (Day) (for Shamouti Shrine)
* First Pokémon walks behind you ([comet's prototype](https://hax.iimarck.us/topic/6248/) and [diff](https://github.com/yenatch/pokecrystal/commit/dbc5cd2025a0214c5b2cd1e3330f50603a0bb9d1))
* 60 FPS via [doublespeed](https://github.com/FredrIQ/pokecrystal/tree/doublespeed) mode
* Evening (intervals: morn 4–11, day 11–6, eve 6–9, nite 9–4)
* Seasons with appropriate day/night lengths from B/W (affects palettes, tiles, wild Pokémon, dialog, accessible areas, etc)
* Dive areas
* Rock Climb areas
* Inverse Battles
* Battle Factory
* Medals for achievements
* Restore [unused memory game](http://iimarck.us/i/memory/) ([more info](https://tcrf.net/Pok%C3%A9mon_Gold_and_Silver#Unused_Memory_Game))
* Restore the Safari Game (some functionality, like HandleSafariAngerEatingStatus, already exists)
* Add [Sweet Honey trees](http://iimarck.us/i/sweet-honey/) for Munchlax (replace Sweet Scent)
* Use the News Machine for something (Mystery Gift?)
* Championship title defense like in Gen VII (challengers: rival, Lyra, Lance, Prof.Oak, Prof.Elm, Clair, Blue, Eusine, Kimono Girl Naoko, Palmer, Lorelei, Agatha, Steven, Cynthia, Caitlin, and Lawrence)
* Add Valencia Island from Pokémon Orange (for Prof. Ivy's lab, where you can battle her) and maybe other Orange Islands
* Phone uses a bitfield to allow storing all numbers
* Make more trainers rematchable
* Variety Channel with daily unique music
* Separate radio channels for March and Lullaby, available every day
* Either add a 510 EV limit, or replace the 12 unused EV berries and Power items with more useful Berries
* Update breeding to Gen VII, including Destiny Knot, Everstone, and Oval Charm effects
* Catch rate formula from Gen III
* Show move stats when overwriting one
* Show stat changes and then absolute values on level up
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
* A third region
* Mega Evolution
* Z-moves
* Gen V Exp. Share
