## Use or remove

* Use EMOTE_QUESTION, EMOTE_HAPPY, EMOTE_SAD, and EMOTE_SLEEP somewhere
* Use SPRITE_UNUSED_GUY (a still moustached man) somewhere
* Use or remove SPRITE_OLD_LINK_RECEPTIONIST
* Phase out SPRITE_MONSTER, SPRITE_FAIRY, SPRITE_BIRD, and SPRITE_DRAGON
* Add a variable sprite for Lyra that turns into Lass
* Add a variable sprite for Silver that turns into Bug Catcher

## Bugs

* Move Reminder doesn't list all possible moves
* Thief permanently steals held items
* TMs refresh PP
* Thick Club + Swords Dance Marowak Attack overflow (only in link battles?)
* Fix delay before last text box when Wonder Trading (is this still there?)
* Headbutt animation looks weird (wrong tile ID?)
* Make the gatehouse roof inside Yellow Forest the same as outside
* Make the gatehouse above the Ruins of Alph the same from Route 36
* Rocket outside Radio Tower isn't visible from Goldenrod Harbor (event is EVENT\_GOLDENROD\_CITY\_ROCKET\_SCOUT)
* Ellipses print too high in [a certain message](http://imgur.com/a/fBKWK)
* Protect prints (sometimes?) "X is protecting itself! Y's attack missed!"
* Dig sometimes prints that both Pokémon dug a hole
* Per-turn status animations might not always work
* Sleep lasts [2–4 turns](https://github.com/roukaour/pokecrystal/commit/252817539482c1fc3fe8dd24c484a74234a0b89a#commitcomment-18349313)?


## Battle mechanics

* http://smogon.site/forums/threads/gsc-mechanics.3542417/
* Gen III critical hit mechanics (ignore -Atk and +Def stat changes, don't ignore burn)
* Defrosted Pokémon can attack on that turn (like waking up)
* Substitute does not block sound-based moves
* Substitute prevents building Rage
* Drain Kiss drains 75% HP
* Avalanche doubles damage if user is hit first
* Low Kick's power is based on weight
* Thunder ignores accuracy and evasion in rain
* Rock-type Pokémon get Sp.Def boosted by 50% in a sandstorm
* Grass-type Pokémon are immune to PoisonPowder, Stun Spore, Sleep Powder, and Spore
* Ghost-type Pokémon are immune to the trapping effects of Mean Look, Clamp, Fire Spin, Whirlpool, and Wrap
* Rock Smash breaks screens instead of lowering Defense (like Brick Break) (non-faithful)


## Other mechanics

* Catch rate formula from Gen III
* Show stat changes and then absolute values on level up
* Some Pokémon evolve by knowing a certain move (Tangela, Yanma, and Pilowsine by knowing AncientPower)
* Brief beeping with low HP
* Healing items activate at 1/3 HP, not 1/2 (edit HandleHPHealingItem)
* Gold Berry heals 25% HP even in battle (edit ConsumeHeldItem)
* Select reorders Pokémon in party menu
* Send gift Pokémon to the PC if the party is full
* Bill calls to switch boxes when one is full
* Respawn uncaught legendaries after beating the Elite Four (Suicune roams)
* More frequently successful Headbutting (edit Script_respawn_one_offs)
* More likely to find roaming Pokémon when on the correct route
* Add more moves learned at level 1 for relearning
* Give female trainers better DVs, and use the new unique DVs feature to make certain Pokémon female


## Aesthetic updates

* Animate new Pokémon sprites
* Design custom animations for new moves
* Show Pokémon portraits when using field moves
* Better Substitute sprites
* Color party/day-care sprites by species
* Special sprites for Pikachu that know Surf or Fly
* Yellow Pikachu Surfing music
* Big roofs like Pewter Museum on Silph Co. and Pokémon Tower
* Goldenrod Dept.Store and Celadon Mansion roofs should have dark sky at night
* Add river to Route 46 from HGSS
* Add umbrellas to Olivine City benches
* Add Celadon Dept. Store electronics floor from RBY
* Use pagodas from [beta tilesets](https://tcrf.net/Pok%C3%A9mon_Gold_and_Silver#Tilesets)
* Merge gray and roof colors on Faraway Island to make room for another green


## New content

* Add Young Couple, Double Team, Dragon Tamer, PI, and Roughneck/Cue Ball trainer classes
* Use Mmmmmm's Shoal Cave / Mt. Pyre music for Seafoam Islands
* Use Mmmmmm's B/W Route 12 music for a new location
* Extend Lugia's chamber with flute music
* Use some of Soloo93's HG/SS Gym Leader [sprite devamps](https://hax.iimarck.us/post/36679/#p36679)?
* Use Mateo's X/Y Hex Maniac sprite devamp (or make an X/Y one)?
* Add wild Pokémon to Navel Rock?
* Lt. Surge's traps from RBY
* Unown ? and ! from Gen III
* More held items (some of: Life Orb, Expert Belt, Muscle Band, Wise Glasses, Wide Lens, Zoom Lens, Light Clay, Damp Rock, Heat Rock, Smooth Rock)
* Aurora Orb boosts Suicune's Defense and Special Defense
* Battle with Tower Tycoon Palmer as the last battle of every 5th and 10th 7-battle set in the Battle Tower
* Battle with Giovanni either in Radio Tower or with Celebi time traveling
* Battle with Cynthia in the Sinjoh Ruins after catching all 26 Unown (reward: Aurora Orb)
* Battle with Steven in some southern ruins ("Hojo Ruins"?), or in Mt. Quena (north of Olivine City?) (reward: ?)
* Battle Caitlin and Darach somewhere, possibly around the Battle Tower
* Cameo battle with Valerie on the Bellchime Trail after the Suicune event (Clefable, Mr. Mime, Wigglytuff, Azumarill, Togekiss, Sylveon) (reward: TM for DazzlinGleam)
* Battle with [Shigeki Morimoto](http://bulbapedia.bulbagarden.net/wiki/Shigeki_Morimoto) (game designer and programmer), [Kōji Nishino](http://bulbapedia.bulbagarden.net/wiki/K%C5%8Dji_Nishino) (planner), [Tsunekazu Ishihara](https://tcrf.net/Pok%C3%A9mon_Red_and_Blue#Deleted_Maps) (president and CEO), and/or Satoshi Tajiri (creator) in Celadon Mansion once a day
* Battle [En and Madoka](http://bulbapedia.bulbagarden.net/wiki/The_Legendary_Rotation_Battle!) somewhere


## New features

* Former trade evolutions work by maximizing vitamins (Machoke: Protein, Graveler: Iron, Haunter: Carbos, Alakazam: Calcium)
* Somebody post–Elite Four shows you Raikou and Entei in case you've never encountered them roaming
* Add an event based on the Spell of the Unown movie after you catch all 26
* Fourth stat screen showing Poké Seer's data
* Restore [unused memory game](http://iimarck.us/i/memory/)
* Add [Sweet Honey trees](http://iimarck.us/i/sweet-honey/) for Munchlax (replace Sweet Scent)
* Pickup ability for Meowth, Aipom, Teddiursa, and/or Phanpy
* Use the News Machine for something (Mystery Gift?)
* Optional Locke mode where fainted Pokémon cannot be revived (Max/Revive, Revival Herb, and Sacred Ash still fix HP and status so they aren't useless)
* Restore the Safari Game (some functionality, like HandleSafariAngerEatingStatus, already exists)
* Include Lyra/Kotone as a friendly rival like in HGSS
  * She starts out with Marill, then takes whichever starter is left and battles you; her Pokémon do evolve, but her team is small (Azumarill, starter, Girafarig, Furret which she caught to teach you how)
* Add a store to buy room decorations that Mom doesn't (the Goldenrod Dept. Store rooftop bargain sale and the harbor are good)
* Sometimes wild Pokémon know an egg move
* Breedable legendary trios with a certain held item
* Longer player and rival names
* More Bag pockets (split Items into Items, Medicine, and Berries)
* Press Start to auto-sort items
* Replace Smoochum and Stantler with Electivire and Magmortar (Magmarizer in Cinnabar Volcano, Electirizer in Rock Tunnel 2F)
* Replace Hoppip+Skiploom+Jumpluff with Sunkern+Sunflora and Rhyperior (Protector in Mt. Mortar)
* Replace Aipom with Shuckle
* Retype Sunflora to Grass/Fire
* Retype Electivire to Electric/Fighting
* Meet Falkner in Dark Cave to have him return to the gym, thus making you fight Sprout Tower first
* Merge Morning Sun and Synthesis into Sunlight, and add Hurricane
* Add a third Trainer Card page for Kanto badges
* Adjust Kanto trainers' levels closer to Gym Leaders
