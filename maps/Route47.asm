const_value set 2
	const ROUTE47_POKEFAN_M
	const ROUTE47_YOUNGSTER
	const ROUTE47_COOLTRAINER_M
	const ROUTE47_COOLTRAINER_F
	const ROUTE47_COWGIRL
	const ROUTE47_ROCKET1
	const ROUTE47_ROCKET2
	const ROUTE47_ROCKET3
	const ROUTE47_POKE_BALL1
	const ROUTE47_POKE_BALL2
	const ROUTE47_POKE_BALL3
	const ROUTE47_POKE_BALL4

Route47_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerHikerDevin:
	trainer EVENT_BEAT_HIKER_DEVIN, HIKER, DEVIN, HikerDevinSeenText, HikerDevinBeatenText, 0, HikerDevinScript

HikerDevinScript:
	end_if_just_battled
	opentext
	writetext HikerDevinAfterText
	waitbutton
	closetext
	end

TrainerCamperGrant:
	trainer EVENT_BEAT_CAMPER_GRANT, CAMPER, GRANT, CamperGrantSeenText, CamperGrantBeatenText, 0, CamperGrantScript

CamperGrantScript:
	end_if_just_battled
	opentext
	writetext CamperGrantAfterText
	waitbutton
	closetext
	end

TrainerCooltrainermThom:
	trainer EVENT_BEAT_COOLTRAINERM_THOM, COOLTRAINERM, THOM, CooltrainermThomSeenText, CooltrainermThomBeatenText, 0, CooltrainermThomScript

CooltrainermThomScript:
	end_if_just_battled
	opentext
	writetext CooltrainermThomAfterText
	waitbutton
	closetext
	end

TrainerCooltrainerfKae:
	trainer EVENT_BEAT_COOLTRAINERF_KAE, COOLTRAINERF, KAE, CooltrainerfKaeSeenText, CooltrainerfKaeBeatenText, 0, CooltrainerfKaeScript

CooltrainerfKaeScript:
	end_if_just_battled
	opentext
	writetext CooltrainerfKaeAfterText
	waitbutton
	closetext
	end

TrainerCowgirlDaniela:
	trainer EVENT_BEAT_COWGIRL_DANIELA, COWGIRL, DANIELA, CowgirlDanielaSeenText, CowgirlDanielaBeatenText, 0, CowgirlDanielaScript

CowgirlDanielaScript:
	end_if_just_battled
	opentext
	writetext CowgirlDanielaAfterText
	waitbutton
	closetext
	end

TrainerGruntF6:
	trainer EVENT_BEAT_ROCKET_GRUNTF_6, GRUNTF, 6, GruntF6SeenText, GruntF6BeatenText, 0, GruntF6Script

GruntF6Script:
	end_if_just_battled
	opentext
	writetext GruntF6AfterText
	waitbutton
	closetext
	end

TrainerGruntM23:
	trainer EVENT_BEAT_ROCKET_GRUNTM_23, GRUNTM, 23, GruntM23SeenText, GruntM23BeatenText, 0, GruntM23Script

GruntM23Script:
	end_if_just_battled
	opentext
	writetext GruntM23AfterText
	waitbutton
	closetext
	end

TrainerGruntM26:
	trainer EVENT_BEAT_ROCKET_GRUNTM_26, GRUNTM, 26, GruntM26SeenText, GruntM26BeatenText, 0, GruntM26Script

GruntM26Script:
	end_if_just_battled
	opentext
	writetext GruntM26AfterText
	waitbutton
	closetext
	end

Route47QuietCaveSign:
	jumptext Route47QuietCaveSignText

Route47Revive:
	itemball REVIVE

Route47MysticWater:
	itemball MYSTIC_WATER

Route47QuickClaw:
	itemball QUICK_CLAW

Route47MaxRepel:
	itemball MAX_REPEL

Route47HiddenPearl:
	dwb EVENT_ROUTE_47_HIDDEN_PEARL, PEARL

Route47HiddenStardust:
	dwb EVENT_ROUTE_47_HIDDEN_STARDUST, STARDUST

HikerDevinSeenText:
	text "Battles are"
	line "battles, so"
	cont "let's go!"
	done

HikerDevinBeatenText:
	text "Wah ha ha!"
	done

