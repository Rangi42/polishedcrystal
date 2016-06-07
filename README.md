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
   * Wild Vulpix on Routes 7, 8, 36 (at night), and 37 (at night)
   * Wild Mankey on Routes 9 and 42
   * Wild Primeape on Routes 9 and 42, and in Cerulean Cave
   * Wild Mareep on Routes 32 and 43
   * Wild Flaaffy on Routes 42 and 43
   * Wild Girafarig on Routes 43 and 48
   * Wild Remoraid on Route 41 (not Route 44; they belong with Mantine)
   * Encounter Articuno in Seafoam Islands
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
   * Wild Shellder in Whirl Islands
   * Wild Octillery in Whirl Islands
   * Wild Dewgong in Seafoam Islands
   * Wild Jynx in Seafoam Islands
   * Wild Ursaring outside Silver Cave
   * Wild Skarmory outside Silver Cave
   * Wild Sneasel outside Silver Cave
   * Wild Houndoom outside Silver Cave
   * Wild Kingdra in Silver Cave
   * Cerulean Cave: Golbat, Crobat, Parasect, Primeape, Wobbuffet, Electrode, Magneton, Raichu, Ditto, Machamp, Alakazam, Golem
   * Goldenrod Game Corner: Cubone, Clefairy, Wobbuffet
   * Celadon Game Corner: Mr. Mime, Eevee, Porygon
   * Trade Teddiursa (found in Dark Cave) for Elekid in Violet City
   * Trade Cubone (bought at the Game Corner) for Diglett in Goldenrod City
   * Trade Steelix (found in Cliff Cave) for Kangaskhan in Olivine City
   * Trade Dragonair for Chansey in Blackthorn City
   * Trade Pinsir for Heracross in Pewter City
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
   * Curse is a Ghost-type move
   * Sandstorm does 1/16 damage per turn
   * Disable lasts for 4 turns
* Gameplay elements from future (or past) generations:
   * Hold B to use Running Shoes
   * Surf at Bicycle/Running Shoes speed
   * Eggs hatch at level 1
   * Maximum $9,999,999 money and 50,000 coins
   * Maximum 30 items and 16 Balls in your bag
   * Added X Spcl. Def
   * Copied most trainer levels and rosters from HGSS
   * Restored the Goldenrod City PokéCom Center from the Japanese version
   * Added Viridian Forest, Pewter Museum, and Cerulean Cave from RBY
   * Added Bellchime Trail, Seafoam Islands, and Seafoam Gym from HGSS
   * Added Elder trainer class from HGSS
   * Rematch Gym Leaders in the Fighting Dojo like in HGSS
* Fix bugs:
   * Dragon Fang boosts Dragon-type moves, not Dragon Scale
   * Burn/Poison/Paralyze improve catch rate
   * Moon Ball catches Moon Stone evolutions
   * Love Ball catches opposite sex
   * Fast Ball catches flee-prone Pokémon
   * Medium-Slow growth rate experience underflow at level 1
   * HP bar lowers at the same speed even for high HP
   * Belly Drum needs to cut HP to raise Attack
   * Lake of Rage Magikarp are larger, not smaller
