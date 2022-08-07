# To Do

> Of course, it is very difficult to make the game, so I hope people don't get their expectations up too high.
>
> — Shigeru Ohmori, "[Pokémon's Developers Talk About Their Console RPG Debut On Switch](http://www.gameinformer.com/b/features/archive/2017/08/08/pokemon-s-developers-talk-about-their-console-rpg-debut-on-switch.aspx)"


## Missing content

The final, non-beta 3.0 release should include all of these.


### General

* Search for "TODO" in the code and finish it
* Fix bugs, including everything on the [Issues](/issues)
* Give NPCs better teams, using the new held items
* Trim egg moves to just leave the possible ones
* Adjust the difficulty curve as needed


### Mechanics

* Option for 510 total limit on EVs
* Finish adding hidden grottoes throughout Johto
* Variety Channel with daily unique music
* Separate radio channels for March and Lullaby, available every day
* Add more random team members for Psychic Inver
* Wild Ghosts and the SilphScope2 in Lavender Town
* More location-unique wild moves (see [material/moves.txt](material/moves.txt))
* Finish wild rosters
* DVs to vary palettes for trainers' duplicate Pokémon (e.g. Clair's Dragonairs)
* Make all the variant forms available
   * Persian as a one-time trade from an Alolan tourist (you can breed it for more)
   * Grimer/Muk in Goldenrod City (Celadon's Muk are a sign of its pollution, Goldenrod's Alolan Muk would be a sign that they manage pollution better)
   * Ponyta/Rapidash on Shamouti Island
   * Corsola/Cursola in Scary Cave
   * Farfetch'd/Sirfetch'd instead of non-faithful Farfetch'd


### Aesthetics

* Play a shiny flash when Pokémon are caught (from Prism)
* "make hgss" to use HGSS-based palettes


### Events

