MACRO song_info
	li \1
	db \2, \3, \4
ENDM

SongInfo:
	list_start SongInfo
	; title, origin, composer, additional credits
	song_info "Opening", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Title Screen", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Main Menu", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "New Bark Town", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, COMPOSER_NONE
	song_info "Mom", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Elm's Lab", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Lyra Appears", ORIGIN_HGSS, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Vs.Rival", ORIGIN_XY, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Lyra Departs", ORIGIN_HGSS, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Route 29", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Johto Wild", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Johto Wild Night", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Victory! Wild", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Cherrygrove City", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Follow Me!", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "#mon Center", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Heal #mon", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Captured #mon", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Spotted! Youngster", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Vs.Johto Trainer", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Victory! Trainer", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Route 30", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Violet City", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Sprout Tower", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Spotted! Sage", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Poké Mart", ORIGIN_HGSS, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	song_info "Hidden Grotto", ORIGIN_B2W2, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Union Cave", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Ruins of Alph", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Unown Radio", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Azalea Town", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Spotted! Team Rocket", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Vs.Team Rocket", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Route 34", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Rival Appears", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Rival", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Rival Departs", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Evolution", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Goldenrod City", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "PokéCom Center", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Gym", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Johto Gym Leader", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Final #mon", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Victory! Gym Leader", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "#mon Channel", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Buena's Password", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	song_info "Game Corner", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Cycling Johto", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Spotted! Lass", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "National Park", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Bug-Catching Contest", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Bug-Catching ContestRanking", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Ecruteak City", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Dance Theater", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Spotted! Kimono Girl", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Burned Tower", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Eusine Appears", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	song_info "Prof.Oak's #mon   Talk", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Route 38", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "#mon March", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Olivine Lighthouse", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Surfing Johto", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Cianwood City", ORIGIN_HGSS, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Route 47", ORIGIN_HGSS, COMPOSER_HITOMI_SATO, COMPOSER_MMMMMM
	song_info "Jessie & James      Appear", ORIGIN_Y, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Safari Zone Gate", ORIGIN_HGSS, COMPOSER_HITOMI_SATO, COMPOSER_MMMMMM
	song_info "Surfing Pikachu", ORIGIN_Y, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Route 42", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Stark Mountain", ORIGIN_DPPT, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	song_info "Rocket Radio", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Rocket Hideout", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Spotted! Pokémaniac", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Radio Tower Occu-   pied!", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Ice Path", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Dragon's Den", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Clair", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	song_info "Route 4", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	song_info "Bell Tower", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Suicune", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Route 26", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Indigo Plateau", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Victory Road", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Indigo Plateau", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Elite Four", ORIGIN_SM, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	song_info "Vs.Champion", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Hall of Fame", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "S.S.Aqua", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Surfing Kanto", ORIGIN_RB, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Vermilion City", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Kanto Gym Leader", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Lavender Town", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "#mon Tower", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Lavender Town", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, COMPOSER_NONE
	song_info "Vs.Kanto Wild", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Kanto Wild Night", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_TRITEHEXAGON
	song_info "Cerulean City", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	song_info "Cycling Kanto", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Route 24", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	song_info "Magnet Train", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Black City", ORIGIN_BW, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "#mon Lullaby", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Celadon City", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Game Corner", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	song_info "Canalave City", ORIGIN_DPPT, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	song_info "Cycling Kalos", ORIGIN_XY, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_SHANTYTOWN
	song_info "Route 11", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Poké Flute", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Route 209", ORIGIN_DPPT, COMPOSER_HITOMI_SATO, COMPOSER_FROGGESTSPIRIT
	song_info "Route 210", ORIGIN_DPPT, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	song_info "Route 225", ORIGIN_DPPT, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	song_info "Vs.Wild #mon", ORIGIN_GO, COMPOSER_JUNICHI_MASUDA, COMPOSER_SHOCKSLAYER
	song_info "Diglett's Cave", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Viridian Forest", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, COMPOSER_NONE
	song_info "Spotted! Hiker", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Pewter City", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Route 3", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Spotted! Officer", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Mt.Moon", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Mt.Moon Square", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Route 1", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Pallet Town", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Prof.Oak Appears", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Spotted! Beauty", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Vs.Kanto Trainer", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Cinnabar Island", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	song_info "Cinnabar Mansion", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Trainer", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	song_info "Scary House", ORIGIN_XY, COMPOSER_MINAKO_ADACHI, COMPOSER_MMMMMM
	song_info "Eterna Forest", ORIGIN_DPPT, COMPOSER_HITOMI_SATO, COMPOSER_FROGGESTSPIRIT
	song_info "Mt.Chimney", ORIGIN_RSE, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Mt.Pyre", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	song_info "Battle Tower", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	song_info "Battle Tower Lobby", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	song_info "Battle Factory", ORIGIN_RSE, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Vs.Trainer", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	song_info "Vs.Frontier Brain", ORIGIN_RSE, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	song_info "Zinnia Appears", ORIGIN_ORAS, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Route 205", ORIGIN_DPPT, COMPOSER_HITOMI_SATO, COMPOSER_FROGGESTSPIRIT
	song_info "Surfing Hoenn", ORIGIN_RSE, COMPOSER_MORIKAZU_AOKI, COMPOSER_MONSTARULES
	song_info "Cycling Hoenn", ORIGIN_RSE, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Vs.Wild", ORIGIN_SM, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	song_info "Sunyshore City", ORIGIN_DPPT, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	song_info "Vs.Trainer", ORIGIN_SM, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	song_info "Route 203", ORIGIN_DPPT, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	song_info "White Treehollow", ORIGIN_B2W2, COMPOSER_HITOMI_SATO, COMPOSER_MMMMMM
	song_info "Laverre City", ORIGIN_XY, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Route 101", ORIGIN_RSE, COMPOSER_MORIKAZU_AOKI, COMPOSER_MMMMMM
	song_info "Ever Grande City", ORIGIN_RSE, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Oreburgh Gate", ORIGIN_DPPT, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Route 12", ORIGIN_BW, COMPOSER_HITOMI_SATO, COMPOSER_MMMMMM
	song_info "Road to Reversal    Mountain", ORIGIN_B2W2, COMPOSER_HITOMI_SATO, COMPOSER_MMMMMM
	song_info "Vs.Zinnia", ORIGIN_ORAS, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Wally Appears", ORIGIN_ORAS, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Vs.Wally", ORIGIN_ORAS, COMPOSER_MINAKO_ADACHI, COMPOSER_MMMMMM
	song_info "Spiky-Eared Pichu", ORIGIN_HGSS, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Vs.Mother Beast", ORIGIN_SM, COMPOSER_MINAKO_ADACHI, COMPOSER_MMMMMM
	song_info "Frost Cavern", ORIGIN_XY, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Power Plant", ORIGIN_XY, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_SHANTYTOWN
	song_info "Reversal Mountain", ORIGIN_B2W2, COMPOSER_HITOMI_SATO, COMPOSER_MMMMMM
	song_info "Meteor Falls", ORIGIN_RSE, COMPOSER_MORIKAZU_AOKI, COMPOSER_MMMMMM
	song_info "Lugia's Song", ORIGIN_M02, COMPOSER_JOHN_LISSAUER_RALPH_SCHUCKETT, COMPOSER_MMMMMM
	song_info "Vs.Lugia", ORIGIN_HGSS, COMPOSER_GO_ICHINOSE, COMPOSER_PIGU
	song_info "Summoning Dance", ORIGIN_HGSS, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Vs.Ho-Oh", ORIGIN_HGSS, COMPOSER_GO_ICHINOSE, COMPOSER_PIGU
	song_info "Cerulean Cave", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Mewtwo", ORIGIN_STADIUM, COMPOSER_JUNICHI_MASUDA, COMPOSER_SHOCKSLAYER
	song_info "Abandoned Ship", ORIGIN_RSE, COMPOSER_MORIKAZU_AOKI, COMPOSER_MMMMMM
	song_info "Vs.Kanto Legend", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_GACT_PIGU
	song_info "Vs.Gym Leader", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	song_info "Vs.Gym Leader", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	song_info "Vs.Gym Leader", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	song_info "Vs.Gym Leader", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	song_info "Vs.Gym Leader", ORIGIN_SWSH, COMPOSER_MINAKO_ADACHI, COMPOSER_SHINKONETCAVY_SHOCKSLAYER
	song_info "Vs.Gym Leader", ORIGIN_GO, COMPOSER_JUNICHI_MASUDA, COMPOSER_SHOCKSLAYER
	song_info "Vs.Elite Four", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	song_info "Celestial Tower", ORIGIN_BW, COMPOSER_SHOTA_KAGEYAMA, COMPOSER_MMMMMM
	song_info "Vs.Champion", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	song_info "Mt.Coronet", ORIGIN_DPPT, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Vs.Champion", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	song_info "Vs.World Champion-  ship Finals", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_PIGU_PIKALAXALT
	song_info "Vs.Champion", ORIGIN_B2W2, COMPOSER_HITOMI_SATO, COMPOSER_MMMMMM
	song_info "Credits", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Post-Credits", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	song_info "Title", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA_SHOTA_KAGEYAMA, COMPOSER_SHANTYTOWN
	song_info "Dewford Town", ORIGIN_RSE, COMPOSER_GO_ICHINOSE, COMPOSER_SHANTYTOWN
	song_info "Marine Tube", ORIGIN_B2W2, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	song_info "Vs.Legendary", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	song_info "Vs.Naljo Wild", ORIGIN_PRISM, COMPOSER_LEVUSBEVUS, COMPOSER_FROGGESTSPIRIT
	song_info "Vs.Naljo Trainer", ORIGIN_PRISM, COMPOSER_GACT, COMPOSER_NOTFROGGESTSPIRIT
	song_info "Vs.Naljo Leader", ORIGIN_PRISM, COMPOSER_GRONNOC, COMPOSER_FROGGESTSPIRIT
	song_info "Vs.Palette Ranger", ORIGIN_PRISM, COMPOSER_CAT333POKEMON, COMPOSER_NOTFROGGESTSPIRIT
	song_info "Vs.Kanto Gym Leader", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	song_info "Vs.Kanto Champion", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	assert_list_length NUM_MUSIC_SONGS - 1
	db -1 ; end
