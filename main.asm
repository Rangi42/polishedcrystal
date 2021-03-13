INCLUDE "constants.asm"


SECTION "bank1", ROMX

INCLUDE "engine/gfx/load_push_oam.asm"
INCLUDE "engine/overworld/map_objects.asm"
INCLUDE "engine/menus/intro_menu.asm"
INCLUDE "engine/overworld/init_map.asm"
INCLUDE "engine/menus/init_options.asm"
INCLUDE "engine/pokemon/learn.asm"
INCLUDE "engine/math/math.asm"
INCLUDE "data/items/attributes.asm"
INCLUDE "engine/overworld/npc_movement.asm"
INCLUDE "engine/events/happiness_egg.asm"
INCLUDE "engine/events/shiny_ditto.asm"
INCLUDE "engine/events/shuckle.asm"
INCLUDE "engine/events/bills_grandfather.asm"
INCLUDE "engine/events/hidden_power_guru.asm"
INCLUDE "engine/events/haircut_etc.asm"


SECTION "bank2", ROMX

INCLUDE "engine/overworld/player_object.asm"
INCLUDE "engine/math/sine.asm"
INCLUDE "data/predef_pointers.asm"
INCLUDE "engine/gfx/color.asm"


SECTION "bank3", ROMX

INCLUDE "engine/events/checktime.asm"
INCLUDE "engine/events/specials.asm"
INCLUDE "engine/math/print_num.asm"
INCLUDE "engine/pokemon/health.asm"
INCLUDE "engine/events/overworld.asm"
INCLUDE "engine/items/items.asm"
INCLUDE "engine/battle/anim_hp_bar.asm"
INCLUDE "engine/pokemon/move_mon.asm"
INCLUDE "engine/pokemon/bills_pc_top.asm"
INCLUDE "engine/pokemon/breedmon_level_growth.asm"
INCLUDE "engine/events/bug_contest/caught_mon.asm"
INCLUDE "engine/events/bug_contest/display_stats.asm"
INCLUDE "engine/items/item_effects.asm"


SECTION "Poke Ball Effects", ROMX

INCLUDE "engine/items/poke_balls.asm"


SECTION "Load Map Part", ROMX

; do not separate
INCLUDE "engine/overworld/player_step.asm"
INCLUDE "engine/overworld/load_map_part.asm"


SECTION "bank4", ROMX

INCLUDE "engine/items/pack.asm"
INCLUDE "engine/events/itemball.asm"
INCLUDE "engine/events/fruit_trees.asm"
INCLUDE "engine/gfx/item_icons.asm"
INCLUDE "engine/overworld/time.asm"
INCLUDE "engine/items/tmhm.asm"
INCLUDE "engine/menus/naming_screen.asm"
INCLUDE "engine/events/heal_machine_anim.asm"
INCLUDE "engine/events/whiteout.asm"
INCLUDE "engine/events/forced_movement.asm"
INCLUDE "engine/events/itemfinder.asm"
INCLUDE "engine/menus/start_menu.asm"
INCLUDE "engine/pokemon/mon_menu.asm"
INCLUDE "engine/overworld/select_menu.asm"
INCLUDE "engine/events/elevator.asm"
INCLUDE "engine/events/bug_contest/contest.asm"
INCLUDE "engine/events/safari_game.asm"
INCLUDE "engine/events/std_collision.asm"


SECTION "Roofs", ROMX

INCLUDE "engine/tilesets/mapgroup_roofs.asm"


SECTION "bank5", ROMX

INCLUDE "engine/rtc/rtc.asm"
INCLUDE "engine/overworld/overworld.asm"
INCLUDE "engine/overworld/tile_events.asm"
INCLUDE "engine/menus/save.asm"
INCLUDE "engine/overworld/spawn_points.asm"
INCLUDE "engine/overworld/map_setup.asm"
INCLUDE "engine/events/pokecenter_pc.asm"
INCLUDE "engine/items/mart.asm"
INCLUDE "engine/events/money.asm"
INCLUDE "data/items/marts.asm"
INCLUDE "engine/events/mom.asm"
INCLUDE "engine/events/daycare.asm"
INCLUDE "engine/pokemon/breeding.asm"


