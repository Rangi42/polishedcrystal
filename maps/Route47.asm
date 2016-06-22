const_value set 2
	const ROUTE47_POKEFAN_M
	const ROUTE47_YOUNGSTER
	const ROUTE47_COOLTRAINER_M
	const ROUTE47_COOLTRAINER_F
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
	db 8
	person_event SPRITE_POKEFAN_M, 26, 59, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerDevin, -1
	person_event SPRITE_YOUNGSTER, 24, 40, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerCamperGrant, -1
	person_event SPRITE_COOLTRAINER_M, 18, 38, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainermThom, -1
	person_event SPRITE_COOLTRAINER_F, 7, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainerfKae, -1
	person_event SPRITE_POKE_BALL, 28, 39, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47Revive, EVENT_ROUTE_47_REVIVE
	person_event SPRITE_POKE_BALL, 32, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47MysticWater, EVENT_ROUTE_47_MYSTIC_WATER
	person_event SPRITE_POKE_BALL, 20, 31, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47QuickClaw, EVENT_ROUTE_47_QUICK_CLAW
	person_event SPRITE_POKE_BALL, 6, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route47MaxRepel, EVENT_ROUTE_47_MAX_REPEL
