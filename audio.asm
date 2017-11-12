INCLUDE "includes.asm"


SECTION "Audio", ROMX

INCLUDE "audio/engine.asm"

INCLUDE "audio/trainer_encounters.asm"

Music:
INCLUDE "audio/music_pointers.asm"

INCLUDE "audio/music/nothing.asm"

Cries:
INCLUDE "audio/cry_pointers.asm"

SFX:
INCLUDE "audio/sfx_pointers.asm"


SECTION "Music 1", ROMX

INCLUDE "audio/music/crystalopening.asm"
INCLUDE "audio/music/titlescreen.asm"


SECTION "Music 2", ROMX

INCLUDE "audio/music/mainmenu.asm"
INCLUDE "audio/music/newbarktown.asm"
INCLUDE "audio/music/mom.asm"
INCLUDE "audio/music/elmslab.asm"
INCLUDE "audio/music/johtowildbattle.asm" ; shares with johtowildbattlenight.asm
INCLUDE "audio/music/johtowildbattlenight.asm" ; shares with johtowildbattle.asm
INCLUDE "audio/music/wildpokemonvictory.asm" ; shares with successfulcapture.asm
INCLUDE "audio/music/successfulcapture.asm" ; shares with wildpokemonvictory.asm


SECTION "Music 3", ROMX

INCLUDE "audio/music/route29.asm"
INCLUDE "audio/music/cherrygrovecity.asm"
INCLUDE "audio/music/showmearound.asm"
INCLUDE "audio/music/pokemoncenter.asm"
INCLUDE "audio/music/healpokemon.asm"
INCLUDE "audio/music/lookyoungster.asm"
INCLUDE "audio/music/johtotrainerbattle.asm"
INCLUDE "audio/music/trainervictory.asm"


SECTION "Music 4", ROMX

INCLUDE "audio/music/route30.asm"
INCLUDE "audio/music/violetcity.asm"
INCLUDE "audio/music/sprouttower.asm"
INCLUDE "audio/music/looksage.asm"
INCLUDE "audio/music/unioncave.asm"
INCLUDE "audio/music/ruinsofalphinterior.asm"
INCLUDE "audio/music/ruinsofalphradio.asm"
INCLUDE "audio/music/azaleatown.asm"


SECTION "Music 5", ROMX

INCLUDE "audio/music/lookrocket.asm" ; shares with rockettheme.asm
INCLUDE "audio/music/rockettheme.asm" ; shares with lookrocket.asm
INCLUDE "audio/music/rocketbattle.asm"
INCLUDE "audio/music/route36.asm"
INCLUDE "audio/music/lookrival.asm" ; shares with aftertherivalfight.asm
INCLUDE "audio/music/rivalbattle.asm"
INCLUDE "audio/music/aftertherivalfight.asm" ; shares with lookrival.asm
INCLUDE "audio/music/evolution.asm"


SECTION "Music 6", ROMX

INCLUDE "audio/music/goldenrodcity.asm"
INCLUDE "audio/music/pokecomcenter.asm"
INCLUDE "audio/music/gym.asm"
INCLUDE "audio/music/johtogymbattle.asm"
INCLUDE "audio/music/gymleadervictory.asm"
INCLUDE "audio/music/pokemonchannel.asm"
INCLUDE "audio/music/buenaspassword.asm"
INCLUDE "audio/music/gamecorner.asm"


SECTION "Music 7", ROMX

INCLUDE "audio/music/bicycle.asm"
INCLUDE "audio/music/looklass.asm"
INCLUDE "audio/music/nationalpark.asm"
INCLUDE "audio/music/bugcatchingcontest.asm"
INCLUDE "audio/music/contestresults.asm"
INCLUDE "audio/music/ecruteakcity.asm"
INCLUDE "audio/music/dancinghall.asm"
INCLUDE "audio/music/lookkimonogirl.asm"


SECTION "Music 8", ROMX

INCLUDE "audio/music/burnedtower.asm"
INCLUDE "audio/music/lookmysticalman.asm"
INCLUDE "audio/music/profoakspokemontalk.asm"
INCLUDE "audio/music/route37.asm"
INCLUDE "audio/music/pokemonmarch.asm"
INCLUDE "audio/music/lighthouse.asm"
INCLUDE "audio/music/surf.asm"
INCLUDE "audio/music/lakeofrage.asm"


SECTION "Music 9", ROMX