HikerDevinAfterText:
	text "After a battle,"
	line "you should part"
	cont "with a laugh!"
	done

CamperGrantSeenText:
	text "I'm not good with"
	line "crowds, so I'm"
	cont "camping out here"
	cont "with my #mon!"
	done

CamperGrantBeatenText:
	text "I should head"
	line "deeper into the"
	cont "mountain…"
	done

CamperGrantAfterText:
	text "See ya!"
	done

CooltrainermThomSeenText:
	text "Together, my"
	line "#mon and I are"
	cont "much stronger!"
	done

CooltrainermThomBeatenText:
	text "That wasn't what"
	line "I expected…"
	done

CooltrainermThomAfterText:
	text "Your power is"
	line "impossible to"
	cont "predict!"
	done

CooltrainerfKaeSeenText:
	text "Standing atop"
	line "these cliffs"
	cont "makes my heart"
	cont "soar!"
	done

CooltrainerfKaeBeatenText:
	text "I was no match"
	line "for you…"
	done

CooltrainerfKaeAfterText:
	text "Thank you for the"
	line "awe-inspiring"
	cont "battle!"
	done

CowgirlDanielaSeenText:
	text "TODO"
	done

CowgirlDanielaBeatenText:
	text "TODO"
	done

CowgirlDanielaAfterText:
	text "TODO"
	done

GruntF6SeenText:
	text "Why should we"
	line "raise #mon like"
	cont "ordinary trainers?"

	para "We're Team Rocket!"
	done

GruntF6BeatenText:
	text "Who are you!?"
	done

GruntF6AfterText:
	text "If we treated"
	line "every single"
	cont "#mon well,"

	para "how would we"
	line "make money?"
	done

GruntM23SeenText:
	text "Aww, are you here"
	line "to save the cute"
	cont "little #mon?"
	done

GruntM23BeatenText:
	text "Ack!"
	line "You're tough!"
	done

GruntM23AfterText:
	text "It doesn't matter."
	line "You can't beat"
	cont "all of us!"
	done

GruntM26SeenText:
	text "Stop meddling with"
	line "our plans!"
	done

GruntM26BeatenText:
	text "Just leave us"
	line "alone…"
	done

GruntM26AfterText:
	text "How we treat"
	line "#mon is none"
	cont "of your business!"
	done

Route47QuietCaveSignText:
	text "West to"
	line "Quiet Cave"
	done

Route47_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $15, $43, 2, CLIFF_EDGE_GATE
	warp_def $15, $35, 1, CLIFF_CAVE
	warp_def $11, $34, 2, CLIFF_CAVE
	warp_def $1d, $35, 3, CLIFF_CAVE
	warp_def $17, $b, 1, QUIET_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 32, 36, SIGNPOST_READ, Route47QuietCaveSign
	signpost 33, 34, SIGNPOST_ITEM, Route47HiddenPearl
	signpost 28, 12, SIGNPOST_ITEM, Route47HiddenStardust

.PersonEvents:
	db 12
	person_event SPRITE_POKEFAN_M, 26, 59, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerDevin, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	person_event SPRITE_YOUNGSTER, 24, 40, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerCamperGrant, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	person_event SPRITE_COOLTRAINER_M, 18, 38, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainermThom, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	person_event SPRITE_COOLTRAINER_F, 7, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainerfKae, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	person_event SPRITE_COWGIRL, 8, 51, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerCowgirlDaniela, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET_GIRL, 27, 55, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerGruntF6, EVENT_CLEARED_YELLOW_FOREST
	person_event SPRITE_ROCKET, 20, 36, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 2, TrainerGruntM23, EVENT_CLEARED_YELLOW_FOREST
	person_event SPRITE_ROCKET, 9, 30, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM26, EVENT_CLEARED_YELLOW_FOREST
	person_event SPRITE_POKE_BALL, 28, 39, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47Revive, EVENT_ROUTE_47_REVIVE
	person_event SPRITE_POKE_BALL, 32, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47MysticWater, EVENT_ROUTE_47_MYSTIC_WATER
	person_event SPRITE_POKE_BALL, 20, 31, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47QuickClaw, EVENT_ROUTE_47_QUICK_CLAW
	person_event SPRITE_POKE_BALL, 6, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47MaxRepel, EVENT_ROUTE_47_MAX_REPEL
