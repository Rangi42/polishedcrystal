	enum_start

	enum scall_command
scall: MACRO
	db scall_command
	dw \1 ; pointer
	ENDM

	enum farscall_command
farscall: MACRO
	db farscall_command
	dba \1
	ENDM

	enum ptcall_command
ptcall: MACRO
	db ptcall_command
	dw \1 ; pointer
	ENDM

	enum jump_command
jump: MACRO
	db jump_command
	dw \1 ; pointer
	ENDM

	enum farjump_command
farjump: MACRO
	db farjump_command
	dba \1
	ENDM

	enum ptjump_command
ptjump: MACRO
	db ptjump_command
	dw \1 ; pointer
	ENDM

	enum ifequal_command
ifequal: MACRO
	db ifequal_command
	db \1 ; byte
	dw \2 ; pointer
	ENDM

	enum ifnotequal_command
ifnotequal: MACRO
	db ifnotequal_command
	db \1 ; byte
	dw \2 ; pointer
	ENDM

	enum iffalse_command
iffalse: MACRO
	db iffalse_command
	dw \1 ; pointer
	ENDM

	enum iftrue_command
iftrue: MACRO
	db iftrue_command
	dw \1 ; pointer
	ENDM

	enum ifgreater_command
ifgreater: MACRO
	db ifgreater_command
	db \1 ; byte
	dw \2 ; pointer
	ENDM

	enum ifless_command
ifless: MACRO
	db ifless_command
	db \1 ; byte
	dw \2 ; pointer
	ENDM

	enum jumpstd_command
jumpstd: MACRO
	db jumpstd_command
	db \1 ; predefined_script
	ENDM

	enum callstd_command
callstd: MACRO
	db callstd_command
	db \1 ; predefined_script
	ENDM

	enum callasm_command
callasm: MACRO
	db callasm_command
	dba \1
	ENDM

	enum special_command
special: MACRO
	db special_command
	db (\1Special - SpecialsPointers) / 3
	ENDM

	enum ptcallasm_command
ptcallasm: MACRO
	db ptcallasm_command
	dw \1 ; asm
	ENDM

	enum checkmapscene_command
checkmapscene: MACRO
	db checkmapscene_command
	map_id \1 ; map
	ENDM

	enum setmapscene_command
setmapscene: MACRO
	db setmapscene_command
	map_id \1 ; map
	db \2 ; trigger_id
	ENDM

	enum checkscene_command
checkscene: MACRO
	db checkscene_command
	ENDM

	enum setscene_command
setscene: MACRO
	db setscene_command
	db \1 ; trigger_id
	ENDM

	enum writebyte_command
writebyte: MACRO
	db writebyte_command
	db \1 ; value
	ENDM

	enum addvar_command
addvar: MACRO
	db addvar_command
	db \1 ; value
	ENDM

	enum random_command
random: MACRO
	db random_command
	db \1 ; input
	ENDM

	enum copybytetovar_command
copybytetovar: MACRO
	db copybytetovar_command
	dw \1 ; address
	ENDM

	enum copyvartobyte_command
copyvartobyte: MACRO
	db copyvartobyte_command
	dw \1 ; address
	ENDM

	enum loadvar_command
loadvar: MACRO
	db loadvar_command
	dw \1 ; address
	db \2 ; value
	ENDM

	enum checkcode_command
checkcode: MACRO
	db checkcode_command
	db \1 ; variable_id
	ENDM

	enum writevarcode_command
writevarcode: MACRO
	db writevarcode_command
	db \1 ; variable_id
	ENDM

	enum writecode_command
writecode: MACRO
	db writecode_command
	db \1 ; variable_id
	db \2 ; value
	ENDM

	enum giveitem_command
giveitem: MACRO
	db giveitem_command
	db \1 ; item
if _NARG == 2
	db \2 ; quantity
else
	db 1
endc
	ENDM

	enum takeitem_command
takeitem: MACRO
	db takeitem_command
	db \1 ; item
if _NARG == 2
	db \2 ; quantity
else
	db 1
endc
	ENDM

	enum checkitem_command
checkitem: MACRO
	db checkitem_command
	db \1 ; item
	ENDM

	enum givemoney_command
givemoney: MACRO
	db givemoney_command
	db \1 ; account
	dt \2 ; money
	ENDM

	enum takemoney_command
takemoney: MACRO
	db takemoney_command
	db \1 ; account
	dt \2 ; money
	ENDM

	enum checkmoney_command