SECTION "Clock Reset", ROMX

INCLUDE "engine/rtc/restart_clock.asm"


SECTION "Effect Command Pointers", ROMX

; must come before data/moves/effects.asm and engine/battle/effect_commands.asm
INCLUDE "data/battle/effect_command_pointers.asm"


SECTION "bank9", ROMX

INCLUDE "engine/menus/menu.asm"
INCLUDE "engine/items/update_item_description.asm"
INCLUDE "engine/events/pokepic.asm"
INCLUDE "engine/menus/scrolling_menu.asm"
INCLUDE "engine/items/switch_items.asm"
INCLUDE "engine/menus/menu_2.asm"
INCLUDE "engine/pokemon/mon_submenu.asm"
INCLUDE "engine/battle/menu.asm"
INCLUDE "engine/items/buy_sell_toss.asm"
INCLUDE "engine/menus/trainer_card.asm"
INCLUDE "engine/events/prof_oaks_pc.asm"
INCLUDE "engine/overworld/decorations.asm"
INCLUDE "engine/pokemon/level_up_happiness.asm"
INCLUDE "engine/battle/read_trainer_dvs.asm"
INCLUDE "engine/battle/returntobattle_useball.asm"
INCLUDE "data/moves/effects.asm"


SECTION "bankA", ROMX

INCLUDE "engine/link/link.asm"
INCLUDE "engine/movie/trade_animation.asm"


SECTION "Wild Data", ROMX

INCLUDE "engine/overworld/wildmons.asm"


SECTION "bankB", ROMX

INCLUDE "engine/battle/trainer_huds.asm"
INCLUDE "data/trainers/class_names.asm"
INCLUDE "engine/battle/ai/redundant.asm"
INCLUDE "engine/events/move_deleter.asm"
INCLUDE "engine/items/tmhm2.asm"
INCLUDE "engine/items/key_items.asm"
INCLUDE "data/moves/descriptions.asm"
INCLUDE "engine/events/pokerus/pokerus.asm"
INCLUDE "engine/battle/start_battle.asm"
INCLUDE "engine/gfx/place_graphic.asm"


SECTION "Effect Commands", ROMX

INCLUDE "engine/battle/effect_commands.asm"


SECTION "Enemy Trainers", ROMX

INCLUDE "engine/battle/ai/items.asm"
INCLUDE "engine/battle/ai/scoring.asm"
INCLUDE "engine/battle/read_trainer_attributes.asm"


SECTION "Enemy Trainer Parties", ROMX

INCLUDE "engine/battle/read_trainer_party.asm"


SECTION "Battle Core", ROMX

INCLUDE "engine/battle/core.asm"


SECTION "Battle Endturn", ROMX

INCLUDE "engine/battle/endturn.asm"


SECTION "Pokedex", ROMX

INCLUDE "engine/pokedex/pokedex.asm"


SECTION "Moves", ROMX

INCLUDE "data/moves/moves.asm"


SECTION "Evolution", ROMX

INCLUDE "engine/pokemon/evolve.asm"


SECTION "bank11", ROMX

INCLUDE "engine/battle/ai/move.asm"
INCLUDE "engine/pokemon/mail.asm"
INCLUDE "engine/events/hidden_grottoes.asm"
INCLUDE "engine/pokedex/pokedex_2.asm"


SECTION "Crystal Features 1", ROMX

INCLUDE "engine/events/move_tutor.asm"
INCLUDE "engine/tilesets/tileset_palettes.asm"
INCLUDE "engine/events/celebi.asm"
INCLUDE "engine/menus/main_menu.asm"
INCLUDE "engine/pokemon/search.asm"
INCLUDE "engine/events/buena_menu.asm"


