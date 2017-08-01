INCLUDE "includes.asm"


SECTION "Roofs", ROMX

INCLUDE "tilesets/roofs.asm"


SECTION "Tileset Data 1", ROMX

Tileset00GFX::
Tileset01GFX::
INCBIN "gfx/tilesets/johto1.2bpp.lz"

Tileset00Meta::
Tileset01Meta::
INCBIN "tilesets/johto1_metatiles.bin"

Tileset00Coll::
Tileset01Coll::
INCLUDE "tilesets/johto1_collision.asm"

Tileset03GFX::
INCBIN "gfx/tilesets/kanto1.2bpp.lz"

Tileset03Meta::
INCBIN "tilesets/kanto1_metatiles.bin"


SECTION "Tileset Data 2", ROMX

Tileset05GFX::
INCBIN "gfx/tilesets/house1.2bpp.lz"

Tileset05Meta::
INCBIN "tilesets/house1_metatiles.bin"

Tileset05Coll::
INCLUDE "tilesets/house1_collision.asm"

Tileset38Meta::
INCBIN "tilesets/museum_metatiles.bin"

Tileset38Coll::
INCLUDE "tilesets/museum_collision.asm"

Tileset41Coll::
INCLUDE "tilesets/valencia_collision.asm"


SECTION "Tileset Data 3", ROMX

Tileset09GFX::
INCBIN "gfx/tilesets/port.2bpp.lz"

Tileset09Meta::
INCBIN "tilesets/port_metatiles.bin"

Tileset09Coll::
INCLUDE "tilesets/port_collision.asm"

Tileset13GFX::
INCBIN "gfx/tilesets/mansion.2bpp.lz"

Tileset13Meta::
INCBIN "tilesets/mansion_metatiles.bin"

Tileset13Coll::
INCLUDE "tilesets/mansion_collision.asm"

Tileset14GFX::
INCBIN "gfx/tilesets/game_corner.2bpp.lz"

Tileset14Meta::
INCBIN "tilesets/game_corner_metatiles.bin"

Tileset14Coll::
INCLUDE "tilesets/game_corner_collision.asm"

Tileset15GFX::
INCBIN "gfx/tilesets/gym1.2bpp.lz"

Tileset15Meta::
INCBIN "tilesets/gym1_metatiles.bin"

Tileset15Coll::
INCLUDE "tilesets/gym1_collision.asm"


SECTION "Tileset Data 4", ROMX

Tileset08GFX::
INCBIN "gfx/tilesets/gate.2bpp.lz"

Tileset08Meta::
INCBIN "tilesets/gate_metatiles.bin"

Tileset08Coll::
INCLUDE "tilesets/gate_collision.asm"

Tileset16GFX::
INCBIN "gfx/tilesets/house3.2bpp.lz"

Tileset16Meta::
INCBIN "tilesets/house3_metatiles.bin"

Tileset16Coll::
INCLUDE "tilesets/house3_collision.asm"

Tileset17GFX::
INCBIN "gfx/tilesets/gym2.2bpp.lz"

Tileset17Meta::
INCBIN "tilesets/gym2_metatiles.bin"

Tileset17Coll::
INCLUDE "tilesets/gym2_collision.asm"

Tileset25GFX::
INCBIN "gfx/tilesets/park.2bpp.lz"

Tileset25Meta::
INCBIN "tilesets/park_metatiles.bin"

Tileset25Coll::
INCLUDE "tilesets/park_collision.asm"


SECTION "Tileset Data 5", ROMX

Tileset11GFX::
INCBIN "gfx/tilesets/facility.2bpp.lz"

Tileset11Meta::
INCBIN "tilesets/facility_metatiles.bin"

Tileset11Coll::
INCLUDE "tilesets/facility_collision.asm"

Tileset19GFX::
INCBIN "gfx/tilesets/lighthouse.2bpp.lz"

