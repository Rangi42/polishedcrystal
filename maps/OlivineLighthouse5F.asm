OlivineLighthouse5F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineLighthouse5F_MapEventHeader:

.Warps: db 7
	warp_def $f, $9, 1, OLIVINE_LIGHTHOUSE_6F
	warp_def $5, $3, 2, OLIVINE_LIGHTHOUSE_4F
	warp_def $7, $9, 3, OLIVINE_LIGHTHOUSE_4F
	warp_def $7, $10, 9, OLIVINE_LIGHTHOUSE_4F
	warp_def $7, $11, 10, OLIVINE_LIGHTHOUSE_4F
	warp_def $5, $10, 2, OLIVINE_LIGHTHOUSE_6F
	warp_def $5, $11, 3, OLIVINE_LIGHTHOUSE_6F

.XYTriggers: db 0

.Signposts: db 1
	signpost 13, 3, SIGNPOST_ITEM, OlivineLighthouse5FHiddenHyperPotion

.PersonEvents: db 5
	person_event SPRITE_SAILOR, 11, 8, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerSailorErnest, -1
	person_event SPRITE_YOUNGSTER, 3, 8, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBird_keeperDenis, -1
	person_event SPRITE_BALL_CUT_FRUIT, 12, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, OlivineLighthouse5FRareCandy, EVENT_OLIVINE_LIGHTHOUSE_5F_RARE_CANDY
	person_event SPRITE_BALL_CUT_FRUIT, 15, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, OlivineLighthouse5FSuperRepel, EVENT_OLIVINE_LIGHTHOUSE_5F_SUPER_REPEL
	person_event SPRITE_BALL_CUT_FRUIT, 13, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TMHMBALL, 0, OlivineLighthouse5FTMEnergyBall, EVENT_OLIVINE_LIGHTHOUSE_5F_TM_ENERGY_BALL

TrainerBird_keeperDenis:
	trainer EVENT_BEAT_BIRD_KEEPER_DENIS, BIRD_KEEPER, DENIS, Bird_keeperDenisSeenText, Bird_keeperDenisBeatenText, 0, Bird_keeperDenisScript

Bird_keeperDenisScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x60ac3
	waitbutton
	closetext
	end

TrainerSailorErnest:
	trainer EVENT_BEAT_SAILOR_ERNEST, SAILOR, ERNEST, SailorErnestSeenText, SailorErnestBeatenText, 0, SailorErnestScript

SailorErnestScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x60a1f
	waitbutton
	closetext
	end

OlivineLighthouse5FRareCandy:
	itemball RARE_CANDY

OlivineLighthouse5FSuperRepel:
	itemball SUPER_REPEL

OlivineLighthouse5FTMEnergyBall:
	tmhmball TM_ENERGY_BALL

OlivineLighthouse5FHiddenHyperPotion:
	dwb EVENT_OLIVINE_LIGHTHOUSE_5F_HIDDEN_HYPER_POTION, HYPER_POTION


SailorErnestSeenText:
	text "I wanted to battle"
	line "Jasmine, but she's"

	para "not up to it now."
	line "So, how about you?"
	done

SailorErnestBeatenText:
	text "Whoa, whoa. You're"
	line "overwhelming!"
	done

UnknownText_0x60a1f:
	text "A Gym Leader isn't"
	line "just about being"

	para "strong. A Leader"
	line "also needs to be"
	cont "compassionate."
	done

Bird_keeperDenisSeenText:
	text "We're pretty high"
	line "up here. My bird"

	para "#mon are in"
	line "prime form."
	done

Bird_keeperDenisBeatenText:
	text "Oops…They crashed…"
	done

UnknownText_0x60ac3:
	text "My #mon learned"
	line "how to use Fly in"
	cont "Cianwood."

	para "Well, since I'm a"
	line "loser, I'll Fly"
	cont "across the sea…"
	done
