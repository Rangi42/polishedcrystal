SECTION "bank1", ROMX

INCLUDE "engine/init.asm"
INCLUDE "engine/gfx/load_push_oam.asm"
INCLUDE "engine/overworld/map_objects.asm"
INCLUDE "engine/menus/intro_menu.asm"
INCLUDE "engine/overworld/init_map.asm"
INCLUDE "engine/menus/init_options.asm"
INCLUDE "engine/pokemon/learn.asm"
INCLUDE "data/items/attributes.asm"
INCLUDE "engine/overworld/npc_movement.asm"
INCLUDE "engine/events/happiness_egg.asm"
INCLUDE "engine/events/shiny_ditto.asm"
INCLUDE "engine/events/shuckle.asm"
INCLUDE "engine/events/bills_grandfather.asm"
INCLUDE "engine/events/hidden_power_guru.asm"
INCLUDE "engine/events/mint_tea.asm"
INCLUDE "engine/events/haircut_etc.asm"


SECTION "bank2", ROMX

INCLUDE "engine/overworld/player_object.asm"
INCLUDE "data/predef_pointers.asm"
INCLUDE "engine/gfx/color.asm"


SECTION "bank3", ROMX

INCLUDE "engine/events/checktime.asm"
INCLUDE "engine/events/specials.asm"
INCLUDE "engine/pokemon/health.asm"
INCLUDE "engine/events/overworld.asm"
INCLUDE "engine/events/overcast.asm"
INCLUDE "engine/items/items.asm"
INCLUDE "engine/battle/anim_hp_bar.asm"
INCLUDE "engine/pokemon/move_mon.asm"
INCLUDE "engine/pokemon/breedmon_level_growth.asm"
INCLUDE "engine/events/bug_contest/caught_mon.asm"
INCLUDE "engine/events/bug_contest/display_stats.asm"
INCLUDE "engine/items/item_effects.asm"


SECTION "Print Number", ROMX

INCLUDE "engine/math/print_num.asm"


SECTION "Bill's PC", ROMX

INCLUDE "engine/pc/bills_pc.asm"
INCLUDE "engine/pc/bills_pc_ui.asm"


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


SECTION "Psychic Inver", ROMX

INCLUDE "engine/battle/pick_psychic_inver_party.asm"


SECTION "Battle Core", ROMX

INCLUDE "engine/battle/core.asm"
INCLUDE "engine/battle/evolve_battle.asm"


SECTION "Battle Endturn", ROMX

INCLUDE "engine/battle/endturn.asm"


SECTION "Math", ROMX

INCLUDE "engine/math/math.asm"


SECTION "Pokedex", ROMX

INCLUDE "engine/pokedex/area.asm"
INCLUDE "engine/pokedex/lcd.asm"
INCLUDE "engine/pokedex/pokedex.asm"
INCLUDE "engine/pokedex/unown_dex.asm"


SECTION "Pokédex Footprints", ROMX

INCLUDE "data/pokemon/footprint_pointers.asm"
INCLUDE "gfx/pokemon/footprints.asm"


SECTION "Pokedex Shapes", ROMX

INCLUDE "gfx/shapes.asm"


SECTION "Moves", ROMX

INCLUDE "data/moves/moves.asm"


SECTION "Evolution", ROMX

INCLUDE "engine/pokemon/evolve.asm"


SECTION "bank11", ROMX

INCLUDE "engine/battle/ai/move.asm"
INCLUDE "engine/pokemon/mail.asm"
INCLUDE "engine/events/hidden_grottoes.asm"
INCLUDE "data/pokemon/dex_entry_pointers.asm"


SECTION "Crystal Features 1", ROMX

INCLUDE "engine/events/move_tutor.asm"
INCLUDE "engine/events/celebi.asm"
INCLUDE "engine/menus/main_menu.asm"
INCLUDE "engine/pokemon/search.asm"
INCLUDE "engine/events/buena_menu.asm"


SECTION "Special Palettes", ROMX

INCLUDE "engine/tilesets/tileset_palettes.asm"


SECTION "Collision Permissions", ROMX

INCLUDE "data/collision/collision_permissions.asm"


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
INCLUDE "engine/pokemon/summary_screen.asm"
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
INCLUDE "engine/events/sweet_honey.asm"


SECTION "bank14", ROMX