SECTION "Collision Permissions", ROMX

INCLUDE "data/collision_permissions.asm"


SECTION "bank13", ROMX

INCLUDE "engine/events/checksave.asm"
INCLUDE "data/maps/scenes.asm"
INCLUDE "engine/rtc/reset_password.asm"
INCLUDE "engine/menus/delete_save.asm"
INCLUDE "engine/smallflag.asm"
INCLUDE "engine/gfx/trademon_frontpic.asm"
INCLUDE "engine/events/pokerus/check_pokerus.asm"
INCLUDE "engine/events/lucky_number.asm"
INCLUDE "engine/pokemon/caught_data.asm"
INCLUDE "engine/pokemon/search2.asm"
INCLUDE "engine/pokemon/stats_screen.asm"
INCLUDE "engine/events/catch_tutorial.asm"
INCLUDE "engine/movie/evolution_animation.asm"
INCLUDE "engine/movie/init_hof_credits.asm"
INCLUDE "engine/battle/sliding_intro.asm"
INCLUDE "engine/movie/bsod.asm"
INCLUDE "engine/events/judge_machine.asm"
INCLUDE "engine/events/poisonstep.asm"
INCLUDE "engine/events/squirtbottle.asm"
INCLUDE "engine/events/card_key.asm"
INCLUDE "engine/events/basement_key.asm"
INCLUDE "engine/events/sacred_ash.asm"


SECTION "bank14", ROMX

INCLUDE "engine/pokemon/party_menu.asm"
INCLUDE "engine/pokemon/tempmon.asm"
INCLUDE "engine/pokemon/types.asm"
INCLUDE "engine/pokemon/mon_stats.asm"
INCLUDE "engine/pokemon/experience.asm"
INCLUDE "engine/pokemon/switchpartymons.asm"
INCLUDE "engine/gfx/load_pics.asm"
INCLUDE "engine/pokemon/move_mon_wo_mail.asm"
INCLUDE "data/pokemon/names.asm"
INCLUDE "engine/pokemon/natures.asm"


SECTION "Base Data", ROMX

INCLUDE "data/pokemon/base_stats.asm"


SECTION "Crystal Phone Text", ROMX

INCLUDE "data/phone/text/extra.asm"
INCLUDE "data/phone/text/lyra.asm"


SECTION "bank20", ROMX

INCLUDE "engine/overworld/player_movement.asm"
INCLUDE "engine/events/engine_flags.asm"
INCLUDE "engine/overworld/variables.asm"
INCLUDE "data/text/battle.asm"
INCLUDE "engine/battle/final_text.asm"
INCLUDE "engine/battle/abilities.asm"


SECTION "bank21", ROMX

INCLUDE "gfx/battle_anims.asm"
INCLUDE "engine/events/halloffame.asm"
INCLUDE "engine/gfx/copy_tilemap_at_once.asm"
INCLUDE "engine/pokemon/abilities.asm"


SECTION "Crystal Features 2", ROMX

INCLUDE "engine/events/kurt.asm"
INCLUDE "engine/gfx/player_gfx.asm"
INCLUDE "engine/events/unown_walls.asm"
INCLUDE "engine/events/buena.asm"
INCLUDE "engine/events/special_movesets.asm"
INCLUDE "engine/events/battle_tower/battle_tower.asm"
INCLUDE "engine/events/battle_tower/trainer_text.asm"
INCLUDE "engine/events/item_maniacs.asm"


SECTION "bank23", ROMX

INCLUDE "engine/tilesets/timeofday_pals.asm"
INCLUDE "engine/battle/battle_transition.asm"
INCLUDE "engine/events/field_moves.asm"
INCLUDE "engine/events/magnet_train.asm"
INCLUDE "engine/gfx/sprites.asm"
INCLUDE "engine/gfx/mon_icons.asm"
INCLUDE "data/pokemon/menu_icon_pointers.asm"


