
# FAQ

If you have a question about playing Polished Crystal, or think you've found a bug, please read this FAQ first.

> At the time, I was asking really obvious questions like: "So 'wireless' means you're getting rid of the wires, right?"
>
> — Tsunekazu Ishihara, "[Iwata Asks – Pokémon HeartGold Version & SoulSilver Version](https://www.nintendo.co.uk/Iwata-Asks/Iwata-Asks-Pokemon-HeartGold-Version-SoulSilver-Version/Iwata-Asks-Pokemon-HeartGold-Version-SoulSilver-Version/4-The-Power-of-Science-is-Staggering-/4-The-Power-of-Science-is-Staggering--226003.html)"


### Contents

* [Which file do I need to play?](#which-file-do-i-need-to-play)
* [Which emulator should I use?](#which-emulator-should-i-use)
* [Are there cheat codes?](#are-there-cheat-codes)
* [Is there documentation for all the {Pokémon, items, moves, etc}?](#is-there-documentation-for-all-the-pokémon-items-moves-etc)
* [What are the options at the start of a new game?](#what-are-the-options-at-the-start-of-a-new-game)
* [How can I change the current time?](#how-can-i-change-the-current-time)
* [What happened to Nuzlocke Mode?](#what-happened-to-nuzlocke-mode)
* [I don't recognize this move, what is it?](#i-dont-recognize-this-move-what-is-it)
* [How do I evolve my Pokémon?](#how-do-i-evolve-my-pokémon)
* [Where do I get the legendary Pokémon?](#where-do-i-get-the-legendary-pokémon)
* [Where do I get this item?](#where-do-i-get-this-item)
* [My Pokémon is a different color, is it shiny?](#my-pokémon-is-a-different-color-is-it-shiny)
* [Why is shiny Gyarados gold? Is the red Gyarados shiny?](#why-is-shiny-gyarados-gold-is-the-red-gyarados-shiny)
* [Where do I get Silver/Gold Leaves?](#where-do-i-get-silvergold-leaves)
* [Where do I get this TM/HM?](#where-do-i-get-this-tmhm)
* [What do blessings and photographs do?](#what-do-blessings-and-photographs-do)
* [What is the Judge Machine?](#what-is-the-judge-machine)
* [What are the "door-shaped grooves" in the Ruins of Alph and Route 47?](#what-are-the-door-shaped-grooves-in-the-ruins-of-alph-and-route-47)
* [I don't like non-canon Pokémon types!](#i-dont-like-non-canon-pokémon-types)
* [How can I switch from the faithful to the non-faithful version of the game?](#how-can-i-switch-from-the-faithful-to-the-non-faithful-version-of-the-game)


### Which file do I need to play?

The [3.2.3 release](https://github.com/Rangi42/polishedcrystal/releases/tag/v3.2.3) provides .gbc files and .sym files. You only need a .gbc file to play; they're ROMs, not patches. I recommend playing `polishedcrystal-3.2.3.gbc`, or `polishedcrystal-faithful-3.2.3.gbc` if you want a more faithful canon experience, without changes to Pokémon base stats or types.

Don't download the debug ROMs; they're for beta testing, not start-to-finish playthroughs. If you're aware of this and you want to help test for bugs, get a debug ROM, talk to your room's radio to unlock many things, and hold A+B to walk through walls.

The [2.2.0 release](https://github.com/Rangi42/polishedcrystal/releases/tag/v2.2.0) is not recommended for general play (it is very old, not supported for bugfixes and not the latest stable release). Only make use of this if you have an existing 2.x save and don't want to start over, since 2.x saves are not compatible with version 3.0.0 and above and cannot be patched.

This is the ROM you should use for patching 2.2.0:

* Pokémon - Crystal Version (UE) (V1.0) [C][!].gbc
  (`md5: 9f2922b235a5eeb78d65594e82ef5dde`)

It's identical to the one built by the [pokecrystal](https://github.com/pret/pokecrystal) project.


### Which emulator should I use?

Not every emulator is compatible with Polished Crystal. With the exception of the Virtual Console emulator, we do not offer any support if an emulator has a bug that isn't reproducible on official hardware. As such, we recommend the following emulators to limit compatibility issues:

#### PC:
* [mGBA](https://mgba.io/) - most popular emulator, no known incompatiblities, can also conveniently play GBA games
* [SameBoy](https://sameboy.github.io/) - one of the most accurate emulators, also has an iOS release
* [BGB](https://bgb.bircd.org/) - Polished Crystal developers use this emulator, more accurate than mGBA, powerful debugger

#### Android:
* [RetroArch](https://www.retroarch.com/) - use SameBoy, mGBA or Gambatte core, **do not use VBA-M core**

#### iOS:
* [SameBoy](https://sameboy.github.io/) - see PC section

Conversely, the following emulators are known to have issues and **should not be used** to play Polished Crystal:

#### PC:
* VBA - this emulator has not been updated since 2004, do not ever use
* VBA-M - despite being actively updated, still is a very inaccurate emulator, use mGBA instead

#### iOS:
* Delta - while we have had a higher incidence rate of issues with Delta, there is presently no evidence that the emulator itself has any issues. We do still strongly recommend using SameBoy on iOS, as we still are awaiting evidence of any unusual issues with this emulator and save states

#### Android:
* MyOldBoy - while most of the game is playable, it is incompatible with the Real-Time Clock in Polished Crystal.
* Nostalgia.GBC - the save file structure that this emulator produces is incompatible with Polished Crystal's save patcher, which means that updating your save to a newer version in the future will be impossible.
* JohnGBC - is confirmed to cause rendering issues and possibly more.

#### Other:
* Goomba Color - used to play GB/C games from a GBA flashcart, this emulator can't even run vanilla Crystal

If you have a preferred emulator that isn't listed above, using it should be fine. Most modern emulators can indeed run Polished Crystal just fine. Be aware, though, that if you're consistently having an issue that isn't reproduced on either official hardware or the most accurate emulators, you will not be provided any support.


### Are there cheat codes?

Cheat codes are *not* officially supported: new updates may change or break old codes, which can lead to irreversible save corruption. There is instead [**Polished Editor**](https://www.polishededitor.vercel.app/), an **unofficial** online save editor for *Pokémon Polished Crystal*, created and maintained by [Rev3lation (@rev3lation)](https://github.com/KohKaiSern).  

If you decide to use cheat codes anyway, note that cheat codes are easily misused - as such, **please disable cheats before complaining that there's a bug in the game, and don't ask for pre-made cheat codes**. Should you wish to create your own cheats, you may refer to the .sym files. The .sym files are created when you build Polished Crystal. They list the memory address of every label in the source code. These can be useful for [discovering GameShark cheat codes](https://github.com/pret/pokecrystal/wiki/Discovering-GameShark-cheat-codes). You can compare the addresses for Polished Crystal with the same labels for [pokecrystal](https://github.com/pret/pokecrystal/tree/symbols) to find the equivalents of old Crystal cheats.


### Is there documentation for all the {Pokémon, items, moves, etc}?


Make good use of the in-game features! The updated Pokédex has a lot more information, including base stats, abilities, detailed wild locations etc. In addition, call Professor Elm to find out how your Pokémon evolves, and call Lyra to find out when your Pokémon learns their next move.

Outside of the game, there exists a [wiki](https://github.com/Rangi42/polishedcrystal/wiki) that is provided with various info.
Alternatively, you may consider [**PolishedDex**](https://www.polisheddex.app/), an **unofficial** online companion site for *Pokémon Polished Crystal*, created and maintained by [Cammy (@caomicc)](https://github.com/caomicc).  
It provides a slew of searchable references, such as the Pokédex, move list, items, locations, abilities, wild encounters, special events and trainers, along with tools like a team builder, headbutt calculator, catch rate calculator and more.

Note that the in-game reference is typically the most accurate, and online resources may not always reflect the game accurately. For the most accurate reference, the game's [data files](data/) do a fairly good job of listing things you'll want to know. Some highlights:

* [Move attributes](data/moves/moves.asm)
* [Wild Pokémon](data/wild/)
* [Hidden Grottoes](data/events/hidden_grottoes/grottoes.asm)


### What are the options at the start of a new game?

* **Natures:** Enables [natures](https://bulbapedia.bulbagarden.net/wiki/Nature) from Gen 3 onward.
* **Abilities:** Enables [abilities](https://bulbapedia.bulbagarden.net/wiki/Ability) from Gen 3 onward.
* **Phys/Spcl split:** Enables the [Physical/Special split](https://bulbapedia.bulbagarden.net/wiki/Damage_category) from Gen 4 onward.
* **EV gain:** Changes how [EVs](https://bulbapedia.bulbagarden.net/wiki/Effort_values) behave. You can choose "All", which allows maxing every stat, "510" which features the modern 510 EV limit, or "No" which disables their effect completely, and will also cause Tyrogue's evolution to depend purely on its IVs.
* **Exp. scaling:** Enables the [experience formula](https://bulbapedia.bulbagarden.net/wiki/Experience#Gain_formula) from Gen 5, 7 and 8, which scales experience by the ratio of the opponent's level to your level.
* **Affection bonus:** Enables the modern Affection system, which can do things like make your Pokémon survive at 1 HP, cure themselves of status problems or evade attacks.
* **Real-time clock:** Enables the game to keep track of time even when you are not playing. Some cartridges or emulators may not support this. Disabling it will cause time to only tick when you play, and a day will last 4 hours.
* **Perfect stats:** All Pokémon stats, for you and the opponent, are calculated as if they had maximum IVs. The actual IVs are still random, so color variation and Hidden Power type are not affected. Note that this has no impact on EVs in any way.
* **Traded PKMN obey:** All differences in traded Pokémon go away: they always obey you, don't gain boosted experience, and can be nicknamed.
* **Evolve in battle:** Allows your Pokémon to evolve in the middle of a battle if their evolution conditions are met.
* **Color variation:** Enables color variation [inspired by Stadium](https://bulbapedia.bulbagarden.net/wiki/List_of_alternately_colored_Pok%C3%A9mon_in_the_games#Pok.C3.A9mon_Stadium). IVs will subtly vary Pokémon colors. This applies to normal and shiny Pokémon.

If you need to change these options after starting a game, press Left+B at the title screen (the screen of the running Suicune) to reset them.

### How can I change the current time?

Press Down+B at the title screen (the screen of the running Suicune) to reset the clock.

### What happened to Nuzlocke Mode?

Having a built-in Nuzlocke Mode led to assumptions that the game catered specifically to the Nuzlocke community, and was balanced accordingly. The problem is that this led to a lot of people complaining that we didn't, for example, offer a built-in level cap or infinite Rare Candies. In the end, we chose to remove the Nuzlocke Mode option to make it clear that, while we have nothing against people doing self-imposed challenges, we have no plans to specifically design the game around them.

Polished Crystal also has no support for in-game level caps, popular in Nuzlockes and other challenge runs. If you'd like to set a challenge for yourself by using them, see [this Wiki page](https://github.com/Rangi42/polishedcrystal/wiki/Nuzlocke#list-of-highest-levels).


### I don't recognize this move, what is it?

There's only room for 255 moves, including Struggle. I wanted to fit in as many useful new moves as possible, so some similar moves were combined to free up space.

* "**Fury Strikes**" = Fury Swipes + Fury Attack
* "**Healing Light**" = Morning Sun + Moonlight + Synthesis
* "**Fresh Snack**" = Softboiled + Milk Drink

Their animations in battle still depend on the Pokémon using them, e.g. Chansey's Fresh Snack looks like Softboiled, while Miltank's looks like Milk Drink. That's also the case for some moves that were consolidated: for example, Withdraw and Harden were removed, but Defense Curl has the animation of Withdraw for Squirtle, and of Harden for Geodude.

### How do I evolve my Pokémon?

* Ask Professor Elm! Give him a call with the Pokémon you have a question about in the lead slot in your party!
* Gen 1's trade evolutions now evolve by using the Linking Cord item.
* Item trade evolutions (like Seadra into Kingdra while holding a Dragon Scale) now evolve when leveling up while holding the item.
* Yanma, Tangela, and Piloswine evolve when leveling up while knowing AncientPower - a trip to the Move Relearner may prove useful here.
* Eevee evolves into Leafeon either with a Leaf Stone or by leveling up in Ilex Forest, site of the Moss Rock.
* Eevee evolves into Glaceon either with an Ice Stone or by leveling up in the Ice Path, site of the Ice Rock.
* Eevee evolves into Sylveon with a Shiny Stone.
* Magneton evolves into Magnezone when leveling up in Magnet Tunnel or Rock Tunnel, sites of the Lodestone.


### Where do I get the legendary Pokémon?

* Articuno is in the Seafoam Islands.
* Zapdos is on the roof of Rock Tunnel.
* Moltres is inside Cinnabar Volcano.
* Their Galarian counterparts can be found by summoning them to the great cherry tree in Cherrygrove Bay. In order to do this, you need Lures which you can obtain from battles in the old Rocket Hideout in Celadon City.
* Raikou and Entei are roaming Johto after you awaken them.
* Suicune is in the Bell Tower after you get the Clear Bell.
* Lugia is in the Whirl Islands after you visit Shamouti Island and then get the Silver Wing there.
* Ho-Oh is atop the Bell Tower after you catch all three legendary beasts and then get the Rainbow Wing in Bell Tower.
* Mewtwo is in Cerulean Cave.
* Mew is a secret; look around Cinnabar Island!
* Celebi is a secret; try Wonder Trading after beating the Elite Four! (And after you catch it, take it to the Ilex Forest shrine!)


### Where do I get this item?

* Exp Share is given by Elm's Aide in the Azalea Town/Ilex Forest gate house.
* Linking Cord is given by Elm's Aide in the Ecruteak City west gate house. A second one in Johto can be found in the lower levels of Union Cave.
* Macho Brace is given by Elm's Aide in Cliff Gate, accessible from Cianwood City.
* Lucky Egg is given by Elm's Aide in Blackthorn City.
* Helix Fossil and Dome Fossil are in Mt. Moon, or may appear from breakable rocks.
* Old Amber is in Pewter City, or may appear from breakable rocks.
* Razor Claw is in Quiet Cave, or held by some wild Johto-form Sneasel.
* Razor Fang is in Victory Road, or held by some wild Gligar.
* Electirizer is in Rock Tunnel, or held by some wild Electabuzz family.
* Magmarizer is on Cinnabar Island, or held by some wild Magmar family.
* Protector is in Mt. Mortar, or held by some wild Rhyhorn/Rhydon.
* Upgrade is given to you in Silph Co. after fixing the Power Plant generator.
* Dubious Disc is in Celadon City.
* King's Rock is in Slowpoke Well, or held by some wild Slowpoke family and Poliwhirl/Poliwrath/Politoed.
* Metal Coat is in the Goldenrod Dept. Store basement (in a part accessible after 7 badges), or held by some wild Magnemite family and Steelix.
* Hard Stone is given by Arthur on Route 36 on Thursdays, found by breaking rocks via Brick Break (Rock Smash in faithful) or held by some wild Happiny, Kantonian Corsola and Onix.
* Dragon Scale is in Mt. Mortar, or held by some wild Horsea family and Dratini family.
* Dusk Stones are in Cerulean Cave, Dark Cave, Dim Cave, Mt. Moon, Quiet Cave, Scary Cave or Union Cave. Bill's grandpa also gives you one, and you can win one in Bug-Catching Contest in the evening.
* Shiny Stones are in Cherrygrove Bay, Mt. Moon or National Park. Bill's grandpa also gives you one, and you can win one in Bug-Catching Contest in the morning.
* An Ice Stone is in Ice Path.
* Bill's grandpa lives in Goldenrod City and gives you one of each evolution stone except for the Ice Stone. Also, certain trainers will call you up to give you stones, just like in regular Crystal. [Hidden Grottoes](https://github.com/Rangi42/polishedcrystal/blob/master/data/events/hidden_grottoes/grottoes.asm) often have an evolution stone as a rare item. The Celadon Dept. Store sells several evolution stones and the Linking Cord.


### My Pokémon is a different color, is it shiny?

There's usually only a 1 in 4,096 chance to encounter a shiny Pokémon (which can be raised with the Shiny Charm or using the Masuda method), and they'll be marked with a star next to their name. You're probably noticing the effect of the **IVs vary colors** option (see [What are the options at the start of a new game?](#what-are-the-options-at-the-start-of-a-new-game)).


### Why is shiny Gyarados gold? Is the red Gyarados shiny?

I like the anime explanation that red Gyarados was forced to rapidly evolve from a Magikarp and kept its previous red coloration. So here, red Gyarados is a variant form, with its own color and different sprite. It's shiny locked, meaning it can't be shiny. Shiny Gyarados are gold, like shiny Magikarp.

### Where do I get Silver/Gold Leaves?

Silver Leaves are like Shards in future generations: they can be given to Move Tutors to learn moves. Wild Oddish and Gloom have a 55% chance of holding Silver Leaves, and there are some hidden on the ground in Ilex Forest.

Gold Leaves can be given to the Move Maniac in Cianwood City to relearn moves. Wild Bellsprout and Weepinbell have a 55% chance of holding Gold Leaves, and there are some hidden on the ground in Yellow Forest.

### Where do I get this TM/HM?

* HM02 Fly is given to you after a certain battle in Yellow Forest, at the end of Route 47+48, which become accessible after beating Chuck.
* HM04 Strength is given to you by the Gym Guide hiding in Cianwood City's Pokémon Center.
* HM06 Whirlpool is given to you after a battle with Lyra on Route 42, which becomes accessible after beating Jasmine.
* TM46 Thief is given to you by Lance after completing Team Rocket's Base in Mahogany Town.


### What do blessings and photographs do?

Daily blessings in Ecruteak City and photographs in Cianwood City make your Pokémon happier, just like haircuts or grooming. Using enough of them will raise your Pokémon's affection, which works similarly to affection mechanics in modern generations.


### What is the Judge Machine?

The Judge Machine in Goldenrod City's PokéCom Center shows your Pokémon's EVs (effort) and IVs (potential). To unlock it, breed at least one Egg and then talk to the engineer working on it.


### What are the "door-shaped grooves" in the Ruins of Alph and Route 47?

Those are opened up after you catch all 28 Unown and talk to the scientist who gave you the Unown Dex.


### I don't like non-canon Pokémon types!

I was hesitant to make original changes like this, because the goal is to be an improved Crystal version, not a new game. In the end I made two versions, one regular and one "faithful".

The regular version makes creative changes to Pokémon base stats and types, and to some move properties, mostly inspired by [Drayano's Sacred Gold and Storm Silver](https://gbatemp.net/threads/pokemon-sacred-gold-storm-silver.327567/). It also improves some translated terms that [Nob Ogasawara](https://twitter.com/dougdinsdale) [complained about](https://lparchive.org/Pokemon-Blue/code.html).

The faithful version does not change those things, besides updating stats to the latest canon generation.

### How can I switch from the faithful to the non-faithful version of the game?

There is no need to reset your progress. The save file for one is compatible with the other. Download the other version of the game (the .gbc file), and replace your current game file with the alternative version. Ensure that both your save file and new game file have the same file name. This completes the switch - load up your game in your emulator and continue playing.