INCLUDE "engine/pokemon/party_menu.asm"
INCLUDE "engine/pokemon/tempmon.asm"
INCLUDE "engine/pokemon/types.asm"
INCLUDE "engine/pokemon/mon_stats.asm"
INCLUDE "engine/pokemon/experience.asm"
INCLUDE "engine/pokemon/switchpartymons.asm"
INCLUDE "engine/pokemon/natures.asm"
INCLUDE "engine/gfx/load_pics.asm"
INCLUDE "engine/gfx/load_font.asm"


SECTION "Base Data", ROMX

INCLUDE "data/pokemon/base_stats.asm"


SECTION "Crystal Phone Text", ROMX

INCLUDE "data/phone/text/irwin_caller.asm"
INCLUDE "data/phone/text/arnie_caller.asm"
INCLUDE "data/phone/text/alan_caller.asm"
INCLUDE "data/phone/text/dana_caller.asm"
INCLUDE "data/phone/text/chad_caller.asm"
INCLUDE "data/phone/text/derek_caller.asm"
INCLUDE "data/phone/text/tully_caller.asm"
INCLUDE "data/phone/text/brent_caller.asm"
INCLUDE "data/phone/text/tiffany_caller.asm"
INCLUDE "data/phone/text/vance_caller.asm"
INCLUDE "data/phone/text/wilton_caller.asm"
INCLUDE "data/phone/text/kenji_caller.asm"
INCLUDE "data/phone/text/parry_caller.asm"
INCLUDE "data/phone/text/erin_caller.asm"
INCLUDE "data/phone/text/lyra.asm"


SECTION "bank20", ROMX

INCLUDE "engine/overworld/player_movement.asm"
INCLUDE "engine/events/engine_flags.asm"
INCLUDE "engine/overworld/variables.asm"
INCLUDE "data/text/battle.asm"
INCLUDE "engine/battle/final_text.asm"
INCLUDE "engine/battle/abilities.asm"
INCLUDE "engine/battle/text.asm"


SECTION "bank21", ROMX

INCLUDE "engine/events/halloffame.asm"
INCLUDE "engine/gfx/copy_tilemap_at_once.asm"
INCLUDE "engine/pokemon/abilities.asm"


SECTION "Crystal Features 2", ROMX

INCLUDE "engine/events/kurt.asm"
INCLUDE "engine/gfx/player_gfx.asm"
INCLUDE "engine/events/unown_walls.asm"
INCLUDE "engine/events/buena.asm"
INCLUDE "engine/events/battle_tower/battle_tower.asm"
INCLUDE "engine/events/battle_tower/trainer_text.asm"
INCLUDE "engine/events/item_maniacs.asm"


SECTION "bank23", ROMX

INCLUDE "engine/tilesets/timeofday_pals.asm"
INCLUDE "engine/battle/battle_transition.asm"
INCLUDE "engine/events/field_moves.asm"
INCLUDE "engine/events/magnet_train.asm"
; The three files below assume they're within the same bank.
INCLUDE "engine/gfx/sprites.asm"
INCLUDE "engine/gfx/mon_icons.asm"
INCLUDE "data/pokemon/mini_icon_pointers.asm"


SECTION "bank24", ROMX

INCLUDE "engine/phone/phone.asm"
INCLUDE "engine/rtc/timeset.asm"
INCLUDE "engine/pokegear/phone.asm"
INCLUDE "engine/pokegear/pokegear.asm"
INCLUDE "engine/events/fish.asm"
INCLUDE "engine/games/slot_machine.asm"


SECTION "Phone Scripts", ROMX

