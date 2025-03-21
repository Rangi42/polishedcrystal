SECTION "Evolutions and Attacks Kanto", ROMX

EvosAttacksPointersKanto::
	dw .BulbasaurEvosAttacks
	dw .IvysaurEvosAttacks
	dw .VenusaurEvosAttacks
	dw .CharmanderEvosAttacks
	dw .CharmeleonEvosAttacks
	dw .CharizardEvosAttacks
	dw .SquirtleEvosAttacks
	dw .WartortleEvosAttacks
	dw .BlastoiseEvosAttacks
	dw .CaterpieEvosAttacks
	dw .MetapodEvosAttacks
	dw .ButterfreeEvosAttacks
	dw .WeedleEvosAttacks
	dw .KakunaEvosAttacks
	dw .BeedrillEvosAttacks
	dw .PidgeyEvosAttacks
	dw .PidgeottoEvosAttacks
	dw .PidgeotEvosAttacks
	dw .RattataPlainEvosAttacks
	dw .RaticatePlainEvosAttacks
	dw .SpearowEvosAttacks
	dw .FearowEvosAttacks
	dw .EkansEvosAttacks
	dw .ArbokEvosAttacks
	dw .PikachuEvosAttacks
	dw .RaichuPlainEvosAttacks
	dw .SandshrewPlainEvosAttacks
	dw .SandslashPlainEvosAttacks
	dw .NidoranFEvosAttacks
	dw .NidorinaEvosAttacks
	dw .NidoqueenEvosAttacks
	dw .NidoranMEvosAttacks
	dw .NidorinoEvosAttacks
	dw .NidokingEvosAttacks
	dw .ClefairyEvosAttacks
	dw .ClefableEvosAttacks
	dw .VulpixPlainEvosAttacks
	dw .NinetalesPlainEvosAttacks
	dw .JigglypuffEvosAttacks
	dw .WigglytuffEvosAttacks
	dw .ZubatEvosAttacks
	dw .GolbatEvosAttacks
	dw .OddishEvosAttacks
	dw .GloomEvosAttacks
	dw .VileplumeEvosAttacks
	dw .ParasEvosAttacks
	dw .ParasectEvosAttacks
	dw .VenonatEvosAttacks
	dw .VenomothEvosAttacks
	dw .DiglettPlainEvosAttacks
	dw .DugtrioPlainEvosAttacks
	dw .MeowthPlainEvosAttacks
	dw .PersianPlainEvosAttacks
	dw .PsyduckEvosAttacks
	dw .GolduckEvosAttacks
	dw .MankeyEvosAttacks
	dw .PrimeapeEvosAttacks
	dw .GrowlithePlainEvosAttacks
	dw .ArcaninePlainEvosAttacks
	dw .PoliwagEvosAttacks
	dw .PoliwhirlEvosAttacks
	dw .PoliwrathEvosAttacks
	dw .AbraEvosAttacks
	dw .KadabraEvosAttacks
	dw .AlakazamEvosAttacks
	dw .MachopEvosAttacks
	dw .MachokeEvosAttacks
	dw .MachampEvosAttacks
	dw .BellsproutEvosAttacks
	dw .WeepinbellEvosAttacks
	dw .VictreebelEvosAttacks
	dw .TentacoolEvosAttacks
	dw .TentacruelEvosAttacks
	dw .GeodudePlainEvosAttacks
	dw .GravelerPlainEvosAttacks
	dw .GolemPlainEvosAttacks
	dw .PonytaPlainEvosAttacks
	dw .RapidashPlainEvosAttacks
	dw .SlowpokePlainEvosAttacks
	dw .SlowbroPlainEvosAttacks
	dw .MagnemiteEvosAttacks
	dw .MagnetonEvosAttacks
	dw .FarfetchDPlainEvosAttacks
	dw .DoduoEvosAttacks
	dw .DodrioEvosAttacks
	dw .SeelEvosAttacks
	dw .DewgongEvosAttacks
	dw .GrimerPlainEvosAttacks
	dw .MukPlainEvosAttacks
	dw .ShellderEvosAttacks
	dw .CloysterEvosAttacks
	dw .GastlyEvosAttacks
	dw .HaunterEvosAttacks
	dw .GengarEvosAttacks
	dw .OnixEvosAttacks
	dw .DrowzeeEvosAttacks
	dw .HypnoEvosAttacks
	dw .KrabbyEvosAttacks
	dw .KinglerEvosAttacks
	dw .VoltorbPlainEvosAttacks
	dw .ElectrodePlainEvosAttacks
	dw .ExeggcuteEvosAttacks
	dw .ExeggutorPlainEvosAttacks
	dw .CuboneEvosAttacks
	dw .MarowakPlainEvosAttacks
	dw .HitmonleeEvosAttacks
	dw .HitmonchanEvosAttacks
	dw .LickitungEvosAttacks
	dw .KoffingEvosAttacks
	dw .WeezingPlainEvosAttacks
	dw .RhyhornEvosAttacks
	dw .RhydonEvosAttacks
	dw .ChanseyEvosAttacks
	dw .TangelaEvosAttacks
	dw .KangaskhanEvosAttacks
	dw .HorseaEvosAttacks
	dw .SeadraEvosAttacks
	dw .GoldeenEvosAttacks
	dw .SeakingEvosAttacks
	dw .StaryuEvosAttacks
	dw .StarmieEvosAttacks
	dw .MrMimePlainEvosAttacks
	dw .ScytherEvosAttacks
	dw .JynxEvosAttacks
	dw .ElectabuzzEvosAttacks
	dw .MagmarEvosAttacks
	dw .PinsirEvosAttacks
	dw .TaurosPlainEvosAttacks
	dw .MagikarpEvosAttacks
	dw .GyaradosEvosAttacks
	dw .LaprasEvosAttacks
	dw .DittoEvosAttacks
	dw .EeveeEvosAttacks
	dw .VaporeonEvosAttacks
	dw .JolteonEvosAttacks
	dw .FlareonEvosAttacks
	dw .PorygonEvosAttacks
	dw .OmanyteEvosAttacks
	dw .OmastarEvosAttacks
	dw .KabutoEvosAttacks
	dw .KabutopsEvosAttacks
	dw .AerodactylEvosAttacks
	dw .SnorlaxEvosAttacks
	dw .ArticunoPlainEvosAttacks
	dw .ZapdosPlainEvosAttacks
	dw .MoltresPlainEvosAttacks
	dw .DratiniEvosAttacks
	dw .DragonairEvosAttacks
	dw .DragoniteEvosAttacks
	dw .MewtwoEvosAttacks
	dw .MewEvosAttacks
.IndirectEnd::

.BulbasaurEvosAttacks
	evo_data EVOLVE_LEVEL, 16, IVYSAUR
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, GROWL
	dbw 7, LEECH_SEED
	dbw 9, VINE_WHIP
	dbw 13, POISONPOWDER
	dbw 13, SLEEP_POWDER
	dbw 15, MUD_SLAP ; Take Down → GSC TM move
	dbw 19, RAZOR_LEAF
	dbw 21, TAKE_DOWN ; Sweet Scent → Take Down
	dbw 25, GROWTH
	dbw 27, DOUBLE_EDGE
	dbw 31, ANCIENTPOWER ; Worry Seed → event move
	dbw 33, HEALINGLIGHT ; Synthesis → similar move
	dbw 37, SEED_BOMB
	dbw 43, SLUDGE_BOMB ; TM move
	db -1 ; no more level-up moves

.IvysaurEvosAttacks
	evo_data EVOLVE_LEVEL, 32, VENUSAUR
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, GROWL
	dbw 7, LEECH_SEED
	dbw 9, VINE_WHIP
	dbw 13, POISONPOWDER
	dbw 13, SLEEP_POWDER
	dbw 15, MUD_SLAP ; Take Down → GSC TM move
	dbw 20, RAZOR_LEAF
	dbw 23, TAKE_DOWN ; Sweet Scent → Take Down
	dbw 28, GROWTH
	dbw 31, DOUBLE_EDGE
	dbw 36, ANCIENTPOWER ; Worry Seed → event move
	dbw 39, HEALINGLIGHT ; Synthesis → similar move
	dbw 44, SEED_BOMB
	dbw 50, SLUDGE_BOMB ; TM move
	db -1 ; no more level-up moves

.VenusaurEvosAttacks
	db -1 ; no more evolutions
	dbw 1, PETAL_DANCE ; evolution move
	dbw 1, OUTRAGE ; HGSS tutor move
	dbw 1, TACKLE
	dbw 3, GROWL
	dbw 7, LEECH_SEED
	dbw 9, VINE_WHIP
	dbw 13, POISONPOWDER
	dbw 13, SLEEP_POWDER
	dbw 15, MUD_SLAP ; Take Down → GSC TM move
	dbw 20, RAZOR_LEAF
	dbw 23, TAKE_DOWN ; Sweet Scent → Take Down
	dbw 28, GROWTH
	dbw 31, DOUBLE_EDGE
	dbw 39, ANCIENTPOWER ; Worry Seed → event move
	dbw 45, HEALINGLIGHT ; Synthesis → similar move
	dbw 50, SEED_BOMB
	dbw 53, SLUDGE_BOMB ; Solar Beam → Sludge Bomb
	dbw 60, SOLAR_BEAM
	db -1 ; no more level-up moves

.CharmanderEvosAttacks
	evo_data EVOLVE_LEVEL, 16, CHARMELEON
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 7, EMBER
	dbw 10, SMOKESCREEN
	dbw 16, METAL_CLAW ; Dragon Rage → TM move
	dbw 19, DRAGON_RAGE ; Scary Face → Dragon Rage
	dbw 25, SCARY_FACE ; Fire Fang → Scary Face
	dbw 28, FLAME_CHARGE ; Flame Burst → TM move
	dbw 34, SLASH
	dbw 37, FLAMETHROWER
	dbw 43, FIRE_SPIN
	dbw 46, CRUNCH
	dbw 52, FLARE_BLITZ ; Sw/Sh move
	db -1 ; no more level-up moves

.CharmeleonEvosAttacks
	evo_data EVOLVE_LEVEL, 36, CHARIZARD
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 7, EMBER
	dbw 10, SMOKESCREEN
	dbw 17, METAL_CLAW ; Dragon Rage → TM move
	dbw 21, DRAGON_RAGE ; Scary Face → Dragon Rage
	dbw 28, SCARY_FACE ; Fire Fang → Scary Face
	dbw 32, FLAME_CHARGE ; Flame Burst → TM move
	dbw 39, SLASH
	dbw 43, FLAMETHROWER
	dbw 50, FIRE_SPIN
	dbw 54, CRUNCH
	dbw 61, FLARE_BLITZ ; Sw/Sh move
	db -1 ; no more level-up moves

.CharizardEvosAttacks
	db -1 ; no more evolutions
	dbw 1, WING_ATTACK ; evolution move
	dbw 1, FLARE_BLITZ
	dbw 1, DRAGONBREATH
	dbw 1, DRAGON_CLAW
	dbw 1, SHADOW_CLAW
	dbw 1, AIR_SLASH
	dbw 1, OUTRAGE ; HGSS tutor move
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 7, EMBER
	dbw 10, SMOKESCREEN
	dbw 17, METAL_CLAW ; Dragon Rage → TM move
	dbw 21, DRAGON_RAGE ; Scary Face → Dragon Rage
	dbw 28, SCARY_FACE ; Fire Fang → Scary Face
	dbw 32, FLAME_CHARGE ; Flame Burst → TM move
	dbw 41, SLASH
	dbw 47, FLAMETHROWER
	dbw 56, FIRE_SPIN
	dbw 62, CRUNCH
	dbw 71, FLARE_BLITZ
	dbw 77, HURRICANE ; Sw/Sh move
	db -1 ; no more level-up moves

.SquirtleEvosAttacks
	evo_data EVOLVE_LEVEL, 16, WARTORTLE
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, LEER ; Tail Whip → similar move
	dbw 7, WATER_GUN
	dbw 10, DEFENSE_CURL ; Withdraw → similar move
	dbw 13, AQUA_JET ; Bubble → egg move
	dbw 16, BITE
	dbw 19, RAPID_SPIN
	dbw 22, PROTECT
	dbw 25, WATER_PULSE
	dbw 28, AQUA_TAIL
	dbw 31, CLOSE_COMBAT ; Skull Bash → new move
	dbw 34, MIRROR_COAT ; Iron Defense → egg move
	dbw 37, RAIN_DANCE
	dbw 40, HYDRO_PUMP
	dbw 43, SHELL_SMASH ; Sw/Sw move
	db -1 ; no more level-up moves

.WartortleEvosAttacks
	evo_data EVOLVE_LEVEL, 36, BLASTOISE
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, LEER ; Tail Whip → similar move
	dbw 7, WATER_GUN
	dbw 10, DEFENSE_CURL ; Withdraw → similar move
	dbw 13, AQUA_JET ; Bubble → egg move
	dbw 16, BITE
	dbw 20, RAPID_SPIN
	dbw 24, PROTECT
	dbw 28, WATER_PULSE
	dbw 32, AQUA_TAIL
	dbw 36, CLOSE_COMBAT ; Skull Bash → new move
	dbw 40, MIRROR_COAT ; Iron Defense → egg move
	dbw 44, RAIN_DANCE
	dbw 48, HYDRO_PUMP
	dbw 52, SHELL_SMASH ; Sw/Sw move
	db -1 ; no more level-up moves

.BlastoiseEvosAttacks
	db -1 ; no more evolutions
	dbw 1, FLASH_CANNON ; evolution move
	dbw 1, AURA_SPHERE ; new move
	dbw 1, ZAP_CANNON ; event move
	dbw 1, OUTRAGE ; HGSS tutor move
	dbw 1, TACKLE
	dbw 4, LEER ; Tail Whip → similar move
	dbw 7, WATER_GUN
	dbw 10, DEFENSE_CURL ; Withdraw → similar move
	dbw 13, AQUA_JET ; Bubble → egg move
	dbw 16, BITE
	dbw 20, RAPID_SPIN
	dbw 24, PROTECT
	dbw 28, WATER_PULSE
	dbw 32, AQUA_TAIL
	dbw 39, CLOSE_COMBAT ; Skull Bash → new move
	dbw 46, MIRROR_COAT ; Iron Defense → egg move
	dbw 53, RAIN_DANCE
	dbw 60, HYDRO_PUMP
	dbw 67, SHELL_SMASH ; Sw/Sw move
if !DEF(FAITHFUL)
	dbw 75, IRON_HEAD ; TM move
endc
	db -1 ; no more level-up moves

.CaterpieEvosAttacks
	evo_data EVOLVE_LEVEL, 7, METAPOD
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, STRING_SHOT
	dbw 9, BUG_BITE
	db -1 ; no more level-up moves

.MetapodEvosAttacks
	evo_data EVOLVE_LEVEL, 10, BUTTERFREE
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Caterpie move
	dbw 1, STRING_SHOT ; Caterpie move
	dbw 1, DEFENSE_CURL ; Harden → similar move
	db -1 ; no more level-up moves

.ButterfreeEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Caterpie move
	dbw 1, STRING_SHOT ; Caterpie move
	dbw 1, GUST
	dbw 11, CONFUSION
	dbw 13, POISONPOWDER
	dbw 15, STUN_SPORE
	dbw 17, SLEEP_POWDER ; Psybeam → Sleep Powder
	dbw 19, PSYBEAM ; Silver Wind → Psybeam
	dbw 23, SUPERSONIC
	dbw 25, SAFEGUARD
	dbw 29, HYPNOSIS ; Whirlwind → new move
	dbw 31, BUG_BUZZ
	dbw 35, REFLECT ; Rage Powder → RBY TM move
	dbw 37, AGILITY ; Captivate → new move
	dbw 41, HEALINGLIGHT ; Tailwind → new move
	dbw 43, AIR_SLASH
	dbw 47, PSYCHIC_M ; Quiver Dance → TM move
	db -1 ; no more level-up moves

.WeedleEvosAttacks
	evo_data EVOLVE_LEVEL, 7, KAKUNA
	db -1 ; no more evolutions
	dbw 1, POISON_STING
	dbw 1, STRING_SHOT
	dbw 9, BUG_BITE
	db -1 ; no more level-up moves

