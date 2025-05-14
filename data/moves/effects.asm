INCLUDE "data/moves/effects_pointers.asm"

MoveEffects: ; used only for BANK(MoveEffects)

NormalHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

SuckerPunch:
	checkobedience
	usedmovetext
	doturn
	hastarget
	suckerpunch
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

LeechHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	draintarget
	postfainteffects
	posthiteffects
	endmove

SwitchHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	switchout
	endmove

MultiHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	startloop
	lowersub
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	clearmissdamage
	moveanimnosub
	failuretext
	applydamage
	criticaltext
	cleartext
	postfainteffects
	posthiteffects
	supereffectivetext
	endloop
	raisesub
	endmove

RecoilHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	recoil
	postfainteffects
	posthiteffects
	endmove

FlinchHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	flinchtarget
	posthiteffects
	endmove

PoisonHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	poisontarget
	posthiteffects
	endmove

BurnHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	burntarget
	posthiteffects
	endmove

ParalyzeHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	paralyzetarget
	posthiteffects
	endmove

BodySlam:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	doubleminimizedamage
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	paralyzetarget
	posthiteffects
	endmove

SleepHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	sleep
	posthiteffects
	endmove

FreezeHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	freezetarget
	posthiteffects
	endmove

ConfuseHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	confusetarget
	posthiteffects
	endmove

AttackUpHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	selfeffectchance
	raisestathit ATTACK
	posthiteffects
	endmove

DefenseUpHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	selfeffectchance
	raisestathit DEFENSE
	posthiteffects
	endmove

SpeedUpHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	selfeffectchance
	raisestathit SPEED
	posthiteffects
	endmove

AllUpHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	; A single effect chance triggers all stats
	selfeffectchance
	raisestathit ATTACK
	raisestathit DEFENSE
	raisestathit SPEED
	raisestathit SP_ATTACK
	raisestathit SP_DEFENSE
	posthiteffects
	endmove

AttackDownHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	loweroppstathit ATTACK
	posthiteffects
	endmove

DefenseDownHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	loweroppstathit DEFENSE
	posthiteffects
	endmove

BrickBreak:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	resettypematchup
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	brickbreak
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

SpeedDownHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	loweroppstathit SPEED
	posthiteffects
	endmove

SpecialAttackDownHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	loweroppstathit SP_ATTACK
	posthiteffects
	endmove

SpecialDefenseDownHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	loweroppstathit SP_DEFENSE
	posthiteffects
	endmove

AccuracyDownHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	loweroppstathit ACCURACY
	posthiteffects
	endmove

EvasionDownHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	loweroppstathit EVASION
	posthiteffects
	endmove

CloseCombat:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	lowerstat DEFENSE
	lowerstat SP_DEFENSE
	posthiteffects
	endmove

StaticDamage:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	constantdamage
	resettypematchup
	moveanim
	failuretext
	applydamage
	postfainteffects
	posthiteffects
	endmove

DoPoison:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpowder
	checkpriority
	bounceback
	checksafeguard
	poison
	endmove

Toxic:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpowder
	checkpriority
	bounceback
	checksafeguard
	toxic
	endmove

DoBurn:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	resettypematchup
	bounceback
	stab
	checksafeguard
	burn
	endmove

DoParalyze:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpowder
	checkpriority
	bounceback
	checksafeguard
	paralyze
	endmove

DoSleep:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpowder
	checkpriority
	bounceback
	checksafeguard
	sleep
	endmove

DoFreeze:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	checksafeguard
	freezetarget
	endmove

DoConfuse:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	checksafeguard
	confuse
	endmove

AttackUp:
	checkobedience
	usedmovetext
	doturn
	forceraisestat ATTACK
	endmove

DefenseUp:
	checkobedience
	usedmovetext
	doturn
	forceraisestat DEFENSE
	endmove

SpeedUp:
	checkobedience
	usedmovetext
	doturn
	forceraisestat SPEED
	endmove

SpecialAttackUp:
	checkobedience
	usedmovetext
	doturn
	forceraisestat SP_ATTACK
	endmove

SpecialDefenseUp:
	checkobedience
	usedmovetext
	doturn
	forceraisestat SP_DEFENSE
	endmove

AccuracyUp:
	checkobedience
	usedmovetext
	doturn
	forceraisestat ACCURACY
	endmove

EvasionUp:
	checkobedience
	usedmovetext
	doturn
	forceraisestat EVASION
	endmove

FocusEnergy:
	checkobedience
	usedmovetext
	doturn
	focusenergy
	endmove

AttackUp2:
	checkobedience
	usedmovetext
	doturn
	forceraisestat $10 | ATTACK
	endmove

