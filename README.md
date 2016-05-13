# Pokémon Polished Crystal

This is a custom Pokémon game based on pret's disassembly of Pokémon Crystal.

In the short-term, it's going to be an improved version of Pokémon Crystal
with bugs fixed, all 251 Pokémon available, more difficulty, lots of mechanics
and features from newer generations (Fairy type, physical/special split, etc),
and aesthetic improvements, inspired by Pokémon FireRed Omega and Emerald Omega.

In the long-term, I'm going to make an original game set five years after GSC,
with a selection of Pokémon, moves, and items from all generations (including
new evolutions and baby forms like Yanmega and Munchlax, personal favorites
like Milotic and Gogoat, and *one* fakemon Kangaskid).

To set up the repository, see [**INSTALL.md**](INSTALL.md).


## Features

* Add Fairy type from Gen VI (treated as Physical)
   * Physical type
   * Updated type chart, Pokémon types, and move types
   * Pink Bow (formerly Polkadot Bow) powers up Fairy-type moves
   * Added Moonblast, Play Rough, and Disarm Voice
* Fix bugs:
   * Belly Drum needs to cut HP to raise Attack
   * Burn/Poison/Paralyze improve catch rate
   * Moon Ball catches Moon Stone evolutions
   * Love Ball catches opposite sex
   * Fast Ball catches flee-prone Pokémon
   * Dragon Fang boosts Dragon-type moves, not Dragon Scale
   * Medium-Slow growth rate experience underflow at level 1
   * HP bar lowering glitch
* Modern game mechanics:
   * Physical/Special split
   * Hold B to run
   * Steel does not resist Ghost or Dark
   * Type-enhancing items raise by 20%, not 10%
   * Hatch Eggs at level 1
   * Critical hit mechanics from Gen VI (200% → 150% damage, better chances)
   * Electric-type Pokémon are immune to paralysis, even from Tri Attack.
   * Ice-type Pokémon are immune to freezing, even from Tri Attack.
   * Fire-type Pokémon are immune to burns, even from Tri Attack.
   * Poison-type Pokémon always hit with Toxic.
   * Growth raises Attack and Sp.Atk
   * Updated Pokémon base stats and move attributes
   * Hidden Power is always 60 power
   * Curse is a Ghost-type move
   * Sandstorm does 1/16 damage per turn
   * Disable lasts for 4 turns
   * Added X Spcl. Def
   * Steel-type Pokémon cannot be poisoned
