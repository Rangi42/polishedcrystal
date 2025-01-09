BugContestantPointers:
	table_width 2
	dw BugContestant_BugCatcherDon ; This reverts back to the player
	dw BugContestant_BugCatcherDon
	dw BugContestant_BugCatcherEd
	dw BugContestant_CooltrainerMNick
	dw BugContestant_PokefanMWilliam
	dw BugContestant_BugCatcherBenny
	dw BugContestant_CamperBarry
	dw BugContestant_PicnickerCindy
	dw BugContestant_BugCatcherJosh
	dw BugContestant_SchoolboyJohnny
	dw BugContestant_SchoolboyKipp
	assert_table_length NUM_BUG_CONTESTANTS + 1

MACRO contest_winner
; species, score
	dp \1
	dw \2
ENDM

BugContestant_BugCatcherDon:
	db BUG_CATCHER, DON
	contest_winner KAKUNA,     300
	contest_winner METAPOD,    285
	contest_winner CATERPIE,   226

BugContestant_BugCatcherEd:
	db BUG_CATCHER, ED
	contest_winner YANMA,      286
	contest_winner BUTTERFREE, 251
	contest_winner CATERPIE,   237

BugContestant_CooltrainerMNick:
	db COOLTRAINERM, NICK
	contest_winner SCYTHER,    357
	contest_winner BUTTERFREE, 349
	contest_winner PINSIR,     368

BugContestant_PokefanMWilliam:
	db POKEFANM, WILLIAM
	contest_winner VENOMOTH,   332
	contest_winner BUTTERFREE, 324
	contest_winner VENONAT,    321

BugContestant_BugCatcherBenny:
	db BUG_CATCHER, BENNY
	contest_winner BUTTERFREE, 318
	contest_winner WEEDLE,     295
	contest_winner CATERPIE,   285

BugContestant_CamperBarry:
	db CAMPER, BARRY
	contest_winner PINSIR,     366
	contest_winner VENONAT,    329
	contest_winner KAKUNA,     314

BugContestant_PicnickerCindy:
	db PICNICKER, CINDY
	contest_winner BUTTERFREE, 341
	contest_winner METAPOD,    301
	contest_winner CATERPIE,   264

BugContestant_BugCatcherJosh:
	db BUG_CATCHER, JOSH
	contest_winner SCYTHER,    326
	contest_winner BUTTERFREE, 292
	contest_winner METAPOD,    282

BugContestant_SchoolboyJohnny:
	db SCHOOLBOY, JOHNNY
	contest_winner WEEDLE,     270
	contest_winner PINSIR,     282
	contest_winner CATERPIE,   251

BugContestant_SchoolboyKipp:
	db SCHOOLBOY, KIPP
	contest_winner VENONAT,    267
	contest_winner PARAS,      254
	contest_winner KAKUNA,     259