INCLUDE "audio/music/lakeofragerocketradio.asm"
INCLUDE "audio/music/rockethideout.asm"
INCLUDE "audio/music/lookpokemaniac.asm"
INCLUDE "audio/music/darkcave.asm"
INCLUDE "audio/music/dragonsden.asm"
INCLUDE "audio/music/clair.asm"
INCLUDE "audio/music/tintower.asm"
INCLUDE "audio/music/suicunebattle.asm"


SECTION "Music 10", ROMX

INCLUDE "audio/music/route26.asm"
INCLUDE "audio/music/victoryroad.asm"
INCLUDE "audio/music/indigoplateau.asm"
INCLUDE "audio/music/championbattle.asm"
INCLUDE "audio/music/halloffame.asm"
INCLUDE "audio/music/ssaqua.asm"
INCLUDE "audio/music/vermilioncity.asm"
INCLUDE "audio/music/kantogymbattle.asm"


SECTION "Music 11", ROMX

INCLUDE "audio/music/lavendertown.asm"
INCLUDE "audio/music/kantowildbattle.asm"
INCLUDE "audio/music/magnettrain.asm"
INCLUDE "audio/music/pokemonlullaby.asm"
INCLUDE "audio/music/celadoncity.asm"
INCLUDE "audio/music/route12.asm"
INCLUDE "audio/music/pokeflutechannel.asm"
INCLUDE "audio/music/viridianforest.asm"


SECTION "Music 12", ROMX

INCLUDE "audio/music/lookhiker.asm"
INCLUDE "audio/music/viridiancity.asm"
INCLUDE "audio/music/route3.asm"
INCLUDE "audio/music/lookofficer.asm"
INCLUDE "audio/music/mtmoon.asm"
INCLUDE "audio/music/mtmoonsquare.asm"
INCLUDE "audio/music/route1.asm"
INCLUDE "audio/music/pallettown.asm"


SECTION "Music 13", ROMX

INCLUDE "audio/music/profoak.asm"
INCLUDE "audio/music/lookbeauty.asm"
INCLUDE "audio/music/kantotrainerbattle.asm"
INCLUDE "audio/music/battletowertheme.asm"
INCLUDE "audio/music/battletowerlobby.asm"


SECTION "Music 14", ROMX

INCLUDE "audio/music/credits.asm"
INCLUDE "audio/music/postcredits.asm"


SECTION "RBY Music 1", ROMX

INCLUDE "audio/music/rby/ceruleancave.asm"
INCLUDE "audio/music/rby/cinnabarmansion.asm"
INCLUDE "audio/music/rby/diglettscave.asm"
INCLUDE "audio/music/rby/indigoplateau.asm"


SECTION "RBY Music 2", ROMX

INCLUDE "audio/music/rby/lavendertown.asm"
INCLUDE "audio/music/rby/lookjessiejames.asm"
INCLUDE "audio/music/rby/pokemontower.asm"
INCLUDE "audio/music/rby/surfingpikachu.asm"


SECTION "RSE Music 1", ROMX

INCLUDE "audio/music/rse/abandonedship.asm"
INCLUDE "audio/music/rse/championbattle.asm"
INCLUDE "audio/music/rse/evergrandecity.asm"
INCLUDE "audio/music/rse/dewfordtown.asm"
INCLUDE "audio/music/rse/frontierbrainbattle.asm"


SECTION "RSE Music 2", ROMX

INCLUDE "audio/music/rse/gymleaderbattle.asm"
INCLUDE "audio/music/rse/meteorfalls.asm"
INCLUDE "audio/music/rse/mountchimney.asm"
INCLUDE "audio/music/rse/mountpyre.asm"
INCLUDE "audio/music/rse/route101.asm"


SECTION "DPPt Music 1", ROMX

INCLUDE "audio/music/dppt/canalavecity.asm"
INCLUDE "audio/music/dppt/championbattle.asm"
INCLUDE "audio/music/dppt/eternaforest.asm"
INCLUDE "audio/music/dppt/gamecorner.asm"
INCLUDE "audio/music/dppt/gymleaderbattle.asm"
INCLUDE "audio/music/dppt/mountcoronet.asm"
INCLUDE "audio/music/dppt/oreburghgate.asm"


SECTION "DPPt Music 2", ROMX

INCLUDE "audio/music/dppt/route203.asm"
INCLUDE "audio/music/dppt/route205.asm"
INCLUDE "audio/music/dppt/route209.asm"
INCLUDE "audio/music/dppt/route210.asm"
INCLUDE "audio/music/dppt/route225.asm"
INCLUDE "audio/music/dppt/starkmountain.asm"
INCLUDE "audio/music/dppt/sunyshorecity.asm"
INCLUDE "audio/music/dppt/trainerbattle.asm"