checkmoney: MACRO
	db checkmoney_command
	db \1 ; account
	dt \2 ; money
	ENDM

	enum givecoins_command
givecoins: MACRO
	db givecoins_command
	dw \1 ; coins
	ENDM

	enum takecoins_command
takecoins: MACRO
	db takecoins_command
	dw \1 ; coins
	ENDM

	enum checkcoins_command
checkcoins: MACRO
	db checkcoins_command
	dw \1 ; coins
	ENDM

	enum addcellnum_command
addcellnum: MACRO
	db addcellnum_command
	db \1 ; person
	ENDM

	enum delcellnum_command
delcellnum: MACRO
	db delcellnum_command
	db \1 ; person
	ENDM

	enum checkcellnum_command
checkcellnum: MACRO
	db checkcellnum_command
	db \1 ; person
	ENDM

	enum checktime_command
checktime: MACRO
	db checktime_command
	db \1 ; time
	ENDM

	enum checkpoke_command
checkpoke: MACRO
	db checkpoke_command
	db \1 ; pkmn
	ENDM

	enum givepoke_command
givepoke: MACRO
	db givepoke_command
	db \1 ; pokemon
	if _NARG >= 3
	db \2 ; form
	db \3 ; level
	else
	db PLAIN_FORM
	db \2 ; level
	endc
	if _NARG >= 4
	db \4 ; item
	else
	db NO_ITEM
	endc
	if _NARG >= 5
	db \5 ; trainer
	if \5
	dw \6 ; trainer_name_pointer
	dw \7 ; pkmn_nickname
	endc
	else
	db FALSE ; no trainer
	endc
	ENDM

	enum giveegg_command
giveegg: MACRO
	db giveegg_command
	db \1 ; pkmn
	if _NARG >= 3
	db \2 ; form
	db \3 ; level
	else
	db PLAIN_FORM
	db \2 ; level
	endc
	ENDM

	enum givepokeitem_command
givepokeitem: MACRO
	db givepokeitem_command
	dw \1 ; pointer
	ENDM

	enum checkpokeitem_command
checkpokeitem: MACRO
	db checkpokeitem_command
	dw \1 ; pointer
	ENDM

	enum checkevent_command
checkevent: MACRO
	db checkevent_command
	dw \1 ; event_flag
	ENDM

	enum clearevent_command
clearevent: MACRO
	db clearevent_command
	dw \1 ; event_flag
	ENDM

	enum setevent_command
setevent: MACRO
	db setevent_command
	dw \1 ; event_flag
	ENDM

	enum checkflag_command
checkflag: MACRO
	db checkflag_command
	dw \1 ; engine_flag
	ENDM

	enum clearflag_command
clearflag: MACRO
	db clearflag_command
	dw \1 ; engine_flag
	ENDM

	enum setflag_command
setflag: MACRO
	db setflag_command
	dw \1 ; engine_flag
	ENDM

	enum wildon_command
wildon: MACRO
	db wildon_command
	ENDM

	enum wildoff_command
wildoff: MACRO
	db wildoff_command
	ENDM

	enum warpmod_command
warpmod: MACRO
	db warpmod_command
	db \1 ; warp_id
	map_id \2 ; map
	ENDM

	enum blackoutmod_command
blackoutmod: MACRO
	db blackoutmod_command
	map_id \1 ; map
	ENDM

	enum warp_command
warp: MACRO
	db warp_command
	map_id \1 ; map
	db \2 ; x
	db \3 ; y
	ENDM

	enum readmoney_command
readmoney: MACRO
	db readmoney_command
	db \1 ; account
	db \2 ; memory
	ENDM

	enum readcoins_command
readcoins: MACRO
	db readcoins_command
	db \1 ; memory
	ENDM

	enum RAM2MEM_command
RAM2MEM: MACRO
	db RAM2MEM_command
	db \1 ; memory
	ENDM

	enum pokenamemem_command
pokenamemem: MACRO
	db pokenamemem_command
	db \1 ; pokemon
	db \2 ; memory
	ENDM

	enum itemtotext_command
itemtotext: MACRO
	db itemtotext_command
	db \1 ; item
	db \2 ; memory
	ENDM

	enum mapnametotext_command
mapnametotext: MACRO
	db mapnametotext_command
	db \1 ; memory
	ENDM

	enum trainertotext_command
trainertotext: MACRO
	db trainertotext_command
	db \1 ; trainer_id
	db \2 ; trainer_group
	db \3 ; memory
	ENDM

	enum stringtotext_command
