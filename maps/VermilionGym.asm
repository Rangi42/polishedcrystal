VermilionGym_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, VermilionGymDoorsScript

	db 2 ; warp events
	warp_event  4, 17, VERMILION_CITY, 7
	warp_event  5, 17, VERMILION_CITY, 7

	db 0 ; coord events

	db 17 ; bg events
	bg_event  1,  7, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  3,  7, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  5,  7, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  7,  7, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  9,  7, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  1,  9, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  3,  9, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  5,  9, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  7,  9, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  9,  9, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  1, 11, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  3, 11, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  5, 11, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  7, 11, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  9, 11, SIGNPOST_READ, VermilionGymTrashCanScript
	bg_event  3, 15, SIGNPOST_READ, VermilionGymStatue
	bg_event  6, 15, SIGNPOST_READ, VermilionGymStatue

	db 10 ; object events
	object_event  4,  5, SPRITE_ELECTRIC_FENCE_LEFT, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, jumptext, VermilionGymElectricFenceText, EVENT_VERMILION_GYM_SWITCH_1
	object_event  5,  5, SPRITE_ELECTRIC_FENCE_RIGHT, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, jumptext, VermilionGymElectricFenceText, EVENT_VERMILION_GYM_SWITCH_1
	object_event  4,  4, SPRITE_ELECTRIC_FENCE_LEFT, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, jumptext, VermilionGymElectricFenceText, EVENT_VERMILION_GYM_SWITCH_2
	object_event  5,  4, SPRITE_ELECTRIC_FENCE_RIGHT, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, jumptext, VermilionGymElectricFenceText, EVENT_VERMILION_GYM_SWITCH_2
	object_event  5,  2, SPRITE_SURGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, SurgeScript_0x1920a5, -1
	object_event  8,  8, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerGentlemanGregory, -1
	object_event  4,  7, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 3, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerGuitaristmVincent, -1
	object_event  0, 10, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerJugglerHorton, -1
	object_event  7, 10, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerGuitaristfJanet, -1
	object_event  7, 15, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 1, VermilionGymGuyScript, -1

	const_def 1 ; object constants
	const VERMILIONGYM_FENCE_1_LEFT
	const VERMILIONGYM_FENCE_1_RIGHT
	const VERMILIONGYM_FENCE_2_LEFT
	const VERMILIONGYM_FENCE_2_RIGHT

VermilionGymDoorsScript:
	checkevent EVENT_VERMILION_GYM_SWITCH_2
	iftrue .done
	checkevent EVENT_VERMILION_GYM_SWITCH_1
	iffalse .resample
	appear VERMILIONGYM_FENCE_1_LEFT
	appear VERMILIONGYM_FENCE_1_RIGHT
.resample
	callasm SampleVermilionGymTrashCan
.done
	return

SurgeScript_0x1920a5:
	faceplayer
	opentext
	checkflag ENGINE_THUNDERBADGE
	iftrue .FightDone
	writetext UnknownText_0x192142
	waitbutton
	closetext
	winlosstext UnknownText_0x192238, 0
	loadtrainer LT_SURGE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LTSURGE
	setevent EVENT_BEAT_GENTLEMAN_GREGORY
	setevent EVENT_BEAT_GUITARISTM_VINCENT
	setevent EVENT_BEAT_JUGGLER_HORTON
	setevent EVENT_BEAT_GUITARISTF_JANET
	opentext
	writetext UnknownText_0x192277
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_THUNDERBADGE
	checkcode VAR_BADGES
	ifequal 9, .FirstBadge
	ifequal 10, .SecondBadge
	ifequal 12, .LyrasEgg
	jump .FightDone
.FirstBadge:
	specialphonecall SPECIALCALL_FIRSTBADGE
	jump .FightDone
.SecondBadge:
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftrue .FightDone
	specialphonecall SPECIALCALL_SECONDBADGE
	jump .FightDone
.LyrasEgg:
	specialphonecall SPECIALCALL_LYRASEGG
.FightDone:
	checkevent EVENT_GOT_TM43_WILD_CHARGE
	iftrue_jumpopenedtext UnknownText_0x192303
	writetext UnknownText_0x192291
	buttonsound
	verbosegivetmhm TM_WILD_CHARGE
	setevent EVENT_GOT_TM43_WILD_CHARGE
	jumpopenedtext SurgeOutroText

GenericTrainerGentlemanGregory:
	generictrainer GENTLEMAN, GREGORY, EVENT_BEAT_GENTLEMAN_GREGORY, GentlemanGregorySeenText, GentlemanGregoryBeatenText

	text "When I was still"
	line "in the army, Lt."

	para "Surge saved my"
	line "life."
	done