* Aesthetic updates:
   * Title case for Pokémon, moves, items, trainers, types, etc
   * Restored original Japanese sprites for Beauty, Fisher, Medium, Sage, and Swimmer♀
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
   * Olivine Lighthouse → Glitter Lighthouse
   * whited out → blacked out
   * Menu Account → Menu Captions
   * Mania → Kirk (Shuckie the Shuckle's OT)
   * ZephyrBadge → the Zephyr Badge, etc
   * Kanto has colored roofs
   * Add lake in front of Sprout Tower from HGSS
   * Match Nidoqueen's shiny palette with Nidoking's regular one
* Increased difficulty:
   * Default Set battle style
   * Enemy AI doesn't fail an extra 25% of the time with sleep or poison-inducing moves, or 40% of the time with stat drops
   * No badge boosts to stats or types
   * Improved items used by some trainers
   * Improved some trainers' rosters, movesets, and DVs (Gym Leaders, the Elite Four, and other bosses)
* Custom features:
   * A randomized Wonder Trade Hub replaces the PokéCom Center's Mobile Trade Corner
   * Yellow Forest replaces the Johto Safari Zone
   * Individual party/day-care icons for each Pokémon
   * Politoed has 80 (+10) Speed to match its total with Poliwrath
   * Lugia and Ho-Oh know their signature moves when encountered at level 60
   * Rematch the Elite Four
   * New default player names
   * Goldenrod Game Corner offers Clefairy as a prize
   * Prof. Oak asks for the player's gender and name together
   * Color-coded starter Poké Balls
   * Change Game Corner prizes (Goldenrod sells Clefary for 800 coins)
   * Add trees for Sitrus Berry (Gold Berry) and Lum Berry (MiracleBerry)
   * Promote the Wise Trio from Sages to Elders
   * The foreign Rocket Grunt in Cerulean City uses the RBY Rocket sprite
   * Eusine has a shiny Haunter
   * Fly to the Rock Tunnel/Power Plant Pokémon Center
   * Menu blurbs (descriptions) are off by default
   * Always show numbers in Pokédex, even in Johto order
   * Move Viridian Gym's HGSS gym trainers to the extended Trainer House, with a prize Nugget for beating them


## To do:

* Remove unused code and resources to make room for new stuff
* Fairy type from Gen VI:
   * Improve Moonblast, Play Rough, and Disarm Voice animations
   * Replace some moves with BabyDollEyes, DazzlinGleam, Drain Kiss, and Fairy Wind
* Catch all 251 Pokémon without trading:
   * Safari Zone Pokémon: **Bulbasaur**, **Charmander**, **Squirtle**, **Kangaskhan** (not in Rock Tunnel), Nidorina, Nidoqueen, Nidorino, Nidoking, Paras, Parasect, Venonat, Venomoth, Doduo, Dodrio, Exeggcute, Exeggutor, Rhyhorn, Rhydon, Chansey, Tangela, Scyther, Pinsir, Dratini, Dragonair
   * Get the Silver Wing only after catching all three legendary birds (Articuno in Seafoam Islands, Zapdos above the Power Plant and new floors of Rock Tunnel, Moltres in Cinnabar Volcano) (like with the three beasts and the Rainbow Wing) (who should give it to you? Prof. Oak, Lance, Lawrence III?)
   * Add the Helix and Dome fossils (in Mt. Moon?) to be restored into Omanyte and Kabuto at the Pewter Museum of Science
   * Restore the GS Ball event for Celebi (get it from the Mystery Gift Machine)
   * Find the Old Sea Chart in the ruins of Pokémon Mansion on Cinnabar Island, and use it to reach Faraway Island and catch Mew
* Modern battle mechanics:
   * http://smogon.site/forums/threads/gsc-mechanics.3542417/
   * Update movesets, and move and item mechanics, to Gen VI
      * Prioritize having viable physical and special moves for each type
      * Moves that can be removed: Psywave, Mimic, Mirror Move
      * Moves that can be merged: Wrap/Bind, Self-Destruct/Explosion, Hi Jump Kick/Jump Kick, Protect/Detect, Defense Curl/Withdraw, Mean Look/Spider Web/Block, Lock On/Mind Reader, Scratch/Fury Swipes/Fury Attack, Bone Club/Bonemerang/Bone Rush, Morning Sun/Synthesis/Moonlight, Brick Break/Rock Smash, Heal Bell/Aromatherapy, Foresight/Odor Sleuth/Miracle Eye, Sleep Powder/GrassWhistle, Thief/Covet, Trick/Switcheroo, Softboiled/Milk Drink
   * Gen III critical hit mechanics (ignore -Atk and +Def stat changes, don't ignore burn)
   * Gain experience from catching Pokémon like in Gen VI
   * Cure poison when it reaches 1 HP outside a battle, or don't damage at all outside battles
   * Sound-based moves bypass Substitute
   * Struggle does 25% recoil damage
   * Waterfall has a 20% flinch chance
   * Low Kick's power is based on weight
   * Beat Up works differently in Gen V
   * Ghost-type Pokémon cannot be trapped
   * Grass-type Pokémon are not affected by Powder moves
   * Sitrus Berry (formerly Gold Berry) restores 25% of max HP, not 30 HP
   * Oran Berry, Sitrus Berry, and Berry Juice activate at 1/3 HP, not 1/2
   * X Accuracy boosts accuracy, it does not ignore accuracy checks entirely
   * Boost CPU Pokémon's stats each by level^2/500 to simulate stat experience (max 20 boost per stat, i.e. half of what can be gained with vitamins)
   * Thunder ignores accuracy and evasion in rain
   * Rock-type Pokémon get Sp.Def boosted by 50% in a sandstorm
   * Grass-type Pokémon are immune to Cotton Spore, PoisonPowder, Powder, Rage Powder, Sleep Powder, Spore, Stun Spore, and Effect Spore
   * Ghost-type Pokémon are immune to the trapping effects of Block, Mean Look, Spider Web, Bind, Clamp, Fire Spin, Infestation, Magma Storm, Sand Tomb, Whirlpool, Wrap, Arena Trap, Magnet Pull, and Shadow Tag
* Gameplay elements from future (or past) generations:
   * Restore locations from RBY (Mt. Moon, Pokémon Tower, Fuschia Safari Zone, Pokémon Mansion, Kanto Underground, Lt.Surge's traps, electronics shop and vending machines in Celadon Dept. Store, Celadon Hotel)
   * Add locations from FRLG (Sevii Islands, Navel Rock, Birth Island)
   * Add locations from HGSS (Embedded Tower, Sinjoh Ruins)
   * Quiet Cave Pokémon: **Self-Destructing Munchlax**, **Dragon Raging Magikarp**, **Larvitar**, **Cubone**, **Marowak**, Golbat, Machop, Gastly, Onix, Natu
   * Quiet Cave items: **Dome Fossil**, **Helix Fossil**, **Old Amber**, **SilverPowder**, **TwistedSpoon**, **Dusk Ball**, Nugget
   * Cinnabar Volcano Pokémon: **Gengar**, Magmar
   * Restore [unused memory game](http://iimarck.us/i/memory/)
   * Add [Sweet Honey trees](http://iimarck.us/i/sweet-honey/) for Munchlax (replace Sweet Scent)
   * Pickup ability for Meowth, Aipom, Teddiursa, and/or Phanpy
   * Unlimited-use TMs from Gen V
   * Continuous Repel system from Gen V
   * Catch rate formula from Gen III
   * Money loss formula from Gen III when whiting out
   * Bill calls to switch boxes when one is full
   * Show stat changes and then absolute values on level up
   * Replace some Kanto music with RBY and HGSS tracks (Cerulean City, Fuchsia City, Cinnabar Island, Nugget Bridge, legendary battles, etc)
   * Unown ? and ! from Gen III
   * Tune Gym Leaders' rematch movesets, levels, held items, and text
* Fix bugs:
   * Thick Club + Swords Dance Marowak Attack overflow (only in link battles?)
   * Fix Pokémon icons used as overworld sprites changing after viewing the party menu
   * Gym Leader rematch sprites don't face correctly (spriteface command issue?)
   * Fix delay before last text box when Wonder Trading
   * Overworld Pokémon sprites can only be from one bank (always BANK(Icons1) at first) (if you view your party, whichever bank the last Pokémon is from gets used for the overworld)
* Aesthetic updates:
   * Animate new Pokémon sprites
   * Use updated Pokémon palettes, including shiny ones (changed ones: Charizard, Kangaskhan, Paras, etc)
   * Add more locations on the Town Map (Ilex Forest, Cerulean Cave, etc)
   * Fix jagged black borders on Town Map (imitate HGSS?)
   * Improve certain shiny palettes (Dragonite, Scizor, Espeon, Ursaring, Forretress)
   * Show Pokémon portraits when using field moves
   * Better Substitute sprite
   * Low-pitched cries when fainting
   * Better Town Map without bold black borders (imitate landmarks from HGSS)
   * Big roofs like Pewter Museum on Silph Co. and Pokémon Tower
   * Add Magnet Train tracks to Route 32 from HGSS
   * Add river to Route 46 from HGSS
   * Put legendary beasts in a pit in Burned Tower, not a platform
   * Make the Ruins of Alph tile with the surrounding maps
   * Add bridges to some caves like Victory Road
   * Add crater to Route 3 from HGSS
* Custom features:
   * Turn the News Machine into a Mystery Gift Machine (so you can get an Eon Mail for the lady in the PokéCom Center)
   * Allow three Wonder Trades per day, not just one
   * Faster text by default
   * Stereo sound by default
   * Optional Locke mode where fainted Pokémon cannot be revived (Max/Revive, Revival Herb, and Sacred Ash still fix HP and status so they aren't useless)
   * Select reorders Pokémon in party menu
   * Brief beeping with low HP
   * Send gift Pokémon to the PC if the party is full
   * Increase limits on Pokémon per box, number of boxes, coins in coin case, etc
   * More frequently successful fishing and Headbutting
   * More likely to find roaming Pokémon when on the correct route
   * The old man in Pewter City shows you Raikou and Entei in case you've never encountered them roaming
   * Suicune roams if you don't catch it in Bell Tower
   * Lawrence III appears in Victory Road after you catch all three legendary birds. He's searching for Moltres, and battles you to acquire it (team: Articuno, Zapdos, Charizard, Dragonite, Honchkrow, Tyranitar). He gives you the Silver Wing if you win.
   * Have Moves as an option in the party Pokémon menu during battle (might be too complicated to avoid glitches since moves can be reordered; also graphics glitches when the mini sprite overwrites the back sprite)
   * Fourth stat screen showing Poké Seer's data
   * Color party/day-care sprites by species
   * Sell evolution stones in Celadon Dept. Store
   * Change in-game trades
   * Cameo battle with Valerie on the Bellchime Trail after the Suicune event (Clefable, Mr. Mime, Wigglytuff, Azumarill, Togekiss, Sylveon) (reward: TM for DazzlinGleam)
   * Battle with Agatha in Lavender Town (Gengar, Crobat, Haunter, Mismagius, Arbok, Gengar)
   * Battle with Lorelei in Seafoam Islands (Dewgong, Cloyster, Mamoswine, Slowbro, Jynx, Lapras)
   * Battle with [Tsunekazu Ishihara](https://tcrf.net/Pok%C3%A9mon_Red_and_Blue#Deleted_Maps) in the Celadon Mansion dev room (Exeggutor, Porygon-Z, Jolteon, Dugtrio, Lapras, Rhydon)
   * Battle with [Shigeki Morimoto](http://bulbapedia.bulbagarden.net/wiki/Shigeki_Morimoto), Shigeru Miyamoto, and Satoshi Tajiri
   * Battle Bill at some point (five Eeveelutions and Porygon) (show him the three legendary dogs and he'll theorize that they originated from Eeveelutions and wants to battle)
   * Replace Cal in Trainer Hall with whichever gender character you don't pick
   * Include Lyra/Kotone as a friendly rival like in HGSS
      * She starts out with Marill, then takes whichever starter is left and battles you; her Pokémon do evolve, but her team is small (Azumarill, starter, Girafarig, Furret which she caught to teach you how)
   * Add a store to buy room decorations that Mom doesn't
   * Also include Green/Leaf on Navel Rock (Venusaur 84, Blastoise 84, Lapras 80, Jolteon 80, Hitmonlee 82, Alakazam 82) (get MysticTicket somehow on Mt. Silver, maybe a hidden item in Red's chamber, maybe as a gift in the Pokémon Center)
   * Encounter Yellow from the Pokémon Adventures manga in Yellow Forest (her Pikachus know Surf and Fly)
   * (Female) Pikachu that know Surf appear with a surf board; (male) Pikachu that know Fly appear with balloons
   * N would sympathize with the Ruins of Alph message about how "we depart for their sakes"
   * Allow Unown to learn AncientPower, Stored Power, and Cosmic Power (also make sure Togetic can learn Stored Power, AncientPower, Silver Wind, and Ominous Wind)
   * Silph Co. lets you onto more floors after restoring power; you can buy Repeat, Timer, Quick, and Dusk Balls
   * Scientist in back of Pewter Museum shows you an Omastar fossil (kept in storage due to its value)
   * Possible retypes: Voltorb+Electrode to Electric/Steel, Dunsparce to Normal/Ground, Butterfree to Bug/Psychic, Noctowl to Psychic/Flying, Ledian to Bug/Fighting, Ninetales to Fire/Psychic or Fire/Ghost, Persian to Normal/Dark, Golduck to Water/Psychic, Mismagius to Ghost/Fairy
   * Gift a shiny Ditto somewhere (maybe in Pokémon Mansion)
   * Add four Ace Trainers to Victory Road


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
* Selection of up to 254 items from all generations (Zinc, PP Max, Dawn Stone, Dusk Stone, etc)
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
* Import some devamped music from future generations


## See also

* Disassembly of [**Pokémon Red/Blue**][pokered]
* irc: [**freenode#pret**][irc]

[pokered]: https://github.com/iimarckus/pokered
[irc]: https://kiwiirc.com/client/irc.freenode.net/?#pret
