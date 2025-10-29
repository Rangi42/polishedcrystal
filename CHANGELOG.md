# Changelog


> What's the point of going through all the trouble of the debug process if you're going to go and fiddle with the game afterwards…?
>
> — Satoru Iwata, "[Iwata Asks – Pokémon HeartGold Version & SoulSilver Version](https://www.nintendo.co.uk/Iwata-Asks/Iwata-Asks-Pokemon-HeartGold-Version-SoulSilver-Version/Iwata-Asks-Pokemon-HeartGold-Version-SoulSilver-Version/1-Just-Making-The-Last-Train/1-Just-Making-The-Last-Train-225842.html)"


***Note: The following changelog may contain spoilers.***

## v3.2.1

Hotfix release.

### Changes
- Temporarily unable to trade pokemon holding mail in link trades to avoid mail corruption. Will be fixed in a future release.
- Thief and Pickpocket can now put items into bag if one is already held.
- Turn the player away from the bed in the Fast Ship after resting so they don't accidentally talk to the bed immediately after healing.
- Turn the player away from the train attendant when arriving in Saffron/Goldenrod so the player doesn't re-initiate the arrival dialogue.
- Talking to an Pokemon in the overworld sets them seen in the pokedex.
- Updated Piloswine and Skarmory's back sprites.
- Updated Para's front animation sprite.
- If a Pokemon knows a HM that you don't have, and that HM is Surf, Strength, or Whirlpool, you cannot forget the HM. This is to reduce chances of softlock.

### Fixes

- Fixed hurricane move animation.
- Fix corrupted dialogue Prof. Elm dialogue after Egg hatch, but the player forgot to bring it with them.
- Fix corrupted text in People & Places radio due to Psychic Inver
- Fix 3DS Virtual Console patches (labels must be <32 chars)
- More accurate sram/wram mismatch error message.
- Fix intimidate triggering twice.
- Fix Shed Skin and held Berry both activating for the same status condition.
- Fix issues related to secondary effects when Pokémon faints
- Fix freeze status text bug.
- Fix confusion self-damage
- Fix Toxic not incrementing properly
- Temp hotfix for link + summary screen causing crash and corrupt mail.
- Recalulate stats for party upon resuming a game.
- Fixed bugged text in bug catching contest.
- Fixed pronouns for Blanche in RocketHideout.
- Fix blaine text corruption when fading out of battle.
- Removed arbitrary delay when loading a game.
- Fixed extraneous visual artifact in Kingdra backsprite.
- Fixed lift key re-appearing after pickup.
- Fixed overworld weather animations when using brick break to smash an overworld rock.

## v3.2.0

The current stable release.

### Additions
- Added pluralize script command to auto-pluralize words as needed.
- Added in-game tips specific to Polished Crystal.
- Added new move tutors and associated event flags.
- Added new Alolan Sandslash and A-Vulpix/Ninetales sprites by mauvesea.
- Added icons for Pokédex and Pokégear, supports icons for special items.
- Added egg page to summary screen.
- Added ability blacklist routine for Trace + Skill Swap.
- Added scaled base EXP exceptions (e.g. Happiny).
- Added check for savestate loading affecting SRAM usage.
- Added Earth Power to Ursaluna and Bloodmoon Ursaluna.
- Added an initial option to disable experience gain (no-exp mode).
- Pokegear clock now shows the time-of-day indicator in the clock UI.
- Support for overriding RGB programs individually and new Analogue Pocket logo asset added to the build assets.
- Updated and added multiple Pokémon sprites and palettes (notable: Magnezone, Magmortar, Sneasler, Typhlosion-Hisuian, Rapidash-Galarian, and others).