GenericTrainerGuitaristmVincent:
	generictrainer GUITARISTM, VINCENT, EVENT_BEAT_GUITARISTM_VINCENT, GuitaristmVincentSeenText, GuitaristmVincentBeatenText

	text "Lt.Surge is pro-"
	line "tected by electric"

	para "fences so you"
	line "won't underestimate"
	cont "his strength!"
	done

GenericTrainerJugglerHorton:
	generictrainer JUGGLER, HORTON, EVENT_BEAT_JUGGLER_HORTON, JugglerHortonSeenText, JugglerHortonBeatenText

	text "Don't get too com-"
	line "fortable about"

	para "beating me…"
	line "Lt.Surge is tough."
	done

GenericTrainerGuitaristfJanet:
	generictrainer GUITARISTF, JANET, EVENT_BEAT_GUITARISTF_JANET, GuitaristfJanetSeenText, GuitaristfJanetBeatenText

	text "Lt.Surge hid both"
	line "switches for the"

	para "electric fences"
	line "in the trash."
	done

VermilionGymGuyScript:
	checkevent EVENT_BEAT_LTSURGE
	iftrue_jumptextfaceplayer VermilionGymGuyWinText
	jumptextfaceplayer VermilionGymGuyText

VermilionGymTrashCanScript:
	checkevent EVENT_VERMILION_GYM_SWITCH_2
	iftrue .trash_can
	callasm CheckVermilionGymTrashCan
	iftrue .open_lock
	checkevent EVENT_VERMILION_GYM_SWITCH_1
	iftrue .reset_switches
.trash_can
	jumpstd trashcan

.open_lock
	opentext
	writetext VermilionGymFoundSwitchText
	playsound SFX_PUSH_BUTTON
	buttonsound
	checkevent EVENT_VERMILION_GYM_SWITCH_1
	iftrue .second_switch
	writetext VermilionGymFoundFirstSwitchText
	playsound SFX_ENTER_DOOR
	disappear VERMILIONGYM_FENCE_1_LEFT
	disappear VERMILIONGYM_FENCE_1_RIGHT
	waitendtext

.second_switch
	writetext VermilionGymFoundSecondSwitchText
	playsound SFX_ENTER_DOOR
	disappear VERMILIONGYM_FENCE_2_LEFT
	disappear VERMILIONGYM_FENCE_2_RIGHT
	waitendtext

.reset_switches
	opentext
	writetext UnknownText_0x19261e
	buttonsound
	writetext VermilionGymResetSwitchesText
	playsound SFX_WRONG
	waitbutton
	closetext
	callasm SampleVermilionGymTrashCan
	appear VERMILIONGYM_FENCE_1_LEFT
	appear VERMILIONGYM_FENCE_1_RIGHT
	end

VermilionGymStatue:
	trainertotext LT_SURGE, 1, $1
	checkflag ENGINE_THUNDERBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

UnknownText_0x192142:
	text "Surge: Hey, you"
	line "little tyke!"

	para "I have to hand it"
	line "to you. It may not"

	para "be very smart to"
	line "challenge me, but"
	cont "it takes guts!"

	para "When it comes to"
	line "electric #mon,"
	cont "I'm number one!"

	para "I've never lost on"
	line "the battlefield."

	para "I'll zap you just"
	line "like I did my"
	cont "enemies in war!"
	done

UnknownText_0x192238:
	text "Surge: Arrrgh!"
	line "You are strong!"

	para "OK, kid. You get"
	line "the Thunder Badge!"
	done

UnknownText_0x192277:
	text "<PLAYER> received"
	line "the Thunder Badge."
	done

UnknownText_0x192291:
	text "Surge: Consider it"
	line "proof that you"
	cont "defeated me."

	para "Looks good on your"
	line "Trainer Card,"
	cont "doesn't it?"

	para "You wear it"
	line "proudly, hear?"

	para "And here's a great"
	line "TM for you!"
	done

SurgeOutroText:
	text "That TM contains"
	line "Wild Charge. Use"

	para "it to go like"
	line "lightning!"
	done

UnknownText_0x192303:
	text "Surge: Hey, kid!"
	line "Still slugging and"
	cont "chugging away?"

	para "My #mon and I"
	line "are still at it!"
	done

GentlemanGregorySeenText:
	text "You're here to"
	line "defeat Lt.Surge?"

	para "Not if I can help"
	line "it!"
	done

GentlemanGregoryBeatenText:
	text "Sorry I failed"
	line "you, Lt.Surge,"
	cont "sir!"
	done

GuitaristmVincentSeenText:
	text "Lt.Surge recog-"
	line "nized my potential"

	para "with Electric"
	line "#mon."

	para "Think you can beat"
	line "me?"
	done

GuitaristmVincentBeatenText:
	text "Ooh, how shocking!"
	done

JugglerHortonSeenText:
	text "I'm going to take"
	line "you down! Prepare"
	cont "to be shocked!"
	done

JugglerHortonBeatenText:
	text "Gwaaah!"
	line "I was overpowered…"
	done

