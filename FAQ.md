# FAQ

If you have a question about playing Polished Crystal, or think you've found a bug, please read this FAQ first.

> At the time, I was asking really obvious questions like: "So 'wireless' means you're getting rid of the wires, right?"
>
> — Tsunekazu Ishihara, "[Iwata Asks – Pokémon HeartGold Version & SoulSilver Version](https://www.nintendo.co.uk/Iwata-Asks/Iwata-Asks-Pokemon-HeartGold-Version-SoulSilver-Version/Iwata-Asks-Pokemon-HeartGold-Version-SoulSilver-Version/4-The-Power-of-Science-is-Staggering-/4-The-Power-of-Science-is-Staggering--226003.html)"


### Contents

* [Which file do I need to play?](#which-file-do-i-need-to-play)
* [What are the .sym files for?](#what-are-the-sym-files-for)
* [Is there documentation for all the {Pokémon, items, moves, etc}?](#is-there-documentation-for-all-the-pokémon-items-moves-etc)
* [Why is shiny Gyarados gold? Is the red Gyarados shiny?](#why-is-shiny-gyarados-gold-is-the-red-gyarados-shiny)
* [My Pokémon is a different color, is it shiny?](#my-pokémon-is-a-different-color-is-it-shiny)
* [What are the options at the start of a new game?](#what-are-the-options-at-the-start-of-a-new-game)
* [I don't recognize this move, what is it?](#i-dont-recognize-this-move-what-is-it)
* [How do I evolve my Pokémon?](#how-do-i-evolve-my-pokémon)
* [Where do I get the legendary Pokémon?](#where-do-i-get-the-legendary-pokémon)
* [Where do I get this item?](#where-do-i-get-this-item)
* [Where do I get Silver/Gold Leaves?](#where-do-i-get-silvergold-leaves)
* [Where do I get this TM/HM?](#where-do-i-get-this-tmhm)
* [What do blessings and photographs do?](#what-do-blessings-and-photographs-do)
* [What is the Judge Machine?](#what-is-the-judge-machine)
* [What are the "door-shaped grooves" in the Ruins of Alph and Route 47?](#what-are-the-door-shaped-grooves-in-the-ruins-of-alph-and-route-47)
* [I don't like non-canon Pokémon types!](#i-dont-like-non-canon-pokémon-types)
* [I want the missing Pokémon back!](#i-want-the-missing-pokémon-back)


### Which file do I need to play?

The [nightly 3.0.0 beta release](https://github.com/Rangi42/polishedcrystal/releases/tag/v3.0.0-beta-nightly) provides .gbc files and .sym files. You only need a .gbc file to play; they're ROMs, not patches. I recommend playing `polishedcrystal-3.0.0-beta-xxxxxxxx.gbc`, or `polishedcrystal-3.0.0-beta-xxxxxxxx-faithful.gbc` if you want a more faithful canon experience, without changes to Pokémon base stats or types.

Don't download the debug ROMs; they're for beta testing, not start-to-finish playthroughs. Although if you want to help test for bugs, get a debug ROM, talk to your room's radio to unlock many things, and hold A+B to wak through walls.

Remember the commit hash at the end of the nightly filename to identify which code is running.

The [2.2.0 release](https://github.com/Rangi42/polishedcrystal/releases/tag/v2.2.0) provides .ips patch files. Apply these to a default Crystal ROM with a tool like [Lunar IPS](http://fusoya.eludevisibility.org/lips/) (for Windows), [MultiPatch](http://projects.sappharad.com/tools/multipatch.html) (for OS X), or [UniPatcher](https://play.google.com/store/apps/details?id=org.emunix.unipatcher&hl=en) (for Android).

This is the ROM you should use for patching 2.2.0:

* Pokémon - Crystal Version (UE) (V1.0) [C][!].gbc  
  (`md5: 9f2922b235a5eeb78d65594e82ef5dde`)

It's identical to the one built by the [pokecrystal](https://github.com/pret/pokecrystal) project.


### What are the .sym files for?

The .sym files are created when you build Polished Crystal. They list the memory address of every label in the source code. These can be useful for [discovering GameShark cheat codes](https://github.com/pret/pokecrystal/wiki/Discovering-GameShark-cheat-codes). You can compare the addresses for Polished Crystal with the same labels for [pokecrystal](https://github.com/pret/pokecrystal/tree/symbols) to find the equivalents of old Crystal cheats.

Cheat codes are *not* officially supported: new updates may change or break old codes, disable cheats before complaining that there's a bug in the game, and don't ask for pre-made cheat codes.


### Is there documentation for all the {Pokémon, items, moves, etc}?

The game's [data files](data/) do a fairly good job of listing things you'll want to know. Some highlights:

* [Base stats and TM learnsets](data/pokemon/base_stats/)
* [Level-up learnsets and evolution methods](data/pokemon/evos_attacks.asm)
* [Egg moves](data/pokemon/egg_moves.asm)
* [Move attributes](data/moves/moves.asm)
* [TM+HM+tutor list](data/moves/tmhm_moves.asm)
* [Wild Pokémon](data/wild/)
* [Hidden Grottoes](data/events/hidden_grottoes/grottoes.asm)

For information that's not all in one file, like [faithful version differences](https://github.com/Rangi42/polishedcrystal/search?q=DEF+FAITHFUL), you can use GitHub's search in this repository.


### Why is shiny Gyarados gold? Is the red Gyarados shiny?

I like the anime explanation that red Gyarados was forced to rapidly evolve from a Magikarp and kept its previous red coloration. So here, red Gyarados is a variant form, with its own color and different sprite. It can't be shiny. Shiny Gyarados are gold, like shiny Magikarp.


### My Pokémon is a different color, is it shiny?

There's only a 1 in 4,096 chance to encounter a shiny Pokémon, and they'll be marked with a star next to their name. You're probably noticing the effect of the **IVs vary colors** option (see below).


### What are the options at the start of a new game?

* **Natures:** Enables [natures](https://bulbapedia.bulbagarden.net/wiki/Nature) from Gen 3 onward.
* **Abilities:** Enables [abilities](https://bulbapedia.bulbagarden.net/wiki/Ability) from Gen 3 onward.
* **Phys/Spcl split:** Enables the [Physical/Special split](https://bulbapedia.bulbagarden.net/wiki/Damage_category) from Gen 4 onward.
* **Exp. scaling:** Enables the [experience formula](https://bulbapedia.bulbagarden.net/wiki/Experience#Gain_formula) from Gen 5, 7 and 8, which scales experience by the ratio of the opponent's level to your level.
* **IVs vary colors:** Enables color variation [inspired by Stadium](https://bulbapedia.bulbagarden.net/wiki/List_of_alternately_colored_Pok%C3%A9mon_in_the_games#Pok.C3.A9mon_Stadium). DVs will subtly vary Pokémon colors. This applies to normal and shiny Pokémon.
* **Perfect stats:** All Pokémon stats, for you and the opponent, are calculated as if they had maximum IVs. The actual IVs are still random, so color variation and Hidden Power type are not affected.
* **Traded Pokémon treat you as OT:** All differences in traded Pokémon go away: they always obey you, don't gain boosted experience, and can be nicknamed.
* **Nuzlocke mode:** Enables a [Nuzlocke challenge](https://bulbapedia.bulbagarden.net/wiki/Nuzlocke_Challenge); see [FEATURES.md](FEATURES.md) for detailed clauses.

If you need to change these options after starting a game, press Left+B at the title screen to reset them.


### I don't recognize this move, what is it?

There's only room for 255 moves, including Struggle. I wanted to fit in as many useful new moves as possible, so some similar moves were combined to free up space.

* "**Fury Strikes**" = Fury Swipes + Fury Attack
* "**Healing Light**" = Morning Sun + Moonlight + Synthesis
* "**Fresh Snack**" = Softboiled + Milk Drink

Their animations in battle still depend on the Pokémon using them, e.g. Chansey's Fresh Snack looks like Softboiled, while Miltank's looks like Milk Drink. That's also the case for some moves that were consolidated: for example, Withdraw and Harden were removed, but Defense Curl has the animation of Withdraw for Squirtle, and of Harden for Geodude.

[Here's a table](https://cdn.discordapp.com/attachments/332698009060114434/754778965410971729/moves.png) of all the moves available in the 3.0.0 beta.


### How do I evolve my Pokémon?

* Item trade evolutions (like Seadra into Kingdra while holding a Dragon Scale) now evolve while holding the item.
* Yanma, Tangela, and Piloswine evolve while knowing AncientPower.
* Eevee evolves into Leafeon in Ilex Forest, site of the Moss Rock.
* Eevee evolves into Glaceon in the Ice Path, site of the Ice Rock.
* Eevee evolves into Sylveon with a Shiny Stone.
* Magneton evolves into Magnezone in Rock Tunnel, site of the Lodestone.
* Machoke, Graveler, Haunter, and Kadabra evolve by having sufficient EVs in Attack, Defense, Speed, and Special respectively (five Protein, Iron, Carbos, or Calcium is enough).


### Where do I get the legendary Pokémon?

* Articuno is in the Seafoam Islands.
* Zapdos is above the Power Plant after you fix the generator.
* Moltres is inside Cinnabar Volcano.
* Raikou and Entei are roaming Johto after you awaken them.
* Suicune is in the Bell Tower after you get the Clear Bell.
* Lugia is in the Whirl Islands after you catch all three legendary birds and then get the Silver Wing in Victory Road.
* Ho-Oh is atop the Bell Tower after you catch all three legendary beasts and then get the Rainbow Wing in Bell Tower.
* Mewtwo is in Cerulean Cave.
* Mew is a secret; look around Cinnabar Island!
* Celebi is a secret; try Wonder Trading after beating the Elite Four! (And after you catch it, take it to the Ilex Forest shrine!)


### Where do I get this item?

* Helix Fossil and Dome Fossil are in Quiet Cave.
* Old Amber is in Pewter City.
* Razor Claw is in Quiet Cave, or held by some wild Sneasel.
* Razor Fang is in Victory Road, or held by some wild Gligar.
* Electirizer is in Rock Tunnel, or held by some wild Electabuzz.
* Magmarizer is on Cinnabar Island, or held by some wild Magmar.
* Protector is in Mt. Mortar, or held by some wild Rhydon.
* Up-Grade is given to you in Silph Co. after fixing the Power Plant generator.
* Dubious Disc is in Celadon City.
* King's Rock is in Slowpoke Well, or held by some wild Slowpoke/Slowbro and Poliwhirl.
* Metal Coat is in the Goldenrod Dept. Store basement, or held by some wild Magnemite/Magneton and Steelix.
* Dragon Scales are in Dragon's Den and Mount Mortar, or held by some wild Horsea/Seadra and Dratini/Dragonair.
* Dusk Stones are in Dark Cave, Quiet Cave, Cerulean Cave, and Mt. Moon. Bill's grandpa also gives you one.
* Shiny Stones are in National Park, Cherrygrove Bay, and Mt. Moon. Bill's grandpa also gives you one.
* Bill's grandpa gives you one of each evolution stone in Goldenrod City. Also, certain trainers will call you up to give you stones, just like in regular Crystal. The Celadon Dept. Store sells the Fire, Water, Thunder, and Leaf Stones.


### Where do I get Silver/Gold Leaves?

Silver Leaves are like Shards in future generations: they can be given to Move Tutors to learn moves. Wild Oddish have a 50% chance of holding Silver Leaves, and there are some hidden on the ground in Ilex Forest.

Gold Leaves can be given to the Move Maniac in Cianwood City to relearn moves. Wild Bellsprout have a 50% chance of holding Gold Leaves, and there are some hidden on the ground in Yellow Forest.


### Where do I get this TM/HM?

* HM02 Fly is given to you after a certain battle in Yellow Forest, at the end of Route 47+48, which become accessible after beating Chuck.
* HM04 Strength is given to you by the Gym Guide hiding in Cianwood City's Pokémon Center.
* HM06 Whirlpool is given to you after a battle with Lyra on Route 42, which becomes accessible after beating Jasmine.
* TM46 Thief is given to you by Lance after completing Team Rocket's Base in Mahogany Town.


### What do blessings and photographs do?

Daily blessings in Ecruteak City and photographs in Cianwood City make your Pokémon happier, just like haircuts or grooming.


### What is the Judge Machine?

The Judge Machine in Goldenrod City's PokéCom Center shows your Pokémon's EVs (effort) and IVs (potential). To unlock it, breed at least one Egg and then talk to the engineer working on it.


### What are the "door-shaped grooves" in the Ruins of Alph and Route 47?

Those are opened up after you catch all 28 Unown and talk to the scientist who gave you the Unown Dex.


### I don't like non-canon Pokémon types!

I was hesitant to make original changes like this, because the goal is to be an improved Crystal version, not a new game. In the end I made two versions, one regular and one "faithful".

The regular version makes creative changes to Pokémon base stats and types, and to some move properties, mostly inspired by [Drayano's Sacred Gold and Storm Silver](https://gbatemp.net/threads/pokemon-sacred-gold-storm-silver.327567/). It also improves some translated terms that [Nob Ogasawara](https://twitter.com/dougdinsdale) [complained about](https://lparchive.org/Pokemon-Blue/code.html).

The faithful version does not change those things, besides updating stats to the latest canon generation.


### I want the missing Pokémon back!

As [FEATURES.md](FEATURES.md) notes, 14 Pokémon had to be removed to make room for 17 Pokémon from Gen 4 (as well as Sylveon from Gen 6 to complete the Eeveelutions). I won't be able to restore them until the engine supports species IDs larger than 8 bits. There are some plans for 9-bit IDs, allowing over 500 Pokémon, but it will take time.

I do think that the added Pokémon are one part of "polishing" Crystal version. Some of the new or improved things from Gen 4, like Leafeon, Tangrowth, or the extra map of Slowpoke Well, were originally planned for Gen 2, as we now know from the [Space World '97](https://tcrf.net/Proto:Pok%C3%A9mon_Gold_and_Silver/Spaceworld_1997_Demo) ROMs. The Sinjoh Ruins in HG/SS emphasize this connection between Johto/Gen 2 and Sinnoh/Gen 4. Although cutting any Pokémon is regrettable, I'd consider skipping Pokémon like Porygon-Z or Honchkrow to be worse than replacing Delibird or Lickitung.