Tileset19Meta::
INCBIN "tilesets/lighthouse_metatiles.bin"

Tileset19Coll::
INCLUDE "tilesets/lighthouse_collision.asm"

Tileset21GFX::
INCBIN "gfx/tilesets/pokecom.2bpp.lz"

Tileset21Meta::
INCBIN "tilesets/pokecom_metatiles.bin"

Tileset21Coll::
INCLUDE "tilesets/pokecom_collision.asm"

Tileset29GFX::
INCBIN "gfx/tilesets/ice_path.2bpp.lz"

Tileset29Meta::
INCBIN "tilesets/ice_path_metatiles.bin"

Tileset29Coll::
INCLUDE "tilesets/ice_path_collision.asm"


SECTION "Tileset Data 6", ROMX

Tileset12GFX::
INCBIN "gfx/tilesets/mart.2bpp.lz"

Tileset12Meta::
INCBIN "tilesets/mart_metatiles.bin"

Tileset12Coll::
INCLUDE "tilesets/mart_collision.asm"

Tileset23GFX::
INCBIN "gfx/tilesets/tower.2bpp.lz"

Tileset23Meta::
INCBIN "tilesets/tower_metatiles.bin"

Tileset23Coll::
INCLUDE "tilesets/tower_collision.asm"

Tileset27GFX::
INCBIN "gfx/tilesets/radio_tower.2bpp.lz"

Tileset27Meta::
INCBIN "tilesets/radio_tower_metatiles.bin"

Tileset27Coll::
INCLUDE "tilesets/radio_tower_collision.asm"

Tileset28Meta::
INCBIN "tilesets/warehouse_metatiles.bin"

Tileset28Coll::
INCLUDE "tilesets/warehouse_collision.asm"


SECTION "Tileset Data 7", ROMX

Tileset07GFX::
INCBIN "gfx/tilesets/pokecenter.2bpp.lz"

Tileset07Meta::
INCBIN "tilesets/pokecenter_metatiles.bin"

Tileset07Coll::
INCLUDE "tilesets/pokecenter_collision.asm"

Tileset26Meta::
INCBIN "tilesets/ruins_metatiles.bin"

Tileset26Coll::
INCLUDE "tilesets/ruins_collision.asm"

Tileset32Meta::
INCBIN "tilesets/alph_metatiles.bin"

Tileset32Coll::
INCLUDE "tilesets/alph_collision.asm"


SECTION "Tileset Data 8", ROMX

Tileset24GFX::
INCBIN "gfx/tilesets/cave.2bpp.lz"

Tileset40GFX::
INCBIN "gfx/tilesets/quiet_cave.2bpp.lz"

Tileset24Meta::
Tileset40Meta::
INCBIN "tilesets/cave_metatiles.bin"

Tileset24Coll::
Tileset40Coll::
INCLUDE "tilesets/cave_collision.asm"

Tileset30GFX::
INCBIN "gfx/tilesets/forest.2bpp.lz"

Tileset30Meta::
INCBIN "tilesets/forest_metatiles.bin"

Tileset30Coll::
INCLUDE "tilesets/forest_collision.asm"

Tileset41GFX::
INCBIN "gfx/tilesets/valencia.2bpp.lz"


SECTION "Tileset Data 9", ROMX

Tileset02GFX::
INCBIN "gfx/tilesets/johto2.2bpp.lz"

Tileset02Meta::
INCBIN "tilesets/johto2_metatiles.bin"

Tileset02Coll::
INCLUDE "tilesets/johto2_collision.asm"

Tileset04GFX::
INCBIN "gfx/tilesets/johto3.2bpp.lz"

Tileset04Meta::
INCBIN "tilesets/johto3_metatiles.bin"

Tileset04Coll::
INCLUDE "tilesets/johto3_collision.asm"

Tileset31GFX::
INCBIN "gfx/tilesets/safari.2bpp.lz"