INCLUDE "engine/phone/scripts/generic_caller.asm"
INCLUDE "engine/phone/scripts/jack_gossip.asm"
INCLUDE "engine/phone/scripts/liz_gossip.asm"
INCLUDE "engine/phone/scripts/chad_gossip.asm"
INCLUDE "engine/phone/scripts/brent_gossip.asm"
INCLUDE "engine/phone/scripts/irwin_gossip.asm"
INCLUDE "engine/phone/scripts/hangups.asm"
INCLUDE "engine/phone/scripts/reminders.asm"
INCLUDE "engine/phone/scripts/hangups_2.asm"
INCLUDE "engine/phone/scripts/reminders_2.asm"
INCLUDE "engine/phone/scripts/bike_shop.asm"
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
INCLUDE "engine/phone/scripts/unused.asm"
INCLUDE "engine/phone/scripts/mom.asm"
INCLUDE "engine/phone/scripts/bill.asm"
INCLUDE "engine/phone/scripts/jack.asm"
INCLUDE "engine/phone/scripts/beverly.asm"
INCLUDE "engine/phone/scripts/huey.asm"
INCLUDE "engine/phone/scripts/gaven.asm"
INCLUDE "engine/phone/scripts/beth.asm"
INCLUDE "engine/phone/scripts/jose.asm"
INCLUDE "engine/phone/scripts/reena.asm"
INCLUDE "engine/phone/scripts/joey.asm"
INCLUDE "engine/phone/scripts/wade.asm"
INCLUDE "engine/phone/scripts/ralph.asm"
INCLUDE "engine/phone/scripts/liz.asm"
INCLUDE "engine/phone/scripts/anthony.asm"
INCLUDE "engine/phone/scripts/todd.asm"
INCLUDE "engine/phone/scripts/gina.asm"
INCLUDE "engine/phone/scripts/irwin.asm"
INCLUDE "engine/phone/scripts/arnie.asm"
INCLUDE "engine/phone/scripts/alan.asm"
INCLUDE "engine/phone/scripts/dana.asm"
INCLUDE "engine/phone/scripts/chad.asm"
INCLUDE "engine/phone/scripts/derek.asm"
INCLUDE "engine/phone/scripts/tully.asm"
INCLUDE "engine/phone/scripts/brent.asm"
INCLUDE "engine/phone/scripts/tiffany.asm"
INCLUDE "engine/phone/scripts/vance.asm"
INCLUDE "engine/phone/scripts/wilton.asm"
INCLUDE "engine/phone/scripts/kenji.asm"
INCLUDE "engine/phone/scripts/parry.asm"
INCLUDE "engine/phone/scripts/erin.asm"
INCLUDE "engine/phone/scripts/generic_callee.asm"


SECTION "Evolution Phone Scripts", ROMX

INCLUDE "engine/phone/scripts/elm.asm"
INCLUDE "engine/phone/scripts/lyra.asm"


SECTION "bank32", ROMX

INCLUDE "engine/battle_anims/bg_effects.asm"


SECTION "Battle Animation Pointers", ROMX

INCLUDE "data/moves/animation_pointers.asm"


SECTION "Battle Animations", ROMX

INCLUDE "data/moves/animations.asm"


SECTION "Sine", ROMX

INCLUDE "engine/math/sine.asm"


SECTION "Move Animations", ROMX

INCLUDE "engine/battle_anims/anim_commands.asm"
INCLUDE "engine/battle_anims/core.asm"
INCLUDE "data/battle_anims/objects.asm"
INCLUDE "engine/battle_anims/helpers.asm"
INCLUDE "data/battle_anims/framesets.asm"
INCLUDE "data/battle_anims/oam.asm"
INCLUDE "data/battle_anims/object_gfx.asm"


SECTION "Move Animation Functions", ROMX

INCLUDE "engine/battle_anims/functions.asm"


SECTION "Pic Animations", ROMX

INCLUDE "engine/gfx/pic_animation.asm"
INCLUDE "gfx/pokemon/anim_pointers.asm"
INCLUDE "gfx/pokemon/anims.asm"
INCLUDE "gfx/pokemon/extra_pointers.asm"
INCLUDE "gfx/pokemon/extras.asm"


SECTION "Pic Animations Bitmasks", ROMX

INCLUDE "gfx/pokemon/bitmask_pointers.asm"
INCLUDE "gfx/pokemon/bitmasks.asm"


SECTION "bank38", ROMX

INCLUDE "engine/games/card_flip.asm"
INCLUDE "engine/games/unown_puzzle.asm"
;INCLUDE "engine/games/memory_game.asm"
INCLUDE "engine/gfx/fade.asm"


SECTION "bank39", ROMX

INCLUDE "engine/menus/options_menu.asm"
INCLUDE "engine/movie/splash.asm"
INCLUDE "engine/movie/intro.asm"


SECTION "bank3E", ROMX

INCLUDE "engine/events/name_rater.asm"
INCLUDE "engine/events/play_slow_cry.asm"
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
INCLUDE "engine/overworld/warp_connection.asm"
INCLUDE "engine/battle/used_move_text.asm"


SECTION "Title", ROMX

INCLUDE "engine/movie/title.asm"


SECTION "Standard Text", ROMX

INCLUDE "data/text/std_text.asm"


SECTION "Crystal Phone Text 2", ROMX

