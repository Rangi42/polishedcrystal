decoration: MACRO
	; type, name, command, event flag, tile/sprite
	db \1, \2, \3
	dw \4
	db \5
ENDM

DecorationAttributes:
	decoration DECO_PLANT,    0,                 0,                  EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, 0
	decoration DECO_PLANT,    PUT_IT_AWAY,       PUT_AWAY_BED,       EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, 0
	decoration DECO_BED,      FEATHERY_BED,      SET_UP_BED,         EVENT_DECO_BED_1,                   $83
	decoration DECO_BED,      PINK_BED,          SET_UP_BED,         EVENT_DECO_BED_2,                   $77
	decoration DECO_BED,      POLKADOT_BED,      SET_UP_BED,         EVENT_DECO_BED_3,                   $7b
	decoration DECO_BED,      PIKACHU_BED,       SET_UP_BED,         EVENT_DECO_BED_4,                   $7f
	decoration DECO_PLANT,    PUT_IT_AWAY,       PUT_AWAY_CARPET,    EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, 0
	decoration DECO_CARPET,   RED_CARPET,        SET_UP_CARPET,      EVENT_DECO_CARPET_1,                $74
	decoration DECO_CARPET,   BLUE_CARPET,       SET_UP_CARPET,      EVENT_DECO_CARPET_2,                $78
	decoration DECO_CARPET,   YELLOW_CARPET,     SET_UP_CARPET,      EVENT_DECO_CARPET_3,                $7c
	decoration DECO_CARPET,   GREEN_CARPET,      SET_UP_CARPET,      EVENT_DECO_CARPET_4,                $80
	decoration DECO_PLANT,    PUT_IT_AWAY,       PUT_AWAY_PLANT,     EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, 0
	decoration DECO_PLANT,    MAGNAPLANT,        SET_UP_PLANT,       EVENT_DECO_PLANT_1,                 $71
	decoration DECO_PLANT,    TROPICPLANT,       SET_UP_PLANT,       EVENT_DECO_PLANT_2,                 $72
	decoration DECO_PLANT,    JUMBOPLANT,        SET_UP_PLANT,       EVENT_DECO_PLANT_3,                 $73
	decoration DECO_PLANT,    PUT_IT_AWAY,       PUT_AWAY_POSTER,    EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, 0
	decoration DECO_PLANT,    TOWN_MAP_D,        SET_UP_POSTER,      EVENT_DECO_PLANT_4,                 $6c
	decoration DECO_POSTER,   PIKACHU,           SET_UP_POSTER,      EVENT_DECO_POSTER_1,                $6d
	decoration DECO_POSTER,   CLEFAIRY,          SET_UP_POSTER,      EVENT_DECO_POSTER_2,                $6e
	decoration DECO_POSTER,   MARILL,            SET_UP_POSTER,      EVENT_DECO_POSTER_3,                $6f
	decoration DECO_PLANT,    PUT_IT_AWAY,       PUT_AWAY_CONSOLE,   EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, 0
	decoration DECO_PLANT,    SUPER_NES,         SET_UP_CONSOLE,     EVENT_DECO_SNES,                    SPRITE_SNES
	decoration DECO_PLANT,    NINTENDO_64,       SET_UP_CONSOLE,     EVENT_DECO_N64,                     SPRITE_N64
	decoration DECO_PLANT,    GAMECUBE,          SET_UP_CONSOLE,     EVENT_DECO_GAMECUBE,                SPRITE_GAMECUBE
	decoration DECO_PLANT,    WII,               SET_UP_CONSOLE,     EVENT_DECO_WII,                     SPRITE_WII
	decoration DECO_PLANT,    PUT_IT_AWAY,       PUT_AWAY_BIG_DOLL,  EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, 0
	decoration DECO_BIGDOLL,  SNORLAX,           SET_UP_BIG_DOLL,    EVENT_DECO_BIG_SNORLAX_DOLL,        SPRITE_BIG_SNORLAX
	decoration DECO_BIGDOLL,  ONIX,              SET_UP_BIG_DOLL,    EVENT_DECO_BIG_ONIX_DOLL,           SPRITE_BIG_ONIX
	decoration DECO_BIGDOLL,  LAPRAS,            SET_UP_BIG_DOLL,    EVENT_DECO_BIG_LAPRAS_DOLL,         SPRITE_BIG_LAPRAS
	decoration DECO_PLANT,    PUT_IT_AWAY,       PUT_AWAY_DOLL,      EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, 0
	decoration DECO_DOLL,     PIKACHU,           SET_UP_DOLL,        EVENT_DECO_PIKACHU_DOLL,            SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     RAICHU,            SET_UP_DOLL,        EVENT_DECO_RAICHU_DOLL,             SPRITE_MON_DOLL_1
	decoration DECO_PLANT,    SURF_PIKA_DOLL,    SET_UP_DOLL,        EVENT_DECO_SURFING_PIKACHU_DOLL,    SPRITE_SURFING_PIKACHU
	decoration DECO_DOLL,     CLEFAIRY,          SET_UP_DOLL,        EVENT_DECO_CLEFAIRY_DOLL,           SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     JIGGLYPUFF,        SET_UP_DOLL,        EVENT_DECO_JIGGLYPUFF_DOLL,         SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     BULBASAUR,         SET_UP_DOLL,        EVENT_DECO_BULBASAUR_DOLL,          SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     CHARMANDER,        SET_UP_DOLL,        EVENT_DECO_CHARMANDER_DOLL,         SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     SQUIRTLE,          SET_UP_DOLL,        EVENT_DECO_SQUIRTLE_DOLL,           SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     CHIKORITA,         SET_UP_DOLL,        EVENT_DECO_CHIKORITA_DOLL,          SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     CYNDAQUIL,         SET_UP_DOLL,        EVENT_DECO_CYNDAQUIL_DOLL,          SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     TOTODILE,          SET_UP_DOLL,        EVENT_DECO_TOTODILE_DOLL,           SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     POLIWAG,           SET_UP_DOLL,        EVENT_DECO_POLIWAG_DOLL,            SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     MAREEP,            SET_UP_DOLL,        EVENT_DECO_MAREEP_DOLL,             SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     TOGEPI,            SET_UP_DOLL,        EVENT_DECO_TOGEPI_DOLL,             SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     MAGIKARP,          SET_UP_DOLL,        EVENT_DECO_MAGIKARP_DOLL,           SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     ODDISH,            SET_UP_DOLL,        EVENT_DECO_ODDISH_DOLL,             SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     GENGAR,            SET_UP_DOLL,        EVENT_DECO_GENGAR_DOLL,             SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     OCTILLERY,         SET_UP_DOLL,        EVENT_DECO_OCTILLERY_DOLL,          SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     DITTO,             SET_UP_DOLL,        EVENT_DECO_DITTO_DOLL,              SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     VOLTORB,           SET_UP_DOLL,        EVENT_DECO_VOLTORB_DOLL,            SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     ABRA,              SET_UP_DOLL,        EVENT_DECO_ABRA_DOLL,               SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     UNOWN,             SET_UP_DOLL,        EVENT_DECO_UNOWN_DOLL,              SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     GEODUDE,           SET_UP_DOLL,        EVENT_DECO_GEODUDE_DOLL,            SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     PINECO,            SET_UP_DOLL,        EVENT_DECO_PINECO_DOLL,             SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     MARILL,            SET_UP_DOLL,        EVENT_DECO_MARILL_DOLL,             SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     TEDDIURSA,         SET_UP_DOLL,        EVENT_DECO_TEDDIURSA_DOLL,          SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     MEOWTH,            SET_UP_DOLL,        EVENT_DECO_MEOWTH_DOLL,             SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     VULPIX,            SET_UP_DOLL,        EVENT_DECO_VULPIX_DOLL,             SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     GROWLITHE,         SET_UP_DOLL,        EVENT_DECO_GROWLITHE_DOLL,          SPRITE_MON_DOLL_1
	decoration DECO_DOLL,     EEVEE,             SET_UP_DOLL,        EVENT_DECO_EEVEE_DOLL,              SPRITE_MON_DOLL_1
	decoration DECO_PLANT,    GOLD_TROPHY,       SET_UP_DOLL,        EVENT_DECO_GOLD_TROPHY,             SPRITE_GOLD_TROPHY
	decoration DECO_PLANT,    SILVER_TROPHY,     SET_UP_DOLL,        EVENT_DECO_SILVER_TROPHY,           SPRITE_SILVER_TROPHY