Tileset31Meta::
INCBIN "tilesets/safari_metatiles.bin"

Tileset31Coll::
INCLUDE "tilesets/safari_collision.asm"


SECTION "Tileset Data 10", ROMX

Tileset06GFX::
INCBIN "gfx/tilesets/house2.2bpp.lz"

Tileset06Meta::
INCBIN "tilesets/house2_metatiles.bin"

Tileset06Coll::
INCLUDE "tilesets/house2_collision.asm"


SECTION "Tileset Data 11", ROMX

Tileset18GFX::
INCBIN "gfx/tilesets/gym3.2bpp.lz"

Tileset18Meta::
INCBIN "tilesets/gym3_metatiles.bin"

Tileset18Coll::
INCLUDE "tilesets/gym3_collision.asm"

Tileset20GFX::
INCBIN "gfx/tilesets/kanto2.2bpp.lz"

Tileset20Meta::
INCBIN "tilesets/kanto2_metatiles.bin"

Tileset20Coll::
INCLUDE "tilesets/kanto2_collision.asm"

Tileset28GFX::
INCBIN "gfx/tilesets/warehouse.2bpp.lz"

Tileset33GFX::
INCBIN "gfx/tilesets/pokemon_mansion.2bpp.lz"

Tileset33Meta::
INCBIN "tilesets/pokemon_mansion_metatiles.bin"

Tileset33Coll::
INCLUDE "tilesets/pokemon_mansion_collision.asm"

Tileset03Coll::
INCLUDE "tilesets/kanto1_collision.asm"


SECTION "Tileset Data 12", ROMX

Tileset22GFX::
INCBIN "gfx/tilesets/battle_tower.2bpp.lz"

Tileset22Meta::
INCBIN "tilesets/battle_tower_metatiles.bin"

Tileset22Coll::
INCLUDE "tilesets/battle_tower_collision.asm"

Tileset35GFX::
INCBIN "gfx/tilesets/tunnel.2bpp.lz"

Tileset35Meta::
INCBIN "tilesets/tunnel_metatiles.bin"

Tileset35Coll::
INCLUDE "tilesets/tunnel_collision.asm"

Tileset36GFX::
INCBIN "gfx/tilesets/decor.2bpp.lz"

Tileset36Meta::
INCBIN "tilesets/decor_metatiles.bin"

Tileset36Coll::
INCLUDE "tilesets/decor_collision.asm"

Tileset37GFX::
INCBIN "gfx/tilesets/shamouti.2bpp.lz"

Tileset37Meta::
INCBIN "tilesets/shamouti_metatiles.bin"

Tileset37Coll::
INCLUDE "tilesets/shamouti_collision.asm"


SECTION "Tileset Data 13", ROMX

Tileset38GFX::
INCBIN "gfx/tilesets/museum.2bpp.lz"

Tileset39GFX::
INCBIN "gfx/tilesets/hotel.2bpp.lz"

Tileset39Meta::
INCBIN "tilesets/hotel_metatiles.bin"

Tileset39Coll::
INCLUDE "tilesets/hotel_collision.asm"


SECTION "Tileset Data 14", ROMX

Tileset10GFX::
INCBIN "gfx/tilesets/lab.2bpp.lz"

Tileset10Meta::
INCBIN "tilesets/lab_metatiles.bin"

Tileset10Coll::
INCLUDE "tilesets/lab_collision.asm"

Tileset34GFX::
INCBIN "gfx/tilesets/faraway.2bpp.lz"

Tileset34Meta::
INCBIN "tilesets/faraway_metatiles.bin"

Tileset34Coll::
INCLUDE "tilesets/faraway_collision.asm"

Tileset41Meta::
INCBIN "tilesets/valencia_metatiles.bin"


SECTION "Tileset Data 15", ROMX

Tileset26GFX::
Tileset32GFX::
INCBIN "gfx/tilesets/ruins.2bpp.lz"