SECTION "HGSS Music 1", ROMX

INCLUDE "audio/music/hgss/ceruleancity.asm"
INCLUDE "audio/music/hgss/cianwoodcity.asm"
INCLUDE "audio/music/hgss/cinnabarisland.asm"
INCLUDE "audio/music/hgss/hoohbattle.asm"
INCLUDE "audio/music/hgss/lugiabattle.asm"
INCLUDE "audio/music/hgss/lyraencounter.asm" ; shares with lyradeparture.asm
INCLUDE "audio/music/hgss/lyradeparture.asm" ; shares with lyraencounter.asm


SECTION "HGSS Music 2", ROMX

INCLUDE "audio/music/hgss/mart.asm"
INCLUDE "audio/music/hgss/nuggetbridge.asm"
INCLUDE "audio/music/hgss/route47.asm"
INCLUDE "audio/music/hgss/safarizonegate.asm"
INCLUDE "audio/music/hgss/spikyearedpichu.asm"
INCLUDE "audio/music/hgss/summoningdance.asm"


SECTION "BW Music 1", ROMX

INCLUDE "audio/music/bw/blackcity.asm"
INCLUDE "audio/music/bw/celestialtower.asm"
INCLUDE "audio/music/bw/elitefourbattle.asm"
INCLUDE "audio/music/bw/finalpokemon.asm"


SECTION "BW Music 2", ROMX

INCLUDE "audio/music/bw/gymleaderbattle.asm"
INCLUDE "audio/music/bw/route12.asm"
INCLUDE "audio/music/bw/route4.asm"
INCLUDE "audio/music/bw/trainerbattle.asm"
INCLUDE "audio/music/bw/wcsbattle.asm"


SECTION "B2W2 Music 1", ROMX

INCLUDE "audio/music/b2w2/championbattle.asm"


SECTION "B2W2 Music 2", ROMX

INCLUDE "audio/music/b2w2/reversalmountainwhite.asm"
INCLUDE "audio/music/b2w2/roadtoreversalmountain.asm"
INCLUDE "audio/music/b2w2/whitetreehollow.asm"
INCLUDE "audio/music/b2w2/marinetube.asm"


SECTION "XY Music 1", ROMX

INCLUDE "audio/music/xy/bicycle.asm"
INCLUDE "audio/music/xy/frostcavern.asm"
INCLUDE "audio/music/xy/gymleaderbattle.asm"
INCLUDE "audio/music/xy/kantolegendbattle.asm"


SECTION "XY Music 2", ROMX

INCLUDE "audio/music/xy/laverrecity.asm"
INCLUDE "audio/music/xy/powerplant.asm"
INCLUDE "audio/music/xy/rivalbattle.asm"
INCLUDE "audio/music/xy/titlescreen.asm"


SECTION "XY Music 3", ROMX

INCLUDE "audio/music/xy/legendarybattle.asm"


SECTION "ORAS Music 1", ROMX

INCLUDE "audio/music/oras/wallybattle.asm"
INCLUDE "audio/music/oras/wallyencounter.asm"


SECTION "ORAS Music 2", ROMX

INCLUDE "audio/music/oras/zinniabattle.asm"
INCLUDE "audio/music/oras/zinniaencounter.asm"


SECTION "SM Music 1", ROMX

INCLUDE "audio/music/sm/elitefourbattle.asm"
INCLUDE "audio/music/sm/motherbeastbattle.asm"


SECTION "SM Music 2", ROMX

INCLUDE "audio/music/sm/trainerbattle.asm"
INCLUDE "audio/music/sm/wildbattle.asm"


SECTION "Prism Music", ROMX

INCLUDE "audio/music/prism/wildbattle.asm"
INCLUDE "audio/music/prism/trainerbattle.asm"
INCLUDE "audio/music/prism/gymleaderbattle.asm"
INCLUDE "audio/music/prism/palettebattle.asm"


SECTION "Go Music", ROMX

INCLUDE "audio/music/go/wildbattle.asm"
INCLUDE "audio/music/go/gymbattle.asm"


SECTION "Movie 2000 Music", ROMX

INCLUDE "audio/music/m02/lugiassong.asm"


SECTION "Sound Effects", ROMX

INCLUDE "audio/sfx.asm"


SECTION "Crystal Sound Effects", ROMX

INCLUDE "audio/sfx_crystal.asm"


SECTION "Cries", ROMX

CryHeaders::
INCLUDE "audio/cry_headers.asm"

INCLUDE "audio/cries.asm"