SECTION "bank24", ROMX

INCLUDE "engine/phone/phone.asm"
INCLUDE "engine/rtc/timeset.asm"
INCLUDE "engine/pokegear/pokegear.asm"
INCLUDE "engine/events/fish.asm"
INCLUDE "engine/games/slot_machine.asm"


SECTION "Phone Scripts", ROMX

INCLUDE "engine/phone/more_phone_scripts.asm"
INCLUDE "engine/phone/buena_phone_scripts.asm"
INCLUDE "engine/events/trainer_scripts.asm"


SECTION "Phone Text 1", ROMX

INCLUDE "data/phone/text/anthony_overworld.asm"
INCLUDE "data/phone/text/todd_overworld.asm"
INCLUDE "data/phone/text/gina_overworld.asm"
INCLUDE "data/phone/text/irwin_overworld.asm"
INCLUDE "data/phone/text/arnie_overworld.asm"
INCLUDE "data/phone/text/alan_overworld.asm"
INCLUDE "data/phone/text/dana_overworld.asm"
INCLUDE "data/phone/text/chad_overworld.asm"
INCLUDE "data/phone/text/derek_overworld.asm"
INCLUDE "data/phone/text/tully_overworld.asm"
INCLUDE "data/phone/text/brent_overworld.asm"
INCLUDE "data/phone/text/tiffany_overworld.asm"
INCLUDE "data/phone/text/vance_overworld.asm"
INCLUDE "data/phone/text/wilton_overworld.asm"
INCLUDE "data/phone/text/kenji_overworld.asm"
INCLUDE "data/phone/text/parry_overworld.asm"
INCLUDE "data/phone/text/erin_overworld.asm"


SECTION "bank2E", ROMX

INCLUDE "engine/events/map_name_sign.asm"
INCLUDE "engine/events/checkforhiddenitems.asm"
INCLUDE "engine/events/treemons.asm"
INCLUDE "engine/events/fishing_gfx.asm"
INCLUDE "engine/pokegear/radio.asm"
INCLUDE "engine/pokemon/mail_2.asm"


SECTION "Phone Scripts 2", ROMX

INCLUDE "engine/events/std_scripts.asm"
INCLUDE "engine/events/initialize_events.asm"
INCLUDE "engine/phone/phone_scripts.asm"


SECTION "bank32", ROMX

INCLUDE "engine/battle_anims/bg_effects.asm"


SECTION "Battle Animation Data", ROMX

INCLUDE "data/moves/animations.asm"


SECTION "Move Animations", ROMX

INCLUDE "engine/battle_anims/anim_commands.asm"
INCLUDE "engine/battle_anims/core.asm"
INCLUDE "data/battle_anims/objects.asm"
INCLUDE "engine/battle_anims/functions.asm"
INCLUDE "engine/battle_anims/helpers.asm"
INCLUDE "data/battle_anims/framesets.asm"
INCLUDE "data/battle_anims/oam.asm"
INCLUDE "data/battle_anims/object_gfx.asm"


SECTION "Pic Animations", ROMX

INCLUDE "engine/gfx/pic_animation.asm"
INCLUDE "gfx/pokemon/anim_pointers.asm"
INCLUDE "gfx/pokemon/anims.asm"
INCLUDE "gfx/pokemon/extra_pointers.asm"
INCLUDE "gfx/pokemon/extras.asm"


SECTION "Pic Animations Bitmasks", ROMX

INCLUDE "gfx/pokemon/bitmask_pointers.asm"
INCLUDE "gfx/pokemon/bitmasks.asm"


SECTION "Pic Animations Frames 1", ROMX

INCLUDE "gfx/pokemon/frame_pointers.asm"
INCLUDE "gfx/pokemon/kanto_frames.asm"


SECTION "Pic Animations Frames 2", ROMX

INCLUDE "gfx/pokemon/johto_frames.asm"


SECTION "bank38", ROMX

