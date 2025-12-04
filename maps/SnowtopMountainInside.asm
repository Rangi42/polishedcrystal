SnowtopMountainInside_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, SnowtopMountainInsideFixFacing

	def_warp_events
	warp_event  9, 29, RUGGED_ROAD_NORTH, 1
	warp_event 27, 29, SNOWTOP_MOUNTAIN_OUTSIDE, 1
	warp_event 26,  4, HIDDEN_CAVE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 26,  3, BGEVENT_JUMPSTD, cavegrotto, HIDDENGROTTO_SNOWTOP_MOUNTAIN_INSIDE
	bg_event  6, 22, BGEVENT_ITEM + ZINC, EVENT_SNOWTOP_MOUNTAIN_INSIDE_HIDDEN_ZINC

	def_object_events
	object_event 28, 14, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, KimonoGirlAmiScript, -1
	object_event  5, 20, SPRITE_SKIER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SnowtopMountainInsideSkierScript, -1
	itemball_event  8,  8, ETHER, 1, EVENT_SNOWTOP_MOUNTAIN_INSIDE_ETHER
	itemball_event 16,  9, HEAVY_BOOTS, 1, EVENT_SNOWTOP_MOUNTAIN_INSIDE_HEAVY_BOOTS
	itemball_event 31, 17, COVERT_CLOAK, 1, EVENT_SNOWTOP_MOUNTAIN_INSIDE_COVERT_CLOAK

	object_const_def
	const SNOWTOPMOUNTAININSIDE_KIMONO_GIRL

SnowtopMountainInsideFixFacing:
	callasm .FixFacing
	endcallback

.FixFacing:
	ld hl, wPrevWarp
	ld a, [hli]
	dec a ; warp 1?
	ret nz
	assert wPrevWarp + 1 == wPrevMapGroup
	ld a, [hli]
	cp GROUP_SNOWTOP_MOUNTAIN_OUTSIDE
	ret nz
	assert wPrevMapGroup + 1 == wPrevMapNumber
	ld a, [hl]
	cp MAP_SNOWTOP_MOUNTAIN_OUTSIDE
	ret nz
	ld a, [wPlayerSpriteSetupFlags]
	or (1 << 5) | UP
	ld [wPlayerSpriteSetupFlags], a
	ret

KimonoGirlAmiScript:
	checkevent EVENT_GOT_PP_MAX_FROM_KIMONO_GIRL_AMI
	iftrue_jumptextfaceplayer .OutroText
	faceplayer
	checkevent EVENT_BEAT_KIMONO_GIRL_AMI
	iftruefwd .Beaten
	checkevent EVENT_BEAT_KIMONO_GIRL_NAOKO
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_SAYO
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_ZUKI
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_KUNI
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_MIKI
	iffalse_jumptext .IntroText
	showtext .SeenText
	winlosstext .BeatenText, 0
	setlasttalked SNOWTOPMOUNTAININSIDE_KIMONO_GIRL
	loadtrainerwithpal KIMONO_GIRL, AMI, TRAINERPAL_AMI
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_KIMONO_GIRL_AMI
.Beaten:
	opentext
	writetext .AfterText
	promptbutton
	verbosegiveitem PP_MAX
	iffalse_endtext
	setevent EVENT_GOT_PP_MAX_FROM_KIMONO_GIRL_AMI
	jumpthisopenedtext

.OutroText:
	text "My cousins and I"
	line "dance in Ecruteak"
	cont "City, but we are"

	para "known to travel"
	line "as well."
	done

.IntroText:
	text "I am a Kimono"
	line "Girl."

	para "Haven't you met my"
	line "five dancing cou-"
	cont "sins in Ecruteak?"

	para "Let me know if"
	line "you do."
	done

.SeenText:
	text "If I were to dance"
	line "here, my sandals"

	para "would slip, or"
	line "stick to the ice."

	para "Therefore let us"
	line "battle instead!"
	done

.BeatenText:
	text "Oh, you are"
	line "fearsome…"
	done

.AfterText:
	text "You are a well-"
	line "balanced Trainer."

	para "Please, make use"
	line "of this item!"
	done

SnowtopMountainInsideSkierScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_ICY_WIND_INTRO
	iftruefwd SnowtopMountainInsideTutorIcyWindScript
	writetext SnowtopMountainInsideSkierText
	waitbutton
	setevent EVENT_LISTENED_TO_ICY_WIND_INTRO
SnowtopMountainInsideTutorIcyWindScript:
	writetext Text_SnowtopMountainInsideTutorIcyWind
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_SnowtopMountainInsideTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval ICY_WIND
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_SnowtopMountainInsideTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_SnowtopMountainInsideTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_SnowtopMountainInsideTutorTaught

SnowtopMountainInsideSkierText:
	text "The wind and hail"
	line "in this canyon"

	para "can hurt if you're"
	line "not equipped for"
	cont "icy weather."

	para "It could be a"
	line "good technique"
	cont "for a #mon!"
	done

Text_SnowtopMountainInsideTutorIcyWind:
	text "I'll teach a #-"
	line "mon of yours to"

	para "use Icy Wind if"
	line "you trade me a"
	cont "Silver Leaf."
	done

Text_SnowtopMountainInsideTutorNoSilverLeaf:
	text "Oh, but you don't"
	line "have a Silver"
	cont "Leaf."
	done

Text_SnowtopMountainInsideTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Icy Wind?"
	done

Text_SnowtopMountainInsideTutorRefused: ; text > text
	text "Brr…"
	done

Text_SnowtopMountainInsideTutorTaught:
	text "OK! Now your"
	line "#mon knows"
	cont "Icy Wind!"
	done
