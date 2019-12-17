command: macro
	enum \1_command
\1 equs "db \1_command"
	dw BattleCommand_\1
endm

commandonly: macro
	enum \1_command
\1 equs "db \1_command"
endm

	enum_start 1

BattleCommandPointers:
	command checkturn
	command checkobedience
	command usedmovetext
	command doturn
	command critical
	command damagestats
	command stab
	command damagevariation
	command checkhit
	command lowersub
	command hittargetnosub
	command raisesub
	command failuretext
	command checkfaint
	command criticaltext
	command supereffectivetext
	command postfainteffects
	command posthiteffects
	command poisontarget
	command sleeptarget
	command draintarget
	command eatdream
	command burntarget
	command freezetarget
	command paralyzetarget
	command selfdestruct
	command statup
	command statdown
	command payday
	command conversion
	command resetstats
	command forceswitch
	command endloop
	command flinchtarget
	command recoil
	command focusenergy
	command confuse
	command confusetarget
	command heal
	command transform
	command screen
	command poison
	command paralyze
	command substitute
	command rechargenextturn
	command metronome
	command leechseed
	command splash
	command disable
	command cleartext
	command charge
	command checkcharge
	command traptarget
	command growth
	command rampage
	command checkrampage
	command constantdamage
	command counter
	command encore
	command painsplit
	command sketch
	command sleeptalk
	command destinybond
	command falseswipe
	command healbell
	command hastarget
	command triplekick
	command kickcounter
	command thief
	command arenatrap
	command defrost
	command curse
	command protect
	command spikes
	command foresight
	command perishsong
	command startsandstorm
	command starthail
	command endure
	command checkcurl
	command rolloutpower
	command bulkup
	command conditionalboost
	command attract
	command happinesspower
	command damagecalc
	command safeguard
	command checksafeguard
	command getmagnitude
	command batonpass
	command pursuit
	command clearhazards
	command healweather
	command hiddenpower
	command startrain
	command startsun
	command attackup
	command defenseup
	command speedup
	command specialattackup
	command specialdefenseup
	command accuracyup
	command evasionup
	command attackup2
	command defenseup2
	command speedup2
	command specialattackup2
	command specialdefenseup2
	command accuracyup2
	command evasionup2
	command attackdown
	command defensedown
	command speeddown
	command specialattackdown
	command specialdefensedown
	command accuracydown
	command evasiondown
	command attackdown2
	command defensedown2
	command speeddown2
	command specialattackdown2
	command specialdefensedown2
	command accuracydown2
	command evasiondown2
	command statupmessage
	command statdownmessage
	command statupfailtext
	command statdownfailtext
	command effectchance
	command statdownanim
	command statupanim
	command switchturn
	command bellydrum
	command rage
	command doubleflyingdamage
	command doubleundergrounddamage
	command mirrorcoat
	command checkfuturesight
	command futuresight
	command doubleminimizedamage
	command skipsuncharge
	command thunderaccuracy
	command teleport
	command switchout
	command ragedamage
	command resettypematchup
	command allstatsup
	command calmmind
	command raisesubnoanim
	command lowersubnoanim
	command dragondance
	command honeclaws
	command clearmissdamage
	command movedelay
	command hittarget
	command tristatuschance
	command supereffectivelooptext
	command startloop
	command curl
	command burn
	command bounceback
	command pickpocket
	command suckerpunch
	command toxicspikes
	command roost
	command skillswap
	command trick
	command knockoff
	command bugbite
	command toxic
	command gyroball
	command checkpowder
	command lowkick
	command brickbreak
	command trickroom

	; The following commands have an argument: stat to raise/lower.
	; (raise|lower)stat: can miss, silent
	; force(raise|lower)stat: (always)
	; (raise|lower)stathit: can miss, respects secondary, silent
	; (raise|lower)oppstat: can miss, respects sub+mist+clear body
	; force(raise|lower)oppstat: respects sub+mist+clear body
	; (raise|lower)oppstathit: can miss, respects secondary+sub+mist+clear body, silent

	enum raisestat_command
raisestat: macro
	db raisestat_command
	db \1
	endm
	dw BattleCommand_raisestat

	enum lowerstat_command
lowerstat: macro
	db lowerstat_command
	db \1
	endm
	dw BattleCommand_lowerstat

	enum raisestat_command
forceraisestat: macro
	db forceraisestat_command
	db \1
	endm
	dw BattleCommand_forceraisestat

	enum forcelowerstat_command
forcelowerstat: macro
	db forcelowerstat_command
	db \1
	endm
	dw BattleCommand_forcelowerstat

	enum raisestat_command
raisestathit: macro
	db raisestathit_command
	db \1
	endm
	dw BattleCommand_raisestathit

	enum lowerstathit_command
lowerstathit: macro
	db lowerstathit_command
	db \1
	endm
	dw BattleCommand_lowerstathit

	enum forceraiseoppstat_command
forceraiseoppstat: macro
	db forceraiseoppstat_command
	db \1
	endm
	dw BattleCommand_forceraiseoppstat

	enum forceloweroppstat_command
forceloweroppstat: macro
	db forceloweroppstat_command
	db \1
	endm
	dw BattleCommand_forceloweroppstat

	enum raiseoppstat_command
raiseoppstat: macro
	db raiseoppstat_command
	db \1
	endm
	dw BattleCommand_raiseoppstat

	enum loweroppstat_command
loweroppstat: macro
	db loweroppstat_command
	db \1
	endm
	dw BattleCommand_loweroppstat

	enum raiseoppstat_command
raiseoppstathit: macro
	db raiseoppstathit_command
	db \1
	endm
	dw BattleCommand_raiseoppstathit

	enum loweroppstathit_command
loweroppstathit: macro
	db loweroppstathit_command
	db \1
	endm
	dw BattleCommand_loweroppstathit

FIRST_MOVEARG_COMMAND EQU raisestat_command
LAST_MOVEARG_COMMAND EQU loweroppstathit_command

	enum_start -1, -1
	commandonly endmove
	commandonly endturn