.KakunaEvosAttacks
	evo_data EVOLVE_LEVEL, 10, BEEDRILL
	db -1 ; no more evolutions
	dbw 1, POISON_STING ; Weedle move
	dbw 1, STRING_SHOT ; Weedle move
	dbw 1, DEFENSE_CURL ; Harden → similar move
	db -1 ; no more level-up moves

.BeedrillEvosAttacks
	db -1 ; no more evolutions
	dbw 1, POISON_STING ; Weedle move
	dbw 1, STRING_SHOT ; Weedle move
	dbw 1, FURY_STRIKES ; Fury Attack → similar move
	dbw 1, U_TURN ; evolution move
	dbw 14, RAGE
	dbw 17, PURSUIT
	dbw 20, FOCUS_ENERGY
	dbw 23, VENOSHOCK
	dbw 26, FEINT_ATTACK ; Assurance → similar move
	dbw 29, TOXIC_SPIKES
	dbw 32, PIN_MISSILE
	dbw 35, POISON_JAB
	dbw 38, AGILITY
	dbw 41, SWORDS_DANCE ; Endeavor → TM move
	dbw 44, OUTRAGE ; Fell Stinger → LGPE move
	db -1 ; no more level-up moves

.PidgeyEvosAttacks
	evo_data EVOLVE_LEVEL, 18, PIDGEOTTO
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 5, GUST ; Sand Attack → Gust
	dbw 9, MUD_SLAP ; Gust → GSC TM move
	dbw 13, QUICK_ATTACK
	dbw 17, RAGE ; Whirlwind → RBY TM move
	dbw 21, CHARM ; Twister → egg move
	dbw 25, SWIFT ; Feather Dance → TM move
	dbw 29, AGILITY
	dbw 33, WING_ATTACK
	dbw 37, ROOST
	dbw 41, DRILL_PECK ; Tailwind → new move
	dbw 45, STEEL_WING ; Mirror Move → TM move
	dbw 49, AIR_SLASH
	dbw 53, HURRICANE
	db -1 ; no more level-up moves

.PidgeottoEvosAttacks
	evo_data EVOLVE_LEVEL, 36, PIDGEOT
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 5, GUST ; Sand Attack → Gust
	dbw 9, MUD_SLAP ; Gust → GSC TM move
	dbw 13, QUICK_ATTACK
	dbw 17, RAGE ; Whirlwind → RBY TM move
	dbw 22, CHARM ; Twister → egg move
	dbw 27, SWIFT ; Feather Dance → TM move
	dbw 32, AGILITY
	dbw 37, WING_ATTACK
	dbw 42, ROOST
	dbw 47, DRILL_PECK ; Tailwind → new move
	dbw 52, STEEL_WING ; Mirror Move → TM move
	dbw 57, AIR_SLASH
	dbw 62, HURRICANE
	db -1 ; no more level-up moves

.PidgeotEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, GUST
	dbw 13, QUICK_ATTACK
	dbw 17, RAGE ; Whirlwind → RBY TM move
	dbw 22, CHARM ; Twister → egg move
	dbw 27, SWIFT ; Feather Dance → TM move
	dbw 32, AGILITY
	dbw 38, WING_ATTACK
	dbw 44, ROOST
	dbw 50, DRILL_PECK ; Tailwind → new move
	dbw 56, STEEL_WING ; Mirror Move → TM move
	dbw 62, AIR_SLASH
	dbw 68, HURRICANE
	db -1 ; no more level-up moves

.RattataPlainEvosAttacks
	evo_data EVOLVE_LEVEL, 20, RATICATE
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 4, QUICK_ATTACK
	dbw 7, FOCUS_ENERGY
	dbw 10, BITE
	dbw 13, PURSUIT
	dbw 16, HYPER_FANG
	dbw 19, SUCKER_PUNCH
	dbw 22, CRUNCH
	dbw 25, FEINT_ATTACK ; Assurance → similar move
	dbw 28, SUPER_FANG
	dbw 31, DOUBLE_EDGE
	dbw 34, COUNTER ; Endeavor → egg move
	db -1 ; no more level-up moves

.RaticatePlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SCARY_FACE ; evolution move
	dbw 1, SWORDS_DANCE
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 4, QUICK_ATTACK
	dbw 7, FOCUS_ENERGY
	dbw 10, BITE
	dbw 13, PURSUIT
	dbw 16, HYPER_FANG
	dbw 19, SUCKER_PUNCH
	dbw 24, CRUNCH
	dbw 29, FEINT_ATTACK ; Assurance → similar move
	dbw 34, SUPER_FANG
	dbw 39, DOUBLE_EDGE
	dbw 44, COUNTER ; Endeavor → egg move
	db -1 ; no more level-up moves

.SpearowEvosAttacks
	evo_data EVOLVE_LEVEL, 20, FEAROW
	db -1 ; no more evolutions
	dbw 1, PECK
	dbw 1, GROWL
	dbw 4, LEER
	dbw 8, PURSUIT
	dbw 11, FURY_STRIKES ; Fury Attack → similar move
	dbw 15, AERIAL_ACE
	dbw 18, SWIFT ; Mirror Move → TM move
	dbw 22, FEINT_ATTACK ; Assurance → similar move
	dbw 25, AGILITY
	dbw 29, FOCUS_ENERGY
	dbw 32, ROOST
	dbw 36, DRILL_PECK
	db -1 ; no more level-up moves

.FearowEvosAttacks
	db -1 ; no more evolutions
	dbw 1, QUICK_ATTACK ; Pluck → egg move
	dbw 1, PECK
	dbw 1, GROWL
	dbw 4, LEER
	dbw 8, PURSUIT
	dbw 11, FURY_STRIKES ; Fury Attack → similar move
	dbw 15, AERIAL_ACE
	dbw 18, SWIFT ; Mirror Move → TM move
	dbw 23, FEINT_ATTACK ; Assurance → similar move
	dbw 27, AGILITY
	dbw 32, FOCUS_ENERGY
	dbw 36, ROOST
	dbw 41, DRILL_PECK
	dbw 45, DOUBLE_EDGE ; Drill Run → tutor move
	db -1 ; no more level-up moves

.EkansEvosAttacks
	evo_data EVOLVE_LEVEL, 22, ARBOK, NO_FORM ; preserve pre-evo form
	db -1 ; no more evolutions
	dbw 1, WRAP
	dbw 1, LEER
	dbw 4, POISON_STING
	dbw 9, BITE
	dbw 12, GLARE
	dbw 17, SCREECH
	dbw 20, ACID
	dbw 25, DISABLE ; Stockpile + Spit Up + Swallow → egg move
	dbw 28, PURSUIT ; Acid Spray → egg move
	dbw 35, POISON_JAB ; Mud Bomb → TM move
	dbw 36, LEECH_LIFE ; Gastro Acid → TM move
	dbw 38, IRON_TAIL ; Belch → TM move
	dbw 41, HAZE
	dbw 44, BULK_UP ; Coil → TM move
	dbw 49, GUNK_SHOT
	db -1 ; no more level-up moves

.ArbokEvosAttacks
	db -1 ; no more evolutions
	dbw 1, WRAP
	dbw 1, LEER
	dbw 1, CRUNCH ; evolution move
	dbw 4, POISON_STING
	dbw 9, BITE
	dbw 12, GLARE
	dbw 17, SCREECH
	dbw 20, ACID
	dbw 27, DISABLE ; Stockpile + Spit Up + Swallow → egg move
	dbw 32, PURSUIT ; Acid Spray → egg move
	dbw 39, POISON_JAB ; Mud Bomb → TM move
	dbw 44, LEECH_LIFE ; Gastro Acid → TM move
	dbw 48, IRON_TAIL ; Belch → TM move
	dbw 51, HAZE
	dbw 56, BULK_UP ; Coil → TM move
	dbw 63, GUNK_SHOT
	db -1 ; no more level-up moves

.PikachuEvosAttacks
	evo_data EVOLVE_ITEM, THUNDERSTONE, RAICHU, PLAIN_FORM
	evo_data EVOLVE_ITEM, ODD_SOUVENIR, RAICHU, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, THUNDERSHOCK
	dbw 1, LEER ; Tail Whip → similar move
	dbw 5, GROWL
	dbw 7, CHARM ; Play Nice → Pichu move
	dbw 10, QUICK_ATTACK
	dbw 13, DOUBLE_KICK ; Electro Ball → LGPE move
	dbw 18, THUNDER_WAVE
	dbw 21, MUD_SLAP ; Feint → GSC TM move
	dbw 23, DOUBLE_TEAM
	dbw 26, SPARK
	dbw 29, IRON_TAIL ; Nuzzle → TM move
	dbw 34, EXTREMESPEED ; Discharge → event move
	dbw 37, BODY_SLAM ; Slam → TM move
	dbw 42, THUNDERBOLT
	dbw 45, AGILITY
	dbw 50, WILD_CHARGE
	dbw 53, LIGHT_SCREEN
	dbw 58, THUNDER
	db -1 ; no more level-up moves

.RaichuPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, THUNDERSHOCK
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, QUICK_ATTACK
	dbw 1, THUNDERBOLT ; evolution move
	dbw 1, REVERSAL ; Sw/Sh move
	db -1 ; no more level-up moves

.SandshrewPlainEvosAttacks
	evo_data EVOLVE_LEVEL, 22, SANDSLASH, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, DEFENSE_CURL
	dbw 3, MUD_SLAP ; Sand Attack → similar move
	dbw 5, POISON_STING
	dbw 7, ROLLOUT
	dbw 9, RAPID_SPIN
	dbw 11, PIN_MISSILE ; Fury Cutter → new move
	dbw 14, MAGNITUDE
	dbw 17, SWIFT
	dbw 20, FURY_STRIKES ; Fury Swipes → similar move
	dbw 23, METAL_CLAW ; Sand Tomb → HGSS tutor move
	dbw 26, SLASH
	dbw 30, DIG
	dbw 34, GYRO_BALL
	dbw 38, SWORDS_DANCE
	dbw 42, SANDSTORM
	dbw 46, EARTHQUAKE
	db -1 ; no more level-up moves

.SandslashPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, SLASH ; Crush Claw → Slash ; evolution move
	dbw 1, DEFENSE_CURL
	dbw 3, MUD_SLAP ; Sand Attack → similar move
	dbw 5, POISON_STING
	dbw 7, ROLLOUT
	dbw 9, RAPID_SPIN
	dbw 11, PIN_MISSILE ; Fury Cutter → new move
	dbw 14, MAGNITUDE
	dbw 17, SWIFT
	dbw 20, FURY_STRIKES ; Fury Swipes → similar move
	dbw 24, SUPER_FANG ; Sand Tomb → HGSS tutor move
	dbw 28, METAL_CLAW ; Slash → TM move
	dbw 33, DIG
	dbw 38, GYRO_BALL
	dbw 43, SWORDS_DANCE
	dbw 48, SANDSTORM
	dbw 53, EARTHQUAKE
	db -1 ; no more level-up moves

.NidoranFEvosAttacks
	evo_data EVOLVE_LEVEL, 16, NIDORINA
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, SCRATCH
	dbw 7, LEER ; Tail Whip → similar move
	dbw 9, DOUBLE_KICK
	dbw 13, POISON_STING
	dbw 19, FURY_STRIKES ; Fury Swipes → similar move
	dbw 21, BITE
	dbw 25, SWEET_KISS ; Helping Hand → event move
	dbw 31, TOXIC_SPIKES
	dbw 33, HEALINGLIGHT ; Flatter → event move (Moonlight)
	dbw 37, CRUNCH
	dbw 43, CHARM ; Captivate → egg move
	dbw 45, POISON_JAB
	db -1 ; no more level-up moves

.NidorinaEvosAttacks
	evo_data EVOLVE_ITEM, MOON_STONE, NIDOQUEEN
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, SCRATCH
	dbw 7, LEER ; Tail Whip → similar move
	dbw 9, DOUBLE_KICK
	dbw 13, POISON_STING
	dbw 20, FURY_STRIKES ; Fury Swipes → similar move
	dbw 23, BITE
	dbw 28, SWEET_KISS ; Helping Hand → event move
	dbw 35, TOXIC_SPIKES
	dbw 38, HEALINGLIGHT ; Flatter → event move (Moonlight)
	dbw 43, CRUNCH
	dbw 50, CHARM ; Captivate → egg move
	dbw 58, POISON_JAB
	db -1 ; no more level-up moves

.NidoqueenEvosAttacks
	db -1 ; no more evolutions
	dbw 1, CLOSE_COMBAT ; Superpower → similar move
	dbw 1, SCRATCH
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, DOUBLE_KICK
	dbw 1, POISON_STING
	dbw 23, OUTRAGE ; Chip Away → HGSS tutor move
	dbw 35, BODY_SLAM
	dbw 43, EARTH_POWER
	dbw 58, CLOSE_COMBAT ; Superpower → similar move
	db -1 ; no more level-up moves

.NidoranMEvosAttacks
	evo_data EVOLVE_LEVEL, 16, NIDORINO
	db -1 ; no more evolutions
	dbw 1, LEER
	dbw 1, PECK
	dbw 7, FOCUS_ENERGY
	dbw 9, DOUBLE_KICK
	dbw 13, POISON_STING
	dbw 19, FURY_STRIKES ; Fury Attack → similar move
	dbw 21, HORN_ATTACK
	dbw 25, SWEET_KISS ; Helping Hand → event move
	dbw 31, TOXIC_SPIKES
	dbw 33, HEALINGLIGHT ; Flatter → event move (Morning Sun)
	dbw 37, POISON_JAB
	dbw 43, CHARM ; Captivate → egg move
	dbw 45, MEGAHORN ; Horn Drill → Nidoking move
	db -1 ; no more level-up moves

.NidorinoEvosAttacks
	evo_data EVOLVE_ITEM, MOON_STONE, NIDOKING
	db -1 ; no more evolutions
	dbw 1, LEER
	dbw 1, PECK
	dbw 7, FOCUS_ENERGY
	dbw 9, DOUBLE_KICK
	dbw 13, POISON_STING
	dbw 20, FURY_STRIKES ; Fury Attack → similar move
	dbw 23, HORN_ATTACK
	dbw 28, SWEET_KISS ; Helping Hand → event move
	dbw 35, TOXIC_SPIKES
	dbw 38, HEALINGLIGHT ; Flatter → event move (Morning Sun)
	dbw 43, POISON_JAB
	dbw 50, CHARM ; Captivate → egg move
	dbw 58, MEGAHORN ; Horn Drill → Nidoking move
	db -1 ; no more level-up moves

.NidokingEvosAttacks
	db -1 ; no more evolutions
	dbw 1, MEGAHORN
	dbw 1, PECK
	dbw 1, FOCUS_ENERGY
	dbw 1, DOUBLE_KICK
	dbw 1, POISON_STING
	dbw 23, OUTRAGE ; Chip Away → HGSS tutor move
	dbw 35, THRASH
	dbw 43, EARTH_POWER
	dbw 58, MEGAHORN
	db -1 ; no more level-up moves

.ClefairyEvosAttacks
	evo_data EVOLVE_ITEM, MOON_STONE, CLEFABLE
	db -1 ; no more evolutions
	dbw 1, DISARM_VOICE
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, GROWL
	dbw 1, ENCORE
	dbw 7, SING
	dbw 10, DOUBLE_SLAP
	dbw 13, DEFENSE_CURL
	dbw 16, SWEET_KISS ; Follow Me → new move
	dbw 19, DIZZY_PUNCH ; Bestow → Crystal unique move
	dbw 22, TRI_ATTACK ; Wake-Up Slap → RBY TM move
	dbw 25, MINIMIZE
	dbw 28, DRAINING_KISS ; Stored Power → Sw/Sh move
	dbw 31, METRONOME
	dbw 34, REFLECT ; Cosmic Power → TM move
	dbw 37, LIGHT_SCREEN ; Lucky Chant → TM move
	dbw 40, BODY_SLAM
	dbw 43, HEALINGLIGHT ; Moonlight → similar move
	dbw 46, MOONBLAST
	dbw 49, BELLY_DRUM ; Gravity → egg move
	dbw 50, EXTRASENSORY ; Meteor Mash → new move
	dbw 55, HEAL_BELL ; Healing Wish → HGSS tutor move
	db -1 ; no more level-up moves

.ClefableEvosAttacks
	db -1 ; no more evolutions
	dbw 1, HEALINGLIGHT ; Moonlight → similar move
	dbw 1, DISARM_VOICE
	dbw 1, PLAY_ROUGH ; LGPE TM move
	dbw 1, SING
	dbw 1, MINIMIZE
	dbw 1, METRONOME
	dbw 1, DOUBLE_SLAP
	db -1 ; no more level-up moves