stringtotext: MACRO
	db stringtotext_command
	dw \1 ; text_pointer
	db \2 ; memory
	ENDM

	enum itemnotify_command
itemnotify: MACRO
	db itemnotify_command
	ENDM

	enum pocketisfull_command
pocketisfull: MACRO
	db pocketisfull_command
	ENDM

	enum opentext_command
opentext: MACRO
	db opentext_command
	ENDM

	enum refreshscreen_command
refreshscreen: MACRO
	db refreshscreen_command
	ENDM

	enum closetext_command
closetext: MACRO
	db closetext_command
	ENDM

	enum farwritetext_command
farwritetext: MACRO
	db farwritetext_command
	dba \1
	ENDM

	enum writetext_command
writetext: MACRO
	db writetext_command
	dw \1 ; text_pointer
	ENDM

	enum repeattext_command
repeattext: MACRO
	db repeattext_command
	db \1 ; byte
	db \2 ; byte
	ENDM

	enum yesorno_command
yesorno: MACRO
	db yesorno_command
	ENDM

	enum loadmenu_command
loadmenu: MACRO
	db loadmenu_command
	dw \1 ; data
	ENDM

	enum closewindow_command
closewindow: MACRO
	db closewindow_command
	ENDM

	enum jumptextfaceplayer_command
jumptextfaceplayer: MACRO
	db jumptextfaceplayer_command
	dw \1 ; text_pointer
	ENDM

	enum farjumptext_command
farjumptext: MACRO
	db farjumptext_command
	dba \1
	ENDM

	enum jumptext_command
jumptext: MACRO
	db jumptext_command
	dw \1 ; text_pointer
	ENDM

	enum waitbutton_command
waitbutton: MACRO
	db waitbutton_command
	ENDM

	enum buttonsound_command
buttonsound: MACRO
	db buttonsound_command
	ENDM

	enum pokepic_command
pokepic: MACRO
	db pokepic_command
	db \1 ; pokemon
if \1 == 0
	db -1 ; party mon
elif _NARG == 2
	db \2 ; form
else
	db 0
endc
	ENDM

	enum closepokepic_command
closepokepic: MACRO
	db closepokepic_command
	ENDM

	enum _2dmenu_command
_2dmenu: MACRO
	db _2dmenu_command
	ENDM

	enum verticalmenu_command
verticalmenu: MACRO
	db verticalmenu_command
	ENDM

	enum randomwildmon_command
randomwildmon: MACRO
	db randomwildmon_command
	ENDM

	enum loadmemtrainer_command
loadmemtrainer: MACRO
	db loadmemtrainer_command
	ENDM

	enum loadwildmon_command
loadwildmon: MACRO
	db loadwildmon_command
	db \1 ; pokemon
if _NARG == 3
	db \2 ; form
	db \3 ; level
else
	db 0  ; form
	db \2 ; level
endc
	ENDM

	enum loadtrainer_command
loadtrainer: MACRO
	db loadtrainer_command
	db \1 ; trainer_group
	db \2 ; trainer_id
	ENDM

	enum startbattle_command
startbattle: MACRO
	db startbattle_command
	ENDM

	enum reloadmapafterbattle_command
reloadmapafterbattle: MACRO
	db reloadmapafterbattle_command
	ENDM

	enum catchtutorial_command
catchtutorial: MACRO
	db catchtutorial_command
	db \1 ; byte
	ENDM

	enum trainertext_command
trainertext: MACRO
	db trainertext_command
	db \1 ; which_text
	ENDM

	enum trainerflagaction_command
trainerflagaction: MACRO
	db trainerflagaction_command
	db \1 ; action
	ENDM

	enum winlosstext_command
winlosstext: MACRO
	db winlosstext_command
	dw \1 ; win_text_pointer
	dw \2 ; loss_text_pointer
	ENDM

	enum scripttalkafter_command
scripttalkafter: MACRO
	db scripttalkafter_command
	ENDM

	enum end_if_just_battled_command
end_if_just_battled: MACRO
	db end_if_just_battled_command
	ENDM

	enum check_just_battled_command
check_just_battled: MACRO
	db check_just_battled_command
	ENDM

	enum setlasttalked_command
setlasttalked: MACRO
	db setlasttalked_command
	db \1 ; person
	ENDM

	enum applymovement_command
applymovement: MACRO
	db applymovement_command
	db \1 ; person
	dw \2 ; data
	ENDM

	enum applymovement2_command