* Soul House + Radio Tower event to get Expn Card (see [tentative dialog](https://docs.google.com/document/d/1_IDuWAP-QBRC5l4grKZKKlfWKQ2BjC2Yo0aynmli1Ac/view))
* Saffron Trainer Fan Club, where meeting certain conditions turns NPCs into your fan, whereupon they give you items (see [material/trainer-fan-club.txt](material/trainer-fan-club.txt))
* Rematch Eusine in Celadon City if you have Suicune in your party
* Rematch Bill in his house somehow
* Calling Lyra should have more varied messages giving evolution advice like [B2/W2](https://bulbapedia.bulbagarden.net/wiki/Professor_Juniper/Quotes#Evolution_hints_.28Xtransceiver.29) (see [material/lyra-dialog.txt](material/lyra-dialog.txt))
* Name trainers after anime characters (Jackson, Ritchie, Liza, Kidd, Lisa)
* Acquire dolls from NPCs throughout the regions
* Red goes back home after you battle him, and returns to Mt. Silver after you battle Green; Green disappears until you battle Red
* Clarify that Silver dropped his trainer card, like in HGSS
* Nurse trainer class (heals you afterwards)
* Gambler trainer class (uses Game Corner mons)
* Soldier trainer class (in Lt. Surge's Gym; also ones elsewhere with Remoraid, Octillery, Forretress, Skarmory, Electrode, Donphan)

Shamouti Island:

* Caitlin and Darach in Beautiful Beach villa (EVENT_BEAT_DARACH and EVENT_BEAT_CAITLIN)
* Looker in hotel room (not S.S. Aqua)


### Maps

Maps need signs, NPCs, trainers (with [dialog](https://docs.google.com/document/d/1_IDuWAP-QBRC5l4grKZKKlfWKQ2BjC2Yo0aynmli1Ac/view) (see also [material/pia-dialogue.txt](material/pia-dialogue.txt) and [material/pokeathlon-dialog.txt](material/pokeathlon-dialog.txt))), visible and hidden items, wild Pokémon, and unique wild moves.

* Connect the Magnet Train track south to Cherrygrove Bay
* Magnet Tunnel (TM74 Gyro Ball)
* Soul House
* Lavender Radio Tower (use Reina, DJ Fern, DJ Lily, and a Clefable+Gengar Couple)
* Saffron City Trainer Fan Club
* Valencia Island (signs and NPCs)
* Route 49 (wild Pokémon and unique wild moves)
* Safari Zone rest houses (NPCs and maybe trainers)
* Reference the Pokéathlon Dome with workers/engineers inside the Route 35 gate and Route 35 Coast
* Goldenrod Museum
* Violet Outskirts with haunted house (EVENT_SAW_HAUNTED_ROOM)


Shamouti Island:

* Shamouti Island
* Shamouti Restaurant (works like Seven Stars Restaurant) (different subset of all trainers every day of the week)
  - Should award Odd Souvenir to make it a renewable reward


### Optimizations

* Optimize map scripts with the various new commands and PERSONTYPE_GENERICTRAINER


## Postponed until 4.0

Some of these may never be added; they're just suggestions.

* More Pokémon
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
   * Add certain other Gen 3+ Pokémon; Prism's dex is similar to my own taste
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
      * Skiddo → Gogoat
      * Mareanie → Toxapex (in Cherrygrove Bay with Corsola)
      * Wooloo → Dubwool
      * Cufant → Copperajah
* More music
   * PGo Overworld/Walking (for Safari Game)
   * PGo Battle! Legendary Raid (for Mew)
   * S/M Malie City (Day) (for Shamouti Shrine)
* More Orange Islands
* First Pokémon walks behind you ([comet's prototype](https://hax.iimarckus.org/topic/6248/) and [diff](https://github.com/yenatch/pokecrystal/commit/dbc5cd2025a0214c5b2cd1e3330f50603a0bb9d1))
* Seasons with appropriate day/night lengths from B/W (affects palettes, tiles, wild Pokémon, dialog, accessible areas, etc)
* Dive areas
* Rock Climb areas
* Medals for achievements
* Take photos with your team against backdrops
* Something like Habitat Lists or DexNav via the Town Map
* Something like Poké Radar or Pokéwalker
* Rarely wild Pokémon know an egg move (could be a bonus for DexNav or Poké Radar use)
* Use the [Japanese GS Ball event quiz](https://www.pokecommunity.com/showthread.php?p=9739072#post9739072) ([original](http://www.geocities.co.jp/Playtown-Darts/9915/serebi.htm))
* Restore [unused memory game](http://iimarckus.org/i/memory/) ([more info](https://tcrf.net/Pok%C3%A9mon_Gold_and_Silver#Unused_Memory_Game))
* Restore the Pikachu's Beach minigame
* Level ranges for wild Pokémon, instead of single values
* Championship title defense like in Gen VII (challengers: rival, Lyra, Lance, Prof.Oak, Prof.Elm, Clair, Blue, Eusine, Kimono Girl Naoko, Palmer, Lorelei, Agatha, Steven, Cynthia, Caitlin, and Lawrence)
* Make more trainers rematchable
* Allow evolution during battle (optional)
* Battle [En and Madoka](http://bulbapedia.bulbagarden.net/wiki/The_Legendary_Rotation_Battle!) somewhere (Trainer House after catching the legendary trios, different trainer each day?)
   * Madoka:
   * She entered this tournament with new Pokémon! Which Pokémon wil she use?
   * "I knew this Pokémon was strong! I didn't spend days and days to find and catch it for nothing."
   * "What? Why did this Pokémon lose?"
   * "I'll come back after raising Pokémon more seriously."
   * En:
   * He wants to battle strong opponents! That is his only wish!
   * "Being able to battle with you, the best Trainer, in the best stage... Ah! I'm really happy right now!"
   * "Oh! This is my first time battling against such a strong opponent!"
   * "Your attack was great! Let's battle again sometime!"
* Select reorders Pokémon in party menu
* Use Mart interface for selling decorations, with a red sidebar
* Make Eggs use their Pokémon's palette

There are some features that I do *not* ever plan to add to Polished Crystal:

* All 802 Pokémon
* A third region with badges
* Mega Evolution
* Z-moves
* Ash-Greninja
* Ash Ketchum
* Gen VI Exp. Share
* Levels above 100