.VulpixPlainEvosAttacks
	evo_data EVOLVE_ITEM, FIRE_STONE, NINETALES, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, EMBER
	dbw 4, GROWL ; Tail Whip → new move
	dbw 7, ASTONISH ; Roar → new move
	dbw 9, CHARM ; Baby-Doll Eyes → similar move
	dbw 10, QUICK_ATTACK
	dbw 12, CONFUSE_RAY
	dbw 15, FIRE_SPIN
	dbw 18, NIGHT_SHADE ; Payback → new move
	dbw 20, WILL_O_WISP
	dbw 23, FEINT_ATTACK
	dbw 26, HEX
	dbw 28, PAIN_SPLIT ; Flame Burst → HGSS tutor move
	dbw 31, EXTRASENSORY
	dbw 34, SAFEGUARD
	dbw 36, FLAMETHROWER
	dbw 39, HYPNOSIS ; Imprison → egg move
	dbw 42, FIRE_BLAST
	dbw 44, SHADOW_BALL ; Grudge → TM move
	dbw 47, DISABLE ; Captivate → egg move
	dbw 50, FLARE_BLITZ ; Inferno → egg move
	dbw 53, HEALINGLIGHT ; new move
	db -1 ; no more level-up moves

.NinetalesPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, NASTY_PLOT ; evolution move
	dbw 1, FLAMETHROWER
	dbw 1, QUICK_ATTACK
	dbw 1, CONFUSE_RAY
	dbw 1, SAFEGUARD
	db -1 ; no more level-up moves

.JigglypuffEvosAttacks
	evo_data EVOLVE_ITEM, MOON_STONE, WIGGLYTUFF
	db -1 ; no more evolutions
	dbw 1, SING
	dbw 1, SWEET_KISS ; Igglybuff move
	dbw 3, DEFENSE_CURL
	dbw 5, TACKLE ; Pound → similar move
	dbw 9, DIZZY_PUNCH ; Play Nice → Crystal unique move
	dbw 11, DISARM_VOICE
	dbw 14, DISABLE
	dbw 17, DOUBLE_SLAP
	dbw 20, ROLLOUT
	dbw 22, CHARM ; Round → Igglybuff move
	dbw 27, MEAN_LOOK ; Wake-Up Slap → new move
	dbw 30, REST
	dbw 32, BODY_SLAM
	dbw 35, GYRO_BALL
	dbw 38, HEAL_BELL ; Mimic → HGSS tutor move
	dbw 41, HYPER_VOICE
	dbw 45, DOUBLE_EDGE
	db -1 ; no more level-up moves

.WigglytuffEvosAttacks
	db -1 ; no more evolutions
	dbw 1, MINIMIZE ; LGPE move
	dbw 1, NASTY_PLOT ; SV TM move
	dbw 1, DOUBLE_EDGE
	dbw 1, PLAY_ROUGH
	dbw 1, SING
	dbw 1, DEFENSE_CURL
	dbw 1, DISABLE
	dbw 1, DOUBLE_SLAP
	db -1 ; no more level-up moves

.ZubatEvosAttacks
	evo_data EVOLVE_LEVEL, 22, GOLBAT
	db -1 ; no more evolutions
	dbw 1, ABSORB
	dbw 5, SUPERSONIC
	dbw 7, ASTONISH
	dbw 11, BITE
	dbw 13, GUST ; Wing Attack → egg move
	dbw 17, CONFUSE_RAY
	dbw 19, WING_ATTACK ; Air Cutter → Wing Attack
	dbw 23, SWIFT
	dbw 25, SUPER_FANG ; Poison Fang → HGSS tutor move
	dbw 29, MEAN_LOOK
	dbw 31, LEECH_LIFE
	dbw 35, HAZE
	dbw 37, VENOSHOCK
	dbw 41, AIR_SLASH
	dbw 43, PURSUIT ; Quick Guard → egg move
	db -1 ; no more level-up moves

.GolbatEvosAttacks
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, CROBAT
	db -1 ; no more evolutions
	dbw 1, SCREECH
	dbw 1, ABSORB
	dbw 1, CRUNCH ; LGPE move
	dbw 5, SUPERSONIC
	dbw 7, ASTONISH
	dbw 11, BITE
	dbw 13, GUST ; Wing Attack → egg move
	dbw 17, CONFUSE_RAY
	dbw 19, WING_ATTACK ; Air Cutter → Wing Attack
	dbw 24, SWIFT
	dbw 27, SUPER_FANG ; Poison Fang → HGSS tutor move
	dbw 32, MEAN_LOOK
	dbw 35, LEECH_LIFE
	dbw 40, HAZE
	dbw 43, VENOSHOCK
	dbw 48, AIR_SLASH
	dbw 51, PURSUIT ; Quick Guard → egg move
	db -1 ; no more level-up moves

.OddishEvosAttacks
	evo_data EVOLVE_LEVEL, 21, GLOOM
	db -1 ; no more evolutions
	dbw 1, ABSORB
	dbw 1, GROWTH
	dbw 5, LEECH_SEED ; Sweet Scent → event move
	dbw 9, ACID
	dbw 13, POISONPOWDER
	dbw 14, STUN_SPORE
	dbw 15, SLEEP_POWDER
	dbw 19, MEGA_DRAIN
	dbw 23, CHARM ; Lucky Chant → egg move
	dbw 27, HEALINGLIGHT ; Moonlight → similar move
	dbw 31, GIGA_DRAIN
	dbw 35, TOXIC
	dbw 39, HYPER_VOICE ; Natural Gift → tutor move
	dbw 43, MOONBLAST
	dbw 47, GROWTH ; Grassy Terrain → GSC move
	dbw 51, PETAL_DANCE
	db -1 ; no more level-up moves

.GloomEvosAttacks
	evo_data EVOLVE_ITEM, LEAF_STONE, VILEPLUME
	evo_data EVOLVE_ITEM, SUN_STONE, BELLOSSOM
	db -1 ; no more evolutions
	dbw 1, ABSORB
	dbw 5, LEECH_SEED ; Sweet Scent → event move
	dbw 9, ACID
	dbw 13, POISONPOWDER
	dbw 14, STUN_SPORE
	dbw 15, SLEEP_POWDER
	dbw 19, MEGA_DRAIN
	dbw 24, CHARM ; Lucky Chant → egg move
	dbw 29, HEALINGLIGHT ; Moonlight → similar move
	dbw 34, GIGA_DRAIN
	dbw 39, TOXIC
	dbw 44, HYPER_VOICE ; Natural Gift → tutor move
	dbw 49, MOONBLAST
	dbw 54, GROWTH ; Grassy Terrain → Crystal move
	dbw 59, PETAL_DANCE
	db -1 ; no more level-up moves

.VileplumeEvosAttacks
	db -1 ; no more evolutions
	dbw 1, MEGA_DRAIN
	dbw 1, HEAL_BELL ; Aromatherapy → similar move
	dbw 1, POISONPOWDER
	dbw 1, STUN_SPORE
	dbw 39, GROWTH
	dbw 49, MOONBLAST ; Petal Blizzard → Gloom move
	dbw 59, PETAL_DANCE
	dbw 69, SOLAR_BEAM
	db -1 ; no more level-up moves

.ParasEvosAttacks
	evo_data EVOLVE_LEVEL, 24, PARASECT
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 2, SLEEP_POWDER ; LGPE move
	dbw 4, STUN_SPORE
	dbw 6, POISONPOWDER
	dbw 11, ABSORB
	dbw 17, BUG_BITE ; Fury Cutter → egg move
	dbw 22, SPORE
	dbw 27, SLASH
	dbw 33, GROWTH
	dbw 38, GIGA_DRAIN
	dbw 43, LEECH_LIFE ; Aromatherapy → TM move
	dbw 49, HEALINGLIGHT ; Rage Powder → new move
	dbw 54, X_SCISSOR
	db -1 ; no more level-up moves

.ParasectEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SHADOW_CLAW ; evolution move
	dbw 1, SCRATCH
	dbw 2, SLEEP_POWDER ; LGPE move
	dbw 4, STUN_SPORE
	dbw 6, POISONPOWDER
	dbw 11, ABSORB
	dbw 17, BUG_BITE ; Fury Cutter → egg move
	dbw 22, SPORE
	dbw 29, SLASH
	dbw 37, GROWTH
	dbw 44, GIGA_DRAIN
	dbw 51, LEECH_LIFE ; Aromatherapy → TM move
	dbw 59, HEALINGLIGHT ; Rage Powder → new move
	dbw 66, X_SCISSOR
	db -1 ; no more level-up moves

.VenonatEvosAttacks
	evo_data EVOLVE_LEVEL, 31, VENOMOTH
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DISABLE
	dbw 1, FORESIGHT
	dbw 5, SUPERSONIC
	dbw 11, CONFUSION
	dbw 13, POISONPOWDER
	dbw 17, PSYBEAM
	dbw 23, BUG_BITE ; Stun Spore → HGSS tutor move
	dbw 25, STUN_SPORE ; Signal Beam → Stun Spore
	dbw 29, SLEEP_POWDER
	dbw 35, LEECH_LIFE
	dbw 37, ZEN_HEADBUTT
	dbw 41, BATON_PASS ; Poison Fang → egg move
	dbw 47, PSYCHIC_M
	db -1 ; no more level-up moves

.VenomothEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BUG_BUZZ
	dbw 1, TACKLE
	dbw 1, DISABLE
	dbw 1, FORESIGHT
	dbw 5, SUPERSONIC
	dbw 11, CONFUSION
	dbw 13, POISONPOWDER
	dbw 17, PSYBEAM
	dbw 23, BUG_BITE ; Stun Spore → HGSS tutor move
	dbw 25, STUN_SPORE ; Signal Beam → Stun Spore
	dbw 29, SLEEP_POWDER
	dbw 31, GUST
	dbw 37, LEECH_LIFE
	dbw 41, ZEN_HEADBUTT
	dbw 47, BATON_PASS ; Poison Fang → egg move
	dbw 55, PSYCHIC_M
	dbw 59, BUG_BUZZ
	db -1 ; no more level-up moves

.DiglettPlainEvosAttacks
	evo_data EVOLVE_LEVEL, 26, DUGTRIO, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, MUD_SLAP ; Sand Attack → Mud-Slap
	dbw 1, SCRATCH
	dbw 1, CHARM ; XD move
	dbw 4, GROWL
	dbw 7, ASTONISH
	dbw 10, AGILITY ; Mud-Slap → LGPE move
	dbw 14, MAGNITUDE
	dbw 18, BULLDOZE
	dbw 22, SUCKER_PUNCH
	dbw 25, ANCIENTPOWER ; Mud Bomb → egg move
	dbw 28, EARTH_POWER
	dbw 31, DIG
	dbw 35, SLASH
	dbw 39, EARTHQUAKE
	dbw 43, NIGHT_SLASH ; Fissure → Dugtrio move
	db -1 ; no more level-up moves

.DugtrioPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TRI_ATTACK ; Sand Tomb → Tri Attack ; evolution move
	dbw 1, NIGHT_SLASH
	dbw 1, MUD_SLAP ; Sand Attack → Mud-Slap
	dbw 1, SCRATCH
	dbw 1, CHARM ; XD move
	dbw 4, GROWL
	dbw 7, ASTONISH
	dbw 10, AGILITY ; Mud-Slap → LGPE move
	dbw 14, MAGNITUDE
	dbw 18, BULLDOZE
	dbw 22, SUCKER_PUNCH
	dbw 25, ANCIENTPOWER ; Mud Bomb → egg move
	dbw 30, EARTH_POWER
	dbw 35, DIG
	dbw 41, SLASH
	dbw 47, EARTHQUAKE
	dbw 53, NIGHT_SLASH ; Fissure → Night Slash
	db -1 ; no more level-up moves

.MeowthPlainEvosAttacks
	evo_data EVOLVE_LEVEL, 28, PERSIAN, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 6, BITE
	dbw 9, ASTONISH ; Fake Out → new move
	dbw 14, FURY_STRIKES ; Fury Swipes → similar move
	dbw 17, SCREECH
	dbw 22, FEINT_ATTACK
	dbw 25, PURSUIT ; Taunt → egg move
	dbw 30, PAY_DAY
	dbw 33, SLASH
	dbw 38, NASTY_PLOT
	dbw 41, THIEF ; Assurance → TM move
	dbw 46, CHARM ; Captivate → egg move
	dbw 49, NIGHT_SLASH
	db -1 ; no more level-up moves

.PersianPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BUBBLE_BEAM ; RBY TM move
	dbw 1, PLAY_ROUGH
	dbw 1, SWIFT ; evolution move
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 6, BITE
	dbw 9, ASTONISH ; Fake Out → new move
	dbw 14, FURY_STRIKES ; Fury Swipes → similar move
	dbw 17, SCREECH
	dbw 22, FEINT_ATTACK
	dbw 25, PURSUIT ; Taunt → egg move
	dbw 32, POWER_GEM
	dbw 37, SLASH
	dbw 44, NASTY_PLOT
	dbw 49, THIEF ; Assurance → TM move
	dbw 56, CHARM ; Captivate → egg move
	dbw 61, NIGHT_SLASH
	db -1 ; no more level-up moves

.PsyduckEvosAttacks
	evo_data EVOLVE_LEVEL, 33, GOLDUCK
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 4, LEER ; Tail Whip → similar move
	dbw 7, WATER_GUN
	dbw 10, CONFUSION
	dbw 13, FURY_STRIKES ; Fury Swipes → similar move
	dbw 16, WATER_PULSE
	dbw 19, DISABLE
	dbw 22, SCREECH
	dbw 25, ZEN_HEADBUTT
	dbw 28, AQUA_TAIL
	dbw 31, RAIN_DANCE ; Soak → TM move
	dbw 34, PSYBEAM ; Psych Up → egg move
	dbw 37, AMNESIA
	dbw 40, HYDRO_PUMP
	dbw 43, NASTY_PLOT ; Wonder Room → SV TM move
	dbw 46, PSYCHIC_M ; TM move
	db -1 ; no more level-up moves

.GolduckEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, AQUA_JET
	dbw 4, LEER ; Tail Whip → similar move
	dbw 7, WATER_GUN
	dbw 10, CONFUSION
	dbw 13, FURY_STRIKES ; Fury Swipes → similar move
	dbw 16, WATER_PULSE
	dbw 19, DISABLE
	dbw 22, SCREECH
	dbw 25, ZEN_HEADBUTT
	dbw 28, AQUA_TAIL
	dbw 31, RAIN_DANCE ; Soak → TM move
	dbw 36, PSYBEAM ; Psych Up → egg move
	dbw 41, AMNESIA
	dbw 46, HYDRO_PUMP
	dbw 51, NASTY_PLOT ; Wonder Room → SV TM move
	dbw 56, PSYCHIC_M ; TM move
	db -1 ; no more level-up moves

.MankeyEvosAttacks
	evo_data EVOLVE_LEVEL, 28, PRIMEAPE
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LOW_KICK
	dbw 1, LEER
	dbw 1, FOCUS_ENERGY
	dbw 5, FURY_STRIKES ; Fury Swipes → similar move
	dbw 8, KARATE_CHOP
	dbw 12, PURSUIT
	dbw 15, SEISMIC_TOSS
	dbw 19, SWAGGER
	dbw 22, CROSS_CHOP
	dbw 26, REVERSAL ; Assurance → egg move
	dbw 29, FEINT_ATTACK ; Punishment → new move
	dbw 33, THRASH
	dbw 36, CLOSE_COMBAT
	dbw 40, SCREECH
	dbw 43, GUNK_SHOT ; Stomping Tantrum → HGSS tutor move
	dbw 47, OUTRAGE
	db -1 ; no more level-up moves

