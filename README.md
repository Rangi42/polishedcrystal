# Pokémon Crystal Omega

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
   * Electric-type Pokémon cannot be Paralyzed
   * Growth raises Attack and Sp.Atk
   * Sandstorm does 1/16 damage per turn
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
   * Refer to badges as "the"
* Graphics updates:
   * Individual party/day-care icons for each Pokémon
   * Original Japanese sprites for some trainers
* No badge boosts to stats or types
* New default player names
* Graveler, Kadabra, Machoke, and Haunter evolve by level-up instead of trading
* Poliwhirl, Slowpoke, Onix, Seadra, Scyther, and Porygon evolve by held item instead of trading
* Enemy AI doesn't fail an extra 25% of the time with sleep-inducing moves


## To do:

* Find and fix more bugs
   * Thick Club + Swords Dance Marowak Attack overflow
* Catch all 251 Pokémon (add Vulpix, Mankey, Mareep, Girafarig, Remoraid, Bulbasaur, Charmander, Squirtle, Omanyte, Kabuto, Aerodactyl, Articuno, Zapdos, Moltres, Mewtwo, Mew, and Celebi) (use Japan's GS Ball event for Celebi)
* Add Glaceon, Leafeon, and Sylveon in the three unused Pokémon slots
* Replace Cleffa and Igglybuff with Togekiss and Weavile
* Mechanics:
   * Update base stats, learnt moves, and move and item mechanics to Gen VI
   * Gen III critical hit mechanics (ignore -Atk and +Def stat changes, don't ignore burn)
   * Catch rate formula from Gen III
   * Money loss formula from Gen III when whiting out
   * Unlimited-use TMs from Gen V
   * Gain experience from catching Pokémon like in Gen VI
   * Cure poison when it reaches 1 HP outside a battle, or don't damage at all outside battles
   * Sound-based moves bypass Substitute
   * Struggle does 25% recoil damage
   * Ghost-type Pokémon cannot be trapped
   * Grass-type Pokémon are not affected by Powder moves
   * Sitrus Berry (formerly Gold Berry) restores 25% of max HP, not 30 HP
   * X Accuracy boosts accuracy, it does not ignore accuracy checks entirely
   * Light Ball doubles Pikachu's Attack as well as Special Attack
   * Boost CPU Pokémon's stats each by level^2/500 to simulate stat experience (max 20 boost per stat, i.e. half of what can be gained with vitamins)
   * Growth raises stats by two stages in sunlight
   * Thunder ignores accuracy and evasion in rain
   * Rock-type Pokémon get Sp.Def boosted by 50% in a sandstorm
* Convenience:
   * Better default settings (fast text, stereo sound, set battle style, etc)
   * Show Phys/Spcl/Stat category for moves
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
* Aesthetics:
   * Improve Moonblast, Play Rough, and Disarm Voice animations
   * Unown ? and ! from Gen III
   * Color party/day-care sprites by species
   * Higher levels and better moves and held items from HGSS
   * Fourth stat screen showing Poké Seer's data
   * Better Substitute sprite
   * Show Pokémon portrait when using field moves
   * Low-pitched cries when fainting
   * Separate Bellchime Trail from Ecruteak City
   * Replace some Kanto music with RBY tracks
* Content:
   * Restore locations from RBY (Viridian Forest, Pewter Museum, Mt. Moon, Cerulean Cave, Pokémon Tower, Safari Zone, Cinnabar Island, Seafoam Islands)
   * Add locations from FRLG (Sevii Islands, Navel Rock, Birth Island)
   * Add locations from HGSS (Bellchime Trail, Embedded Tower, Sinjoh Ruins)
   * Replace Mimic with Fairy Wind, Mirror Move with DazzlinGleam, Detect with BabyDollEyes (merge with Protect), Withdraw with Drain Kiss (merge with Defense Curl), Spider Web with Bullet Punch (merge with Mean Look), and Mind Reader with Iron Head (merge with Mean Look)
   * Change in-game trades


## Long-term

* New storyline set 5 years after Gen II
* Selection of 255 Pokémon from all generations
* Selection of 255 moves from all generations (Hail, etc)
* Selection of up to 255 items from all generations (Zinc, X Sp. Def, PP Max, Dome Fossil, Helix Fossil, Old Amber, Dawn Stone, Dusk Stone, etc)
* Custom held items that prevent status conditions (based on unused game code)
* More Berries (Liechi, Ganlon, Salac, Petaya, Apicot, Lansat)
* Separate IVs and DVs for Special Attack and Special Defense
* Separate shininess from DVs
* Shiny Charm from Gen V increases shiny likelihood from 1/8192 to 1/1024
* Move Relearner
* Abilities
* Natures
* Wonder Trade system like Red++ (replace the Pokécom Center's Mobile Trade System)
* Replace HM01 Cut with Machete item, and HM05 Flash with Flashlight item
* Make Rock Smash an HM
* Merge Nidoran ♂ and ♀, using a multiple-sprite system like Unown
* Evening from 5–7 PM (change morning from 4−9 AM)
* Custom title screen and end credits
* Import some music from RBY, FRLG, and HGSS
* Rematch Gym Leaders and Elite Four with better teams
* Improved AI


## See also

* Disassembly of [**Pokémon Red/Blue**][pokered]
* irc: [**freenode#pret**][irc]

[pokered]: https://github.com/iimarckus/pokered
[irc]: https://kiwiirc.com/client/irc.freenode.net/?#pret