applymovement2: MACRO
	db applymovement2_command
	dw \1 ; data
	ENDM

	enum faceplayer_command
faceplayer: MACRO
	db faceplayer_command
	ENDM

	enum faceobject_command
faceobject: MACRO
	db faceobject_command
	db \1 ; person1
	db \2 ; person2
	ENDM

	enum variablesprite_command
variablesprite: MACRO
	db variablesprite_command
	db \1 - SPRITE_VARS ; byte
	db \2 ; sprite
	ENDM

	enum disappear_command
disappear: MACRO
	db disappear_command
	db \1 ; person
	ENDM

	enum appear_command
appear: MACRO
	db appear_command
	db \1 ; person
	ENDM

	enum follow_command
follow: MACRO
	db follow_command
	db \1 ; person2
	db \2 ; person1
	ENDM

	enum stopfollow_command
stopfollow: MACRO
	db stopfollow_command
	ENDM

	enum moveobject_command
moveobject: MACRO
	db moveobject_command
	db \1 ; person
	db \2 ; x
	db \3 ; y
	ENDM

	enum writepersonxy_command
writepersonxy: MACRO
	db writepersonxy_command
	db \1 ; person
	ENDM

	enum loademote_command
loademote: MACRO
	db loademote_command
	db \1 ; bubble
	ENDM

	enum showemote_command
showemote: MACRO
	db showemote_command
	db \1 ; bubble
	db \2 ; person
	db \3 ; time
	ENDM

	enum turnobject_command
turnobject: MACRO
	db turnobject_command
	db \1 ; person
	db \2 ; facing
	ENDM

	enum follownotexact_command
follownotexact: MACRO
	db follownotexact_command
	db \1 ; person2
	db \2 ; person1
	ENDM

	enum earthquake_command
earthquake: MACRO
	db earthquake_command
	db \1 ; param
	ENDM

	enum changemap_command
changemap: MACRO
	db changemap_command
	dba \1 ; map_data
	ENDM

	enum changeblock_command
changeblock: MACRO
	db changeblock_command
	db \1 ; x
	db \2 ; y
	db \3 ; block
	ENDM

	enum reloadmap_command
reloadmap: MACRO
	db reloadmap_command
	ENDM

	enum reloadmappart_command
reloadmappart: MACRO
	db reloadmappart_command
	ENDM

	enum usestonetable_command
usestonetable: MACRO
	db usestonetable_command
	dw \1 ; stonetable_pointer
	ENDM

	enum playmusic_command
playmusic: MACRO
	db playmusic_command
	db \1 ; music_id
	ENDM

	enum encountermusic_command
encountermusic: MACRO
	db encountermusic_command
	ENDM

	enum musicfadeout_command
musicfadeout: MACRO
	db musicfadeout_command
	db \1 ; music
	db \2 ; fadetime
	ENDM

	enum playmapmusic_command
playmapmusic: MACRO
	db playmapmusic_command
	ENDM

	enum dontrestartmapmusic_command
dontrestartmapmusic: MACRO
	db dontrestartmapmusic_command
	ENDM

	enum cry_command
cry: MACRO
	db cry_command
	db \1 ; cry_id
	ENDM

	enum playsound_command
playsound: MACRO
	db playsound_command
	db \1 ; sound_id
	ENDM

	enum waitsfx_command
waitsfx: MACRO
	db waitsfx_command
	ENDM

	enum warpsound_command
warpsound: MACRO
	db warpsound_command
	ENDM

	enum specialsound_command
specialsound: MACRO
	db specialsound_command
	ENDM

	enum passtoengine_command
passtoengine: MACRO
	db passtoengine_command
	db \1 ; data_pointer
	ENDM

	enum newloadmap_command
newloadmap: MACRO
	db newloadmap_command
	db \1 ; which_method
	ENDM

	enum pause_command
pause: MACRO
	db pause_command
	db \1 ; length
	ENDM

	enum deactivatefacing_command
deactivatefacing: MACRO
	db deactivatefacing_command
	db \1 ; time
	ENDM

	enum priorityjump_command
priorityjump: MACRO
	db priorityjump_command
	dw \1 ; pointer
	ENDM

	enum warpcheck_command
warpcheck: MACRO
	db warpcheck_command
	ENDM

	enum ptpriorityjump_command
ptpriorityjump: MACRO
	db ptpriorityjump_command
	dw \1 ; pointer
	ENDM

	enum return_command
return: MACRO
	db return_command
	ENDM

	enum end_command