.PrimeapeEvosAttacks
	evo_data EVOLVE_MOVE, OUTRAGE, ANNIHILAPE
	db -1 ; no more evolutions
	dbw 1, OUTRAGE
	dbw 1, RAGE ; evolution move
	dbw 1, SCRATCH
	dbw 1, LOW_KICK
	dbw 1, LEER
	dbw 1, FOCUS_ENERGY
	dbw 5, FURY_STRIKES ; Fury Swipes → similar move
	dbw 8, KARATE_CHOP
	dbw 12, PURSUIT
	dbw 15, SEISMIC_TOSS
	dbw 19, SWAGGER
	dbw 22, CROSS_CHOP
	dbw 26, REVERSAL ; Assurance → egg move
	dbw 30, FEINT_ATTACK ; Punishment → new move
	dbw 35, THRASH
	dbw 39, CLOSE_COMBAT
	dbw 44, SCREECH
	dbw 48, GUNK_SHOT ; Stomping Tantrum → HGSS tutor move
	dbw 53, OUTRAGE
	db -1 ; no more level-up moves

.GrowlithePlainEvosAttacks
	evo_data EVOLVE_ITEM, FIRE_STONE, ARCANINE
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, BITE
	dbw 1, ROAR
	dbw 6, EMBER
	dbw 8, LEER
	dbw 10, SAFEGUARD ; Odor Sleuth → egg move
	dbw 12, BATON_PASS ; Helping Hand → new move
	dbw 17, FIRE_SPIN ; Flame Wheel → egg move
	dbw 19, REVERSAL
	dbw 21, DOUBLE_KICK ; Fire Fang → egg move
	dbw 23, TAKE_DOWN
	dbw 28, FLAME_CHARGE ; Flame Burst → TM move
	dbw 30, AGILITY
	dbw 32, THRASH ; Retaliate → egg move
	dbw 34, FLAMETHROWER
	dbw 39, CRUNCH
	dbw 41, SUNNY_DAY ; Heat Wave → TM move
	dbw 43, OUTRAGE
	dbw 45, PLAY_ROUGH ; Flare Blitz → LGPE move
	dbw 49, FLARE_BLITZ
	db -1 ; no more level-up moves

.ArcaninePlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DRAGON_DANCE ; new move
	dbw 1, GROWL
	dbw 1, BITE
	dbw 1, ROAR
	dbw 1, FLAME_CHARGE
	dbw 1, TAKE_DOWN
	dbw 1, EXTREMESPEED ; evolution move
	db -1 ; no more level-up moves

.PoliwagEvosAttacks
	evo_data EVOLVE_LEVEL, 25, POLIWHIRL
	db -1 ; no more evolutions
	dbw 1, SWEET_KISS ; event move
	dbw 1, WATER_GUN ; Water Sport → Water Gun
	dbw 5, HYPNOSIS ; Water Gun → Hypnosis
	dbw 8, DOUBLE_SLAP ; Hypnosis → Double Slap
	dbw 11, AQUA_JET ; Bubble → new move
	dbw 15, MUD_SLAP ; Double Slap → TM move
	dbw 18, RAIN_DANCE
	dbw 21, BODY_SLAM
	dbw 25, BUBBLE_BEAM
	dbw 28, LOW_KICK ; Mud Shot → LGPE move
	dbw 31, BELLY_DRUM
	dbw 35, GROWTH ; Wake-Up Slap → event move
	dbw 38, HYDRO_PUMP
	dbw 41, EARTH_POWER ; Mud Bomb → similar move
	db -1 ; no more level-up moves

.PoliwhirlEvosAttacks
	evo_data EVOLVE_ITEM, WATER_STONE, POLIWRATH
	evo_data EVOLVE_HOLDING, KINGS_ROCK, TR_ANYTIME, POLITOED
	db -1 ; no more evolutions
	dbw 1, SWEET_KISS ; event move
	dbw 1, WATER_GUN ; Water Sport → Water Gun
	dbw 5, HYPNOSIS ; Water Gun → Hypnosis
	dbw 8, DOUBLE_SLAP ; Hypnosis → Double Slap
	dbw 11, AQUA_JET ; Bubble → new move
	dbw 15, MUD_SLAP ; Double Slap → TM move
	dbw 18, RAIN_DANCE
	dbw 21, BODY_SLAM
	dbw 27, BUBBLE_BEAM
	dbw 32, LOW_KICK ; Mud Shot → LGPE move
	dbw 37, BELLY_DRUM
	dbw 43, GROWTH ; Wake-Up Slap → event move
	dbw 48, HYDRO_PUMP
	dbw 53, EARTH_POWER ; Mud Bomb → similar move
	db -1 ; no more level-up moves

.PoliwrathEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BUBBLE_BEAM
	dbw 1, HYPNOSIS
	dbw 1, DOUBLE_SLAP
	dbw 1, CLOSE_COMBAT ; evolution move
	dbw 32, DYNAMICPUNCH
	dbw 43, EARTH_POWER ; Mind Reader → Poliwhirl move
	dbw 53, CROSS_CHOP ; Circle Throw → similar move
	db -1 ; no more level-up moves

.AbraEvosAttacks
	evo_data EVOLVE_LEVEL, 16, KADABRA
	db -1 ; no more evolutions
	dbw 1, TELEPORT
	db -1 ; no more level-up moves

.KadabraEvosAttacks
	evo_data EVOLVE_ITEM, LINKING_CORD, ALAKAZAM
	db -1 ; no more evolutions
	dbw 1, TELEPORT
	dbw 1, FORESIGHT ; evolution move
	dbw 16, CONFUSION
	dbw 18, DISABLE
	dbw 21, PSYBEAM
	dbw 23, NIGHT_SHADE ; Miracle Eye → LGPE move
	dbw 26, REFLECT
	dbw 28, LIGHT_SCREEN ; Psycho Cut → egg move
	dbw 31, RECOVER
	dbw 33, BARRIER ; Telekinesis → egg move
	dbw 36, BATON_PASS ; Ally Switch → new move
	dbw 38, PSYCHIC_M
	dbw 41, CALM_MIND
	dbw 43, CONFUSE_RAY ; Role Play → new move
	dbw 46, FUTURE_SIGHT
	db -1 ; no more level-up moves

.AlakazamEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TRI_ATTACK ; RBY TM move
	dbw 1, TELEPORT
	dbw 1, FORESIGHT ; evolution move
	dbw 16, CONFUSION
	dbw 18, DISABLE
	dbw 21, PSYBEAM
	dbw 23, NIGHT_SHADE ; Miracle Eye → LGPE move
	dbw 26, REFLECT
	dbw 28, LIGHT_SCREEN ; Psycho Cut → egg move
	dbw 31, RECOVER
	dbw 33, BARRIER ; Telekinesis → egg move
	dbw 36, BATON_PASS ; Ally Switch → new move
	dbw 38, PSYCHIC_M
	dbw 41, CALM_MIND
	dbw 43, CONFUSE_RAY ; Role Play → new move
	dbw 46, FUTURE_SIGHT
	db -1 ; no more level-up moves

.MachopEvosAttacks
	evo_data EVOLVE_LEVEL, 28, MACHOKE
	db -1 ; no more evolutions
	dbw 1, LOW_KICK
	dbw 1, LEER
	dbw 3, FOCUS_ENERGY
	dbw 7, KARATE_CHOP
	dbw 9, FORESIGHT
	dbw 13, RAGE ; Low Sweep → RBY TM move
	dbw 15, SEISMIC_TOSS
	dbw 19, REVERSAL ; Revenge → Sw/Sh move
	dbw 21, KNOCK_OFF
	dbw 25, MACH_PUNCH ; Vital Throw → egg move
	dbw 27, BULLET_PUNCH ; Wake-Up Slap → egg move
	dbw 31, THRASH ; Dual Chop → event move
	dbw 33, CLOSE_COMBAT ; Submission → new move
	dbw 37, BULK_UP
	dbw 39, CROSS_CHOP
	dbw 43, SCARY_FACE
	dbw 45, DYNAMICPUNCH
	db -1 ; no more level-up moves

.MachokeEvosAttacks
	evo_data EVOLVE_ITEM, LINKING_CORD, MACHAMP
	db -1 ; no more evolutions
	dbw 1, LOW_KICK
	dbw 1, LEER
	dbw 3, FOCUS_ENERGY
	dbw 7, KARATE_CHOP
	dbw 9, FORESIGHT
	dbw 13, RAGE ; Low Sweep → RBY TM move
	dbw 15, SEISMIC_TOSS
	dbw 19, REVERSAL ; Revenge → Sw/Sh move
	dbw 21, KNOCK_OFF
	dbw 25, MACH_PUNCH ; Vital Throw → egg move
	dbw 27, BULLET_PUNCH ; Wake-Up Slap → egg move
	dbw 33, THRASH ; Dual Chop → event move
	dbw 37, CLOSE_COMBAT ; Submission → new move
	dbw 43, BULK_UP
	dbw 47, CROSS_CHOP
	dbw 53, SCARY_FACE
	dbw 57, DYNAMICPUNCH
	db -1 ; no more level-up moves

.MachampEvosAttacks
	db -1 ; no more evolutions
	dbw 1, STRENGTH ; evolution move
	dbw 1, ROCK_BLAST ; Sw/Sh move
	dbw 1, LOW_KICK
	dbw 1, LEER
	dbw 3, FOCUS_ENERGY
	dbw 7, KARATE_CHOP
	dbw 9, FORESIGHT
	dbw 13, RAGE ; Low Sweep → RBY TM move
	dbw 15, SEISMIC_TOSS
	dbw 19, REVERSAL ; Revenge → Sw/Sh TM move
	dbw 21, KNOCK_OFF
	dbw 25, MACH_PUNCH ; Vital Throw → egg move
	dbw 27, BULLET_PUNCH ; Wake-Up Slap → egg move
	dbw 33, THRASH ; Dual Chop → event move
	dbw 37, CLOSE_COMBAT ; Submission → new move
	dbw 43, BULK_UP
	dbw 47, CROSS_CHOP
	dbw 53, SCARY_FACE
	dbw 57, DYNAMICPUNCH
	db -1 ; no more level-up moves

.BellsproutEvosAttacks
	evo_data EVOLVE_LEVEL, 21, WEEPINBELL
	db -1 ; no more evolutions
	dbw 1, VINE_WHIP
	dbw 7, GROWTH
	dbw 11, WRAP
	dbw 13, SLEEP_POWDER
	dbw 15, POISONPOWDER
	dbw 17, STUN_SPORE
	dbw 23, ACID
	dbw 27, KNOCK_OFF
	dbw 29, SWEET_KISS ; Sweet Scent → event move
	dbw 35, HEALINGLIGHT ; Gastro Acid → new move
	dbw 39, RAZOR_LEAF
	dbw 41, POISON_JAB
	dbw 47, SUCKER_PUNCH ; Slam → HGSS tutor move
	dbw 50, SWORDS_DANCE ; Wring Out → egg move
	db -1 ; no more level-up moves

.WeepinbellEvosAttacks
	evo_data EVOLVE_ITEM, LEAF_STONE, VICTREEBEL
	db -1 ; no more evolutions
	dbw 1, VINE_WHIP
	dbw 7, GROWTH
	dbw 11, WRAP
	dbw 13, SLEEP_POWDER
	dbw 15, POISONPOWDER
	dbw 17, STUN_SPORE
	dbw 24, ACID
	dbw 29, KNOCK_OFF
	dbw 32, SWEET_KISS ; Sweet Scent → event move
	dbw 39, HEALINGLIGHT ; Gastro Acid → new move
	dbw 44, RAZOR_LEAF
	dbw 47, POISON_JAB
	dbw 54, SUCKER_PUNCH ; Slam → HGSS tutor move
	dbw 58, SWORDS_DANCE ; Wring Out → egg move
	db -1 ; no more level-up moves

.VictreebelEvosAttacks
	db -1 ; no more evolutions
	dbw 1, VINE_WHIP
	dbw 1, SLEEP_POWDER
	dbw 1, HEALINGLIGHT ; Sweet Scent → new move
	dbw 1, RAZOR_LEAF
	dbw 32, SUCKER_PUNCH ; Leaf Storm → prior move
	dbw 44, SWORDS_DANCE ; Leaf Blade → prior move
	db -1 ; no more level-up moves

.TentacoolEvosAttacks
	evo_data EVOLVE_LEVEL, 30, TENTACRUEL
	db -1 ; no more evolutions
	dbw 1, POISON_STING
	dbw 4, SUPERSONIC
	dbw 7, WATER_GUN ; Constrict → new move
	dbw 10, ACID
	dbw 13, TOXIC_SPIKES
	dbw 16, WATER_PULSE
	dbw 19, WRAP
	dbw 22, CONFUSE_RAY ; Acid Spray → event move
	dbw 25, BUBBLE_BEAM
	dbw 28, BARRIER
	dbw 31, POISON_JAB
	dbw 34, VENOSHOCK ; Brine → tutor move
	dbw 37, SCREECH
	dbw 40, HEX
	dbw 43, SLUDGE_BOMB ; Sludge Wave → TM move
	dbw 46, HYDRO_PUMP
	db -1 ; no more level-up moves

.TentacruelEvosAttacks
	db -1 ; no more evolutions
	dbw 1, POWER_WHIP ; evolution move
	dbw 1, POISON_STING
	dbw 4, SUPERSONIC
	dbw 7, WATER_GUN ; Constrict → new move
	dbw 10, ACID
	dbw 13, TOXIC_SPIKES
	dbw 16, WATER_PULSE
	dbw 19, WRAP
	dbw 22, CONFUSE_RAY ; Acid Spray → event move
	dbw 25, BUBBLE_BEAM
	dbw 28, BARRIER
	dbw 32, POISON_JAB
	dbw 36, VENOSHOCK ; Brine → tutor move
	dbw 40, SCREECH
	dbw 44, HEX
	dbw 48, SLUDGE_BOMB ; Sludge Wave → TM move
	dbw 52, HYDRO_PUMP
	db -1 ; no more level-up moves

.GeodudePlainEvosAttacks
	evo_data EVOLVE_LEVEL, 25, GRAVELER, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 4, MUD_SLAP ; Mud Sport → TM move
	dbw 6, RAPID_SPIN ; Rock Polish → event move
	dbw 10, ROLLOUT
	dbw 12, MAGNITUDE
	dbw 16, ROCK_THROW
	dbw 18, ANCIENTPOWER ; Smack Down → HGSS tutor move
	dbw 22, BULLDOZE
	dbw 24, ROCK_BLAST ; Self-Destruct → Rock Blast
	dbw 28, SANDSTORM ; Stealth Rock → TM move
	dbw 30, ROCK_SLIDE ; Rock Blast → TM move
	dbw 34, EARTHQUAKE
	dbw 36, EXPLOSION
	dbw 40, DOUBLE_EDGE
	dbw 42, STONE_EDGE
	db -1 ; no more level-up moves

.GravelerPlainEvosAttacks
	evo_data EVOLVE_ITEM, LINKING_CORD, GOLEM, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 4, MUD_SLAP ; Mud Sport → TM move
	dbw 6, RAPID_SPIN ; Rock Polish → event move
	dbw 10, ROLLOUT
	dbw 12, MAGNITUDE
	dbw 16, ROCK_THROW
	dbw 18, ANCIENTPOWER ; Smack Down → HGSS tutor move
	dbw 22, BULLDOZE
	dbw 24, ROCK_BLAST ; Self-Destruct → Rock Blast
	dbw 30, SANDSTORM ; Stealth Rock → TM move
	dbw 34, ROCK_SLIDE ; Rock Blast → TM move
	dbw 40, EARTHQUAKE
	dbw 44, EXPLOSION
	dbw 50, DOUBLE_EDGE
	dbw 54, STONE_EDGE
	db -1 ; no more level-up moves

.GolemPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 4, MUD_SLAP ; Mud Sport → TM move
	dbw 6, RAPID_SPIN ; Rock Polish → event move
	dbw 10, ROLLOUT
	dbw 12, MAGNITUDE
	dbw 16, ROCK_THROW
	dbw 18, ANCIENTPOWER ; Smack Down → HGSS tutor move
	dbw 22, BULLDOZE
	dbw 24, ROCK_BLAST ; Self-Destruct → Rock Blast
	dbw 30, SANDSTORM ; Stealth Rock → TM move
	dbw 34, ROCK_SLIDE ; Rock Blast → TM move
	dbw 40, EARTHQUAKE
	dbw 44, EXPLOSION
	dbw 50, DOUBLE_EDGE
	dbw 54, STONE_EDGE
	dbw 60, GYRO_BALL ; Heavy Slam → similar move
	db -1 ; no more level-up moves

