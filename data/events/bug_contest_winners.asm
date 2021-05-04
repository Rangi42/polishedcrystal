BugContestantPointers:
	table_width 2, BugContestantPointers
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

BugContestant_BugCatcherDon:
	db BUG_CATCHER, DON
	dpw KAKUNA,     300
	dpw METAPOD,    285
	dpw CATERPIE,   226

BugContestant_BugCatcherEd:
	db BUG_CATCHER, ED
	dpw YANMA,      286
	dpw BUTTERFREE, 251
	dpw CATERPIE,   237

BugContestant_CooltrainerMNick:
	db COOLTRAINERM, NICK
	dpw SCYTHER,    357
	dpw BUTTERFREE, 349
	dpw PINSIR,     368

BugContestant_PokefanMWilliam:
	db POKEFANM, WILLIAM
	dpw VENOMOTH,   332
	dpw BUTTERFREE, 324
	dpw VENONAT,    321

BugContestant_BugCatcherBenny:
	db BUG_CATCHER, BENNY
	dpw BUTTERFREE, 318
	dpw WEEDLE,     295
	dpw CATERPIE,   285

BugContestant_CamperBarry:
	db CAMPER, BARRY
	dpw PINSIR,     366
	dpw VENONAT,    329
	dpw KAKUNA,     314

BugContestant_PicnickerCindy:
	db PICNICKER, CINDY
	dpw BUTTERFREE, 341
	dpw METAPOD,    301
	dpw CATERPIE,   264

BugContestant_BugCatcherJosh:
	db BUG_CATCHER, JOSH
	dpw SCYTHER,    326
	dpw BUTTERFREE, 292
	dpw METAPOD,    282

BugContestant_SchoolboyJohnny:
	db SCHOOLBOY, JOHNNY
	dpw WEEDLE,     270
	dpw PINSIR,     282
	dpw CATERPIE,   251

BugContestant_SchoolboyKipp:
	db SCHOOLBOY, KIPP
	dpw VENONAT,    267
	dpw PARAS,      254
	dpw KAKUNA,     259
