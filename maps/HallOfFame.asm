HallOfFame_MapScriptHeader:
	db 1 ; scene scripts
	scene_script HallOfFameEntranceTrigger

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  4, 13, LANCES_ROOM, 3
	warp_event  5, 13, LANCES_ROOM, 4

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  4, 12, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

	const_def 1 ; object constants
	const HALLOFFAME_LANCE

HallOfFameEntranceTrigger:
	priorityjump .Script
	end

.Script:
	follow HALLOFFAME_LANCE, PLAYER
	applymovement HALLOFFAME_LANCE, .WalkUpMovement
	stopfollow
	turnobject PLAYER, RIGHT
	opentext
	writetext .LanceText1
	waitbutton
	checkcode VAR_BADGES
	ifequal 16, .CheckGoldTrophy
	checkevent EVENT_DECO_SILVER_TROPHY
	iftrue .NoTrophy
	jump .SilverTrophy
.CheckGoldTrophy
	checkevent EVENT_DECO_GOLD_TROPHY
	iftrue .NoTrophy
	jump .GoldTrophy
.SilverTrophy
	writetext .LanceTrophyText
	waitbutton
	setevent EVENT_DECO_SILVER_TROPHY
	writetext .SilverTrophyText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext .SilverTrophySentText
	waitbutton
	jump .NoTrophy
.GoldTrophy
	writetext .LanceTrophyText
	waitbutton
	setevent EVENT_DECO_GOLD_TROPHY
	writetext .GoldTrophyText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext .GoldTrophySentText
	waitbutton
	jump .NoTrophy
.NoTrophy
	writetext .LanceText2
	waitbutton
	closetext
	turnobject HALLOFFAME_LANCE, UP
	applyonemovement PLAYER, slow_step_up
	setscene $1
	pause 15
	writebyte 2 ; Machine is in the Hall of Fame
	special HealMachineAnim
	checkcode VAR_BADGES
	ifless 16, .NotATrueRematch
	setevent EVENT_BEAT_ELITE_FOUR_AGAIN
.NotATrueRematch
	setevent EVENT_BEAT_ELITE_FOUR
	setevent EVENT_TELEPORT_GUY
	setevent EVENT_RIVAL_SPROUT_TOWER
	setevent EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	clearevent EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	special RespawnOneOffs
	setmapscene SPROUT_TOWER_3F, $1
	special HealParty
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftrue .SkipPhoneCall
	specialphonecall SPECIALCALL_SSTICKET
	setevent EVENT_BATTLE_TOWER_OPEN
	clearevent EVENT_BATTLE_TOWER_CLOSED
.SkipPhoneCall:
	halloffame
	end

.WalkUpMovement:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_right
	turn_head_left
	step_end

.LanceText1:
	text "Lance: It's been a"
	line "long time since I"
	cont "last came here."

	para "This is where we"
	line "honor the League"

	para "Champions for all"
	line "eternity."

	para "Their courageous"
	line "#mon are also"
	cont "inducted."
	done

.LanceTrophyText:
	text "Take this as a"
	line "memento of what"

	para "you accomplished"
	line "here today."
	done

.LanceText2:
	text "Here today, we"
	line "witnessed the rise"

	para "of a new League"
	line "Champion--a"

	para "trainer who feels"
	line "compassion for,"

	para "and trust toward,"
	line "all #mon."

	para "A trainer who"
	line "succeeded through"

	para "perseverance and"
	line "determination."

	para "The new League"
	line "Champion who has"

	para "all the makings"
	line "of greatness!"

	para "<PLAYER>, allow me"
	line "to register you"

	para "and your partners"
	line "as Champions!"
	done

.GoldTrophyText:
	text "<PLAYER> received"
	line "Gold Trophy."
	done

.GoldTrophySentText:
	text "Gold Trophy"
	line "was sent home."
	done

.SilverTrophyText:
	text "<PLAYER> received"
	line "Silver Trophy."
	done

.SilverTrophySentText:
	text "Silver Trophy"
	line "was sent home."
	done