.PonytaPlainEvosAttacks
	evo_data EVOLVE_LEVEL, 40, RAPIDASH, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 4, LEER ; Tail Whip → similar move
	dbw 9, EMBER
	dbw 13, STOMP ; Flame Wheel → Stomp
	dbw 17, FLAME_CHARGE ; Stomp → Flame Charge
	dbw 21, LOW_KICK ; Flame Charge → event move
	dbw 25, FIRE_SPIN
	dbw 29, TAKE_DOWN
	dbw 33, DOUBLE_KICK ; Inferno → egg move
	dbw 37, AGILITY
	dbw 41, FIRE_BLAST
	dbw 45, EXTREMESPEED ; Bounce → new move
	dbw 49, FLARE_BLITZ
	db -1 ; no more level-up moves

.RapidashPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, PLAY_ROUGH ; evolution move
	dbw 1, POISON_JAB
	dbw 1, MEGAHORN
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 4, LEER ; Tail Whip → similar move
	dbw 9, EMBER
	dbw 13, STOMP ; Flame Wheel → Stomp
	dbw 17, FLAME_CHARGE ; Stomp → Flame Charge
	dbw 21, LOW_KICK ; Flame Charge → event move
	dbw 25, FIRE_SPIN
	dbw 29, TAKE_DOWN
	dbw 33, DOUBLE_KICK ; Inferno → egg move
	dbw 37, AGILITY
	dbw 41, FIRE_BLAST
	dbw 45, EXTREMESPEED ; Bounce → new move
	dbw 49, FLARE_BLITZ
	db -1 ; no more level-up moves

.SlowpokePlainEvosAttacks
	evo_data EVOLVE_HOLDING, KINGS_ROCK, TR_ANYTIME, SLOWKING, PLAIN_FORM
	evo_data EVOLVE_LEVEL, 37, SLOWBRO, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, CURSE
	dbw 1, TACKLE
	dbw 5, GROWL
	dbw 9, WATER_GUN
	dbw 14, CONFUSION
	dbw 19, DISABLE
	dbw 23, HEADBUTT
	dbw 28, WATER_PULSE
	dbw 32, ZEN_HEADBUTT
	dbw 36, SAFEGUARD ; Slack Off → egg move
	dbw 41, AMNESIA
	dbw 45, PSYCHIC_M
	dbw 49, RAIN_DANCE
	dbw 54, BELLY_DRUM ; Psych Up → egg move
	dbw 58, RECOVER ; Heal Pulse → similar move
	db -1 ; no more level-up moves

.SlowbroPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DEFENSE_CURL ; Withdraw → similar move ; evolution move
	dbw 1, CURSE
	dbw 1, TACKLE
	dbw 5, GROWL
	dbw 9, WATER_GUN
	dbw 14, CONFUSION
	dbw 19, DISABLE
	dbw 23, HEADBUTT
	dbw 28, WATER_PULSE
	dbw 32, ZEN_HEADBUTT
	dbw 36, SAFEGUARD ; Slack Off → egg move
	dbw 43, AMNESIA
	dbw 49, PSYCHIC_M
	dbw 55, RAIN_DANCE
	dbw 62, BELLY_DRUM ; Psych Up → egg move
	dbw 68, RECOVER ; Heal Pulse → similar move
	db -1 ; no more level-up moves

.MagnemiteEvosAttacks
	evo_data EVOLVE_LEVEL, 30, MAGNETON
	db -1 ; no more evolutions
	dbw 1, SUPERSONIC
	dbw 1, TACKLE
	dbw 5, THUNDERSHOCK
	dbw 7, THUNDER_WAVE
	dbw 11, QUICK_ATTACK ; Magnet Bomb → TCG move
	dbw 13, LIGHT_SCREEN
	dbw 17, SONIC_BOOM
	dbw 19, SPARK
	dbw 23, SWIFT ; Mirror Shot → TM move
	dbw 25, SCREECH ; Metal Sound → Screech
	dbw 29, THUNDERBOLT ; Electro Ball → TM move
	dbw 31, FLASH_CANNON
	dbw 35, EXPLOSION ; Screech → TM move
	dbw 37, HIDDEN_POWER ; Discharge → TM move
	dbw 41, AGILITY ; Lock-On → event move
	dbw 43, GYRO_BALL ; Magnet Rise → Gyro Ball
	dbw 47, THUNDER ; Gyro Ball → TM move
	dbw 49, ZAP_CANNON
	db -1 ; no more level-up moves

.MagnetonEvosAttacks
	evo_data EVOLVE_ITEM, THUNDERSTONE, MAGNEZONE
	evo_data EVOLVE_LOCATION, MAGNET_TUNNEL, MAGNEZONE
	evo_data EVOLVE_LOCATION, DIM_CAVE, MAGNEZONE
	db -1 ; no more evolutions
	dbw 1, TRI_ATTACK ; evolution move
	dbw 1, SUPERSONIC
	dbw 1, TACKLE
	dbw 5, THUNDERSHOCK
	dbw 7, THUNDER_WAVE
	dbw 11, QUICK_ATTACK ; Magnet Bomb → TCG move
	dbw 13, LIGHT_SCREEN
	dbw 17, SONIC_BOOM
	dbw 19, SPARK
	dbw 23, SWIFT ; Mirror Shot → TM move
	dbw 25, SCREECH ; Metal Sound → Screech
	dbw 29, THUNDERBOLT ; Electro Ball → TM move
	dbw 33, FLASH_CANNON
	dbw 39, EXPLOSION ; Screech → TM move
	dbw 43, HIDDEN_POWER ; Discharge → TM move
	dbw 49, AGILITY ; Lock-On → event move
	dbw 53, GYRO_BALL ; Magnet Rise → Gyro Ball
	dbw 59, THUNDER ; Gyro Ball → TM move
	dbw 63, ZAP_CANNON
	db -1 ; no more level-up moves

.FarfetchDPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, POISON_JAB
	dbw 1, BATON_PASS ; Brave Bird → event move
	dbw 1, PECK
	dbw 1, MUD_SLAP ; Sand Attack → similar move
	dbw 1, LEER
	dbw 7, FURY_STRIKES ; Fury Attack → similar move
	dbw 9, AERIAL_ACE
	dbw 13, KNOCK_OFF
	dbw 15, RAZOR_LEAF ; LGPE move
	dbw 19, SLASH
	dbw 21, KARATE_CHOP ; Air Cutter → new move
	dbw 25, SWORDS_DANCE
	dbw 31, AGILITY
	dbw 33, NIGHT_SLASH
	dbw 37, ACROBATICS
	dbw 43, HI_JUMP_KICK ; Feint → new move
	dbw 45, FALSE_SWIPE
	dbw 49, AIR_SLASH
	dbw 55, BRAVE_BIRD
	db -1 ; no more level-up moves

.DoduoEvosAttacks
	evo_data EVOLVE_LEVEL, 31, DODRIO
	db -1 ; no more evolutions
	dbw 1, PECK
	dbw 1, GROWL
	dbw 5, QUICK_ATTACK
	dbw 8, RAGE
	dbw 12, FURY_STRIKES ; Fury Attack → similar move
	dbw 15, PURSUIT
	dbw 19, BATON_PASS ; Pluck → XD move
	dbw 22, DOUBLE_KICK ; Double Hit → new move
	dbw 26, AGILITY
	dbw 29, DOUBLE_TEAM ; Uproar → TM move
	dbw 33, TRI_ATTACK ; Acupressure → Crystal move
	dbw 36, SWORDS_DANCE
	dbw 40, HI_JUMP_KICK ; Jump Kick → similar move
	dbw 43, DRILL_PECK
	dbw 47, REVERSAL ; Endeavor → new move
	dbw 50, THRASH
	db -1 ; no more level-up moves

.DodrioEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TRI_ATTACK ; evolution move
	dbw 1, PECK
	dbw 1, GROWL
	dbw 5, QUICK_ATTACK
	dbw 8, RAGE
	dbw 12, FURY_STRIKES ; Fury Attack → similar move
	dbw 15, PURSUIT
	dbw 19, BATON_PASS ; Pluck → XD move
	dbw 22, DOUBLE_KICK ; Double Hit → new move
	dbw 26, AGILITY
	dbw 29, DOUBLE_TEAM ; Uproar → TM move
	dbw 34, BULLDOZE ; Acupressure → TM move
	dbw 38, SWORDS_DANCE
	dbw 43, HI_JUMP_KICK ; Jump Kick → similar move
	dbw 47, DRILL_PECK
	dbw 52, REVERSAL ; Endeavor → new move
	dbw 56, THRASH
	db -1 ; no more level-up moves

.SeelEvosAttacks
	evo_data EVOLVE_LEVEL, 34, DEWGONG
	db -1 ; no more evolutions
	dbw 1, HEADBUTT
	dbw 3, GROWL
	dbw 7, WATER_GUN ; Water Sport → RBY TM move
	dbw 11, ICY_WIND
	dbw 13, ENCORE
	dbw 17, ICE_SHARD
	dbw 21, REST
	dbw 23, SLEEP_TALK ; Aqua Ring → TM move
	dbw 27, AURORA_BEAM
	dbw 31, AQUA_JET
	dbw 33, BUBBLE_BEAM ; Brine → RBY TM move
	dbw 37, TAKE_DOWN
	dbw 41, PERISH_SONG ; Dive →  new move
	dbw 43, AQUA_TAIL
	dbw 47, ICE_BEAM
	dbw 51, SAFEGUARD
	dbw 53, HAIL
	db -1 ; no more level-up moves

.DewgongEvosAttacks
	db -1 ; no more evolutions
	dbw 1, ICICLE_SPEAR ; Sheer Cold → egg move ; evolution move
	dbw 1, HEADBUTT
	dbw 3, GROWL
	dbw 7, WATER_GUN ; Signal Beam → RBY TM move
	dbw 11, ICY_WIND
	dbw 13, ENCORE
	dbw 17, ICE_SHARD
	dbw 21, REST
	dbw 23, SLEEP_TALK ; Aqua Ring → TM move
	dbw 27, AURORA_BEAM
	dbw 31, AQUA_JET
	dbw 33, BUBBLE_BEAM ; Brine → RBY TM move
	dbw 39, TAKE_DOWN
	dbw 45, PERISH_SONG ; Dive → new move
	dbw 49, AQUA_TAIL
	dbw 55, ICE_BEAM
	dbw 61, SAFEGUARD
	dbw 65, HAIL
	dbw 69, MEGAHORN ; LGPE move
	db -1 ; no more level-up moves

.GrimerPlainEvosAttacks
	evo_data EVOLVE_LEVEL, 38, MUK, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, ACID ; Poison Gas → new move
	dbw 4, DEFENSE_CURL ; Harden → similar move
	dbw 7, MUD_SLAP
	dbw 12, DISABLE
	dbw 15, VENOSHOCK ; Sludge → tutor move
	dbw 18, HAZE ; Mud Bomb → egg move
	dbw 21, MINIMIZE
	dbw 26, FEINT_ATTACK ; Fling → new move
	dbw 29, SLUDGE_BOMB
	dbw 32, SCARY_FACE ; Sludge Wave → egg move
	dbw 37, SCREECH
	dbw 40, GUNK_SHOT
	dbw 43, PAIN_SPLIT ; Acid Armor → HGSS tutor move
	dbw 46, TOXIC_SPIKES ; Belch → SV TM move
	db -1 ; no more level-up moves

.MukPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, MOONBLAST ; LGPE move
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, ACID ; Poison Gas → new move
	dbw 4, DEFENSE_CURL ; Harden → similar move
	dbw 7, MUD_SLAP
	dbw 12, DISABLE
	dbw 15, VENOSHOCK ; Sludge → tutor move
	dbw 18, HAZE ; Mud Bomb → egg move
	dbw 21, MINIMIZE
	dbw 26, FEINT_ATTACK ; Fling → new move
	dbw 29, SLUDGE_BOMB
	dbw 32, SCARY_FACE ; Sludge Wave → egg move
	dbw 37, SCREECH
	dbw 40, GUNK_SHOT
	dbw 46, PAIN_SPLIT ; Acid Armor → HGSS tutor move
	dbw 52, TOXIC_SPIKES ; Belch → SV TM move
	db -1 ; no more level-up moves

.ShellderEvosAttacks
	evo_data EVOLVE_ITEM, WATER_STONE, CLOYSTER
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, DEFENSE_CURL ; Withdraw → similar move
	dbw 8, SUPERSONIC
	dbw 13, ICICLE_SPEAR
	dbw 16, PROTECT
	dbw 20, LEER
	dbw 25, BITE ; Ice Shard → new move
	dbw 28, ICE_SHARD ; Clamp → Ice Shard
	dbw 32, BUBBLE_BEAM ; Razor Shell → egg move
	dbw 37, AURORA_BEAM
	dbw 40, WHIRLPOOL
	dbw 44, EXPLOSION ; Brine → RBY TM move
	dbw 49, BARRIER ; Iron Defense → egg move
	dbw 52, ICE_BEAM
	dbw 56, SHELL_SMASH
	dbw 61, HYDRO_PUMP
	db -1 ; no more level-up moves

.CloysterEvosAttacks
	db -1 ; no more evolutions
	dbw 1, HYDRO_PUMP
	dbw 1, SHELL_SMASH
	dbw 1, TOXIC_SPIKES
	dbw 1, FURY_STRIKES ; Spike Cannon → similar move
	dbw 1, TRI_ATTACK ; RBY TM move
	dbw 1, DEFENSE_CURL ; Withdraw → similar move
	dbw 1, SUPERSONIC
	dbw 1, PROTECT
	dbw 1, AURORA_BEAM
	dbw 1, SPIKES ; evolution move
	dbw 28, ICICLE_SPEAR ; Spikes → Icicle Spear
	dbw 32, PIN_MISSILE ; Sw/Sh TM move
	dbw 50, ICICLE_CRASH
	db -1 ; no more level-up moves

.GastlyEvosAttacks
	evo_data EVOLVE_LEVEL, 25, HAUNTER
	db -1 ; no more evolutions
	dbw 1, HYPNOSIS
	dbw 1, LICK
	dbw 5, DISABLE ; Spite → egg move
	dbw 8, MEAN_LOOK
	dbw 12, CURSE
	dbw 15, NIGHT_SHADE
	dbw 19, CONFUSE_RAY
	dbw 22, SUCKER_PUNCH
	dbw 26, PAIN_SPLIT ; Payback → HGSS tutor move
	dbw 29, SHADOW_BALL
	dbw 33, DREAM_EATER
	dbw 36, DARK_PULSE
	dbw 40, DESTINY_BOND
	dbw 43, HEX
	dbw 47, PERISH_SONG ; Nightmare → new move
	db -1 ; no more level-up moves

.HaunterEvosAttacks
	evo_data EVOLVE_ITEM, LINKING_CORD, GENGAR
	db -1 ; no more evolutions
	dbw 1, SHADOW_CLAW ; Shadow Punch → TM move ; evolution move
	dbw 1, HYPNOSIS
	dbw 1, LICK
	dbw 5, DISABLE ; Spite → egg move
	dbw 8, MEAN_LOOK
	dbw 12, CURSE
	dbw 15, NIGHT_SHADE
	dbw 19, CONFUSE_RAY
	dbw 22, SUCKER_PUNCH
	dbw 28, PAIN_SPLIT ; Payback → HGSS tutor move
	dbw 33, SHADOW_BALL
	dbw 39, DREAM_EATER
	dbw 44, DARK_PULSE
	dbw 50, DESTINY_BOND
	dbw 55, HEX
	dbw 61, PERISH_SONG ; Nightmare → new move
	db -1 ; no more level-up moves

.GengarEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SHADOW_CLAW ; Shadow Punch → TM move ; evolution move
	dbw 1, HYPNOSIS
	dbw 1, LICK
	dbw 5, DISABLE ; Spite → egg move
	dbw 8, MEAN_LOOK
	dbw 12, CURSE
	dbw 15, NIGHT_SHADE
	dbw 19, CONFUSE_RAY
	dbw 22, SUCKER_PUNCH
	dbw 28, PAIN_SPLIT ; Payback → HGSS tutor move
	dbw 33, SHADOW_BALL
	dbw 39, DREAM_EATER
	dbw 44, DARK_PULSE
	dbw 50, DESTINY_BOND
	dbw 55, HEX
	dbw 61, PERISH_SONG ; Nightmare → new move
	db -1 ; no more level-up moves

