# Pokémon Polished Crystal

This is a custom Pokémon game based on [the Pokémon Crystal disassembly](https://github.com/pret/pokecrystal).

My goal is to create what the title says: an improved, polished version of Pokémon Crystal. It fixes bugs, takes into account the official game changes since 2001, and adds some new ideas of my own. Many features restore what was removed from R/B/Y, or original to HG/SS.

I've had vague plans to make a Pokémon game for years. I'm very impressed by the effort that's gone into disassembling Pokémon Crystal and making the code so well-organized. Thanks to making it open-source (and to the ROM hackers that inspired me), I'm finally making this game a reality.


## Download and Play

The most recent version is 2.0.1 as of September 9, 2016.

To play, download the .ips patch file, and use a tool like [Lunar IPS](http://fusoya.eludevisibility.org/lips/) (for Windows), [MultiPatch](http://projects.sappharad.com/tools/multipatch.html) (for OS X), or [UniPatcher](https://play.google.com/store/apps/details?id=org.emunix.unipatcher&hl=en) (for Android) to apply the patch to a default Crystal ROM.

This is the ROM you should use:

* Pokémon - Crystal Version (UE) (V1.0) [C][!].gbc  
  (`md5: 9f2922b235a5eeb78d65594e82ef5dde`)

It's identical to the one built by the [pokecrystal](https://github.com/pret/pokecrystal) project.

*If you want to do a [Nuzlocke Challenge](http://bulbapedia.bulbagarden.net/wiki/Nuzlocke_Challenge), check out Nuzlocke mode in the Option menu!*

There are two patches for Polished Crystal. The "faithful" patch does not change any Pokémon base stats or move attributes beyond the updates in Gen VI. The regular patch has some custom changes for more diverse and viable Pokémon.

* [Pokémon Polished Crystal 2.0.1](patches/polishedcrystal-2.0.1.ips)  
  (IPS patch file `md5: 961c1a1ba360e4153a70d1ab94c7057f`)  
  (Patched GBC ROM `md5: bc2874247d8dd2f609d877cb8cb2c204`)
* [Pokémon Polished Crystal (Faithful) 2.0.1](patches/polishedcrystal-faithful-2.0.1.ips)  
  (IPS patch file `md5: a962f9fa3b9316d49cf1077627037858`)  
  (Patched GBC ROM `md5: 87285af80c7aa2e3b1912bb0466ed0a9`)


## Features

A full list of features is in [FEATURES.md](FEATURES.md). Some highlights:

* 253 Pokémon, including some new evolutions.
* 48 new moves.
* 65 TMs and 21 move tutors.
* Many new mechanics, including the Fairy type, Physical/Special split, unlimited TMs, Running Shoes, and continuous Repel.
* New maps: some restored from R/B/Y, some devamped from HG/SS, and some original.
* New characters, including Lorelei and Agatha from R/B/Y, Lyra and the Team Rocket Executives from HG/SS, and others.
* Steadily increasing challenges throughout the game, with new post-game content that climaxes in a level 100 battle.
* Music and graphics devamped from other versions.
* Nuzlocke mode in the Option menu, enabling the basic rules of the [Nuzlocke Challenge](http://bulbapedia.bulbagarden.net/wiki/Nuzlocke_Challenge).


## Screenshots

![title-screen](screenshots/title-screen.png)
![running-shoes](screenshots/running-shoes.png)
![town-map](screenshots/town-map.png)
![lyra](screenshots/lyra.png)
  
![cherrygrove-city](screenshots/cherrygrove-city.png)
![pokemon-center](screenshots/pokemon-center.png)
![nuzlocke-mode](screenshots/nuzlocke-mode.png)
![oaks-aide](screenshots/oaks-aide.png)
  
![elder-li](screenshots/elder-li.png)
![move-tutor](screenshots/move-tutor.png)
![moss-rock](screenshots/moss-rock.png)
![rich-boy](screenshots/rich-boy.png)
  
![tm58](screenshots/tm58.png)
![game-corner-prizes](screenshots/game-corner-prizes.png)
![goldenrod-move-tutor](screenshots/goldenrod-move-tutor.png)
![eviolite](screenshots/eviolite.png)
  
![wonder-trade](screenshots/wonder-trade.png)
![ecruteak-shrine](screenshots/ecruteak-shrine.png)
![cowgirl](screenshots/cowgirl.png)
![olivine-city](screenshots/olivine-city.png)
  
![remoraid](screenshots/remoraid.png)
![shiny-bellossom](screenshots/shiny-bellossom.png)
![hex-maniac](screenshots/hex-maniac.png)
![team-rocket](screenshots/team-rocket.png)
  
![steelix](screenshots/steelix.png)
![custom-map](screenshots/custom-map.png)
![ice-rock](screenshots/ice-rock.png)
![route-45](screenshots/route-45.png)

![sitrus-berry](screenshots/sitrus-berry.png)
![weavile](screenshots/weavile.png)
![move-reminder](screenshots/move-reminder.png)
![moves](screenshots/moves.png)
  
![sylveon-moonblast](screenshots/sylveon-moonblast.png)
![togetic-fairy-wind](screenshots/togetic-fairy-wind.png)
![aerodactyl-fossil](screenshots/aerodactyl-fossil.png)
![cerulean-city](screenshots/cerulean-city.png)
  
![celadon-city](screenshots/celadon-city.png)
![fly-to-rock-tunnel](screenshots/fly-to-rock-tunnel.png)
![viridian-forest](screenshots/viridian-forest.png)
![mismagius](screenshots/mismagius.png)
  
![fighting-dojo](screenshots/fighting-dojo.png)
![silph-co](screenshots/silph-co.png)
![new-balls](screenshots/new-balls.png)
![rock-tunnel](screenshots/rock-tunnel.png)
  
![safari-zone](screenshots/safari-zone.png)
![soul-house](screenshots/soul-house.png)
![cinnabar-island](screenshots/cinnabar-island.png)
![seafoam-islands](screenshots/seafoam-islands.png)


## FAQ

**Is there a Pokédex document I can refer to?**

The game's data files do a fairly good job of listing things you'll want to know.

* [Base stats and TM learnsets](data/base_stats/)
* [Level-up learnsets and evolution methods](data/evos_attacks.asm)
* [Egg moves](data/egg_moves.asm)
* [Move attributes](battle/moves/moves.asm)
* [TM+HM+tutor list](engine/tmhm.asm#L48)
* [Wild Pokémon](data/wild/)

**How do I evolve my Pokémon?**

* Item trade evolutions (like Seadra into Kingdra while holding a Dragon Scale) now evolve while holding the item.
* Yanma, Tangela, and Piloswine evolve while knowing AncientPower.
* Eevee evolves into Leafeon in Ilex Forest, site of the Moss Rock.
* Eevee evolves into Glaceon in the Ice Path, site of the Ice Rock.
* Eevee evolves into Sylveon with a Shiny Stone.
* Magneton evolves into Magnezone in Rock Tunnel, site of the Lodestone.
* Machoke, Graveler, Haunter, and Kadabra evolve by having sufficient EVs in Attack, Defense, Speed, and Special respectively (five Protein, Iron, Carbos, or Calcium is enough).

**Where do I get the legendary Pokémon?**

* Articuno is in the Seafoam Islands.
* Zapdos is above the Power Plant after you fix the generator.
* Moltres is inside Cinnabar Volcano.
* Raikou and Entei are roaming Johto.
* Suicune is in the Bell Tower after you get the Clear Bell.
* Lugia is in the Whirl Islands after you catch all three legendary birds and then get the Silver Wing in Victory Road.
* Ho-Oh is atop the Bell Tower after you catch all three legendary beasts and then get the Rainbow Wing in Bell Tower.
* Mewtwo is in Cerulean Cave.
* Mew and Celebi are a secret!

**Where do I get this item?**

* The Razor Claw is in Quiet Cave, or held by some wild Sneasel.
* The Razor Fang is in Victory Road, or held by some wild Gligar.
* The Electirizer is in Rock Tunnel, or held by some wild Electabuzz.
* The Magmarizer is on Cinnabar Island, or held by some wild Magmar.
* The Protector is in Mt. Mortar, or held by some wild Rhydon.
* The Up-Grade is given to you in Silph Co. after fixing the Power Plant generator.
* The Dubious Disc is in Celadon City.
* The Metal Coat is in the Goldenrod Dept. Store basement, or held by some wild Magnemite/Magneton and Steelix.
* Dragon Scales are in Dragon's Den and Mount Mortar, or held by some wild Horsea/Seadra and Dratini/Dragonair.
* King's Rocks are in Slowpoke Well and the Seafoam Islands, or held by some wild Slowpoke/Slowbro and Poliwhirl.
* Dusk Stones are in Dark Cave, Quiet Cave, Cerulean Cave, and Mt. Moon. Bill's grandpa also gives you one.
* Shiny Stones are in National Park, Cherrygrove Bay, and Mt. Moon. Bill's grandpa also gives you one.
* Bill's grandpa gives you one of each evolution stone in Goldenrod City. Also, certain trainers will call you up to give you stones, just like in regular Crystal. The Celadon Dept. Store sells the Fire, Water, Thunder, and Leaf Stones.

**Where do I get Silver/Gold Leaves?**

Silver Leaves are like Shards in future generations: they can be given to Move Tutors to learn moves. Wild Oddish have a 50% chance of holding Silver Leaves, and there are some hidden on the ground in Ilex Forest.

Gold Leaves can be given to the Move Maniac to relearn moves. Wild Bellsprout have a 50% chance of holding Gold Leaves, and there are some hidden on the ground in Yellow Forest.

**Where do I get this TM/HM?**

* HM02 Fly is given to you after a certain battle in Yellow Forest, at the end of Route 47+48, which become accessible after beating Chuck.
* HM06 Whirlpool is given to you after a battle with Lyra on Route 42, which becomes accessible after beating Jasmine.
* TM46 Thief is given to you by Lance after completing Team Rocket's Base in Mahogany Town.

**What do blessings and photographs do?**

Daily blessings in Ecruteak City and photographs in Cianwood City make your Pokémon happier, just like haircuts or grooming.

**I don't like non-canon Pokémon types!**

I was hesitant to make original changes like this, because the goal is to be an improved Crystal version, not a new game. In the end I made two versions, one regular (with changes) and one "faithful" (with original typings).


## Bugs

[TODO.md](TODO.md) contains a full list of possible future changes, including these bugs to fix:

* Nuzlocke mode sometimes turns on by itself.
* The Move Reminder doesn't list all the possible moves.
* Thief permanently steals held items.
* TMs can restore PP.
* NPC trainers overuse Baton Pass.
* Some NPC trainers incorrectly use X Spcl. Atk.
* Avalanche's power doesn't double if the user is hit first.


## Changes in 2.0.2

These changes have been made since the previous 2.0.1 release. If you build the project as-is, it will include all of them.

* Add: Connect Goldenrod Harbor to Route 41 west and Olivine City north.
* Add: Move stats show accuracy.
* Add: Buy basic items in Yellow Forest gate.
* Add: Yellow Surfing Pikachu music.
* Add: Correct OT genders for Wonder Trade.
* Add: Hurricane is 100% accurate in rain.
* Add: Blizzard is 100% accurate in hail.
* Add: Meowth+Persian can learn False Swipe.
* Add: Shellder+Cloyster can learn Waterfall.
* Add: Moomoo accepts Oran or Sitrus Berries (Sitrus heals +2).
* Add: Buff Fire Spin and Whirlpool to 90% accuracy (non-Faithful).
* Add: Name Cameron, Teala, and Felicity.
* Edit: Some wild encounters and trainer rosters.
* Edit: Berry locations.
* Edit: Remove Cut tree blocking Celadon Gym.
* Edit: Palmer's sprite.
* Edit: Brighter purple for sprites.
* Edit: Buff Ditto.
* Fix: Thief permanently steals held items.
* Fix: Make Route 24 Rocket Grunt mandatory to avoid sequence breaking.
* Fix: Static Pokémon respawn if they're caught.
* Fix: Lyra's catching tutorial breaks the map music.
* Fix: Text overflow in Sandstorm TM house.
* Fix: Waterfall HM item ball is blue.
* Fix: Surfing Pikachu's picture.
* Fix: Expert Belt → Wise Glasses.
* Fix: No wild encounters in Cherrygrove Bay.
* Fix: Slowking evolution check before Slowbro.
* Fix: Leafeon/Glaceon evolution check before Espeon/Umbreon.
* Fix: Crunch lowers Defense, not Special Defense.
* Fix: Ice Shard's description overflows into Toxic's.
* Fix: Hurricane can hit during Fly.
* Fix: Toxic used by Poison-types can hit during Fly and Dig.
* Fix: AI overuse of Future Sight.
* Fix: Alphabetical Pokédex was missing Magnezone.
* Fix: Fire Spin and Whirlpool have 35 power, 85% accuracy, and 15 PP.
* Fix: Trapping moves do 1/8 damage each turn and last 4–5 turns.
* Fix: Waterfall tile animation.
* Fix: Whirl Islands Lugia music.
* Fix: Hidden Power has fixed power now.
* Fix: Consistent music volume for all tracks.