* Grammar and spelling updates:
   * Title case for Pokémon, moves, items, trainers, types, etc
   * Updated Berry names (Burnt Berry → Rawst Berry, etc)
   * Leppa Berry (formerly MysteryBerry) restores 10 PP, not 5
   * Cooltrainer → Ace Trainer
   * Mysticalman Eusine → Mystery Man Eusine
   * Pack → Bag
   * Enemy → Foe
   * Pink Bow → Silk Scarf
   * Elixer → Elixir
   * Tin Tower → Bell Tower
   * Olivine Lighthouse → Glitter Lighthouse
   * whited out → blacked out
   * Menu Account → Menu Blurbs
   * Mania → Kirk (Shuckie the Shuckle's OT)
   * Refer to badges as "the"
* Restorations:
   * Original Japanese sprites for some trainers
   * Enabled the Goldenrod City PokéCom Center
   * Copied trainer levels and rosters from HGSS (but not movesets)
   * Added Bellchime Trail from HGSS
   * Added Elder trainer class from HGSS
   * Wild Vulpix on Routes 7, 8, 36 (at night), and 37 (at night)
   * Wild Mankey on Routes 9 and 42
   * Wild Primeape on Routes 9 and 42
   * Wild Mareep on Routes 32 and 43
   * Wild Flaaffy on Routes 42 and 43
   * Wild Girafarig on Route 43
   * Wild Remoraid on Route 41 (not Route 44; they belong with Mantine)
* Customizations:
   * A randomized Wonder Trade Hub replaces the PokéCom Center's Mobile Trade Corner
   * Individual party/day-care icons for each Pokémon
   * Graveler, Kadabra, Machoke, and Haunter evolve by level-up instead of trading
   * Poliwhirl, Slowpoke, Onix, Seadra, Scyther, and Porygon evolve by held item instead of trading
   * Politoed has 80 (+10) Speed to match its total with Poliwrath
   * Enemy AI doesn't fail an extra 25% of the time with sleep or poison-inducing moves, or 40% of the time with stat drops
   * Improved items used by some trainers
   * Improved some trainers' DVs
   * Improved boss trainers' teams
   * No badge boosts to stats or types
   * New default player names
   * Ask gender at a sensible time in Oak's speech
   * Color-coded starter Poké Balls
   * Lugia and Ho-Oh know their signature moves when encountered at level 60
   * Change Game Corner prizes (Goldenrod sells Clefary for 800 coins)
   * Rematch Elite Four
   * Gym Leaders have 3, then 4, then 5, and the rest have 6 Pokémon
   * Add trees for Sitrus Berry (Gold Berry) and Lum Berry (MiracleBerry)
   * Promote the Wise Trio from Sages to Elders
   * The foreign Rocket Grunt in Cerulean City uses the RBY Rocket sprite
   * Fly to Rock Tunnel/Power Plant Pokémon Center


## To do:

* Bug fixes:
   * Make Growth display an appropriate effect and message regarding both raised stats  
     https://hax.iimarck.us/topic/4198/
* Allow Wonder Trading only a few times a day
* Remove unused code
* Find and fix more bugs
   * Thick Club + Swords Dance Marowak Attack overflow
* Catch all 251 Pokémon (add Bulbasaur, Charmander, Squirtle, Omanyte, Kabuto, Aerodactyl, Articuno, Zapdos, Moltres, Mewtwo, Mew, and Celebi) (use Japan's GS Ball event for Celebi)
* Add Glaceon, Leafeon, and Sylveon in the three unused Pokémon slots
* Replace Cleffa and Igglybuff with Togekiss and Weavile
* Mechanics:
   * Update learnt moves, and move and item mechanics, to Gen VI
   * Gen III critical hit mechanics (ignore -Atk and +Def stat changes, don't ignore burn)
   * Catch rate formula from Gen III
   * Money loss formula from Gen III when whiting out
   * Unlimited-use TMs from Gen V
   * Gain experience from catching Pokémon like in Gen VI
   * Cure poison when it reaches 1 HP outside a battle, or don't damage at all outside battles
   * Sound-based moves bypass Substitute
   * Roar, Whirlwind, and Struggle are unaffected by accuracy or evasion, like Swift
   * Struggle does 25% recoil damage
   * Low Kick's power is based on weight
   * Beat Up works differently in Gen V
   * Ghost-type Pokémon cannot be trapped
   * Grass-type Pokémon are not affected by Powder moves
   * Sitrus Berry (formerly Gold Berry) restores 25% of max HP, not 30 HP
   * Oran Berry, Sitrus Berry, and Berry Juice activate at 1/3 HP, not 1/2
   * X Accuracy boosts accuracy, it does not ignore accuracy checks entirely
   * Light Ball doubles Pikachu's Attack as well as Special Attack
   * Boost CPU Pokémon's stats each by level^2/500 to simulate stat experience (max 20 boost per stat, i.e. half of what can be gained with vitamins)
   * Growth raises stats by two stages in sunlight
   * Thunder ignores accuracy and evasion in rain
   * Rock-type Pokémon get Sp.Def boosted by 50% in a sandstorm
   * Grass-type Pokémon are immune to Cotton Spore, PoisonPowder, Powder, Rage Powder, Sleep Powder, Spore, Stun Spore, and Effect Spore.
   * Ghost-type Pokémon are immune to the trapping effects of Block, Mean Look, Spider Web, Bind, Clamp, Fire Spin, Infestation, Magma Storm, Sand Tomb, Whirlpool, Wrap, Arena Trap, Magnet Pull, and Shadow Tag.
* Convenience:
   * Better default settings (fast text, stereo sound, set battle style, etc)
   * Settings for 12/24-hour clock, and imperial/metric units
   * Even faster text
   * Continuous Repel system from Gen V
   * Brief beeping with low HP
   * Bill calls to switch boxes when one is full
   * Send gift Pokémon to the PC if the party is full
   * Increase limits on Pokémon per box, number of boxes, coins in coin case, etc
   * No delay when Kurt makes Apricorn Balls
   * More successful fishing and Headbutting
   * More likely to find roaming Pokémon when on the correct route
   * Select reorders Pokémon in party menu
   * Show stat changes and then absolute values on level up
   * Have Moves as an option in the party Pokémon menu during battle (might be too complicated to avoid glitches since moves can be reordered; also graphics glitches when the mini sprite overwrites the back sprite)
* Aesthetics:
   * Poké → ()PC on Pokémon Center signs
   * Improve Moonblast, Play Rough, and Disarm Voice animations
   * Unown ? and ! from Gen III
   * Color party/day-care sprites by species
   * Higher levels and better moves and held items from HGSS
   * Fourth stat screen showing Poké Seer's data
   * Better Substitute sprite
   * Show Pokémon portrait when using field moves
   * Low-pitched cries when fainting
   * Replace some Kanto music with RBY tracks
* Content:
   * Sell evolution stones in Celadon Dept. Store
   * Restore locations from RBY (Viridian Forest, Pewter Museum, Mt. Moon, Cerulean Cave, Pokémon Tower, Safari Zone, Cinnabar Island, Pokémon Mansion, Seafoam Islands, Lt.Surge's traps)
   * Add locations from FRLG (Sevii Islands, Navel Rock, Birth Island)
   * Add locations from HGSS (Embedded Tower, Sinjoh Ruins)
   * Replace Mimic with Fairy Wind, Mirror Move with DazzlinGleam, Detect with BabyDollEyes (merge with Protect), Withdraw with Drain Kiss (merge with Defense Curl), Spider Web with Bullet Punch (merge with Mean Look), and Mind Reader with Iron Head (merge with Mean Look)
   * Change in-game trades
   * Rematch Gym Leaders in the Fighting Dojo
   * Cameo battle with Valerie on the Bellchime Trail after the Suicune event (Clefable, Sylveon, Mr. Mime, Togekiss) (reward: TM for DazzlinGleam)


## Long-term

* New storyline set 5 years after Gen II
* Selection of 255 Pokémon from all generations
* Selection of 255 moves from all generations (Hail, etc)
* Selection of up to 255 items from all generations (Zinc, PP Max, Dome Fossil, Helix Fossil, Old Amber, Dawn Stone, Dusk Stone, etc)
* Custom held items that prevent status conditions (based on unused game code)
* More Berries (Liechi, Ganlon, Salac, Petaya, Apicot, Lansat)
* Separate IVs and DVs for Special Attack and Special Defense
* Separate shininess from DVs
* Shiny Charm from Gen V increases shiny likelihood from 1/8192 to 1/1024
* Move Relearner
* Abilities
* Natures
* Replace Poké Seer byte with <gender:1, shiny:1, whichability:1, nature:5> (or have one ability per species and use two bits for gender, instead of checking the base data for genderless)
* Replace HM01 Cut with Machete item, and HM05 Flash with Bell Lantern item
* Make Rock Smash an HM
* Merge Nidoran ♂ and ♀, using a multiple-sprite system like Unown
* Evening from 5–7 PM (change morning from 4−9 AM)
* Separate bag pockets for usable items and held items
* Custom title screen and end credits
* Import some music from RBY, FRLG, and HGSS
* Improved AI
* Tune boss trainers' movesets (after adding Gen III+ moves)


## See also

* Disassembly of [**Pokémon Red/Blue**][pokered]
* irc: [**freenode#pret**][irc]

[pokered]: https://github.com/iimarckus/pokered
[irc]: https://kiwiirc.com/client/irc.freenode.net/?#pret