INCLUDE "engine/games/card_flip.asm"
INCLUDE "engine/games/unown_puzzle.asm"
;INCLUDE "engine/games/memory_game.asm"
INCLUDE "engine/pokemon/bills_pc.asm"
INCLUDE "engine/gfx/fade.asm"


SECTION "bank39", ROMX

INCLUDE "engine/menus/options_menu.asm"
INCLUDE "engine/movie/splash.asm"
INCLUDE "engine/movie/intro.asm"


SECTION "Typefaces", ROMX

INCLUDE "engine/gfx/load_font.asm"


SECTION "bank3E", ROMX

INCLUDE "engine/events/name_rater.asm"
INCLUDE "engine/events/play_slow_cry.asm"
INCLUDE "engine/pokedex/unown_dex.asm"
INCLUDE "engine/events/magikarp.asm"
INCLUDE "engine/battle/hidden_power.asm"
INCLUDE "engine/battle/misc.asm"


SECTION "bank3F", ROMX

INCLUDE "engine/tilesets/tileset_anims.asm"
INCLUDE "engine/events/npc_trade.asm"
INCLUDE "engine/events/mom_phone.asm"
INCLUDE "engine/events/wonder_trade.asm"


SECTION "bank41", ROMX

INCLUDE "engine/gfx/dma_transfer.asm"
INCLUDE "gfx/emotes.asm"
INCLUDE "engine/overworld/warp_connection.asm"
INCLUDE "engine/battle/used_move_text.asm"


SECTION "Title", ROMX

INCLUDE "engine/movie/title.asm"


SECTION "Standard Text", ROMX

INCLUDE "data/text/std_text.asm"


SECTION "Crystal Phone Text 2", ROMX

INCLUDE "data/phone/text/extra2.asm"


SECTION "Phone Text 2", ROMX

INCLUDE "data/phone/text/jack_overworld.asm"
INCLUDE "data/phone/text/beverly_overworld.asm"
INCLUDE "data/phone/text/huey_overworld.asm"
INCLUDE "data/phone/text/gaven_overworld.asm"
INCLUDE "data/phone/text/beth_overworld.asm"
INCLUDE "data/phone/text/jose_overworld.asm"
INCLUDE "data/phone/text/reena_overworld.asm"
INCLUDE "data/phone/text/joey_overworld.asm"
INCLUDE "data/phone/text/wade_overworld.asm"
INCLUDE "data/phone/text/ralph_overworld.asm"


SECTION "Phone Text 3", ROMX

INCLUDE "data/phone/text/mom.asm"
INCLUDE "data/phone/text/bill.asm"
INCLUDE "data/phone/text/elm.asm"
INCLUDE "data/phone/text/trainers1.asm"
INCLUDE "data/phone/text/liz_overworld.asm"


SECTION "Diploma", ROMX

INCLUDE "engine/events/diploma.asm"


SECTION "Battle Tower Text", ROMX

INCLUDE "data/battle_tower/trainer_text.asm"


SECTION "Unique Wild Moves", ROMX

INCLUDE "engine/battle/unique_wild_moves.asm"


SECTION "Battle Stat Changes", ROMX

INCLUDE "engine/battle/stats.asm"


SECTION "Item Text", ROMX

INCLUDE "data/items/names.asm"
INCLUDE "data/items/key_names.asm"
INCLUDE "data/items/apricorn_names.asm"
INCLUDE "engine/items/print_item_description.asm"


SECTION "Move and Landmark Text", ROMX

INCLUDE "data/moves/names.asm"
INCLUDE "engine/overworld/landmarks.asm"


SECTION "Crystal Events", ROMX

INCLUDE "engine/events/battle_tower/load_trainer.asm"
INCLUDE "engine/events/odd_egg.asm"


SECTION "Type Chart", ROMX

INCLUDE "engine/items/type_chart.asm"


SECTION "VWF", ROMX

INCLUDE "engine/gfx/vwf.asm"