.OnixEvosAttacks
	evo_data EVOLVE_HOLDING, METAL_COAT, TR_ANYTIME, STEELIX
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL ; Harden → similar move
	dbw 1, WRAP ; Bind → similar move
	dbw 4, CURSE
	dbw 7, ROCK_THROW
	dbw 10, RAGE
	dbw 13, ROCK_BLAST ; Rock Tomb → egg move
	dbw 16, BODY_SLAM ; Stealth Rock → TM move
	dbw 19, SANDSTORM ; Rock Polish → Sandstorm
	dbw 22, ANCIENTPOWER ; Smack Down → HGSS tutor move
	dbw 25, DRAGONBREATH
	dbw 28, HEADBUTT ; Slam → tutor move
	dbw 31, SCREECH
	dbw 34, ROCK_SLIDE
	dbw 37, CRUNCH ; Sand Tomb → Steelix move
	dbw 40, IRON_TAIL
	dbw 43, DIG
	dbw 46, STONE_EDGE
	dbw 49, DOUBLE_EDGE
	dbw 52, EARTHQUAKE ; Sandstorm → TM move
	db -1 ; no more level-up moves

.DrowzeeEvosAttacks
	evo_data EVOLVE_LEVEL, 26, HYPNO
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, HYPNOSIS
	dbw 5, DISABLE
	dbw 9, CONFUSION
	dbw 13, HEADBUTT
	dbw 17, LOW_KICK ; Poison Gas → HGSS tutor move
	dbw 21, CALM_MIND ; Meditate → TM move
	dbw 25, PSYBEAM
	dbw 29, TRI_ATTACK ; Wake-Up Slap → RBY TM move
	dbw 33, BARRIER ; Psych Up → egg move
	dbw 37, BELLY_DRUM ; Synchronoise → event move
	dbw 41, ZEN_HEADBUTT
	dbw 45, SWAGGER
	dbw 49, PSYCHIC_M
	dbw 53, NASTY_PLOT
	dbw 57, TOXIC ; Psyshock → TM move
	dbw 61, FUTURE_SIGHT
	db -1 ; no more level-up moves

.HypnoEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, HYPNOSIS
	dbw 5, DISABLE
	dbw 9, CONFUSION
	dbw 13, HEADBUTT
	dbw 17, LOW_KICK ; Poison Gas → HGSS tutor move
	dbw 21, CALM_MIND ; Meditate → TM move
	dbw 25, PSYBEAM
	dbw 29, TRI_ATTACK ; Wake-Up Slap → RBY TM move
	dbw 33, BARRIER ; Psych Up → egg move
	dbw 37, BELLY_DRUM ; Synchronoise → event move
	dbw 41, ZEN_HEADBUTT
	dbw 45, SWAGGER
	dbw 49, PSYCHIC_M
	dbw 53, NASTY_PLOT
	dbw 57, TOXIC ; Psyshock → TM move
	dbw 61, FUTURE_SIGHT
	db -1 ; no more level-up moves

.KrabbyEvosAttacks
	evo_data EVOLVE_LEVEL, 28, KINGLER
	db -1 ; no more evolutions
	dbw 1, AQUA_JET ; Bubble → new move
	dbw 5, SCRATCH ; Vice Grip → new move
	dbw 9, LEER
	dbw 11, DEFENSE_CURL ; Harden → similar move
	dbw 15, BUBBLE_BEAM
	dbw 19, DIG ; Mud Shot → egg move
	dbw 21, METAL_CLAW
	dbw 25, STOMP
	dbw 29, PROTECT
	dbw 31, X_SCISSOR ; Guillotine → TM move
	dbw 35, CLOSE_COMBAT ; Slam → new move
	dbw 39, CRABHAMMER ; Brine → Crabhammer
	dbw 41, ANCIENTPOWER ; Crabhammer → HGSS tutor move
	dbw 45, REVERSAL ; Flail → similar move
	db -1 ; no more level-up moves

.KinglerEvosAttacks
	db -1 ; no more evolutions
	dbw 1, AQUA_JET ; Bubble → new move
	dbw 5, SCRATCH ; Vice Grip → new move
	dbw 9, LEER
	dbw 11, DEFENSE_CURL ; Harden → similar move
	dbw 15, BUBBLE_BEAM
	dbw 19, DIG ; Mud Shot → egg move
	dbw 21, METAL_CLAW
	dbw 25, STOMP
	dbw 32, PROTECT
	dbw 37, X_SCISSOR ; Guillotine → TM move
	dbw 44, CLOSE_COMBAT ; Slam → new move
	dbw 51, CRABHAMMER ; Brine → Crabhammer
	dbw 56, ANCIENTPOWER ; Crabhammer → HGSS tutor move
	dbw 63, REVERSAL ; Flail → new move
	db -1 ; no more level-up moves

.VoltorbPlainEvosAttacks
	evo_data EVOLVE_LEVEL, 30, ELECTRODE
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, THUNDERSHOCK ; LGPE move
	dbw 4, SONIC_BOOM
	dbw 6, AGILITY ; Eerie Impulse → event move
	dbw 9, SPARK
	dbw 11, ROLLOUT
	dbw 13, SCREECH
	dbw 16, THUNDER_WAVE ; Charge Beam → TM move
	dbw 20, SWIFT
	dbw 22, THUNDERBOLT ; Electro Ball → TM move
	dbw 26, REFLECT ; Self-Destruct → TM move
	dbw 29, LIGHT_SCREEN
	dbw 34, EXPLOSION ; Magnet Rise → Explosion
	dbw 37, THUNDER ; Discharge → TM move
	dbw 41, BUG_BUZZ ; Explosion → new move
	dbw 46, GYRO_BALL
	dbw 48, MIRROR_COAT
	db -1 ; no more level-up moves

.ElectrodePlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, THUNDERSHOCK ; LGPE move
	dbw 4, SONIC_BOOM
	dbw 6, AGILITY ; Eerie Impulse → event move
	dbw 9, SPARK
	dbw 11, ROLLOUT
	dbw 13, SCREECH
	dbw 16, THUNDER_WAVE ; Charge Beam → TM move
	dbw 20, SWIFT
	dbw 22, THUNDERBOLT ; Electro Ball → TM move
	dbw 26, REFLECT ; Self-Destruct → TM move
	dbw 29, LIGHT_SCREEN
	dbw 36, EXPLOSION ; Magnet Rise → Explosion
	dbw 41, THUNDER ; Discharge → TM move
	dbw 47, BUG_BUZZ ; Explosion → new move
	dbw 54, GYRO_BALL
	dbw 58, MIRROR_COAT
	db -1 ; no more level-up moves

.ExeggcuteEvosAttacks
	evo_data EVOLVE_ITEM, LEAF_STONE, EXEGGUTOR, PLAIN_FORM
	evo_data EVOLVE_ITEM, ODD_SOUVENIR, EXEGGUTOR, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Barrage → new move
	dbw 1, HYPNOSIS
	dbw 7, REFLECT
	dbw 11, LEECH_SEED
	dbw 14, CONFUSION
	dbw 17, RAGE ; Bullet Seed → RBY TM move
	dbw 19, STUN_SPORE
	dbw 21, POISONPOWDER
	dbw 23, SLEEP_POWDER
	dbw 27, PSYBEAM ; Confusion → LGPE move
	dbw 33, ANCIENTPOWER ; Worry Seed → HGSS tutor move
	dbw 37, HEALINGLIGHT ; Natural Gift → new move
	dbw 43, SOLAR_BEAM
	dbw 47, EXTRASENSORY
	dbw 50, PSYCHIC_M ; Bestow → TM move
	db -1 ; no more level-up moves

.ExeggutorPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Barrage → new move
	dbw 1, HYPNOSIS
	dbw 1, CONFUSION
	dbw 1, STOMP ; evolution move
	dbw 17, LOW_KICK ; Psyshock → HGSS tutor move
	dbw 27, ZEN_HEADBUTT ; Egg Bomb → tutor move
	dbw 37, POWER_WHIP ; Wood Hammer → new move
	dbw 47, PETAL_DANCE ; Leaf Storm → new move
	db -1 ; no more level-up moves

.CuboneEvosAttacks
	evo_data EVOLVE_LEVEL, 28, MAROWAK, PLAIN_FORM
	evo_data EVOLVE_ITEM, ODD_SOUVENIR, MAROWAK, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 3, TACKLE ; Tail Whip → new move
	dbw 7, MUD_SLAP ; Bone Club → TM move
	dbw 11, HEADBUTT
	dbw 13, LEER
	dbw 17, FOCUS_ENERGY
	dbw 21, BONEMERANG
	dbw 23, RAGE
	dbw 27, LOW_KICK ; False Swipe → HGSS tutor move
	dbw 31, FALSE_SWIPE ; Thrash → False Swipe
	dbw 33, THRASH ; Fling → Thrash
	dbw 37, MAGNITUDE ; Stomping Tantrum → new move
	dbw 41, ROCK_SMASH ; Endeavor → TM move
	dbw 43, DOUBLE_EDGE
	dbw 47, REVERSAL ; Retaliate → new move
	dbw 51, OUTRAGE ; Bone Rush → HGSS tutor move
	db -1 ; no more level-up moves

.MarowakPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SWORDS_DANCE ; evolution move
	dbw 1, GROWL
	dbw 3, TACKLE ; Tail Whip → new move
	dbw 7, MUD_SLAP ; Bone Club → TM move
	dbw 11, HEADBUTT
	dbw 13, LEER
	dbw 17, FOCUS_ENERGY
	dbw 21, BONEMERANG
	dbw 23, RAGE
	dbw 27, LOW_KICK ; False Swipe → HGSS tutor move
	dbw 33, THRASH
	dbw 37, KNOCK_OFF ; Fling → TM move
	dbw 43, MAGNITUDE ; Stomping Tantrum → new move
	dbw 49, ROCK_SMASH ; Endeavor → TM move
	dbw 53, DOUBLE_EDGE
	dbw 59, REVERSAL ; Retaliate → new move
	dbw 65, OUTRAGE ; Bone Rush → HGSS tutor move
	db -1 ; no more level-up moves

.HitmonleeEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DOUBLE_KICK ; evolution move
	dbw 1, BULK_UP ; Revenge → TM move
	dbw 5, AGILITY ; Meditate → new move
	dbw 9, PURSUIT ; Rolling Kick → egg move
	dbw 13, LOW_KICK ; Jump Kick → HGSS tutor move
	dbw 17, STOMP ; Brick Break → new move
if DEF(FAITHFUL)
	dbw 21, ENDURE ; Focus Energy → TM move
else
	dbw 21, ROCK_SMASH ; Focus Energy → "Brick Break"
endc
	dbw 25, AERIAL_ACE ; Feint → new move
	dbw 29, HI_JUMP_KICK
	dbw 33, DOUBLE_TEAM ; Mind Reader → TM move
	dbw 37, FORESIGHT
	dbw 41, FOCUS_ENERGY ; Wide Guard → LGPE move
	dbw 45, REVERSAL ; Blaze Kick → Reversal
	dbw 49, ENDURE
	dbw 53, FOCUS_BLAST ; Mega Kick → TM move
	dbw 57, CLOSE_COMBAT
	dbw 61, COUNTER ; Reversal → TM move
	db -1 ; no more level-up moves

.HitmonchanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DIZZY_PUNCH ; Comet Punch → Dizzy Punch ; evolution move
	dbw 1, BULK_UP ; Revenge → TM move
	dbw 6, AGILITY
	dbw 11, PURSUIT
	dbw 13, MACH_PUNCH
	dbw 17, BULLET_PUNCH
	dbw 21, AERIAL_ACE ; Feint → new move
	dbw 26, SEISMIC_TOSS ; Vacuum Wave → RBY TM move
	dbw 31, FORESIGHT ; Quick Guard → new move
	dbw 36, THUNDERPUNCH
	dbw 36, ICE_PUNCH
	dbw 36, FIRE_PUNCH
	dbw 41, FOCUS_ENERGY ; Sky Uppercut → LGPE move
	dbw 46, DYNAMICPUNCH ; Mega Punch → TM move
	dbw 51, PROTECT ; Detect → TM move
	dbw 56, FOCUS_BLAST ; Focus Punch → TM move
	dbw 61, COUNTER
	dbw 66, CLOSE_COMBAT
	db -1 ; no more level-up moves

.LickitungEvosAttacks
	evo_data EVOLVE_MOVE, ROLLOUT, LICKILICKY
	db -1 ; no more evolutions
	dbw 1, LICK
	dbw 5, SUPERSONIC
	dbw 9, DEFENSE_CURL
	dbw 13, KNOCK_OFF
	dbw 17, WRAP
	dbw 21, STOMP
	dbw 25, DISABLE
	dbw 29, HEADBUTT ; Slam → TM move
	dbw 33, ROLLOUT
	dbw 37, SCREECH ; Chip Away → Screech
	dbw 41, AMNESIA ; Me First → egg move
	dbw 45, BODY_SLAM ; Refresh → egg move
	dbw 49, CURSE ; Screech → egg move
	dbw 53, POWER_WHIP
	dbw 57, BELLY_DRUM ; Wring Out → egg move
	db -1 ; no more level-up moves

.KoffingEvosAttacks
	evo_data EVOLVE_HOLDING, CHARCOAL, TR_ANYTIME, WEEZING, GALARIAN_FORM
	evo_data EVOLVE_LEVEL, 35, WEEZING, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, ACID ; Smog → new move
	dbw 7, SMOKESCREEN
	dbw 12, ENDURE ; Assurance → TM move
	dbw 15, WILL_O_WISP ; Clear Smog → TM move
	dbw 18, VENOSHOCK ; Sludge → tutor move
	dbw 23, RAGE ; Self-Destruct → RBY TM move
	dbw 26, HAZE
	dbw 29, GYRO_BALL
	dbw 34, SLUDGE_BOMB
	dbw 37, EXPLOSION
	dbw 40, DESTINY_BOND
	dbw 42, PAIN_SPLIT ; Belch → HGSS tutor move
	dbw 45, FIRE_BLAST ; Memento → TM move
	db -1 ; no more level-up moves

.WeezingPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, ACID ; Smog → new move
	dbw 7, SMOKESCREEN
	dbw 12, ENDURE ; Assurance → TM move
	dbw 15, WILL_O_WISP ; Clear Smog → TM move
	dbw 18, VENOSHOCK ; Sludge → tutor move
	dbw 23, RAGE ; Self-Destruct → RBY TM move
	dbw 26, HAZE
	dbw 29, GYRO_BALL
	dbw 34, SLUDGE_BOMB
	dbw 40, EXPLOSION
	dbw 46, DESTINY_BOND
	dbw 51, PAIN_SPLIT ; Belch → HGSS tutor move
	dbw 57, FIRE_BLAST ; Memento → TM move
	db -1 ; no more level-up moves

.RhyhornEvosAttacks
	evo_data EVOLVE_LEVEL, 42, RHYDON
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, MUD_SLAP ; Sand-Attack → similar move
	dbw 1, LEER ; Tail Whip → similar move
	dbw 3, HORN_ATTACK
	dbw 6, FURY_STRIKES ; Fury Attack → similar move
	dbw 9, SCARY_FACE
	dbw 13, MAGNITUDE ; Smack Down → egg move
	dbw 17, STOMP
	dbw 21, BULLDOZE
	dbw 25, ANCIENTPOWER ; Chip Away → HGSS tutor move
	dbw 29, ROCK_BLAST
	dbw 33, TAKE_DOWN ; Drill Run → Take Down
	dbw 37, STONE_EDGE ; Take Down → Stone Edge
	dbw 41, DOUBLE_EDGE ; Double Edge → event move
	dbw 45, EARTHQUAKE
	dbw 49, CLOSE_COMBAT ; Megahorn → new move
	dbw 53, MEGAHORN ; Horn Drill → Megahorn
	db -1 ; no more level-up moves

