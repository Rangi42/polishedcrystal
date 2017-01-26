This is *not* actually a list of concrete plans. Many items are just ideas I thought could be neat, but might never make it into the game. I consider Polished Crystal to be basically finished, apart from bugfixes and a few more modernized battle mechanics. There will probably be more features added in future, but the ones that already exist comprise a complete game.


## Use or remove

* Use EMOTE_QUESTION, EMOTE_HAPPY, EMOTE_SAD, and EMOTE_SLEEP somewhere


## Bugs

* Nuzlocke mode sometimes turns on by itself
* TMs refresh PP
* Protect prints (sometimes?) "X is protecting itself! Y's attack missed!"
* Dig sometimes prints that both Pokémon dug a hole
* Per-turn status animations might not always work
* Some trainers use X Spcl. Atk (seems to involve their second item slot, e.g. Lance's Full Restore)
* Thick Club + Swords Dance Marowak Attack overflow (only in link battles?)
* Headbutt overworld animation looks weird (wrong tile ID?)


## Battle mechanics

* Optional Gen V scaled experience formula
* http://smogon.com/forums/threads/gsc-mechanics.3542417/
* Defrosted Pokémon can attack on that turn (like waking up)
* Substitute prevents building Rage
* Avalanche doubles damage if user is hit first (description claims it does this already)
* Thunder, Blizzard, and Hurricane ignore accuracy and evasion in weather (not just 100% accuracy)
* Low Kick's power is based on weight
* Body Slam does double damage against Minimize
* Stomp and Body Slam never miss against Minimize
* Destiny Bond's success chance halves every successive turn it's used (Gen VII)
* Ghost-type Pokémon are immune to the trapping effects of Mean Look, Clamp, Fire Spin, Whirlpool, and Wrap
* Rock Smash breaks screens instead of lowering Defense (like Brick Break) (non-Faithful)


## Other mechanics

* Heal Balls heals HP, PP, and status
* Kurt gives Balls right away once per day
* Catch rate formula from Gen III
* Show move stats when overwriting one
* Show stat changes and then absolute values on level up
* Send gift Pokémon to the PC if the party is full
* Separate radio channels for March and Lullaby, available every day
* Press Start to auto-sort items
* Select reorders Pokémon in party menu
* Longer player and rival names
* Sometimes wild Pokémon know an egg move
* More likely to find roaming Pokémon when on the correct route
* Get better Wonder Trade items at higher levels


## Aesthetic updates

* Cross whirlpools, don't remove them (like HGSS)
* Make shiny Gyarados some color, and red Gyarados special
* Use separate music for Gym Leaders and the Elite 4
* Add separate animation graphics for more Poké Ball designs
* Show item pictures in bag, and possibly when picking them up
* Play Pokémon cry+animation when they escape a Poké Ball, and shiny flash when they're caught
* Animate new Pokémon sprites (Sylveon, Pikachu, etc)
* Design custom animations for new moves
* Color party and day-care sprites by species ([from Crystal_](https://hax.iimarck.us/topic/6932/), GetSpriteOAMAttr;8d0de for party, \_GetSpritePalette;142c4 for Day-Care)
* Add umbrellas to Olivine City benches
* Add boats to Goldenrod Harbor
* Custom overworld sprites for Rocket Executives


## New content

* Victor and Puka the Surfing Pikachu ("Hey, you can do it, too")
* Use RBY's Surf and Bike themes in Kanto
* Add Crossing Cave (music: Mt. Pyre Peak?) to Route 35 and Route 35 Coast
* Add Noisy Forest below Route 36 (music: White Treehollow)
* Add haunted house inside Noisy Forest with RBY-style Ghosts and a Lapras-like Mismagius
* Add Dim/Scary Cave (music: Rock Tunnel) and Cerulean Sea (music: Route 25) between Route 25/Cerulean Cape and Route 10
   * Add Light Clay in Dim/Scary Cave
* Expand Diglett's Cave
   * Add a Smooth Rock
* Expand Mt. Moon
* Add five stat trainers
   * Cheryl: Noisy Forest; rewards HP Up
   * Riley: Crossing Cave; rewards Protein
   * Buck: Diglett's Cave; rewards Iron/Zinc
   * Mira: Dim/Scary Cave; rewards Calcium
   * Marley: Mt. Moon; rewards Carbos
* Elite Four have different rematch dialog
* Use RBY's Pokémon Tower music (Crossing Cave bottom)
* Use the Spiky-Eared Pichu and B/W Routes 4 + 12 music somewhere
* Use the B/W Route 4 and Route 12 music somewhere rugged
* Use the Laverre City and Malie City music somewhere traditional
* Use some of Soloo93's HG/SS Gym Leader [sprite devamps](https://hax.iimarck.us/post/36679/#p36679)?
* Battle Caitlin and Darach somewhere, possibly around the Battle Tower or Trainer House (reward: ?)
* Battle [En and Madoka](http://bulbapedia.bulbagarden.net/wiki/The_Legendary_Rotation_Battle!) somewhere (Trainer House after catching the legendary trios, different trainer each day?)


## New features

* Restore [unused memory game](http://iimarck.us/i/memory/) ([more info](https://tcrf.net/Pok%C3%A9mon_Gold_and_Silver#Unused_Memory_Game))
* Restore the Safari Game (some functionality, like HandleSafariAngerEatingStatus, already exists)
* Add [Sweet Honey trees](http://iimarck.us/i/sweet-honey/) for Munchlax (replace Sweet Scent)
* Use the News Machine for something (Mystery Gift?)
* Abilities in general
* First Pokémon walks behind you
* More Pokémon
   * Short-term: rewrite Bill's PC to not use -1 as a terminator, allowing 254 Pokémon
   * Medium-term: rewrite Eggs to use bit flags instead of -2, allowing 255 Pokémon
   * Long-term: rewrite everything to use two-byte IDs, allowing 65534 Pokémon
* Earn Battle Points in the Battle Tower, tradable for new held items (replace TMs/HMs with a bit array to make room)
* Evening (intervals: morn 4–11, day 11–6, eve 6–9, nite 9–4)
* Seasons with appropriate day/night lengths from B/W (affects palettes, tiles, wild Pokémon, dialog, accessible areas, etc)
* Dive
* Rock Climb


### New items

Implement effects:

* Honey (for Honey Trees)
* Ability Capsule
* Quick Powder (already on wild Ditto)
* Choice {Band, Scarf, Specs} (Battle Tower)
* Binding Band
* {Mental, Power, White} Herb (Battle Tower)
* Big Root (Yellow Forest)
* Shell Bell (already in Aerodactyl chamber)
* Assault Vest
* Expert Belt (Mt. Silver)
* Life Orb (Ruins of Alph)
* Weak Policy
* {Wide, Zoom} Lens (sold by harbor merchant)
* Focus Sash
* Air Balloon
* Destiny Knot (Route 27)
* Metronome
* Rocky Helmet
* Safe Goggles
* Shed Shell (Bug-Catching Contest)
* Flame Orb
* Toxic Orb
* Black Sludge
* Shiny Charm (already given by Prof. Oak)
* Oval Charm (already given by Prof. Oak)

Find locations for:

* BalmMushroom (add in Noisy Forest)
* Pearl String (replace a Big Pearl or two, add in beaches)
* Rare Bone (add in caves)
* Bottle Cap (rock smash, fishing)
* Cherish Ball
* Soothe Bell (add in National Park)