end: MACRO
	db end_command
	ENDM

	enum reloadandreturn_command
reloadandreturn: MACRO
	db reloadandreturn_command
	db \1 ; which_method
	ENDM

	enum endall_command
endall: MACRO
	db endall_command
	ENDM

	enum pokemart_command
pokemart: MACRO
	db pokemart_command
	db \1 ; dialog_id
	db \2 ; mart_id
	ENDM

	enum elevator_command
elevator: MACRO
	db elevator_command
	dw \1 ; floor_list_pointer
	ENDM

	enum trade_command
trade: MACRO
	db trade_command
	db \1 ; trade_id
	ENDM

	enum askforphonenumber_command
askforphonenumber: MACRO
	db askforphonenumber_command
	db \1 ; number
	ENDM

	enum hangup_command
hangup: MACRO
	db hangup_command
	ENDM

	enum describedecoration_command
describedecoration: MACRO
	db describedecoration_command
	db \1 ; byte
	ENDM

	enum fruittree_command
fruittree: MACRO
	db fruittree_command
	db \1 ; tree_id
	db \2 ; fruit_id
	ENDM

	enum specialphonecall_command
specialphonecall: MACRO
	db specialphonecall_command
	db \1 ; call_id
	ENDM

	enum checkphonecall_command
checkphonecall: MACRO
	db checkphonecall_command
	ENDM

	enum verbosegiveitem_command
verbosegiveitem: MACRO
	db verbosegiveitem_command
	db \1 ; item
if _NARG == 2
	db \2 ; quantity
else
	db 1
endc
	ENDM

	enum verbosegiveitem2_command
verbosegiveitem2: MACRO
	db verbosegiveitem2_command
	db \1 ; item
	db \2 ; var
	ENDM

	enum swarm_command
swarm: MACRO
	db swarm_command
	db \1 ; flag
	map_id \2 ; map
	ENDM

	enum halloffame_command
halloffame: MACRO
	db halloffame_command
	ENDM

	enum credits_command
credits: MACRO
	db credits_command
	ENDM

	enum warpfacing_command
warpfacing: MACRO
	db warpfacing_command
	db \1 ; facing
	map_id \2 ; map
	db \3 ; x
	db \4 ; y
	ENDM

	enum battletowertext_command
battletowertext: MACRO
	db battletowertext_command
	db \1 ; memory
	ENDM

	enum landmarktotext_command
landmarktotext: MACRO
	db landmarktotext_command
	db \1 ; id
	db \2 ; memory
	ENDM

	enum trainerclassname_command
trainerclassname: MACRO
	db trainerclassname_command
	db \1 ; id
	db \2 ; memory
	ENDM

	enum name_command
name: MACRO
	db name_command
	db \1 ; type
	db \2 ; id
	db \3 ; memory
	ENDM

	enum wait_command
wait: MACRO
	db wait_command
	db \1 ; duration
	ENDM

	enum check_save_command
check_save: MACRO
	db check_save_command
	ENDM

	enum count_seen_caught_command
count_seen_caught: MACRO
	db count_seen_caught_command
	ENDM

	enum trainerpic_command
trainerpic: MACRO
	db trainerpic_command
	db \1 ; trainer
	ENDM

	enum givetmhm_command
givetmhm: MACRO
	db givetmhm_command
	db \1 ; tmhm
	ENDM

	enum checktmhm_command
checktmhm: MACRO
	db checktmhm_command
	db \1 ; tmhm
	ENDM

	enum verbosegivetmhm_command
verbosegivetmhm: MACRO
	db verbosegivetmhm_command
	db \1 ; tmhm
	ENDM

	enum tmhmnotify_command
tmhmnotify: MACRO
	db tmhmnotify_command
	ENDM

	enum tmhmtotext_command
tmhmtotext: MACRO
	db tmhmtotext_command
	db \1 ; tmhm
	db \2 ; memory
	ENDM

	enum checkdarkness_command
checkdarkness: MACRO
	db checkdarkness_command
	ENDM

	enum checkunits_command
checkunits: MACRO
	db checkunits_command
	ENDM

	enum unowntypeface_command
unowntypeface: MACRO
	db unowntypeface_command
	ENDM

	enum restoretypeface_command
restoretypeface: MACRO
	db restoretypeface_command
	ENDM

	enum jumpstashedtext_command
jumpstashedtext: MACRO
	db jumpstashedtext_command
	ENDM

	enum jumpopenedtext_command
