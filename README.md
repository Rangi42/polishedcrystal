# Pokémon Polished Crystal

This is a custom Pokémon game based on pret's disassembly of Pokémon Crystal.

In the short-term, it's going to be what the title says: an improved, polished
version of Pokémon Crystal. Partly it will imitate [MrDollSteak's ROMbase for
FireRed](http://www.pokecommunity.com/showpost.php?p=7814321&postcount=252):
decapitalized names, new game mechanics like the Fairy type and Physical/Special
split, and adding Pokémon, moves, and items from future generations. I'm also
inspired by [Mateo's Red++](https://github.com/TheFakeMateo/RedPlusPlus/),
which devamps certain FireRed features for a Red base, and adds some entirely
original ones. I'm doing the same thing with HGSS, copying things like the
Bellchime Trail and Gym Leader rematches, and making some tweaks out of
personal preference. And finally, like [Emerald
Omega](http://www.pokecommunity.com/showthread.php?t=322110) and
[FireRed Omega](http://www.smogon.com/forums/threads/pokemon-fire-red-omega-in-game-discussion-tiering.3480788/),
the game will be harder. Levels are higher, parties are larger, bosses have held
items and better movesets, and there's an equal playing field between you and
the AI: no badge boosts for you, no arbitrary misses for them.

In the long-term, I want going to make an original game set five years after GSC,
with a selection of Pokémon, moves, and items from all generations (including
new evolutions and baby forms like Yanmega and Munchlax, personal favorites
like Milotic and Gogoat, and maybe *one* fakemon Kangaskid/Kangascub/Kangaschan).
I've had semi-concrete plans to make a Pokémon game for years, but an early
attempt with RPG Maker 2000 never got anywhere.

I'm very impressed by the effort that's gone into disassembling Pokémon Crystal
and making the code so well-organized. Thanks to making that open-source (and to
the ROM hackers that inspired me), I'm finally making it a reality.

(Speaking of which, I borrowed Mateo's randomized Wonder Trading idea because
the PokéCom Center is just perfect for it; the dialog about how "you can trade
Pokémon with other people far away" is already there! I'm making the Pokémon you
receive have random OT names, so if anyone whose ideas or code I use wants to
appear there, let me know.)

To set up the repository, see [**INSTALL.md**](INSTALL.md).


## Features

* Add Fairy type from Gen VI:
   * Updated type chart, Pokémon types, and move types
   * Pink Bow (formerly Polkadot Bow) powers up Fairy-type moves
   * Added Moonblast, Play Rough, and Disarm Voice
* Catch all ~~251~~ 253 Pokémon without trading, some earlier than in GSC or HGSS:
   * Remove Spearow, Fearow, Lickitung, Goldeen, Seaking, Cleffa, Igglybuff, Sunkern, Sunflora, Wobbuffet, Shuckle, and Delibird
   * Add Leafeon, Glaceon, Sylveon, Magnezone, Tangrowth, Porygon-Z, Munchlax, Togekiss, Yanmega, Honchkrow, Mismagius, Gliscor, Weavile, and Mamoswine
   * Graveler, Kadabra, Machoke, and Haunter evolve by level-up instead of trading
   * Poliwhirl, Slowpoke, Onix, Seadra, Scyther, and Porygon evolve by held item instead of trading
   * Eevee evolves into Leafeon in Ilex Forest
   * Eevee evolves into Glaceon in the Ice Path
   * Magneton evolves into Magnezone in the Lighthouse
   * Eevee evolves into Sylveon with a Shiny Stone
   * Wild Vulpix on Routes 7, 8, 36 (at night), and 37 (at night)
   * Wild Mankey on Routes 9 and 42
   * Wild Primeape on Routes 9 and 42, and in Cerulean Cave
   * Wild Mareep on Routes 32 and 43
   * Wild Flaaffy on Routes 42 and 43
   * Wild Girafarig on Routes 43 and 48
   * Wild Remoraid on Route 41 (not Route 44; they belong with Mantine)
   * Encounter Articuno in Seafoam Islands
   * Encounter Zapdos on Route 10, above Rock Tunnel
   * Encounter Moltres in Cinnabar Volcano
   * Encounter Mewtwo in Cerulean Cave
   * Wild Slugma in Burned Tower
   * Wild Magmar in Burned Tower
   * Wild Houndour on Routes 35 and 37
   * Wild Murkrow on Routes 38 and 39 (at night)
   * Wild Staryu on Route 40
   * Wild Steelix in Cliff Cave and Silver Cave
   * Wild Misdreavus in Cliff Cave
   * Wild Teddiursa on Route 45 (in the morning)
   * Wild Chikorita in Yellow Forest (in the morning/day)
   * Wild Cyndaquil in Yellow Forest (at night)
   * Wild Totodile in Yellow Forest (by Surfing)
   * Wild Pikachu in Yellow Forest know Fly or Surf
   * Wild Munchlax in Quiet Cave know Self-Destruct
   * Wild Magikarp in Quiet Cave know Hydro Pump
   * Wild Magikarp in Lake of Rage know Dragon Rage
   * Helix Fossil and Dome Fossil in Quiet Cave
   * Wild Shellder in Whirl Islands
   * Wild Octillery in Whirl Islands
   * Wild Dewgong in Seafoam Islands
   * Wild Jynx in Seafoam Islands
   * Wild Ursaring outside Silver Cave
   * Wild Skarmory outside Silver Cave
   * Wild Sneasel outside Silver Cave
   * Wild Houndoom outside Silver Cave
   * Wild Kingdra in Silver Cave
   * Wild Bulbasaur in the Safari Zone
   * Wild Charmander in the Safari Zone
   * Wild Squirtle in the Safari Zone (by Surfing)
   * Wild Kangaskhan in the Safari Zone (not in Rock Tunnel)
   * Cerulean Cave: Golbat, Crobat, Parasect, Primeape, Tangrowth, Electrode, Magneton, Raichu, Ditto, Machamp, Alakazam, Golem
   * Goldenrod Game Corner: Abra, Cubone, Clefairy
   * Celadon Game Corner: Mr. Mime, Eevee, Porygon
   * Trade Teddiursa (found in Dark Cave) for Elekid in Violet City
   * Trade Cubone (bought at the Game Corner) for Diglett in Goldenrod City
   * Trade Steelix (found in Cliff Cave) for Kangaskhan in Olivine City
   * Trade Dragonair for Chansey in Blackthorn City
   * Trade Pinsir for Heracross in Pewter City
   * Wonder Trade after beating the Elite Four for a shiny Pichu holding a GS Ball, then use that to trigger an encounter with Celebi
   * Find the Old Sea Map in the ruins of Pokémon Mansion on Cinnabar Island, and use it to reach Faraway Island and encounter Mew
   * Wild Bellsprout may hold Gold Leaf
   * Wild Oddish may hold Silver Leaf
   * Wild Kadabra may hold TwistedSpoon
   * Wild Alakazam may hold TwistedSpoon
   * Wild Ditto may hold Metal Powder
   * Restore fossils at the Pewter Museum of Science
* Add moves from future generations
   * Remove Acid Armor, Amnesia, Barrage, Beat Up, Bide, Bind, Bone Club, Bone Rush, Clamp, Constrict, Cotton Spore, Detect, Fissure, Frustration, Guillotine, Horn Drill, Jump Kick, Kinesis, Lovely Kiss, Mega Kick, Mega Punch, Mimic, Mind Reader, Mirror Move, Poison Gas, Present, Psych Up, Psywave, Razor Wind, Rolling Kick, Sharpen, Skull Bash, Smog, Snore, Spider Web, Spite, Sweet Scent, Vice Grip, and Withdraw
   * Add Air Slash, Aqua Tail, Astonish, Avalanche, Bug Buzz, Bulk Up, Bullet Punch, Calm Mind, Dark Pulse, DazzlinGleam, Dragon Claw, Dragon Dance, Dragon Pulse, Drain Kiss, Earth Power, Extrasensory, Fairy Wind, Flare Blitz, Flash Cannon, Focus Blast, Gunk Shot, Hex, Hyper Voice, Iron Head, Metal Sound, Nasty Plot, Night Slash, Poison Jab, Power Gem, Play Rough, Psystrike, Razor Shell, Seed Bomb, Shadow Claw, Stone Edge, Wild Charge, Will-O-Wisp, X-Scissor, and Zen Headbutt
   * Revised set of 60 TMs, 8 HMs, and 16 move tutors (one Silver Leaf per tutoring)
* Modern battle mechanics:
   * Physical/Special split, with display
   * Updated Pokémon base stats and move attributes
   * Steel does not resist Ghost or Dark
   * Type-enhancing items raise by 20%, not 10%
   * Light Ball doubles Pikachu's Attack as well as Special Attack
   * Critical hits do 150% damage, not 200%, but are more likely
   * Electric-type Pokémon are immune to paralysis, even from Tri Attack
   * Ice-type Pokémon are immune to freezing, even from Tri Attack
   * Fire-type Pokémon are immune to burns, even from Tri Attack
   * Steel-type Pokémon are immune to poisoning
   * Poison-type Pokémon always hit with Toxic
   * Roar, Whirlwind, and Struggle are unaffected by accuracy or evasion, like Swift
   * Growth raises Attack and Special Attack, by two stages in sunlight
   * Hidden Power is always 60 power
   * Curse is Ghost-type
   * Sandstorm does 1/16 damage per turn
   * Disable lasts for 4 turns
   * Waterfall has a 20% flinch chance
   * Shiny Pokémon have an odd Attack DV, 2, 3, 7, or 11 Defense, 5 or 13 Speed, and perfect 15 Special, so 1/1024 Pokémon is shiny
* Gameplay elements from future (or past) generations:
   * Hold B to use Running Shoes
   * Surf at Bicycle/Running Shoes speed
   * Eggs hatch at level 1
   * Maximum $9,999,999 money and 50,000 coins
   * Maximum 30 items and 16 Balls in your bag
   * Added X Spcl. Def
   * Copied most trainer levels and rosters from HGSS
   * Restored the Goldenrod City PokéCom Center from the Japanese version
   * Added Viridian Forest, Pewter Museum, Pokémon Mansion, and Cerulean Cave from RBY
   * Added Bellchime Trail, Seafoam Islands, and Seafoam Gym from HGSS
   * Added Elder trainer class from HGSS
   * Rematch Gym Leaders in the Fighting Dojo like in HGSS
   * Cure poison when it reaches 1 HP outside a battle
* Pokémon and move edits:
   * Cut is Steel-type, 60 power, 100% accuracy
   * Sing has 75% accuracy (matching Lovely Kiss)
   * Supersonic has 65% accuracy
   * Fly has 100% accuracy
   * Rock Smash has 75 power and is HM08
   * Guillotine is Steel-type
   * Pain Split is Ghost-type
   * Butterfree is Bug/Psychic
   * Persian is Normal/Dark
   * Ninetales is Fire/Ghost
   * Golduck is Water/Psychic
   * Noctowl is Flying/Psychic
   * Ledian is Bug/Fighting
   * Dunsparce is Normal/Ground
   * Mismagius is Ghost/Fairy
* Fix bugs:
   * Dragon Fang boosts Dragon-type moves, not Dragon Scale
   * Burn/Poison/Paralyze improve catch rate
   * Moon Ball catches Moon Stone evolvers
   * Love Ball catches opposite sex
   * Fast Ball catches flee-prone Pokémon
   * Medium-Slow growth rate experience underflow at level 1
   * HP bar lowers at the same speed even for high HP
   * Belly Drum needs to cut HP to raise Attack
   * Lake of Rage Magikarp are larger, not smaller
* Aesthetic updates:
   * Title case for Pokémon, moves, items, trainers, types, etc
   * Restored original Japanese sprites for Beauty, Fisher, Medium, Sage, and Swimmer♀
   * Use some music from RBY and HGSS in Kanto
   * Poké → ()PC on Pokémon Center signs from the Japanese version
   * Berry → Oran Berry, Burnt Berry → Rawst Berry, etc
   * Leppa Berry (formerly MysteryBerry) restores 10 PP, not 5
   * Pack → Bag
   * Enemy → Foe
   * Cooltrainer → Ace Trainer
   * Fisher → Fisherman
   * Mysticalman Eusine → Mystery Man Eusine
   * Pink Bow → Silk Scarf
   * Elixer → Elixir
   * Tin Tower → Bell Tower
   * Virtual Boy → GameCube
   * Olivine Lighthouse → Glitter Lighthouse
   * whited out → blacked out
   * Menu Account → Menu Captions
   * Mania → Kirk (Shuckie the Shuckle's OT)
   * ZephyrBadge → the Zephyr Badge, etc
   * Kanto has colored roofs
   * Rounder Strength boulder like RBY/RSE/FRLG
   * Add lake in front of Sprout Tower from HGSS
   * Add Magnet Train tracks to Route 32 from HGSS
   * Add decorative waterfall in Ecruteak City from HGSS
   * Add boardwalk to Olivine City from HGSS
   * Add dead trees in Blackthorn City from HGSS
   * Add bridge to Victory Road from HGSS
   * Vermilion City boardwalk uses planks from RBY
   * Prof. Oak's lab has FRLG/HGSS appearance
   * Add meteorite debris to Route 3 from HGSS
   * Add craters to Mt. Moon from FRLG
   * Add fountain and benches to Cerulean City from HGSS
   * Add generator to Power Plant from FRLG
   * Add fountain to Celadon City from HGSS
   * Add Celadon Hotel and the "Chief" house from RBY
   * The Ruins of Alph tile with their surrounding maps
   * Use devamped Town Map graphics from HGSS
   * Match Nidoqueen's shiny palette with Nidoking's regular one
   * Rocket Executives use Team Rocket battle music
* Increased difficulty:
   * Default Set battle style
   * Enemy AI doesn't fail an extra 25% of the time with sleep or poison-inducing moves, or 40% of the time with stat drops
   * No badge boosts to stats or types
   * Improved items used by some trainers
   * Improved some trainers' rosters, movesets, and DVs (Gym Leaders, the Elite Four, and other bosses)
* Custom features:
   * A randomized Wonder Trade Hub replaces the PokéCom Center's Mobile Trade Corner
   * Yellow Forest replaces the Johto Safari Zone
   * Cherrygrove Bay connects Cherrygrove City and Route 32
   * Individual party/day-care icons for each Pokémon
   * Politoed has 80 (+10) Speed to match its total with Poliwrath
   * Lugia and Ho-Oh know their signature moves when encountered at level 60
   * Rematch the Elite Four
   * Battle Yellow from the Pokémon Adventures manga in Yellow Forest
   * Find Surfing Pikachu Doll in Yellow Forest
   * Two of Prof. Oak's aides give you items as you complete the Pokédex
   * Battle Lorelei in Ice Path
   * Battle Agatha in Soul House
   * Battle Bill after catching all three legendary beasts
   * Battle Lawrence III after catching all three legendary birds, and get the Silver Wing
   * Battle Green after Red on Navel Rock
   * The old man in Pewter City gives you Old Amber
   * Removed Brick Piece
   * New default player names
   * Goldenrod Game Corner offers Clefairy as a prize
   * Odd Egg is always shiny, with an equal chance to be either gender
   * Nidorina and Nidoqueen can breed
   * Get a Silver Trophy when you beat the Elite 4 and a Gold Trophy when you rematch them
   * Prof. Oak asks for the player's gender and name together
   * Color-coded starter Poké Balls
   * Prof. Oak trades Kanto starter dolls for evolution stones in his lab
   * Change Game Corner prizes (Goldenrod sells Clefary for 800 coins)
   * Add trees for Sitrus Berry (Gold Berry) and Lum Berry (MiracleBerry)
   * Promote the Wise Trio from Sages to Elders
   * Eusine has a shiny Electrode
   * Lawrence has a shiny Charizard
   * Fly to the Rock Tunnel/Power Plant Pokémon Center
   * Menu blurbs (descriptions) are off by default
   * Always show numbers in Pokédex, even in Johto order
   * Access Silph Co. after restoring power to Kanto, and buy new Poké Balls
   * Move Viridian Gym's HGSS gym trainers to the extended Trainer House, with a prize Nugget for beating them
   * Add four Boarders and Skiers to Ice Path
   * Add four Ace Trainers to Victory Road
   * Buy evolution stones in Celadon Dept. Store
   * Buy BlueSky Mail and Morph Mail in Goldenrod City
   * Buy Eon Mail in Goldenrod City after getting Eevee from Bill
   * Buy Music Mail in Blackthorn City
   * Buy Mirage Mail in Mt. Moon Square


## To do:

* Remove unused code and resources to make room for new stuff
* Add custom animations for new moves
* Modern battle mechanics:
   * http://smogon.site/forums/threads/gsc-mechanics.3542417/
   * Gen III critical hit mechanics (ignore -Atk and +Def stat changes, don't ignore burn)
   * Gain experience from catching Pokémon like in Gen VI
   * Sound-based moves bypass Substitute
   * Struggle does 25% recoil damage
   * Drain Kiss drains 75% HP
   * Double-Edge does 33% recoil damage
   * Flare Blitz does 33% recoil damage
   * Avalanche doubles damage if user is hit first
   * Hex doubles damage if foe has a status condition
   * Low Kick's power is based on weight
   * Sitrus Berry (formerly Gold Berry) restores 25% of max HP, not 30 HP
   * Oran Berry, Sitrus Berry, and Berry Juice activate at 1/3 HP, not 1/2
   * X Accuracy boosts accuracy, it does not ignore accuracy checks entirely
   * Thunder ignores accuracy and evasion in rain
   * Rock-type Pokémon get Sp.Def boosted by 50% in a sandstorm
   * Grass-type Pokémon are immune to PoisonPowder, Stun Spore, Sleep Powder, and Spore
   * Ghost-type Pokémon are immune to the trapping effects of Mean Look, Clamp, Fire Spin, Whirlpool, and Wrap
* Gameplay elements from future (or past) generations:
   * Restore [unused memory game](http://iimarck.us/i/memory/)
   * Add [Sweet Honey trees](http://iimarck.us/i/sweet-honey/) for Munchlax (replace Sweet Scent)
   * Pickup ability for Meowth, Aipom, Teddiursa, and/or Phanpy
   * Unlimited-use TMs from Gen V
   * Continuous Repel system from Gen V
   * Catch rate formula from Gen III
   * Money loss formula from Gen III when whiting out
   * Bill calls to switch boxes when one is full
   * Show stat changes and then absolute values on level up
   * Unown ? and ! from Gen III
   * Tune Gym Leaders' rematch movesets, levels, held items, and text
   * Move Relearner that accepts Gold Leaves
* Fix bugs:
   * Overworld Pokémon sprites can only be from one bank (always BANK(Icons1) at first) (if you view your party, whichever bank the last Pokémon is from gets used for the overworld)
   * Thick Club + Swords Dance Marowak Attack overflow (only in link battles?)
   * Fix delay before last text box when Wonder Trading
* Increased difficulty:
   * Give female trainers better DVs, and use the new unique DVs feature to make certain Pokémon female
* Aesthetic updates:
   * Animate new Pokémon sprites
   * Fix Pokémon footprints
   * Use updated Pokémon palettes, including shiny ones (changed ones: Charizard, Kangaskhan, Paras, etc)
   * Improve certain shiny palettes (blue Dragonite, silver Scizor, blue Espeon, black Ursaring, dark green Forretress)
   * Show Pokémon portraits when using field moves
   * Better Substitute sprites
   * Low-pitched cries when fainting
   * Big roofs like Pewter Museum on Silph Co. and Pokémon Tower
   * Goldenrod Dept.Store and Celadon Mansion roofs should have dark sky at night
   * Add Young Couple and Double Team trainer classes
   * Add river to Route 46 from HGSS
   * Add Celadon Dept. Store electronics floor from RBY
   * Use pagodas from [beta tilesets](https://tcrf.net/Pok%C3%A9mon_Gold_and_Silver#Tilesets)
* Custom features:
   * Turn the News Machine into a Mystery Gift Machine (so you can get an Eon Mail for the lady in the PokéCom Center)
   * Faster text by default
   * Stereo sound by default
   * Optional Locke mode where fainted Pokémon cannot be revived (Max/Revive, Revival Herb, and Sacred Ash still fix HP and status so they aren't useless)
   * Select reorders Pokémon in party menu
   * Brief beeping with low HP
   * Pokédex area display uses whiever region you're in (edit engine/pokegear.asm:_Area)
   * Send gift Pokémon to the PC if the party is full
   * Increase limits on Pokémon per box, number of boxes, coins in coin case, etc
   * More frequently successful fishing and Headbutting
   * More likely to find roaming Pokémon when on the correct route
   * The old man in Pewter City shows you Raikou and Entei in case you've never encountered them roaming
   * Suicune roams if you don't catch it in Bell Tower
   * Aurora Orb boosts Suicune's Defense and Special Defense
   * Have Moves as an option in the party Pokémon menu during battle (might be too complicated to avoid glitches since moves can be reordered; also graphics glitches when the mini sprite overwrites the back sprite)
   * Fourth stat screen showing Poké Seer's data
   * Color party/day-care sprites by species
   * Battle with Tower Tycoon Palmer as the last battle of every 5th and 10th 7-battle set in the Battle Tower
   * Battle with Giovanni either in Radio Tower or with Celebi time traveling
   * Cameo battle with Valerie on the Bellchime Trail after the Suicune event (Clefable, Mr. Mime, Wigglytuff, Azumarill, Togekiss, Sylveon) (reward: TM for DazzlinGleam)
   * Battle with [Tsunekazu Ishihara](https://tcrf.net/Pok%C3%A9mon_Red_and_Blue#Deleted_Maps) in the Celadon Mansion dev room (Exeggutor, Porygon-Z, Jolteon, Dugtrio, Lapras, Rhydon)
   * Battle with [Shigeki Morimoto](http://bulbapedia.bulbagarden.net/wiki/Shigeki_Morimoto), Shigeru Miyamoto, and Satoshi Tajiri
   * Replace Cal in Trainer Hall with whichever gender character you don't pick
   * Include Lyra/Kotone as a friendly rival like in HGSS
      * She starts out with Marill, then takes whichever starter is left and battles you; her Pokémon do evolve, but her team is small (Azumarill, starter, Girafarig, Furret which she caught to teach you how)
   * Add a store to buy room decorations that Mom doesn't
   * Special sprites for Pikachu that know Surf or Fly
   * Yellow Pikachu Surfing music
   * N would sympathize with the Ruins of Alph message about how "we depart for their sakes"
   * Somtimes wild Pokémon know an egg move
   * Rock Smash breaks screens instead of lowering Defense (like Brick Break)
   * Gift a shiny Ditto somewhere (maybe in Pokémon Mansion)


## Long-term

* New storyline set 5 years after Gen II
* Selection of 253 Pokémon from all generations
* Selection of 254 moves from all generations
* Separate IVs and EVs for Special Attack and Special Defense
* Separate shininess from IVs
* Hail
* Move Relearner
* Abilities
* Natures
* Overworld weather, or at least automatic when battles start
* Custom held items that prevent status conditions (based on unused game code)
* More Berries (Liechi, Ganlon, Salac, Petaya, Apicot, Lansat)
* Replace HM01 Cut with Machete item, and HM05 Flash with Bell Lantern item
* Make Rock Smash an HM (actually Brick Break)
* Evening from 5–7 PM (change morning from 4−9 AM)
* First party Pokémon follows you like in Yellow or HGSS
* Separate bag pockets for usable items and held items, or for Berries and/or healing items
* Custom title screen and end credits
* Shiny Charm from Gen V increases shiny likelihood from 1/8192 to 1/1024
* Replace Poké Seer byte with <gender:1, shiny:1, which_ability:1, nature:5> (or have one ability per species and use two bits for gender, instead of checking the base data for genderless)
* Improved AI


## See also

* Disassembly of [**Pokémon Red/Blue**][pokered]
* irc: [**freenode#pret**][irc]

[pokered]: https://github.com/iimarckus/pokered
[irc]: https://kiwiirc.com/client/irc.freenode.net/?#pret