DefenseUp2:
	checkobedience
	usedmovetext
	doturn
	forceraisestat $10 | DEFENSE
	endmove

SpeedUp2:
	checkobedience
	usedmovetext
	doturn
	forceraisestat $10 | SPEED
	endmove

SpecialAttackUp2:
	checkobedience
	usedmovetext
	doturn
	forceraisestat $10 | SP_ATTACK
	endmove

SpecialDefenseUp2:
	checkobedience
	usedmovetext
	doturn
	forceraisestat $10 | SP_DEFENSE
	endmove

AccuracyUp2:
	checkobedience
	usedmovetext
	doturn
	forceraisestat $10 | ACCURACY
	endmove

EvasionUp2:
	checkobedience
	usedmovetext
	doturn
	forceraisestat $10 | EVASION
	endmove

BulkUp:
	checkobedience
	usedmovetext
	doturn
	forceraisestat ATTACK
	forceraisestat DEFENSE
	endmove

CalmMind:
	checkobedience
	usedmovetext
	doturn
	forceraisestat SP_ATTACK
	forceraisestat SP_DEFENSE
	endmove

Growth:
	checkobedience
	usedmovetext
	doturn
	growth
	endmove

DragonDance:
	checkobedience
	usedmovetext
	doturn
	forceraisestat ATTACK
	forceraisestat SPEED
	endmove

HoneClaws:
	checkobedience
	usedmovetext
	doturn
	forceraisestat ATTACK
	forceraisestat ACCURACY
	endmove

DefenseCurl:
	checkobedience
	usedmovetext
	doturn
	forceraisestat DEFENSE
	curl
	endmove

Minimize:
	checkobedience
	usedmovetext
	doturn
	forceraisestat $10 | EVASION
	minimize
	endmove

ShellSmash:
	checkobedience
	usedmovetext
	doturn
	forcelowerstat DEFENSE
	forcelowerstat SP_DEFENSE
	forceraisestat $10 | ATTACK
	forceraisestat $10 | SP_ATTACK
	forceraisestat $10 | SPEED
	endmove

AttackDown:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat ATTACK
	endmove

DefenseDown:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat DEFENSE
	endmove

SpeedDown:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat SPEED
	endmove

SpecialAttackDown:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat SP_ATTACK
	endmove

SpecialDefenseDown:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat SP_DEFENSE
	endmove

AccuracyDown:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat ACCURACY
	endmove

EvasionDown:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat EVASION
	endmove

AttackDown2:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat $10 | ATTACK
	endmove

DefenseDown2:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat $10 | DEFENSE
	endmove

SpeedDown2:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat $10 | SPEED
	endmove

SpecialAttackDown2:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat $10 | SP_ATTACK
	endmove

SpecialDefenseDown2:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat $10 | SP_DEFENSE
	endmove

AccuracyDown2:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat $10 | ACCURACY
	endmove

EvasionDown2:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	loweroppstat $10 | EVASION
	endmove

ResetStats:
	checkobedience
	usedmovetext
	doturn
	resetstats
	endmove

Safeguard:
	checkobedience
	usedmovetext
	doturn
	safeguard
	endmove

Screen:
	checkobedience
	usedmovetext
	doturn
	screen
	endmove

TrickRoom:
	checkobedience
	usedmovetext
	doturn
	trickroom
	endmove

Heal:
	checkobedience
	usedmovetext
	doturn
	heal
	endmove

Roost:
	checkobedience
	usedmovetext
	doturn
	roost
	heal
	endmove

Rampage:
	checkobedience
	usedmovetext
	doturn
	hastarget
	rampage
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	clearmissdamage
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

Trap:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	clearmissdamage
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	traptarget
	posthiteffects
	endmove

Explosion:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	selfdestruct
	moveanimnosub
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

DreamEater:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	eatdream
	postfainteffects
	posthiteffects
	endmove

Roar:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	roar
	endmove

SkillSwap:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkpriority
	skillswap
	endmove

Trick:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	trick
	endmove

Conversion:
	checkobedience
	usedmovetext
	doturn
	conversion
	endmove

PayDay:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	payday
	postfainteffects
	posthiteffects
	endmove

KnockOff:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	conditionalboost
	moveanim
	failuretext
	knockoff FALSE
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	; Must come after posthiteffects in case of indirect faint
	knockoff TRUE
	endmove

BugBite:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	bugbite FALSE
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	; Must come after posthiteffects in case of indirect faint
	bugbite TRUE
	endmove

TriAttack:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	tristatuschance
	posthiteffects
	endmove

Transform:
	checkobedience
	usedmovetext
	doturn
	hastarget
	transform
	endmove