jumpopenedtext: MACRO
	db jumpopenedtext_command
	dw \1 ; text_pointer
	ENDM

	enum iftrue_jumptext_command
iftrue_jumptext: MACRO
	db iftrue_jumptext_command
	dw \1 ; text_pointer
	ENDM

	enum iffalse_jumptext_command
iffalse_jumptext: MACRO
	db iffalse_jumptext_command
	dw \1 ; text_pointer
	ENDM

	enum iftrue_jumptextfaceplayer_command
iftrue_jumptextfaceplayer: MACRO
	db iftrue_jumptextfaceplayer_command
	dw \1 ; text_pointer
	ENDM

	enum iffalse_jumptextfaceplayer_command
iffalse_jumptextfaceplayer: MACRO
	db iffalse_jumptextfaceplayer_command
	dw \1 ; text_pointer
	ENDM

	enum iftrue_jumpopenedtext_command
iftrue_jumpopenedtext: MACRO
	db iftrue_jumpopenedtext_command
	dw \1 ; text_pointer
	ENDM

	enum iffalse_jumpopenedtext_command
iffalse_jumpopenedtext: MACRO
	db iffalse_jumpopenedtext_command
	dw \1 ; text_pointer
	ENDM

	enum writethistext_command
writethistext: MACRO
	db writethistext_command
ENDM

	enum jumpthistext_command
jumpthistext: MACRO
	db jumpthistext_command
	ENDM

	enum jumpthistextfaceplayer_command
jumpthistextfaceplayer: MACRO
	db jumpthistextfaceplayer_command
	ENDM

	enum jumpthisopenedtext_command
jumpthisopenedtext: MACRO
	db jumpthisopenedtext_command
	ENDM

	enum showtext_command
showtext: MACRO
	db showtext_command
	dw \1 ; text_pointer
	ENDM

	enum showtextfaceplayer_command
showtextfaceplayer: MACRO
	db showtextfaceplayer_command
	dw \1 ; text_pointer
	ENDM

	enum applyonemovement_command
applyonemovement: MACRO
	db applyonemovement_command
	db \1 ; person
	db movement_\2 ; movement data
	db movement_step_end
	ENDM

	enum showcrytext_command
showcrytext: MACRO
	db showcrytext_command
	dw \1 ; text_pointer
	db \2 ; cry_id
	ENDM

	enum endtext_command
endtext: MACRO
	db endtext_command
	ENDM

	enum waitendtext_command
waitendtext: MACRO
	db waitendtext_command
	ENDM

	enum iftrue_endtext_command
iftrue_endtext: MACRO
	db iftrue_endtext_command
	ENDM

	enum iffalse_endtext_command
iffalse_endtext: MACRO
	db iffalse_endtext_command
	ENDM

	enum loadgrottomon_command
loadgrottomon: MACRO
	db loadgrottomon_command
	ENDM

	enum giveapricorn_command
giveapricorn: MACRO
	db giveapricorn_command
	db \1 ; apricorn
if _NARG == 2
	db \2 ; quantity
else
	db 1
endc
	ENDM

	enum paintingpic_command
paintingpic: MACRO
	db paintingpic_command
	db \1 ; painting
	ENDM

	enum checkegg_command
checkegg: MACRO
	db checkegg_command
	ENDM

callthisasm: MACRO
	; "callasm .asm\@" causes a "File stack dump too long, got truncated"
	; error due to the long filename:linenumber trace of nested macros.
	db callasm_command
	dba .asm\@
	end
.asm\@
ENDM

	enum givekeyitem_command
givekeyitem: MACRO
	db givekeyitem_command
	db \1 ; key item
ENDM

	enum checkkeyitem_command
checkkeyitem: MACRO
	db checkkeyitem_command
	db \1 ; key item
ENDM

	enum takekeyitem_command
takekeyitem: MACRO
	db takekeyitem_command
	db \1 ; key item
ENDM

	enum verbosegivekeyitem_command
verbosegivekeyitem: MACRO
	db verbosegivekeyitem_command
	db \1 ; key item
ENDM

	enum keyitemnotify_command
keyitemnotify: MACRO
	db keyitemnotify_command
ENDM

	enum givebp_command
givebp: MACRO
	db givebp_command
	dw \1 ; bp
	ENDM

	enum takebp_command
takebp: MACRO
	db takebp_command
	dw \1 ; bp
	ENDM

	enum checkbp_command
checkbp: MACRO
	db checkbp_command
	dw \1 ; bp
	ENDM