.RhydonEvosAttacks
	evo_data EVOLVE_HOLDING, PROTECTOR, TR_ANYTIME, RHYPERIOR
	db -1 ; no more evolutions
	dbw 1, OUTRAGE ; Hammer Arm → HGSS tutor move ; evolution move
	dbw 1, TACKLE
	dbw 1, MUD_SLAP ; Sand-Attack → similar move
	dbw 1, LEER ; Tail Whip → similar move
	dbw 3, HORN_ATTACK
	dbw 6, FURY_STRIKES ; Fury Attack → similar move
	dbw 9, SCARY_FACE
	dbw 13, MAGNITUDE ; Smack Down → egg move
	dbw 17, STOMP
	dbw 21, BULLDOZE
	dbw 25, ANCIENTPOWER ; Chip Away → HGSS tutor move
	dbw 29, ROCK_BLAST
	dbw 33, TAKE_DOWN ; Drill Run → Take Down
	dbw 37, STONE_EDGE ; Take Down → Stone Edge
	dbw 41, DOUBLE_EDGE ; Double Edge → event move
	dbw 48, EARTHQUAKE
	dbw 55, CLOSE_COMBAT ; Megahorn → new move
	dbw 62, MEGAHORN ; Horn Drill → Megahorn
	db -1 ; no more level-up moves

.ChanseyEvosAttacks
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, BLISSEY
	db -1 ; no more evolutions
	dbw 1, DEFENSE_CURL
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, GROWL
	dbw 5, LEER ; Tail Whip → similar move
	dbw 9, SWEET_KISS ; Refresh → Happiny move
	dbw 12, DOUBLE_SLAP
	dbw 16, FRESH_SNACK ; Soft-Boiled → similar move
	dbw 20, METRONOME ; Bestow → egg move
	dbw 23, MINIMIZE
	dbw 27, TAKE_DOWN
	dbw 31, SING
	dbw 35, CHARM ; Fling → Happiny move
	dbw 39, HEAL_BELL ; Heal Pulse → HGSS tutor move
	dbw 44, BODY_SLAM ; Egg Bomb → TM move
	dbw 50, LIGHT_SCREEN
	dbw 57, SUBSTITUTE ; Healing Wish → TM move
	dbw 65, DOUBLE_EDGE
	db -1 ; no more level-up moves

.TangelaEvosAttacks
	evo_data EVOLVE_MOVE, ANCIENTPOWER, TANGROWTH
	db -1 ; no more evolutions
	dbw 1, WRAP ; Constrict → similar move
	dbw 4, SLEEP_POWDER
	dbw 7, VINE_WHIP
	dbw 10, ABSORB
	dbw 14, POISONPOWDER
	dbw 17, PROTECT ; Bind → TM move
	dbw 20, GROWTH
	dbw 23, MEGA_DRAIN
	dbw 27, KNOCK_OFF
	dbw 30, STUN_SPORE
	dbw 33, HEALINGLIGHT ; Natural Gift → new move
	dbw 36, GIGA_DRAIN
	dbw 38, ANCIENTPOWER
	dbw 41, BODY_SLAM ; Slam → similar move
	dbw 44, PAIN_SPLIT ; Tickle → HGSS tutor move
	dbw 46, SWORDS_DANCE ; Wring Out → TM move
	dbw 48, BATON_PASS ; Grassy Terrain → new move
	dbw 50, POWER_WHIP
	db -1 ; no more level-up moves

.KangaskhanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DIZZY_PUNCH ; Comet Punch → Dizzy Punch
	dbw 1, LEER
	dbw 7, LOW_KICK ; Fake Out → HGSS tutor move
	dbw 10, BITE ; Tail Whip → Bite
	dbw 13, HEADBUTT ; Bite → tutor move
	dbw 19, DOUBLE_KICK ; Double Hit → new move
	dbw 22, RAGE
	dbw 25, TAKE_DOWN ; Mega Punch → RBY TM move
	dbw 31, STOMP ; Chip Away → egg move
	dbw 34, MACH_PUNCH ; Dizzy Punch → new move
	dbw 37, CRUNCH
	dbw 43, ENDURE
	dbw 46, OUTRAGE
	dbw 49, SUCKER_PUNCH
	dbw 50, REVERSAL
	db -1 ; no more level-up moves

.HorseaEvosAttacks
	evo_data EVOLVE_LEVEL, 32, SEADRA
	db -1 ; no more evolutions
	dbw 1, WATER_GUN ; Bubble → similar move
	dbw 5, SMOKESCREEN
	dbw 9, LEER
	dbw 13, BUBBLE_BEAM ; Water Gun → Bubble Beam
	dbw 17, AQUA_JET ; Twister → new move
	dbw 21, WATER_PULSE ; Bubble Beam → TM move
	dbw 26, FOCUS_ENERGY
	dbw 31, OUTRAGE ; Brine → HGSS tutor move
	dbw 36, AGILITY
	dbw 41, DRAGON_PULSE
	dbw 46, DRAGON_DANCE
	dbw 52, HYDRO_PUMP
	db -1 ; no more level-up moves

.SeadraEvosAttacks
	evo_data EVOLVE_HOLDING, DRAGON_SCALE, TR_ANYTIME, KINGDRA
	db -1 ; no more evolutions
	dbw 1, WATER_GUN ; Bubble → similar move
	dbw 5, SMOKESCREEN
	dbw 9, LEER
	dbw 13, BUBBLE_BEAM ; Water Gun → Bubble Beam
	dbw 17, AQUA_JET ; Twister → new move
	dbw 21, WATER_PULSE ; Bubble Beam → TM move
	dbw 26, FOCUS_ENERGY
	dbw 31, OUTRAGE ; Brine → HGSS tutor move
	dbw 38, AGILITY
	dbw 45, DRAGON_PULSE
	dbw 52, DRAGON_DANCE
	dbw 60, HYDRO_PUMP
	db -1 ; no more level-up moves

.GoldeenEvosAttacks
	evo_data EVOLVE_LEVEL, 33, SEAKING
	db -1 ; no more evolutions
	dbw 1, PECK
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, WATER_GUN ; Water Sport → RBY TM move
	dbw 5, SUPERSONIC
	dbw 8, HORN_ATTACK
	dbw 13, REVERSAL ; Flail → similar move
	dbw 16, WATER_PULSE
	dbw 21, HAZE ; Aqua Ring → egg move
	dbw 24, FURY_STRIKES ; Fury Attack → similar moves
	dbw 29, AGILITY
	dbw 32, WATERFALL
	dbw 37, BODY_SLAM ; Horn Drill → tutor move
	dbw 40, KNOCK_OFF ; Soak → tutor move
	dbw 45, MEGAHORN
	db -1 ; no more level-up moves

.SeakingEvosAttacks
	db -1 ; no more evolutions
	dbw 1, POISON_JAB
	dbw 1, PECK
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, WATER_GUN ; Water Sport → RBY TM move
	dbw 5, SUPERSONIC
	dbw 8, HORN_ATTACK
	dbw 13, REVERSAL ; Flail → similar move
	dbw 16, WATER_PULSE
	dbw 21, HAZE ; Aqua Ring → egg move
	dbw 24, FURY_STRIKES ; Fury Attack → similar moves
	dbw 29, AGILITY
	dbw 32, WATERFALL
	dbw 40, BODY_SLAM ; Horn Drill → tutor move
	dbw 46, KNOCK_OFF ; Soak → tutor move
	dbw 54, MEGAHORN
	db -1 ; no more level-up moves

.StaryuEvosAttacks
	evo_data EVOLVE_ITEM, WATER_STONE, STARMIE
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL ; Harden → similar move
	dbw 4, WATER_GUN
	dbw 7, RAPID_SPIN
	dbw 10, RECOVER
	dbw 13, HYPNOSIS ; Psywave → new move
	dbw 16, SWIFT
	dbw 18, BUBBLE_BEAM
	dbw 22, AGILITY ; Camouflage → new move
	dbw 24, GYRO_BALL
	dbw 28, PAIN_SPLIT ; Brine → HGSS tutor move
	dbw 31, MINIMIZE
	dbw 35, REFLECT ; Reflect Type → new move
	dbw 37, POWER_GEM
	dbw 40, CONFUSE_RAY
	dbw 42, PSYCHIC_M
	dbw 46, LIGHT_SCREEN
	dbw 49, HYDRO_PUMP ; Cosmic Power → Hydro Pump
	db -1 ; no more level-up moves

.StarmieEvosAttacks
	db -1 ; no more evolutions
	dbw 1, HYDRO_PUMP
	dbw 1, WATER_GUN
	dbw 1, RAPID_SPIN
	dbw 1, RECOVER
	dbw 1, SWIFT
	dbw 40, CONFUSE_RAY
	dbw 60, TRI_ATTACK ; RBY TM move
	db -1 ; no more level-up moves

.MrMimePlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BARRIER
	dbw 1, CONFUSION
	dbw 4, HYPNOSIS ; Copycat → egg move
	dbw 8, CALM_MIND ; Meditate → TM move
	dbw 11, DOUBLE_SLAP
	dbw 13, PROTECT ; Mimic → event move
	dbw 15, METRONOME ; Psywave → RBY TM move
	dbw 18, ENCORE
	dbw 22, LIGHT_SCREEN
	dbw 22, REFLECT
	dbw 25, PSYBEAM
	dbw 29, SUBSTITUTE
	dbw 32, CONFUSE_RAY ; Recycle → egg move
	dbw 36, TRICK
	dbw 39, PSYCHIC_M
	dbw 43, FUTURE_SIGHT ; Role Play → egg move
	dbw 46, BATON_PASS
	dbw 50, SAFEGUARD
	db -1 ; no more level-up moves

.ScytherEvosAttacks
	evo_data EVOLVE_HOLDING, METAL_COAT, TR_ANYTIME, SCIZOR
	evo_data EVOLVE_HOLDING, HARD_STONE, TR_ANYTIME, KLEAVOR
	db -1 ; no more evolutions
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 5, FOCUS_ENERGY
	dbw 9, PURSUIT
	dbw 13, FALSE_SWIPE
	dbw 17, AGILITY
	dbw 21, WING_ATTACK
	dbw 25, BUG_BITE ; Fury Cutter → similar move
	dbw 29, SLASH
	dbw 33, GLARE ; Razor Wind → new move
	dbw 37, DOUBLE_TEAM
	dbw 41, X_SCISSOR
	dbw 45, NIGHT_SLASH
	dbw 49, CLOSE_COMBAT ; Double Hit → SV TM move
	dbw 50, AIR_SLASH
	dbw 57, SWORDS_DANCE
	db -1 ; no more level-up moves

.JynxEvosAttacks
	db -1 ; no more evolutions
	dbw 1, PETAL_DANCE ; event move
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, LICK
	dbw 1, CONFUSION ; Smoochum move
	dbw 1, SWEET_KISS ; Smoochum move
	dbw 5, SING ; Lovely Kiss → Smoochum move
	dbw 8, SCREECH ; Lovely Kiss → LGPE move
	dbw 11, ICY_WIND ; Powder Snow → TM move
	dbw 15, DOUBLE_SLAP
	dbw 18, ICE_PUNCH
	dbw 21, METRONOME ; Heart Stamp → RBY TM move
	dbw 25, MEAN_LOOK
	dbw 28, DRAINING_KISS ; Fake Tears → Drain Kiss
	dbw 33, PSYBEAM ; Wake-Up Slap → new move
	dbw 39, AVALANCHE
	dbw 44, BODY_SLAM
	dbw 49, NASTY_PLOT ; Wring Out → egg move
	dbw 55, PERISH_SONG
	dbw 60, BLIZZARD
	db -1 ; no more level-up moves

.ElectabuzzEvosAttacks
	evo_data EVOLVE_HOLDING, ELECTIRIZER, TR_ANYTIME, ELECTIVIRE
	db -1 ; no more evolutions
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 5, THUNDERSHOCK
	dbw 8, LOW_KICK
	dbw 12, SWIFT
	dbw 15, BULK_UP ; Shock Wave → TM move
	dbw 19, THUNDER_WAVE
	dbw 22, KARATE_CHOP ; Electro Ball → egg move
	dbw 26, LIGHT_SCREEN
	dbw 29, THUNDERPUNCH
	dbw 36, SCREECH ; Discharge → Screech
	dbw 42, CROSS_CHOP ; Screech → new move
	dbw 49, THUNDERBOLT
	dbw 55, THUNDER
	db -1 ; no more level-up moves

.MagmarEvosAttacks
	evo_data EVOLVE_HOLDING, MAGMARIZER, TR_ANYTIME, MAGMORTAR
	db -1 ; no more evolutions
	dbw 1, HAZE ; Smog → new move
	dbw 1, LEER
	dbw 5, EMBER
	dbw 8, SMOKESCREEN
	dbw 12, FEINT_ATTACK
	dbw 15, FIRE_SPIN
	dbw 19, LOW_KICK ; Clear Smog → HGSS tutor move
	dbw 22, FLAME_CHARGE ; Flame Burst → TM move
	dbw 26, CONFUSE_RAY
	dbw 29, FIRE_PUNCH
	dbw 36, SUNNY_DAY ; Lava Plume → Sunny Day
	dbw 42, FOCUS_BLAST ; Sunny Day → TM move
	dbw 49, FLAMETHROWER
	dbw 55, FIRE_BLAST
	db -1 ; no more level-up moves

.PinsirEvosAttacks
	db -1 ; no more evolutions
	dbw 1, FURY_STRIKES ; Vice Grip → new move
	dbw 1, FOCUS_ENERGY
	dbw 4, WRAP ; Bind → similar move
	dbw 8, SEISMIC_TOSS
	dbw 12, DEFENSE_CURL ; Harden → similar move
	dbw 16, RAGE ; Revenge → RBY TM move
	dbw 20, ROCK_THROW ; Brick Break → event move
	dbw 26, ROCK_SMASH ; Vital Throw → TM move
	dbw 29, X_SCISSOR
	dbw 33, FEINT_ATTACK ; Submission → egg moves
	dbw 36, OUTRAGE ; Storm Throw → LGPE move
	dbw 40, SWORDS_DANCE
	dbw 43, THRASH
	dbw 47, CLOSE_COMBAT ; Superpower → similar move
	dbw 50, MEGAHORN ; Guillotine → new move
	db -1 ; no more level-up moves

.TaurosPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, LEER ; Tail Whip → similar move
	dbw 5, RAGE
	dbw 8, HORN_ATTACK
	dbw 11, SCARY_FACE
	dbw 15, PURSUIT
	dbw 19, REST
	dbw 24, QUICK_ATTACK ; Payback → event move
	dbw 29, FOCUS_ENERGY ; Work Up → LGPE move
	dbw 35, TAKE_DOWN
	dbw 41, ZEN_HEADBUTT
	dbw 48, SWAGGER
	dbw 55, THRASH
	dbw 63, DOUBLE_EDGE
	dbw 71, GIGA_IMPACT
	dbw 80, OUTRAGE ; HGSS tutor move
	db -1 ; no more level-up moves

.MagikarpEvosAttacks
	evo_data EVOLVE_LEVEL, 20, GYARADOS, NO_FORM ; preserve pre-evo form
	db -1 ; no more evolutions
	dbw 1, SPLASH
	dbw 15, TACKLE
	dbw 30, REVERSAL ; Flail → event move
	db -1 ; no more level-up moves

.GyaradosEvosAttacks
	db -1 ; no more evolutions
	dbw 1, WATERFALL ; HM move
	dbw 1, BITE ; evolution move
	dbw 1, THRASH
	dbw 1, DRAGON_RAGE
	dbw 1, WRAP ; Bind → similar move
	dbw 21, LEER
	dbw 24, GUST ; Twister → new move
	dbw 27, DRAGON_RAGE ; Ice Fang → Dragon Rage
	dbw 30, AQUA_TAIL
	dbw 33, SCARY_FACE
	dbw 36, DRAGONBREATH ; Dragon Rage → GSC TM move
	dbw 39, CRUNCH
	dbw 42, HYDRO_PUMP
	dbw 45, DRAGON_DANCE
	dbw 48, HURRICANE
	dbw 51, RAIN_DANCE
	dbw 54, HYPER_BEAM
	dbw 57, OUTRAGE ; HGSS tutor move
	db -1 ; no more level-up moves

.LaprasEvosAttacks
	db -1 ; no more evolutions
	dbw 1, ANCIENTPOWER ; HGSS tutor move
	dbw 1, DRAGON_RAGE ; RBY TM move
	dbw 1, DRAGONBREATH ; GSC TM move
	dbw 1, SING
	dbw 1, GROWL
	dbw 1, WATER_GUN
	dbw 4, BITE ; Mist → event move
	dbw 7, CONFUSE_RAY
	dbw 10, ICE_SHARD
	dbw 14, WATER_PULSE
	dbw 18, BODY_SLAM
	dbw 22, RAIN_DANCE
	dbw 27, PERISH_SONG
	dbw 32, ICE_BEAM
	dbw 37, FUTURE_SIGHT ; Brine → event move
	dbw 43, SAFEGUARD
	dbw 47, HYDRO_PUMP
	dbw 50, OUTRAGE ; Sheer Cold → HGSS tutor move
	dbw 54, MEGAHORN ; LGPE TM move
	db -1 ; no more level-up moves

.DittoEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TRANSFORM
	db -1 ; no more level-up moves

.EeveeEvosAttacks
	evo_data EVOLVE_ITEM, THUNDERSTONE, JOLTEON
	evo_data EVOLVE_ITEM, WATER_STONE, VAPOREON
	evo_data EVOLVE_ITEM, FIRE_STONE, FLAREON
	evo_data EVOLVE_ITEM, SUN_STONE, ESPEON
	evo_data EVOLVE_ITEM, MOON_STONE, UMBREON
	evo_data EVOLVE_ITEM, LEAF_STONE, LEAFEON
	evo_data EVOLVE_ITEM, ICE_STONE, GLACEON
	evo_data EVOLVE_ITEM, SHINY_STONE, SYLVEON
	evo_data EVOLVE_LOCATION, ILEX_FOREST, LEAFEON
	evo_data EVOLVE_LOCATION, ICE_PATH, GLACEON
	evo_data EVOLVE_HAPPINESS, TR_MORNDAY, ESPEON
	evo_data EVOLVE_HAPPINESS, TR_EVENITE, UMBREON
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	dbw 10, SWIFT
	dbw 13, QUICK_ATTACK
	dbw 17, BITE
	dbw 20, HEAL_BELL ; Refresh → HGSS tutor move
	dbw 23, THIEF ; Covet → TM move
	dbw 25, TAKE_DOWN
	dbw 29, CHARM
	dbw 33, BATON_PASS
	dbw 37, DOUBLE_EDGE
	dbw 41, GROWTH ; Last Resort → event move
	dbw 45, REVERSAL ; Trump Card → new move
	db -1 ; no more level-up moves

.VaporeonEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, WATER_GUN ; evolution move
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	dbw 13, QUICK_ATTACK
	dbw 17, WATER_PULSE
	dbw 20, AURORA_BEAM
	dbw 25, RECOVER ; Aqua Ring → similar move
	dbw 29, BARRIER ; Acid Armor → similar move
	dbw 33, HAZE
	dbw 37, SCALD ; Muddy Water → TM move
	dbw 41, DOUBLE_EDGE ; Last Resort → tutor move
	dbw 45, HYDRO_PUMP
	db -1 ; no more level-up moves

.JolteonEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, THUNDERSHOCK ; evolution move
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	dbw 13, QUICK_ATTACK
	dbw 17, SPARK ; Double Kick → new move
	dbw 20, LIGHT_SCREEN ; Thunder Fang → TM move
	dbw 25, PIN_MISSILE
	dbw 29, AGILITY
	dbw 33, THUNDER_WAVE
	dbw 37, THUNDERBOLT ; Discharge → TM move
	dbw 41, DOUBLE_EDGE ; Last Resort → tutor move
	dbw 45, THUNDER
	db -1 ; no more level-up moves

.FlareonEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, EMBER ; evolution move
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	dbw 13, QUICK_ATTACK
	dbw 17, BITE
	dbw 20, FIRE_SPIN ; Fire Fang → Fire Spin
	dbw 25, FLAME_CHARGE ; Fire Spin → TM move
	dbw 29, SCARY_FACE
	dbw 33, SMOKESCREEN ; Smog → new move
	dbw 37, FLAMETHROWER ; Lava Plume → new move
	dbw 41, DOUBLE_EDGE ; Last Resort → tutor move
	dbw 45, FLARE_BLITZ
	db -1 ; no more level-up moves

.PorygonEvosAttacks
	evo_data EVOLVE_HOLDING, UPGRADE, TR_ANYTIME, PORYGON2
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, CONVERSION
	dbw 1, TELEPORT ; Sharpen → RBY TM move
	dbw 7, PSYBEAM
	dbw 12, AGILITY
	dbw 18, RECOVER
	dbw 23, GROWTH ; Magnet Rise → new move
	dbw 29, AURORA_BEAM ; Signal Beam → new move
	dbw 34, THUNDER_WAVE ; Recycle → TM move
	dbw 40, BARRIER ; Discharge → event move
	dbw 45, THUNDERBOLT ; Lock-On → TM move
	dbw 50, TRI_ATTACK
	dbw 56, MIRROR_COAT ; Magic Coat → new move
	dbw 62, ZAP_CANNON
	db -1 ; no more level-up moves

.OmanyteEvosAttacks
	evo_data EVOLVE_LEVEL, 40, OMASTAR
	db -1 ; no more evolutions
	dbw 1, WRAP ; Constrict → similar move
	dbw 1, DEFENSE_CURL ; Withdraw → similar move
	dbw 7, BITE
	dbw 10, WATER_GUN
	dbw 16, ROCK_THROW ; Rollout → event move
	dbw 19, LEER
	dbw 25, ROLLOUT ; Mud Shot → Rollout
	dbw 28, BUBBLE_BEAM ; Brine → egg move
	dbw 34, PROTECT
	dbw 37, ANCIENTPOWER
	dbw 43, AURORA_BEAM ; Tickle → egg move
	dbw 46, ROCK_BLAST
	dbw 52, SHELL_SMASH
	dbw 55, HYDRO_PUMP
	dbw 61, POWER_GEM ; new move
	db -1 ; no more level-up moves

.OmastarEvosAttacks
	db -1 ; no more evolutions
	dbw 1, WRAP ; Constrict → similar move
	dbw 1, DEFENSE_CURL ; Withdraw → similar move
	dbw 1, ICICLE_SPEAR ; Spike Cannon → new move ; evolution move
	dbw 7, BITE
	dbw 10, WATER_GUN
	dbw 16, ROCK_THROW ; Rollout → event move
	dbw 19, LEER
	dbw 25, ROLLOUT ; Mud Shot → Rollout
	dbw 28, BUBBLE_BEAM ; Brine → egg move
	dbw 34, PROTECT
	dbw 37, ANCIENTPOWER
	dbw 48, SPIKES ; Tickle → new move
	dbw 56, ROCK_BLAST
	dbw 67, SHELL_SMASH
	dbw 75, HYDRO_PUMP
	dbw 86, POWER_GEM ; new move
	db -1 ; no more level-up moves

.KabutoEvosAttacks
	evo_data EVOLVE_LEVEL, 40, KABUTOPS
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, DEFENSE_CURL ; Harden → similar move
	dbw 6, ABSORB
	dbw 11, MUD_SLAP ; Leer → GSC TM move
	dbw 16, ROCK_THROW ; Mud Shot → Rock Throw (event move)
	dbw 21, LEER ; Sand Attack → Leer
	dbw 26, ENDURE
	dbw 31, AQUA_JET
	dbw 36, MEGA_DRAIN
	dbw 41, SCREECH ; Metal Sound → similar move
	dbw 46, ANCIENTPOWER
	dbw 51, GIGA_DRAIN ; Wring Out → TM move
	dbw 56, IRON_HEAD ; new move
	dbw 61, SHELL_SMASH ; new move
	db -1 ; no more level-up moves

.KabutopsEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SLASH ; evolution move
	dbw 1, LOW_KICK ; HGSS tutor move
	dbw 1, SCRATCH
	dbw 1, DEFENSE_CURL ; Harden → similar move
	dbw 6, ABSORB
	dbw 11, MUD_SLAP ; Leer → GSC TM move
	dbw 16, ROCK_THROW ; Mud Shot → Rock Throw (event move)
	dbw 21, LEER ; Sand Attack → Leer
	dbw 26, ENDURE
	dbw 31, AQUA_JET
	dbw 36, MEGA_DRAIN
	dbw 45, SCREECH ; Metal Sound → similar move
	dbw 54, ANCIENTPOWER
	dbw 63, LEECH_LIFE ; Wring Out → LGPE move
	dbw 72, NIGHT_SLASH
	dbw 81, SHELL_SMASH ; new move
	db -1 ; no more level-up moves

.AerodactylEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DRAGON_RAGE ; RBY TM move
	dbw 1, DRAGONBREATH ; GSC TM move
	dbw 1, WING_ATTACK
	dbw 1, SUPERSONIC
	dbw 1, BITE
	dbw 1, SCARY_FACE
	dbw 9, ROAR
	dbw 13, ROCK_THROW ; LGPE move
	dbw 17, AGILITY
	dbw 25, ANCIENTPOWER
	dbw 33, CRUNCH
	dbw 41, TAKE_DOWN
	dbw 49, BRAVE_BIRD ; Sky Drop → new move
	dbw 57, IRON_HEAD
	dbw 65, HYPER_BEAM
	dbw 73, ROCK_SLIDE
	dbw 81, GIGA_IMPACT
	db -1 ; no more level-up moves

.SnorlaxEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, DEFENSE_CURL
	dbw 9, AMNESIA
	dbw 12, LICK
	dbw 17, RAGE ; Chip Away → RBY TM move
	dbw 20, TAKE_DOWN ; Yawn → RBY TM move
	dbw 25, BODY_SLAM
	dbw 28, REST
	dbw 33, SLEEP_TALK
	dbw 36, ROLLOUT
	dbw 41, OUTRAGE ; Block → HGSS tutor move
	dbw 44, BELLY_DRUM
	dbw 49, CRUNCH
	dbw 50, CLOSE_COMBAT ; Heavy Slam → new move
	dbw 57, GIGA_IMPACT
	db -1 ; no more level-up moves

.ArticunoPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GUST
	dbw 1, ICY_WIND ; Powder Snow → similar move
	dbw 1, LEER ; LGPE move
	dbw 8, ICE_SHARD ; Mist → Ice Shard
	dbw 15, SAFEGUARD ; Ice Shard → new move
	dbw 22, EXTRASENSORY ; Mind Reader → event move
	dbw 29, ANCIENTPOWER
	dbw 36, AGILITY
	dbw 43, ICE_BEAM
	dbw 50, AIR_SLASH ; Reflect → new move
	dbw 57, HAIL
	dbw 64, REFLECT ; Tailwind → Reflect
	dbw 71, BLIZZARD
	dbw 78, BRAVE_BIRD ; Sheer Cold → new move
	dbw 85, ROOST
	dbw 92, HURRICANE
	dbw 99, AEROBLAST ; new move
	db -1 ; no more level-up moves

.ZapdosPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, PECK
	dbw 1, THUNDERSHOCK
	dbw 1, LEER ; LGPE move
	dbw 8, THUNDER_WAVE
	dbw 15, PROTECT ; Detect → similar move
	dbw 22, EXTRASENSORY ; Pluck → event move
	dbw 29, ANCIENTPOWER
	dbw 36, AGILITY ; Charge → Agility
	dbw 43, THUNDERBOLT ; Agility → TM move
	dbw 50, DRILL_PECK ; Discharge → Drill Peck
	dbw 57, RAIN_DANCE
	dbw 64, LIGHT_SCREEN
	dbw 71, THUNDER ; Drill Peck → Thunder
	dbw 78, BRAVE_BIRD ; Thunder → new move
	dbw 85, ROOST
	dbw 92, HURRICANE ; Zap Cannon → new move
	dbw 99, ZAP_CANNON
	db -1 ; no more level-up moves

.MoltresPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, WING_ATTACK
	dbw 1, EMBER
	dbw 1, LEER ; LGPE move
	dbw 8, FIRE_SPIN
	dbw 15, SAFEGUARD ; Agility → Safeguard
	dbw 22, EXTRASENSORY ; Endure → event move
	dbw 29, ANCIENTPOWER
	dbw 36, AGILITY ; Flamethrower → Agility
	dbw 43, FLAMETHROWER ; Safeguard → Flamethrower
	dbw 50, AIR_SLASH
	dbw 57, SUNNY_DAY
	dbw 64, WILL_O_WISP ; Heat Wave → event move
	dbw 71, FIRE_BLAST ; Solar Beam → TM move
	dbw 78, BRAVE_BIRD ; Sky Attack → new move
	dbw 85, ROOST
	dbw 92, HURRICANE
	dbw 99, SOLAR_BEAM
	db -1 ; no more level-up moves

.DratiniEvosAttacks
	evo_data EVOLVE_LEVEL, 30, DRAGONAIR
	db -1 ; no more evolutions
	dbw 1, WRAP
	dbw 1, LEER
	dbw 5, THUNDER_WAVE
	dbw 11, AQUA_JET ; Twister → egg move
	dbw 15, DRAGON_RAGE
	dbw 21, HEADBUTT ; Slam → tutor move
	dbw 25, AGILITY
	dbw 31, DRAGONBREATH ; Dragon Tail → GSC TM move
	dbw 35, AQUA_TAIL
	dbw 41, BARRIER ; Dragon Rush → event move
	dbw 45, SAFEGUARD
	dbw 51, DRAGON_DANCE
	dbw 55, OUTRAGE
	dbw 61, HYPER_BEAM
	db -1 ; no more level-up moves

.DragonairEvosAttacks
	evo_data EVOLVE_LEVEL, 55, DRAGONITE
	db -1 ; no more evolutions
	dbw 1, WRAP
	dbw 1, LEER
	dbw 5, THUNDER_WAVE
	dbw 11, AQUA_JET ; Twister → egg move
	dbw 15, DRAGON_RAGE
	dbw 21, HEADBUTT ; Slam → tutor move
	dbw 25, AGILITY
	dbw 33, DRAGONBREATH ; Dragon Tail → GSC TM move
	dbw 39, AQUA_TAIL
	dbw 47, BARRIER ; Dragon Rush → event move
	dbw 53, SAFEGUARD
	dbw 61, DRAGON_DANCE
	dbw 67, OUTRAGE
	dbw 75, HYPER_BEAM
	db -1 ; no more level-up moves

.DragoniteEvosAttacks
	db -1 ; no more evolutions
	dbw 1, HURRICANE
	dbw 1, CLOSE_COMBAT
	dbw 1, FIRE_PUNCH
	dbw 1, THUNDERPUNCH
	dbw 1, ROOST
	dbw 1, WRAP
	dbw 1, LEER
	dbw 1, THUNDER_WAVE
	dbw 1, WING_ATTACK ; evolution move
	dbw 5, THUNDER_WAVE
	dbw 11, AQUA_JET ; Twister → egg move
	dbw 15, DRAGON_RAGE
	dbw 21, HEADBUTT ; Slam → tutor move
	dbw 25, AGILITY
	dbw 33, DRAGONBREATH ; Dragon Tail → GSC TM move
	dbw 39, AQUA_TAIL
	dbw 47, BARRIER ; Dragon Rush → event move
	dbw 53, SAFEGUARD
	dbw 61, DRAGON_DANCE
	dbw 67, OUTRAGE
	dbw 75, HYPER_BEAM
	dbw 81, HURRICANE
	db -1 ; no more level-up moves

.MewtwoEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TELEPORT ; Psywave → RBY TM move
	dbw 1, AGILITY ; Sw/Sh move
	dbw 1, FOCUS_ENERGY ; Laser Focus → similar move
	dbw 1, CONFUSION
	dbw 1, DISABLE
	dbw 10, SAFEGUARD
	dbw 19, SWIFT
	dbw 28, FUTURE_SIGHT
	dbw 37, BARRIER ; Psych Up → Barrier
	dbw 46, RECOVER
	dbw 55, PSYCHIC_M
	dbw 64, POWER_GEM ; Barrier → SV TM move
	dbw 73, AURA_SPHERE
	dbw 82, AMNESIA
	dbw 91, NASTY_PLOT ; Mist → Mew move
	dbw 100, PSYSTRIKE
	db -1 ; no more level-up moves

.MewEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SKETCH ; Reflect Type → new move
	dbw 1, TELEPORT ; event move
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, TRANSFORM
	dbw 1, CONFUSION ; LGPE move
	dbw 10, HEADBUTT ; Mega Punch → TM move
	dbw 20, METRONOME
	dbw 30, PSYCHIC_M
	dbw 40, BARRIER
	dbw 50, ANCIENTPOWER
	dbw 60, BATON_PASS ; Amnesia → Baton Pass
	dbw 70, SAFEGUARD ; Me First → Mewtwo move
	dbw 80, AMNESIA ; Baton Pass → Amnesia
	dbw 90, NASTY_PLOT
	dbw 100, AURA_SPHERE
	db -1 ; no more level-up moves