Substitute:
	checkobedience
	usedmovetext
	doturn
	substitute
	endmove

HyperBeam:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	rechargenextturn
	postfainteffects
	posthiteffects
	endmove

Rage:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	rage
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

Metronome:
	checkobedience
	usedmovetext
	doturn
	metronome
	endmove

LeechSeed:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	leechseed
	endmove

Splash:
	checkobedience
	usedmovetext
	doturn
	splash
	endmove

Disable:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	failuretext
	disable
	endmove

Counter:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit ; needed for Parental Bond, it can't miss
	counter
	moveanim
	failuretext
	applydamage
	postfainteffects
	posthiteffects
	endmove

Encore:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	failuretext
	encore
	endmove

PainSplit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	painsplit
	endmove

Sketch:
	checkobedience
	usedmovetext
	doturn
	hastarget
	sketch
	endmove

SleepTalk:
	checkobedience
	usedmovetext
	doturn
	sleeptalk
	endmove

DestinyBond:
	checkobedience
	usedmovetext
	doturn
	checkpriority
	destinybond
	endmove

Reversal:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	constantdamage
	stab
	moveanim
	failuretext
	applydamage
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

FalseSwipe:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	falseswipe
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

HealBell:
	checkobedience
	usedmovetext
	doturn
	healbell
	endmove

Thief:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	; Must come after posthiteffects in case of indirect faint
	thief
	endmove

MeanLook:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkpriority
	bounceback
	arenatrap
	endmove

Curse:
	checkobedience
	usedmovetext
	doturn
	curse
	endmove

Protect:
	checkobedience
	usedmovetext
	doturn
	protect
	endmove

Spikes:
	checkobedience
	usedmovetext
	doturn
	hastarget
	bounceback
	spikes
	endmove

ToxicSpikes:
	checkobedience
	usedmovetext
	doturn
	hastarget
	bounceback
	toxicspikes
	endmove

Foresight:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	foresight
	endmove

PerishSong:
	checkobedience
	usedmovetext
	doturn
	perishsong
	endmove

Sandstorm:
	checkobedience
	usedmovetext
	doturn
	startsandstorm
	endmove

Hail:
	checkobedience
	usedmovetext
	doturn
	starthail
	endmove

Endure:
	checkobedience
	usedmovetext
	doturn
	endure
	endmove

Rollout:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	rolloutpower
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

Swagger:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	raiseoppstat $10 | ATTACK
	confusetarget
	endmove

ConditionalBoostHit:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	conditionalboost
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

Attract:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	bounceback
	attract
	endmove

Return:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	happinesspower
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

SacredFire:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	burntarget
	posthiteffects
	endmove

Magnitude:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	getmagnitude
	damagecalc
	stab
	damagevariation
	doubleundergrounddamage
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

GyroBall:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	gyroball
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

LowKick:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	lowkick
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

BatonPass:
	checkobedience
	usedmovetext
	doturn
	batonpass
	endmove

Pursuit:
	checkobedience
	pursuit
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	conditionalboost
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

RapidSpin:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	clearhazards
	postfainteffects
	selfeffectchance
	raisestathit SPEED
	posthiteffects
	endmove

HealingLight:
	checkobedience
	usedmovetext
	doturn
	healweather
	endmove

HiddenPower:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	hiddenpower
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

RainDance:
	checkobedience
	usedmovetext
	doturn
	startrain
	endmove

SunnyDay:
	checkobedience
	usedmovetext
	doturn
	startsun
	endmove

BellyDrum:
	checkobedience
	usedmovetext
	doturn
	bellydrum
	endmove

Earthquake:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	doubleundergrounddamage
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

FutureSight:
	checkfuturesight
	checkobedience
	usedmovetext
	doturn
	hastarget
	futuresight
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanimnosub
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

Gust:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	doubleflyingdamage
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

Stomp:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	doubleminimizedamage
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	flinchtarget
	posthiteffects
	endmove

SolarBeam:
	checkobedience
	usedmovetext
	doturn
	hastarget
	charge
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

Thunder:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	thunderaccuracy
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	effectchance
	paralyzetarget
	posthiteffects
	endmove

Teleport:
	checkobedience
	usedmovetext
	doturn
	teleport
	endmove

Fly:
Dig:
	checkobedience
	usedmovetext
	doturn
	hastarget
	charge
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanimnosub
	raisesub
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	postfainteffects
	posthiteffects
	endmove

FlareBlitz:
	checkobedience
	usedmovetext
	doturn
	hastarget
	checkhit
	checkpriority
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	recoil
	postfainteffects
	effectchance
	burntarget
	posthiteffects
	endmove
