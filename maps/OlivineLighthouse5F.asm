OlivineLighthouse5F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineLighthouse5F_MapEventHeader:

.Warps: db 7
	warp_def 15, 9, 1, OLIVINE_LIGHTHOUSE_6F
	warp_def 5, 3, 2, OLIVINE_LIGHTHOUSE_4F
	warp_def 7, 9, 3, OLIVINE_LIGHTHOUSE_4F
	warp_def 7, 16, 9, OLIVINE_LIGHTHOUSE_4F
	warp_def 7, 17, 10, OLIVINE_LIGHTHOUSE_4F
	warp_def 5, 16, 2, OLIVINE_LIGHTHOUSE_6F
	warp_def 5, 17, 3, OLIVINE_LIGHTHOUSE_6F

.XYTriggers: db 0

.Signposts: db 1
	signpost 13, 3, SIGNPOST_ITEM + HYPER_POTION, EVENT_OLIVINE_LIGHTHOUSE_5F_HIDDEN_HYPER_POTION

.PersonEvents: db 5
	person_event SPRITE_SAILOR, 11, 8, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerSailorErnest, -1
	person_event SPRITE_YOUNGSTER, 3, 8, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBird_keeperDenis, -1
	itemball_event 12, 15, RARE_CANDY, 1, EVENT_OLIVINE_LIGHTHOUSE_5F_RARE_CANDY
	itemball_event 15, 6, SUPER_REPEL, 1, EVENT_OLIVINE_LIGHTHOUSE_5F_SUPER_REPEL
	tmhmball_event 13, 2, TM_ENERGY_BALL, EVENT_OLIVINE_LIGHTHOUSE_5F_TM_ENERGY_BALL

TrainerBird_keeperDenis:
	trainer EVENT_BEAT_BIRD_KEEPER_DENIS, BIRD_KEEPER, DENIS, Bird_keeperDenisSeenText, Bird_keeperDenisBeatenText, 0, Bird_keeperDenisScript

Bird_keeperDenisScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x60ac3

TrainerSailorErnest:
	trainer EVENT_BEAT_SAILOR_ERNEST, SAILOR, ERNEST, SailorErnestSeenText, SailorErnestBeatenText, 0, SailorErnestScript

SailorErnestScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x60a1f

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