#### Fixes
- Fixed mail encoding (avoid ngrams).
- Fixed battle text delay to minimum of 1s.
- Fixed Rare Candy bug at level 100.
- Fixed cries during trade animation.
- Fixed Celadon University lag (sprite overlap).
- Fixed Elm battle vs. Togepi request logic.
- Fixed text speed options behavior.
- Fixed ineligible switch textboxes on first turn.
- Fixed nickname screen palette bug.
- Fixed headbutt/cut trees visual glitch during lightning.
- Fixed VermilionCity NPC disappearing from sprite limit.
- Fixed hidden ability for Typhlosion-H.
- Fixed object pop-in issues across various routes.
- Fixed Ghost mon `<TARGET>` name override.
- Fixed dev room tile collision (head in wall).
- Fixed instant text skip on in-battle move description.
- Fixed music and SFX bugs (e.g., PGO leader's room).
- Fixed lucky island text input using proper `rawchar`.
- Fixed Spiky-Eared Pichu crash when trading special Pokémon.
- Fixed Jessie & James rematch logic and unused event flag.
- Fixed evolution-during-battle edge cases.
- Fixed ability activation bugs (Imposter, Neutralizing Gas, etc).
- Fixed Ability label confusion for disabling animations.
- Fixed Safari Zone bait/rock mechanics with abilities.
- Fixed neutralizing gas handling.
- Fixed ability icon display logic on rental mon trade.
- Fixed miscellaneous visual and formatting bugs.
- Fixed several battle engine and move interaction bugs since the last changelog update, including:
    - Corrected Protect/Endure success probabilities and capped Protect chaining chance.
    - Fixed various secondary-effect/timing bugs (including Rampage/Future Sight interaction and Move secondary effect ordering).
    - Fixed Intimidate / Eject Pack / Neutralizing Gas interactions and related held-item/ability edge cases.
    - Fixed Magic Bounce, Enigma Berry, Punching Glove, and other ability/item interaction bugs.
    - Fixed double-switch order and Trick Room logic edge cases.
- Fixed Disable turncount and Rest/Lum/Chesto trigger bugs.
- Made Sweet Honey not allow battling roaming Pokémon (behaviour/overworld fix).
- Fixed a number of text/encoding and daycare wording issues (shorter "want egg" prompt, mail encoding with ngrams avoided).
- Numerous crash and stability fixes, optimizations, and unreferenced-code cleanups across battle, text, and overworld systems.

#### Changes
- **Updated Summary Screen (major visual/functional upgrade).**
- Re-introduced trade evolutions.
- Adjusted Magikarp record length (now 106.6 cm).
- Updated "badge" capitalization in text to match vanilla.
- Improved Neutralizing Gas + Skill Swap interaction logic.
- Improved battle animations (summary, Ursaluna fix).
- Improved AI damage calc (e.g., Parental Bond).
- Adjusted move animations and fix order of status/inflict routines.
- Rewrote loading for Pikachu's unique moves (Yellow Forest).
- Adjusted Heracross palette (and reverted + reapplied fix).
- Adjusted RockItems to total 256.
- Made modern EV rules the default option to reduce bulk by default.
- Pluralization improvements used in text now simplify duplicated battle text variants (e.g. "Hit N times" now uses pluralize tables).
- Updated various engine internals to use newer hardware constants and RGBDS features (minor layout and performance improvements).

#### Removals
- Removed duplicate Sketch from Smeargle.
- Removed unused unique move for Scizor.
- Removed duplicate egg text.
- Removed unreachable tree from Route 16 West.

## v3.1.1

This is a hotfix release that removes one bug that caused the overworld graphics to glitch out badly when hatching an egg.

## v3.1.0

### Additions
- Bloodmoon Ursaluna, with its signature ability "Mind's Eye", is now available. It can be obtained by leveling up Ursaring in Murky Swamp (though it will be a one-off encounter in future). There are now 289 species of Pokémon plus 46 variant forms and 56 cosmetic forms.
- Added the much requested NPC to point the players in the direction of the Go-Goggles.
- The Candy Jar can now be obtained in the Goldenrod Underground. Exp Candies can be bought as well.
- Support for the GB Printer was added so that players can print the Diploma by talking to the Graphic Artist in Celadon Mansion.
- The Galarian legendary birds can now be encountered after defeating the Pokémon Go team leaders in the old Rocket Hideout in Celadon City.

### Fixes
- Updated the title version label to v3.1.0 and the copyright year to 2025.
- A graphical bug with Piers' microphone so that it is below the player sprite.

## v3.0.0

Previously known as the "9bit" branch of development, this version represents the bulk of the myriad of changes to v3.0.0-beta, which are covered in the following subsections.

### Pokémon
The total number of unique Pokémon has risen to 390 (including Red Gyarados, Spiky-Eared Pichu, and Armored Mewtwo). Excluding regional and alternate forms, there are 289 species required to complete the Pokédex. In general, if a Pokémon has some connection to Generations I or II, it is very likely present in the game, except for convergent species, Paradox Pokémon, and Mega Evolutions.

_Availability:_
- Reincluded post-3.0.0-beta: Spearow, Fearow, Aipom, Goldeen, Seaking, Hoppip, Skiploom, Jumpluff, Lickitung, Stantler, Shuckle, Cleffa, Igglybuff, Smoochum, Deliberd.
- Added in v3.1.1: Ambipom, Lickilicky, Wyrdeer, Farigiraf, Paldean Wooper, Clodsire, Annihilape, Hisuian Growlithe, Hisuian Arcanine, Galarian Corsola, Cursola, Dudunsparce, Bonsley, Hisuian Voltorb, Hisuian Electrode, Galarian Farfetch'd, Sirfetch'd, Happiny, Kleavor, Mantyke, Galarian Meowth, Perrserker, Mime Jr., Galarian Mr. Mime, Mr. Rime, Hisuian Qwilfish, Overqwil, Hisuian Sneasel, Sneasler, Paldean Tauros (Plain, Fire, and Water), Ursaluna (Plain), Wynaut, Hisuian Typhlosian, Galarian Articuno, Galarian Zapdos, and Galarian Moltres. (The three legendary birds are still unavailable.)
- All Magikarp Jump forms are now included.

_Evolution Methods:_
- Machoke, Graveler (both Plain and Alolan forms), Haunter, and Kadabra now evolve using the Linking Cord item, and no longer evolve by level up when they have a specific amount of EVs.
- Bonsley evolves by leveling up while knowing Rock Throw.
- Aipom evolves by leveling up while knowing Double Slap.
- Koffing evolves into Galarian Weezing by leveling up while holding a Charcoal.
- Primeape evolves into Annihilape by leveling up while knowing Outrage.
- Scyther evolves into Kleavor by leveling up while holding a Hard Stone.
- Girafarig evolves into Farigiraf by leveling up while knowing Zen Headbutt.
- Dunsparce evolves into Dudunsparce at level 32.
- Hisuian Qwilfish evolves into Overqwil at level 33.
- Ursaring evolves into Ursaluna by leveling up at the Sinjoh Ruins or the Mystri Stage. You can also use a Moon Stone. It evolves into Bloodmoon Ursaluna by leveling up in Murky Swamp.
- Magneton evolves into Magnezone by leveling up in Magnet Tunnel or Dim Cave. You can also use a Thunderstone.
- Stantler evolves into Wyrdeer by leveling up at Rugged Road, Snowtop Mountain, Sinjoh Ruins, or Mystri Stage.
- Mime Jr. evolves into Plain Mr. Mime at level 30 and Galarian Mr. Mime at Ice Path. You can also use an Ice Stone for the latter.
- Hisuian Sneasel, Galarian Corsola, and Galarian Mr. Mime evolve the way they do in the mainline games.
- In addition to evolving by leveling up in Ilex Forest and Ice Path, respectively, Eevee can evolve into Leafeon using a Leaf Stone and Glaceon using an Ice Stone.
- Non-Alolan Pokémon evolve into their Alolan form evolutions by using an Odd Souvenir.

_Typing And Stats:_
- Farfetch'd was reverted to Normal/Flying with the inclusion of Galarian Farfetch'd.
- Girafarig and Farigiraf are now Dark/Psychic.
- Galarian Corsola and Cursola are Ghost/Rock.
- Lugia is Water/Flying.

### Gameplay Features

_Initial Options:_
- You can now choose a third player character sprite option.
- The options menu pages were reorganized so that properties of the world/setting are initial options and properties of your equipment/interface are in-game options.
- No Real Time Clock (RTC) was turned into an initial option.
- Evolve in Battle added as an initial option (see next section).
- New EV settings for play include choosing whether or not EVs exist, are 510 max for any Pokémon (like modern games), or All in which a Pokémon can gain 252 EVs in every stat. These settings apply both to the player and to NPCs.
- Affection is included and can be turned on and off.
- New Game+ now preserves Catch/Oval/Shiny Charm (in addition to your money, mom's money, battle points, and any boxed Pokémon like before).
- Nuzlocke Mode has been removed along with some features that were added as a replacement. This is because the option caused players to believe that the game was balanced around the feature and often suggested changes based on this misperception.

_Moves and Battle:_
- Tons of move animation and sprite changes.
- You can now evolve during battle just like in the anime.
- Implemented several abilities, such as Bulletproof, Honey Gatherer, Sharpness, Armor Tail, and Cud Chew.
- Added new moves: Flare Blitz, Stone Edge, Astonish, Brave Bird, Brick Break, Bug Buzz, Bullet Punch, Drain Punch, Flash Cannon, Focus Blast, Hurricane, Hyper Voice, Iron Head, Play Rough, Shadow Claw.
- Healing moves were reduced to 5 pp except Fresh Snack aka Softboiled+Milk Drink.
- Nerfed scald from 80BP to 70BP instead of basically removing like S/V.
- HM moves can be forgotten and released.
- Trainers have random abilities if not specified.
- Added trainer classes, such as Soldier.
- Added more trainer party EVs.
- Nurses can no longer use full restores.
- New hold berry animation.
- Implement critical capture sound effect, and the crit catch shake.
- Stat change sound effects and graphics.
- Use the Generation 5 gym symbol for the gym battle intro splash.
- You can now switch and sort key items in the bag.
- Can no longer change the ball of traded Pokémon.
- Hyper Training now requires level 50 if modern EVs are enabled.

_Items And Rewards:_
- The aide in the gate west of Azalea now gives the Exp Share. For the gate west of Ecruteak, the aide now gives a Linking Cord.
- Added the Wing Case key item.
- Gold Leaf and Silver Leaf are no longer obtainable through headbutt. Instead, EV Wings can be obtained some of the time.
- One Odd Souvenir is accessible before the Johto Elite Four from Elm for finishing the Mystery Egg quest.
- Mirror Herb can now be used to transfer egg moves to an empty move slot using the daycare.
- Mint Leaf can be traded to the Tea Lady in Celadon apartments to change your Pokémon's nature.
- Removed the Dawn Stone for the Oval Stone.
- Exp share and power items available pre-E4.
- Oak gives the Shiny Charm now.
- Catching Charm can now be gotten from Prof. Oak.
- Sweet Honey added, which attracts wild Pokémon at the level of your party lead. Additionally an NPC was added who will sell it to you in the Goldenrod Flower shop.
- You can now buy PewterCrunch.
- Add Battle Factory items.
- Fourth Trainer Star is for beating Palmer or Thorton.
- Mint Leaf can now be bought with BP in the Battle Tower.
- The following items were replaced:
    * Ring Target -> Linking Cord
    * Absorb Bulb -> Clear Amulet
    * Cell Battery -> Mirror Herb
    * LuminousMoss -> PunchinGlove
    * Snowball -> Covert Cloak
    * UtilUmbrella -> Loaded Dice
- Added GBC Sound key item.
- The Pokedex UI is overhauled, and is extensive in use and function. This includes a New Unown mode UI, and it plays cries in the new Dex entry mode.
- Sound effect for new Premier Ball.
- Added Go-Goggles key item. 

_Overworld And NPCs:_
- Field moves can be used without teaching TMs/HMs, so long as a member of the party can learn the move (as Headbutt and Teleport are not TMs/HMs, this does not apply). This includes Flash which can be used by pressing A in the dark, but excludes Dig which has no shortcut to use. Fly can be used through the Pokegear Map.
- Added several Hidden Grottos throughout the Johto region.
- Allow fishing while surfing with its own graphics.
- Player turns around after using a Pokecenter.
- Added Trainer Tip signs for some new features and some more Advanced Tips to Kanto.
- There are now several new routes based off of pokewalker locations or otherwise connecting proximinal routes that weren't connected before, such as Magnet Tunnel, Rugged Road, and Snowtop Mountain. Additionally, Stormy Beach, Cherrygrove Bay, Murky Swamp, and Violet Outskirts were all populated with wildmons.
- Special attention was given to Snowtop Mountain in that you can't get phone calls there and that there is a cool interactive cutscene there where you can view the scenery.
- Violet Outskirts was also given a spooky event. Take the Sylph Scope there for an event mon.
- Removed Celadon Outskirts.
- Dynamic level scaling based on badge number was included for both wildmons and trainers in certain locations.
    For Wildmons: Hidden grottoes, all optional areas, and the Safari Zone.
    For Trainers: Route Leaders, and all trainers in the optional routes.
- Three-Segment Dudunsparce more common during swarms.
- Holding B on cycling road hits the brakes on the bike.
- You can now call Elm to know how your lead party mon evolves. You can also call Lyra to find out when your mon will learn its next move (but it will not specify the move). There is also a hint that Lyra calls are useful now.
- New heal spot right before Victory Road.
- Cerulean City Slowpoke is a Slowbro now.
- The Abra man in the League now stays until you can fly to Vermillion City.
- Added a second Rawst Berry tree in Violet Outskirts.
- Fixed the area where the Go-Goggles are found to make it more obvious where to surf. And added an NPC to hint to where it is.
- NPC trade changes (such as one for Galarian Weezing and changing the one in Violet so that it's a Poliwag for a Voltorb).
- Lucky Number is now Daily, not Weekly.
- Moved and added, or removed/replaced some cameo trainers. These include Piers, Katy, Thorton and Melony added, while Skyla was replaced with Marlon and Anabel was moved to the outside of Battle Tower.
- Many added Pokémon are now available in the wild.
- Alolan Exeggutor now blocks paths instead of Vileplume.
- Added a nurse's office to Celadon University.
- Added an Endure move tutor.
- Added Kimono Girls Mako and Mina.
- Nature Changing NPC with mint leaf tea.
- Added a bunch of Pokémon journals.
- Several NPC interactions (haircuts and the friendship option for Shrine Maiden Rei) now exclusively give affection.
- More NPC hints about all kinds of features and items.
- Olivine Lighthouse shines at night.
- Goldenrod Museum is now open for business.
- Plays a sound when the Rocket member takes a gate toll.
- Toned down poison screen effect for accessibility.
- Vulcandth added to the NPCs in the dev room.
- Added sand footprints. 
- Imported some text stuff from Prism.
- Changed the abbreviation of Speed to Spe instead of Spd as it was ambiguous.
- Remove roam mon anti-oscillation feature. (In Gen II, and ONLY in Gen II, if you return to the map you previously visited, roamers are forbidden from jumping there.)
- Weather effects, including rain (with lightning 25% of the time), sandstorm, and snow, now occur in the overworld on certain maps on certain days.

_Miscellaneous:_
- Feature Glaceon in the intro to reflect Rangi's profile picture.
- Analogue Pocket support for the RTC-off setting.
- Updated credits for sprite work (gmerc, Farore) and contributions.

### Fixes
Note: Some of these fixes may be intra-version fixes, and may not be all carried over from v3.0.0-beta.

- Fully paralyzed animation is faster now.
- Poison status outside of battle now interacts with Poison Heal properly, dealing no damage.
- Run Away prevents being trapped in unfaithful build.
- Updated a few egg move pools (like giving one to Weavile).
- Field Moves no longer crash when used by legendaries.
- Moon Ball and Love Ball now work properly
- Critical Captures now work properly.
- Magikarp length event now works properly.
- Updated Catch Charm numbers for expanded dex.
- Several crash fixes.
- Sleep Talk bugs fixed.
- Destiny Bond bug fixed.
- Pokerus fixes.
- Bug Catching contest fixes.
- Switch mode bug fixes.
- Lots of tile fixes and updates.
- A number of givepoke fixes.
- Tons of graphical glitch fixes. And fixes to those fixes.
- Pokedex radio show bug fix.
- Future Sight bug fixes.
- Analytic bug fixes.
- Link Battle bug fixes. Including allowing to do it in the first place.
- Sound bug fixes for cries and background music on transitions.
- Scaled EXP rounding changes.
- Register regular Pikachu in dex if you remove Surf/Fly from the special Pikachu forms.
- Several typo fixes.
- Several NPC trainer party error fixes.
- Updated Johto and Kanto Pokedex area maps.
- Added Orange Islands Pokedex area map.
- Headbutt and Rock Smash locators for dex.
- Wonder Trade bug fixes, including the post-E4 event.
- Learnset updates.
- Dex tracks cosmic forms separately instead of only regional forms.
- Updated some Battle Tower Movesets.
- Updated many mons movepools, learnsets, and tm compatibility to include or exclude moves they should or shouldn't learn in line with current generations.
- Balanced some wildmon levels.
- Updated several trainer parties.
- Fixed Several Pokégear phone bugs.
- Several music player fixes.
- Fix trade glitches.
- Fixed Professor Oak's PC problems.
- Unique wild moves fixes.
- Wild Pikachu encounter bugs.
- Radio text alignment.
- Happiness checker.
- Light Ball and Thick Club bugs.
- Removed some headbutt trees from Goldenrod City.
- Safeguard bugs.
- Respawn in New Bark post-Elite 4.
- Allow losing to Elm.
- Several typo fixes.
- Infinite loop with empty TM/HM list.
- Lower fish and tree item probabilities.
- Party member gender icons on the nickname screen.
- New game clock.
- Move maniac text bug.
- Updated mons to have current gen stats.
- Mom randomly calling player bug.
- Overworld ability effect bugs.
- Bad egg bug given from NPCs.
- Oak tells you to meet him to unlock Mt. Silver.
- Items couldn't be used during bug catching contest.
- Power boosting and crit-boosting item fixes, as well as Metal Powder, Quick Powder, and Eviolite.
- Damage calculation bugs.
- Storage system wasn't working properly.
- Updated exp yield to scale like SwSh.
- Ball used when owning exactly 255 species crash.
- Several move description fixes.
- Several breeding bugs including pokeballs not inheriting correctly.
- Odd eggs hatch in pokeballs.
- Egg hatching uses shiny palette.
- Several map tweaks.
- Many mini-graphic tweaks and fixes.
- Text alignment fixes.
- Gave the sailboat text in Goldenrod Harbor.
- Swimmers in the Battle Tower now have walking sprites.
- Many graphic bug fixes.
- Fixed Trick bug so it can be used if one mon has an item.
- Fixed catch tutorial.
- Fix frontier brain battles no occurring bug.
- NPC trainer mon's cries fix.
- Damage hit sounds now working properly fixed.
- Fixed display bug for level up moves for stone evos.
- Move fixes, including Water Pulse, Roost, Hex, Disable, Pay Day, Destiny Bond (both function and the weird text bug), Destiny Bond a second time, Knock Off, Bug Bite, Psystrike (damage calc), Perish Song (should still affect the user if the opponent is immune), Avalanche not checking for if the opponent has hurt you, and Reversal so it can actually crit.
- Fix AI teleport usage.
- Rebalanced fishing item drop rate.
- Fix party icon colors when varying colors by DVs is off.
- Ghost types can be affected by Wrap/etc passive damage. They can still flee/switch.
- Revise initial option descriptions.
- Make more items available.
- Show icon for Park Balls.
- Colored gender symbols in nickname screen.
- Vitimin bugs.
- Allow player to player trading before the first gym.
- Pokedex graphics bugs and fixes.
- Nickname menus after contest prize in bug catching contest and prizing.
- Fix allowing fly in multiple areas.
- Fixed cursed body text bug.
- Changed Sludge Bomb to special and Gunk Shot to physical.
- Prof. Elm battle scripting.
- Reset mom's money on new game.
- Vitamins and Wings now account for the (optional) 510 EV limit.
- Fix player EVs before a battle begins (stat recalculation before battle).
- Screen no longer flashes when a mon escapes from a Park Ball.
- Shellder can learn Bite and be fished in Slowpoke Well (with Super Rod).
- Battle Factory EVs follow EV settings.
- Link Battle Record bug.
- In-Battle Pickup permanently steals wildmons items.
- Made several events more like HGSS, such as Silver dropping their trainer card.
- Pokegear radio bug.
- Fixed fishing for different forms.
- Journal total count and entry bug fixes.
- Buena's Password now operates in the evening.
- Fixed party naming screen issues.
- Marlon palette fly glitch.
- Sylveon breeding bug. No more eldritch Eevees.
- Tea/Hyper Training factors in EVs.
- Knock Off against Substitute interaction fix.
- Infinite LuckNumberShow wins bug.
- Fixed Sheer Force affecting Thief.
- Fix Tyrogue evolution in EV disable mode.
- Fixed surfing behind the lighthouse.
- Many many improvements to the Battle Engine. 
- Figy Berry fix.
- Fixed stat change bug.
- Stat lowering actions fixes.
- Multihit move fixes.
- All kinds of optimizations to have the game run cleaner.
- Fix "spinner" Trainers and made them more like RBY.
- Apricorn colors fixes.
- Magnet Train animation fixes.
- Fade in palettes and flash darkness fixes.
- Several rounds of noise fixes.
- Fixed labels and terminology to be more like the official games.
- Fixed Violet gym guy throwing you across the street bug.
- Battle Factory's closed doors fix.
- Critical hit chance calculations fix.
- Neutralizing Gas and Intimidate interactions.
- Lake of Rage softlock.
- Regional Variants can now be obtained through Wonder Trade.
- Can no longer Wonder Trade Spiky-Eared Pichu.
- Audio Engine Fixes.
- Eusine and Gramps interaction rework.
- Crys's sprites and anims.
- Save state detection fixes.
- Map fly state after playing music in PokeGear bug fix.
- Credit boarder gfx.
- Throat Spray now works for both damaging and nondamaging moves, including Heal Bell.
- Ability Patch also boosts breeding HA rate.
- Judge machine graphics.
- Fixed Forewarn.
- Hail defense boost no longer a faithful check. (We had it first, Gamefreak!)
- Celadon Mansion dex completion doesn't ignore Mew and Celebi.
- Made more new pokes available like regional Diglett and Diglett Cave.
- Fix Eeveelution location requirements.
- Toxic counter still increases with Poison Heal.
- Togepi Elm Lab glitch so you can get the reward with a female Togepi.
- Fixed Perish Body.
- Fixed scene transition for the SS Anne.
- Museum painting crash fix.
- Fixed Koffing and Mime Jr. evolution glitch so they can evolve into regional forms at any level.
- Cleaned up some NPC dialogue to account for removed features.
- Updated some move tutor learnsets and TM/HM learnset to match newer gens more.
- Removed unnecessary text.
- Tons of audio fixes.
- Fix Lagging Tail, Quick Claw, and Quick Draw.
- Trainer pics no longer affected by color variation.
- Rating for perfect pokedex now happens at 289, not 251.
- Ability slideout for post-battle Pickup now uses mon's nickname.
- Music stops when evolution is cancelled bug.
- Correct Radio Tower quiz.
- Prevent skipping Lyra.
- Rebalanced Odd Egg chances.
- No accuracy move display fix; displays 100% and not ---%.
- Overworld slow cry fix.
- Clarify initial game settings (color variation is based on IVs but not correlated with their quality, and always has been).
- Friendship mechanics are now Gen XI.
- EV berries don't effect affection.  (does this mean that it now affects them or no longer does? couldn't tell from the description)
- Tackle animation sprite limit fix.
- Fixed Fast Ball.
- Catch Charm multiplier checks and fixes.
- Pickup and Honey Gatherer still activate if the mon is holding an item and its transferred to bag.
- Sanity checks for item swapping.
- Fix Punching Glove.
- Fix Soundproof to work against all sound status moves.
- Fix map name sign display issues.
- Mirror Herb now works on evolved Pokémon.
- Fix Battle Factory elevations.
- Use Berry Tree tiles in Cherrygrove Bay.
- Make field abilities like Magnet Pull work when Sweet Honey is used.
- Fix move swap for non-active party members in battle.
- Use a darker blue for NPCS at night.
- Fix number of headbutt trees during overcast in Azalea Town.
- Fix the weather checks for defensive rock+sandstorm and ice+hail boosts being inverted.
- Fix Smeargle party palette bug.
- Make Psychic Inver's roof purple.
- Fix cut tree flicker.
- Fix player layered underneath NPC when following.
- Fix lingering leaves when using cut on grass.
- Fix Player Sprite when bonking Alph tile description wall.
- Fix grotto exits where the player is standing on grass.
- Hide weather icon when 'No moves left' text is displayed and show it if present when move description is closed in battle.
- Fix stats screen at max volume.
- More helpful item descriptions for Light Ball and Thick Club.
- Buying decorations visually updates money.
- Correct background palette for 10 character enemy mon names.
- Fix Route 16 being full of ghosts! (Near Halloween, no less!)
- Modernize Illuminate.
- Quick Draw now only works on attacking moves, and fixed the slideout.   
- Fixed bugs with initial and in-game options.
- Use the originally intended roof colors for Cianwood and Mahogany.
- Update Battle Tower Picnicker to use the same palette as the one on Route 40.
- Minor bug fix to Water Absorb and friends.
- Fade in palettes for ending the Bug Catching Catching contest early.
- Fixed GitHub issues #775, #795, #782, #790, #801, #902, #915, #916, #900, #949, #950, #905.
- Fixed breeding bugs where hatched Pokémon are only female when breeding with basic Pokémon, and another breeding bug for variant forms.

## v3.0.0-beta

### Additions
* Add: Medicine and Berry pockets in the Bag.
* Add: Store up to 30 phone numbers in Pokégear.
* Add: Always keep the option to Teleport away from Indigo Plateau.
* Add: Portrait for the meteorite in Pewter Museum.
* Add: Special sprite for Red's Pikachu.
* Add: Johto and Kanto forms for Arbok.
* Add: Drain Kiss drains 75% HP.
* Add: Update Pokémon, move, and item attributes to Gen VII:
   * Super Potion heals 60 HP.
   * Hyper Potion heals 120 HP and costs ¥1500.
   * Fresh Water heals 30 HP.
   * Soda Pop heals 50 HP.
   * Lemonade heals 70 HP and costs ¥400.
   * X items sharply raise stats and cost twice as much.
   * Tackle has 40 power.
   * Sucker Punch has 70 power.
   * Leech Life has 80 power and 10 PP.
   * Thunder Wave has 90% accuracy.
   * Swagger has 85% accuracy.
   * Paralysis halves (not quarters) Speed.
   * Burn does 1/16 (not 1/8) damage per turn.
   * Confusion has a 33% chance (not 50%) to hit self.
   * Gengar has the ability Cursed Body. (Can also have Levitate in non-Faithful.)
   * Raikou, Entei, and Suicune have the hidden ability Inner Focus. (Faithful only.)
   * New item: Protect Pads (abbreviated "Protective Pads"). "Protect the holder from effects caused by making direct contact with the target."
   * Timer Ball catch rate multiplier is 1 + (turns passed × 3) / 10.
   * Nest Ball catch rate multiplier is (41 − enemy mon level) / 5.
* Add: Flash is required to return Falkner to the Gym.
* Add: Replace Spike Cannon with Icicle Spear.
* Add: Replace Twineedle with U-turn.
* Add: Replace Whirlwind with Sucker Punch.
* Add: Replace Vital Throw with Aura Sphere.
* Add: Replace Nightmare with Facade.
* Add: Replace Submission with Close Combat.
* Add: Replace Sand-Attack with Toxic Spikes.
* Add: Replace Fairy Wind with Bulldoze.
* Add: Replace Metal Sound with Roost.
* Add: Replace Sky Attack with Brave Bird.
* Add: Replace Twister with Aqua Jet.
* Add: Replace Sludge with Venoshock.
* Add: Replace Egg Bomb with Skill Swap.
* Add: Replace Mist with Amnesia.
* Add: Replace Fury Cutter with Bug Bite.
* Add: Replace Harden with Rock Blast.
* Add: Replace Triple Kick with Drain Punch.
* Add: Replace Lock-On with Power Whip.
* Add: Replace Flail with Gyro Ball.
* Add: Replace Flame Wheel with Flame Charge.
* Add: Replace Moonlight and Morning Sun with Knock Off and "HealingLight".
* Add: Replace Fury Attack and Fury Cutter with Trick and "Fury Strikes".
* Add: Giga Impact.
* Add: NPC trainers can have nicknamed Pokémon.
* Add: NPC trainers can have custom EVs.
* Add: Accuracy and evasion work like in Gen VI.
* Add: Substitute blocks sound-based moves.
* Add: Gen III critical hit mechanics (ignore -Atk and +Def stat changes, don't ignore burn).
* Add: Grass-type Pokémon are immune to PoisonPowder, Stun Spore, Sleep Powder, and Spore.
* Add: Marowak is Ground/Ghost.
* Add: Charizard is Fire/Dragon.
* Add: Yanmega is Bug/Dragon.
* Add: Ampharos is Electric/Dragon.
* Add: Noctowl is Ghost/Flying.
* Add: Bellossom is Grass/Fairy.
* Add: Celebi is Grass/Fairy.
* Add: Rapidash is Fire/Fairy.
* Add: Octillery is Water/Fire.
* Add: Politoed can learn Energy Ball.
* Add: Pidgeot can learn Focus Blast.
* Add: Misdreavus can learn Disarm Voice.
* Add: Espeon can learn Power Gem.
* Add: Dig has 90 BP.
* Add: Give in-game trades good natures.
* Add: TM prices from OR/AS.
* Add: Show quantity in Bag in marts.
* Add: Fancier Bag interface with color-coded pockets.
* Add: Get a free Premier Ball with every 10 Balls bought.
* Add: Show Pokémon portraits when using field moves (thanks to TPP:AC).
* Add: Time boundaries from HG/SS (day lasts until 8 PM, not 6 PM).
* Add: Use DVs to vary Pokémon colors like in Stadium.
* Add: Update random Wonder Trade OT names.
* Add: Teleport switches in trainer battles, like Let's Go.
* Add: Rock Smash has 60 power (non-Faithful).
* Add: Strength is Fighting-type (non-Faithful).
* Add: Submission has 120 power (non-Faithful).
* Add: Trainers have max happiness for Return.
* Add: 1/2048 chance for Wonder Traded Pokémon to have Pokérus.
* Add: Buy 12 Moomoo Milk at once.
* Add: Show TM names before buying them and when picking them up.
* Add: Say which pocket is full if an item can't be picked up.
* Add: Use Yellow's encounter music for Jessie & James.
* Add: Large red Gyarados sprite.
* Add: Route 23 between Pokémon League Gate and Victory Road.
* Add: Oak's lab looks different from Elm's lab.
* Add: Grass-green for Faraway Island.
* Add: TM prices from OR/AS.
* Add: Update random Wonder Trade OT names.
* Add: Respawn roaming beasts when released.
* Add: You can nickname a traded Pokémon once if it has no nickname yet.
* Add: Mr. Pokémon gives you a non-OT Ditto, not an Egg, for the Masuda breeding method.
* Add: Use original Jynx sprite.
* Add: Make overworld sprites darker at night.
* Add: Goldenrod Dept. Store and Celadon Mansion roofs have a dark sky at night.
* Add: Olivine Gym has its two trainers from HGSS.
* Add: Unlock frame type 9.
* Add: Choose a typeface/font.
* Add: XY Bicycle music for Cycling Road.
* Add: Prof.Oak gives you the Oval Charm for seeing all 254 Pokémon, and the Shiny Charm for catching all 254.
* Add: Prof.Elm is in the intro.
* Add: Cosplayer, Bug Maniac, Ruin Maniac, Lady, Baker, Tamer, Artist, Aroma Lady, Sightseer♂, and Sightseer♀ trainer classes.
* Add: New Trainer Card based on the Name Cards from the Mobile Adapter system.
* Add: Show PC box quantity.
* Add: Pokémon stats show caught Poké Ball.
* Add: Nest, Net, Dive, Luxury, and Heal Balls.
* Add: Cerulean Bike Shop from HGSS.
* Add: Elite 4 rooms have floor arenas.
* Add: Confirm gender selection.
* Add: Colored party Pokémon icons.
* Add: Magikarp Jump patterns.
* Add: Headbutt trees to get Silver and Gold Leaves.
* Add: Smash rocks to get various items.
* Add: Item maniacs from B/W.
* Add: Fish to get items based on the Rod (Bottle Caps with Super Rod).
* Add: Mulch regrows Berries.
* Add: Three battle styles: set, switch, and predict.
* Add: Battle Scene → Battle Effects.
* Add: Final Lyra battle.
* Add: Use a Ball on an already-caught Pokémon to change its Ball.
* Add: Kurt makes Balls right away.
* Add: Bug-Catching Contest prizes from HGSS.
* Add: Hidden Grottoes.
* Add: Unown ! and ?.
* Add: In-battle symbol to show that Nuzlocke mode prevents capture.
* Add: More Grass-type Pokémon can learn Earth Power and Earthquake.
* Add: Status icons in battle.
* Add: You can Wonder Trade Eggs.
* Add: Hidden Power guru finds your Pokémon's Hidden Power.
* Add: Hidden Power can be Fairy-type in non-Faithful.
* Add: Reset initial options by pressing Left+B at the title screen.
* Add: Music resumes where it left off after a battle (from TPP).
* Add: Use a proper menu for resurrecting Fossils.
* Add: Press B in the battle menu to move the cursor to Run.
* Add: Music player with piano roll by Sanqui.
* Add: Instant text option.
* Add: Imperial or metric units.
* Add: 12-hour or 24-hour clock.
* Add: ABC or QWERTY keyboard.
* Add: Item icons in the Bag.
* Add: Thrown Balls use individual icons.
* Add: Pokédex shows shiny palettes after getting the Shiny Charm.
* Add: New Game+ preserves your money, Battle Points, and PC Pokémon.
* Add: Phone call trainers ask automatically for your number.
* Add: Replace Jigglypuff Poster with Marill Poster.
* Add: Briefly beep to warn of low HP.
* Add: Play B/W final Pokémon music for Gym Leaders and Elite 4.
* Add: New title music after beating the Elite 4.
* Add: Larger Kanto routes, like in RBY.
* Add: Proper inverted colors in battle (by MeroMero).
* Add: Evolution moves from Gen VII.
* Add: Move Reminder supports pre-evolution and evolution moves.
* Add: Dark battle intro at night.
* Add: Evening as a time of day (shares wild Pokémon with night).
* Add: Trainer battles can be forfeited.
* Add: Show genders in party menu.
* Add: Show weather icons during battle like Gen 5+.
* Add: Vending machines have a 1/32 chance of giving an extra item.
* Add: Cross whirlpools, don't remove them (like HGSS).
* Add: Rename RageCandyBar to Cake of Rage.
* Add: Rename Guard Spec. to Guard Stats.
* Add: Rename Kay to Carrie (from Pokémon Stadium 2).
* Add: Rename Slowbro to the Squatter Pokémon. <https://lparchive.org/Pokemon-Blue/code.html>

### Fixes
* Fix: Lt. Surge's electric fence color does not override speech bubbles.
* Fix: Zap Cannon has 120 power.
* Fix: Pay Day pays 5 times the user's level, not 2.
* Fix: Explosion and Self-Destruct do not halve Defense.
* Fix: Quick Ball catch rate multiplier is 5 on the first turn.
* Fix: Minimize raises evasion by two stages.
* Fix: Gen 7 critical hit chances (1/24, 1/8, 1/2, 1/1)
* Fix: Munchlax, Magnezone, and Tangrowth have their relatives' cries.
* Fix: Game console names in room.
* Fix: Yellow Forest gate clerk does not face you.
* Fix: Read hidden Ruins of Alph tablet from one direction.
* Fix: Ice Rock tile collision data.
* Fix: Adjust some trainer levels and rosters.
* Fix: Move a trainer in Viridian Gym to prevent getting stuck on spinners.
* Fix: Fix some sprites.
* Fix: Sandstorm and Hail double, not halve, Special Defense and Defense.
* Fix: Enemy Psystrike uses player's Defense.
* Fix: TMs do not refresh PP.
* Fix: Sketch fails if user is transformed.
* Fix: Wild encounter battle transitions correctly depend on relative levels.
* Fix: Dig and Fly prevent capture.
* Fix: Yellow Carpet is buyable.
* Fix: Tangrowth can learn Curse.
* Fix: Lyra's Bag is the female version.
* Fix: Incorrect Cowgirl and Misty sprites.
* Fix: Pokémon caught during the Bug-Catching Contest are recorded as caught in Goldenrod Harbor.
* Fix: Magnet Train tracks were missing tiles.
* Fix: Shiny icon is the star from Gen 3+.
* Fix: SPRITE_DRAGONITE uses Dragonite's side view.

### Removals
* Remove: Rebattling Breeders like in B2/W2.