GuitaristfJanetSeenText:
	text "I'm a lightweight,"
	line "but I'm good with"
	cont "electricity!"
	done

GuitaristfJanetBeatenText:
	text "Fried!"
	done

VermilionGymGuyText:
	text "Yo! Champ in"
	line "making!"

	para "Lt.Surge is very"
	line "cautious. He has"

	para "traps set all over"
	line "the Gym."

	para "But you're good at"
	line "Gym puzzles by"
	cont "now, aren't you?"

	para "You'll have no"
	line "problem getting to"
	cont "Lt.Surge."
	done

VermilionGymGuyWinText:
	text "Whew! That was an"
	line "electrifying bout!"

	para "It sure made me"
	line "nervous."
	done

VermilionGymFoundSwitchText:
	text "A secret switch"
	line "beneath the trash?"

	para "Better press it."
	done

VermilionGymFoundFirstSwitchText:
	text "The first electric"
	line "fence unlocked!"
	done

VermilionGymFoundSecondSwitchText:
	text "The second"
	line "electric fence"

	para "unlocked! The"
	line "path is clear!"
	done

VermilionGymResetSwitchesText:
	text "Oh no, the elec-"
	line "tric fence locked"
	cont "again!"
	done

UnknownText_0x19261e:
	text "Nope! Nothing here"
	line "but trash."
	done

VermilionGymElectricFenceText:
	text "An electric fence!"
	line "Don't touch it!"
	done

; Vermilion Gym trash can code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/maps/VermilionGym.asm

SampleVermilionGymTrashCan:
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
.loop
	call Random
	and $3f
	cp 38
	jr nc, .loop
	ld [wVermilionGymTrashCan1], a
	xor a
	ld [wVermilionGymTrashCan2], a
	pop af
	ld [rSVBK], a
	ret

CheckVermilionGymTrashCan:
	call GetFacingTileCoord
	ld hl, .CoordTable
	ld a, d
	swap a
	or e
	push af
	ld de, 3
	call IsInArray
	pop bc
	jr nc, .nope_no_pop
	ld a, [rSVBK]
	push af
	ld a, 3
	ld [rSVBK], a
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wVermilionGymTrashCan1]
	ld de, 1
	push bc
	call IsInArray
	pop bc
	jr nc, .nope
	ld a, [wVermilionGymTrashCan2]
	and a
	jr z, .set
	cp b
	jr z, .nope
	pop af
	ld [rSVBK], a
	ld a, 2
	jr .done

.set
	ld a, b
	ld [wVermilionGymTrashCan2], a
	pop af
	ld [rSVBK], a
	ld a, 1
	jr .done
.nope
	pop af
	ld [rSVBK], a
.nope_no_pop
	xor a
.done
	ld [ScriptVar], a
	ret

.CoordTable
vermiliongymtrashcan: MACRO
	dn \1 + 4, \2 + 4
	dw \3
endm
	vermiliongymtrashcan 1,  7, .Set1_1
	vermiliongymtrashcan 3,  7, .Set2_1
	vermiliongymtrashcan 5,  7, .Set3_1
	vermiliongymtrashcan 7,  7, .Set4_1
	vermiliongymtrashcan 9,  7, .Set5_1
	vermiliongymtrashcan 1,  9, .Set1_2
	vermiliongymtrashcan 3,  9, .Set2_2
	vermiliongymtrashcan 5,  9, .Set3_2
	vermiliongymtrashcan 7,  9, .Set4_2
	vermiliongymtrashcan 9,  9, .Set5_2
	vermiliongymtrashcan 1, 11, .Set1_3
	vermiliongymtrashcan 3, 11, .Set2_3
	vermiliongymtrashcan 5, 11, .Set3_3
	vermiliongymtrashcan 7, 11, .Set4_3
	vermiliongymtrashcan 9, 11, .Set5_3
	db $ff

.Set1_1
	db 0, 12, 22, -1
.Set2_1
	db 0, 1, 14, 23, 26, -1
.Set3_1
	db 1, 2, 16, 27, 30, -1
.Set4_1
	db 2, 3, 18, 31, 34, -1
.Set5_1
	db 3, 20, 35, -1
.Set1_2
	db 4, 12, 13, 23, 24, -1
.Set2_2
	db 4, 5, 14, 15, 22, 25, 27, 28, -1
.Set3_2
	db 5, 6, 16, 17, 26, 29, 31, 32, -1
.Set4_2
	db 6, 7, 18, 19, 30, 33, 35, 36, -1
.Set5_2
	db 7, 20, 21, 35, 37, -1
.Set1_3
	db 8, 13, 25, -1
.Set2_3
	db 8, 9, 15, 24, 29, -1
.Set3_3
	db 9, 10, 17, 28, 33, -1
.Set4_3
	db 10, 11, 19, 32, 37, -1
.Set5_3
	db 11, 21, 36, -1
