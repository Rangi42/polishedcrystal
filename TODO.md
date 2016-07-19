* Remove unused code and resources to make room for new stuff

* Modern battle mechanics:
   * http://smogon.site/forums/threads/gsc-mechanics.3542417/
   * Gen III critical hit mechanics (ignore -Atk and +Def stat changes, don't ignore burn)
   * Sleep lasts 1-3 turns, not 1-7
   * Freeze has a 20% chance to dethaw, can attack on that turn (like waking up), and the freeze animation happens each turn (like the other conditions)
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
   * Some Pokémon evolve by knowing a certain move (Tangela, Yanma, and Pilowsine by knowing AncientPower)
   * Lt. Surge's traps from RBY
   * More held items (some of: Life Orb, Light Clay, Damp Rock, Heat Rock, Smooth Rock, Expert Belt, Muscle Band, Wise Glasses, Wide Lens, Zoom Lens)
   * Respawn uncaught legendaries after beating the Elite Four
   * Add more moves learned at level 1 for relearning
   * Evolve some Pokémon by knowing a certain move

* Fix bugs:
   * Some overworld sprites glitch when walking
   * Move Reminder doesn't list all possible moves
   * Overworld Pokémon sprites can only be from one bank (always BANK(Icons1) at first) (if you view your party, whichever bank the last Pokémon is from gets used for the overworld)
   * Thick Club + Swords Dance Marowak Attack overflow (only in link battles?)
   * Fix delay before last text box when Wonder Trading

* Increased difficulty:
   * Give female trainers better DVs, and use the new unique DVs feature to make certain Pokémon female

* Aesthetic updates:
   * Animate new Pokémon sprites
   * Design custom animations for new moves
   * Show Pokémon portraits when using field moves
   * Better Substitute sprites
   * Big roofs like Pewter Museum on Silph Co. and Pokémon Tower
   * Goldenrod Dept.Store and Celadon Mansion roofs should have dark sky at night
   * Add Young Couple and Double Team trainer classes
   * Add river to Route 46 from HGSS
   * Add umbrellas to Olivine City benches
   * Add Celadon Dept. Store electronics floor from RBY
   * Use pagodas from [beta tilesets](https://tcrf.net/Pok%C3%A9mon_Gold_and_Silver#Tilesets)

* Custom features:
   * Turn the News Machine into a Mystery Gift Machine (so you can get an Eon Mail for the lady in the PokéCom Center)
   * Optional Locke mode where fainted Pokémon cannot be revived (Max/Revive, Revival Herb, and Sacred Ash still fix HP and status so they aren't useless)
   * Select reorders Pokémon in party menu
   * Brief beeping with low HP
   * Pokédex area display uses whiever region you're in (edit engine/pokegear.asm:_Area)
   * Send gift Pokémon to the PC if the party is full
   * Increase limits on Pokémon per box, number of boxes, coins in coin case, etc
   * More frequently successful fishing and Headbutting
   * More likely to find roaming Pokémon when on the correct route
   * Somebody post–Elite Four shows you Raikou and Entei in case you've never encountered them roaming
   * Suicune roams if you don't catch it in Bell Tower
   * Aurora Orb boosts Suicune's Defense and Special Defense
   * Have Moves as an option in the party Pokémon menu during battle (might be too complicated to avoid glitches since moves can be reordered; also graphics glitches when the mini sprite overwrites the back sprite)
   * Fourth stat screen showing Poké Seer's data
   * Restore the Safari Game (some functionality, like HandleSafariAngerEatingStatus, already exists)
   * Color party/day-care sprites by species
   * Battle with Tower Tycoon Palmer as the last battle of every 5th and 10th 7-battle set in the Battle Tower
   * Battle with Giovanni either in Radio Tower or with Celebi time traveling
   * Cameo battle with Valerie on the Bellchime Trail after the Suicune event (Clefable, Mr. Mime, Wigglytuff, Azumarill, Togekiss, Sylveon) (reward: TM for DazzlinGleam)
   * Battle with [Shigeki Morimoto](http://bulbapedia.bulbagarden.net/wiki/Shigeki_Morimoto) (game designer and programmer), [Kōji Nishino](http://bulbapedia.bulbagarden.net/wiki/K%C5%8Dji_Nishino) (planner), [Tsunekazu Ishihara](https://tcrf.net/Pok%C3%A9mon_Red_and_Blue#Deleted_Maps) (president and CEO), and/or Satoshi Tajiri (creator) in Celadon Mansion once a day
   * Replace Cal in Trainer Hall with whichever gender character you don't pick
   * Include Lyra/Kotone as a friendly rival like in HGSS
      * She starts out with Marill, then takes whichever starter is left and battles you; her Pokémon do evolve, but her team is small (Azumarill, starter, Girafarig, Furret which she caught to teach you how)
   * Add a store to buy room decorations that Mom doesn't
   * Special sprites for Pikachu that know Surf or Fly
   * Yellow Pikachu Surfing music
   * N would sympathize with the Ruins of Alph message about how "we depart for their sakes"
   * Somtimes wild Pokémon know an egg move
   * Rock Smash breaks screens instead of lowering Defense (like Brick Break)
   * Add female Guitarist
   * Title screen should say "F1.0.0" not "v1.0.0" for faithful version