INCLUDE "data/phone/text/bike_shop.asm"
INCLUDE "data/phone/text/jack_caller.asm"
INCLUDE "data/phone/text/beverly_caller.asm"
INCLUDE "data/phone/text/huey_caller.asm"
INCLUDE "data/phone/text/gaven_caller.asm"
INCLUDE "data/phone/text/beth_caller.asm"
INCLUDE "data/phone/text/jose_caller.asm"
INCLUDE "data/phone/text/reena_caller.asm"
INCLUDE "data/phone/text/joey_caller.asm"
INCLUDE "data/phone/text/wade_caller.asm"
INCLUDE "data/phone/text/ralph_caller.asm"
INCLUDE "data/phone/text/liz_caller.asm"
INCLUDE "data/phone/text/anthony_caller.asm"
INCLUDE "data/phone/text/todd_caller.asm"
INCLUDE "data/phone/text/gina_caller.asm"


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
INCLUDE "data/phone/text/jack_callee.asm"
INCLUDE "data/phone/text/beverly_callee.asm"
INCLUDE "data/phone/text/huey_callee.asm"
INCLUDE "data/phone/text/unknown_callee.asm"
INCLUDE "data/phone/text/gaven_callee.asm"
INCLUDE "data/phone/text/beth_callee.asm"
INCLUDE "data/phone/text/jose_callee.asm"
INCLUDE "data/phone/text/reena_callee.asm"
INCLUDE "data/phone/text/joey_callee.asm"
INCLUDE "data/phone/text/wade_callee.asm"
INCLUDE "data/phone/text/ralph_callee.asm"
INCLUDE "data/phone/text/liz_callee.asm"
INCLUDE "data/phone/text/anthony_callee.asm"
INCLUDE "data/phone/text/todd_callee.asm"
INCLUDE "data/phone/text/gina_callee.asm"
INCLUDE "data/phone/text/irwin_callee.asm"
INCLUDE "data/phone/text/arnie_callee.asm"
INCLUDE "data/phone/text/alan_callee.asm"
INCLUDE "data/phone/text/dana_callee.asm"
INCLUDE "data/phone/text/chad_callee.asm"
INCLUDE "data/phone/text/derek_callee.asm"
INCLUDE "data/phone/text/tully_callee.asm"
INCLUDE "data/phone/text/brent_callee.asm"
INCLUDE "data/phone/text/tiffany_callee.asm"
INCLUDE "data/phone/text/vance_callee.asm"
INCLUDE "data/phone/text/wilton_callee.asm"
INCLUDE "data/phone/text/kenji_callee.asm"
INCLUDE "data/phone/text/parry_callee.asm"
INCLUDE "data/phone/text/erin_callee.asm"
INCLUDE "data/phone/text/unused.asm"
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
INCLUDE "data/items/special_names.asm"
INCLUDE "data/items/apricorn_names.asm"
INCLUDE "engine/items/print_item_description.asm"


SECTION "Pokemon Body Data", ROMX

INCLUDE "data/pokemon/body_data.asm"


SECTION "Pokemon Names", ROMX

INCLUDE "data/pokemon/names.asm"


SECTION "Badge Names", ROMX

INCLUDE "data/events/badge_names.asm"


SECTION "Move Names", ROMX

INCLUDE "data/moves/names.asm"


SECTION "Crystal Events", ROMX

INCLUDE "engine/events/battle_tower/load_trainer.asm"
INCLUDE "engine/events/odd_egg.asm"


SECTION "Painting Pic Pointers", ROMX

INCLUDE "data/events/paintings/pic_pointers.asm"


SECTION "Type Chart", ROMX

INCLUDE "engine/items/type_chart.asm"


SECTION "VWF", ROMX

INCLUDE "engine/gfx/vwf.asm"


SECTION "Dynamic Pals System", ROMX

INCLUDE "engine/gfx/sprite_palettes.asm"
INCLUDE "engine/gfx/dynamic_pals.asm"


SECTION "Weather System", ROMX

INCLUDE "engine/overworld/weather.asm"
INCLUDE "engine/events/weather.asm"


SECTION "Exp Candy Names", ROMX

INCLUDE "data/items/exp_candy_names.asm"


SECTION "GB Printer", ROMX

INCLUDE "engine/printer/printer.asm"
INCLUDE "engine/printer/printer_serial.asm"
INCLUDE "audio/music/printer.asm"


SECTION "LureMenu", ROMX

INCLUDE "engine/menus/lure_menu.asm"
