#!/usr/bin/env python3

"""
Convert legacy audio files to modern format

Originally written by dannye for Crystal Tracker
https://github.com/dannye/crystal-tracker/blob/main/tools/upgrade.py
Migrated here to Python 3 (where `count` is a positional parameter of `re.sub`)
"""

import argparse
import os
import re

successes = 0
failures = 0

notes = {
	"__": 0x0,
	"C_": 0x1,
	"C#": 0x2,
	"D_": 0x3,
	"D#": 0x4,
	"E_": 0x5,
	"F_": 0x6,
	"F#": 0x7,
	"G_": 0x8,
	"G#": 0x9,
	"A_": 0xa,
	"A#": 0xb,
	"B_": 0xc,
	"CC": 0xd,
}

channel_count_pattern        = re.compile(r"channel_count\s")
channel_pattern              = re.compile(r"channel\s")
musicheader_pattern          = re.compile(r"musicheader\s")
musicheader_pattern_full     = re.compile(r"musicheader\s+\S*?\s*,\s*\S*?\s*,\s*\S*")
dbw_pattern                  = re.compile(r"dbw\s")
dbw_pattern_full             = re.compile(r"dbw\s+\S*?\s*,\s*\S*")
sound_pattern                = re.compile(r"sound\s")
sound_pattern_full           = re.compile(r"sound\s+\S*?\s*,\s*\S*?\s*,\s*\S*?\s*,\s*\S*")
noise_pattern                = re.compile(r"noise\s")
noise_pattern_full           = re.compile(r"noise\s+\S*?\s*,\s*\S*?\s*,\s*\S*?\s*,\s*\S*")
note_pattern                 = re.compile(r"note\s")
note_pattern_full            = re.compile(r"note\s+\S*?\s*,\s*\S*")
rest_pattern                 = re.compile(r"note\s+__\s*,")
notetype_pattern             = re.compile(r"notetype\s")
notetype_pattern_full        = re.compile(r"notetype\s+\S*?\s*,\s*\S*")
drumspeed_pattern_full       = re.compile(r"notetype\s+\S*")
note_type_pattern            = re.compile(r"note_type\s")
note_type_pattern_short      = re.compile(r"note_type\s+\S*")
note_type_pattern_full       = re.compile(r"note_type\s+\S*?\s*,\s*\S*?\s*,\s*\S*")
pitchoffset_pattern          = re.compile(r"pitchoffset\s")
pitchoffset_pattern_full     = re.compile(r"pitchoffset\s+\S*?\s*,\s*\S*")
dutycycle_pattern            = re.compile(r"dutycycle\s")
intensity_pattern            = re.compile(r"intensity\s")
intensity_pattern_full       = re.compile(r"intensity\s+\S*")
volume_envelope_pattern      = re.compile(r"volume_envelope\s")
volume_envelope_pattern_full = re.compile(r"volume_envelope\s+\S*?\s*,\s*\S*")
soundinput_pattern           = re.compile(r"soundinput\s")
soundinput_pattern_full      = re.compile(r"soundinput\s+\S*")
sound_duty_pattern           = re.compile(r"sound_duty\s")
sound_duty_pattern_short     = re.compile(r"sound_duty\s+\S*")
sound_duty_pattern_full      = re.compile(r"sound_duty\s+\S*?\s*,\s*\S*?\s*,\s*\S*?\s*,\s*\S*")
togglesfx_pattern            = re.compile(r"togglesfx")
slidepitchto_pattern         = re.compile(r"slidepitchto\s")
slidepitchto_pattern_full    = re.compile(r"slidepitchto\s+\S*?\s*,\s*\S*?\s*,\s*\S*")
vibrato_pattern              = re.compile(r"vibrato\s")
vibrato_pattern_full         = re.compile(r"vibrato\s+\S*?\s*,\s*\S*")
togglenoise_pattern          = re.compile(r"togglenoise")
panning_pattern              = re.compile(r"panning\s")
panning_pattern_full         = re.compile(r"panning\s+\S*")
volume_pattern               = re.compile(r"volume\s")
volume_pattern_full          = re.compile(r"volume\s+\S*")
tone_pattern                 = re.compile(r"tone\s")
restartchannel_pattern       = re.compile(r"restartchannel\s")
newsong_pattern              = re.compile(r"newsong\s")
sfxpriorityon_pattern        = re.compile(r"sfxpriorityon")
sfxpriorityoff_pattern       = re.compile(r"sfxpriorityoff")
stereopanning_pattern        = re.compile(r"stereopanning\s")
stereopanning_pattern_full   = re.compile(r"stereopanning\s+\S*")
sfxtogglenoise_pattern       = re.compile(r"sfxtogglenoise")
setcondition_pattern         = re.compile(r"setcondition\s")
jumpif_pattern               = re.compile(r"jumpif\s")
jumpchannel_pattern          = re.compile(r"jumpchannel\s")
loopchannel_pattern          = re.compile(r"loopchannel\s")
callchannel_pattern          = re.compile(r"callchannel\s")
endchannel_pattern           = re.compile(r"endchannel")

def parse_value(s):
	s = s.strip()
	scale = 1
	if s[0] == "-":
		s = s[1:].strip()
		scale = -1
	if s[0] == "$":
		return int(s[1:], 16) * scale
	elif s[0] == "&":
		return int(s[1:], 8) * scale
	elif s[0] == "%":
		return int(s[1:], 2) * scale
	else:
		return int(s, 10) * scale

def upgrade_macro(command, state):
	command_stripped = command.strip()

	# channel_count
	if re.match(channel_count_pattern, command_stripped):
		state["num_channels"] = parse_value(command_stripped[len("channel_count"):])

	# channel
	elif re.match(channel_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 2)
		channel_number = parse_value(macro_args[0][len("channel"):])
		channel_label = macro_args[1].strip()
		if state["num_channels"] > 0:
			state["num_channels"] -= 1
		state["channel_{}_label".format(channel_number)] = channel_label

	# musicheader/channel_count+channel
	elif re.match(musicheader_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 3)
		num_channels = parse_value(macro_args[0][len("musicheader"):])
		channel_number = parse_value(macro_args[1])
		channel_label = macro_args[2].strip()
		command = re.sub(musicheader_pattern_full, "channel {}, {}".format(channel_number, channel_label), command, count=1)
		if state["num_channels"] > 0:
			state["num_channels"] -= 1
		else:
			state["num_channels"] = num_channels - 1
			command = "\tchannel_count {}\n".format(num_channels) + command
		state["channel_{}_label".format(channel_number)] = channel_label

	# dbw/channel_count+channel
	elif re.match(dbw_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 2)
		arg0 = parse_value(macro_args[0][len("dbw"):])
		num_channels = (arg0 >> 6 & 0b11) + 1
		channel_number = (arg0 & 0b11) + 1
		channel_label = macro_args[1].strip()
		command = re.sub(dbw_pattern_full, "channel {}, {}".format(channel_number, channel_label), command, count=1)
		if state["num_channels"] > 0:
			state["num_channels"] -= 1
		else:
			state["num_channels"] = num_channels - 1
			command = "\tchannel_count {}\n".format(num_channels) + command
		state["channel_{}_label".format(channel_number)] = channel_label

	# sound/square_note
	elif re.match(sound_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 4)
		pitch = macro_args[0][len("sound"):].strip()
		length = parse_value(macro_args[1])
		envelope = parse_value(macro_args[2])
		frequency = parse_value(macro_args[3])
		length = ((notes[pitch] if pitch in notes else parse_value(pitch)) << 4) + length - 1
		volume = envelope >> 4
		fade = envelope & 0x0f if envelope & 0x0f <= 8 else (envelope & 0b0111) * -1
		command = re.sub(sound_pattern_full, "square_note {}, {}, {}, {}".format(length, volume, fade, frequency), command, count=1)

	# noise/noise_note
	elif re.match(noise_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 4)
		pitch = macro_args[0][len("noise"):].strip()
		length = parse_value(macro_args[1])
		envelope = parse_value(macro_args[2])
		frequency = parse_value(macro_args[3])
		length = ((notes[pitch] if pitch in notes else parse_value(pitch)) << 4) + length - 1
		volume = envelope >> 4
		fade = envelope & 0x0f if envelope & 0x0f <= 8 else (envelope & 0b0111) * -1
		command = re.sub(noise_pattern_full, "noise_note {}, {}, {}, {}".format(length, volume, fade, frequency), command, count=1)

	# drum_note
	elif state["current_channel"] == 4 and re.match(note_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 2)
		pitch = macro_args[0][len("note"):].strip()
		length = parse_value(macro_args[1])
		if pitch == "__":
			command = re.sub(note_pattern_full, "rest {}".format(length), command, count=1)
		elif pitch in notes:
			command = re.sub(note_pattern_full, "drum_note {}, {}".format(notes[pitch], length), command, count=1)
		else:
			command = re.sub(note_pattern_full, "drum_note {}, {}".format(pitch, length), command, count=1)

	# "note __"/rest
	elif re.match(rest_pattern, command_stripped):
		command = re.sub(rest_pattern, "rest", command, count=1)

	# notetype/note_type+drum_speed
	elif re.match(notetype_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 1 or len(macro_args) == 2)
		if len(macro_args) > 1:
			speed = parse_value(macro_args[0][len("notetype"):])
			envelope = parse_value(macro_args[1])
			volume = envelope >> 4
			if state["current_channel"] == 3:
				fade = envelope & 0x0f
			else:
				fade = envelope & 0x0f if envelope & 0x0f <= 8 else (envelope & 0b0111) * -1
			command = re.sub(notetype_pattern_full, "note_type {}, {}, {}".format(speed, volume, fade), command, count=1)
		else:
			speed = parse_value(macro_args[0][len("notetype"):])
			command = re.sub(drumspeed_pattern_full, "drum_speed {}".format(speed), command, count=1)

	# note_type
	elif re.match(note_type_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 1 or len(macro_args) == 3)
		if len(macro_args) > 1:
			speed = parse_value(macro_args[0][len("note_type"):])
			volume = parse_value(macro_args[1])
			fade = parse_value(macro_args[2])
			if state["current_channel"] == 3 and fade < 0:
				fade = 8 - fade
				command = re.sub(note_type_pattern_full, "note_type {}, {}, {}".format(speed, volume, fade), command, count=1)
			elif state["current_channel"] != 3 and fade > 8:
				fade = (fade & 0b0111) * -1
				command = re.sub(note_type_pattern_full, "note_type {}, {}, {}".format(speed, volume, fade), command, count=1)
		else:
			speed = parse_value(macro_args[0][len("note_type"):])
			command = re.sub(note_type_pattern_short, "drum_speed {}".format(speed), command, count=1)

	# pitchoffset/transpose
	elif re.match(pitchoffset_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 2)
		octaves = parse_value(macro_args[0][len("pitchoffset"):])
		pitches = notes[macro_args[1].strip()] - 1
		command = re.sub(pitchoffset_pattern_full, "transpose {}, {}".format(octaves, pitches), command, count=1)

	# dutycycle/duty_cycle
	elif re.match(dutycycle_pattern, command_stripped):
		command = re.sub(dutycycle_pattern, "duty_cycle ", command, count=1)

	# intensity/volume_envelope
	elif re.match(intensity_pattern, command_stripped):
		envelope = parse_value(command_stripped[len("intensity"):])
		volume = envelope >> 4
		if state["current_channel"] == 3:
			fade = envelope & 0x0f
		else:
			fade = envelope & 0x0f if envelope & 0x0f <= 8 else (envelope & 0b0111) * -1
		command = re.sub(intensity_pattern_full, "volume_envelope {}, {}".format(volume, fade), command, count=1)

	# volume_envelope
	elif re.match(volume_envelope_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 2)
		volume = parse_value(macro_args[0][len("volume_envelope"):])
		fade = parse_value(macro_args[1])
		if state["current_channel"] == 3 and fade < 0:
			fade = 8 - fade
			command = re.sub(volume_envelope_pattern_full, "volume_envelope {}, {}".format(volume, fade), command, count=1)
		elif state["current_channel"] != 3 and fade > 8:
			fade = (fade & 0b0111) * -1
			command = re.sub(volume_envelope_pattern_full, "volume_envelope {}, {}".format(volume, fade), command, count=1)

	# soundinput/pitch_sweep
	elif re.match(soundinput_pattern, command_stripped):
		soundinput = parse_value(command_stripped[len("soundinput"):])
		duration = soundinput >> 4
		sweep = soundinput & 0x0f if soundinput & 0x0f <= 8 else (soundinput & 0b0111) * -1
		command = re.sub(soundinput_pattern_full, "pitch_sweep {}, {}".format(duration, sweep), command, count=1)

	# sound_duty/duty_cycle_pattern
	elif re.match(sound_duty_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 1 or len(macro_args) == 4)
		if len(macro_args) > 1:
			duty1 = parse_value(macro_args[0][len("sound_duty"):])
			duty2 = parse_value(macro_args[1])
			duty3 = parse_value(macro_args[2])
			duty4 = parse_value(macro_args[3])
			command = re.sub(sound_duty_pattern_full, "duty_cycle_pattern {}, {}, {}, {}".format(duty4, duty3, duty2, duty1), command, count=1)
		else:
			duty_cycle_pattern = parse_value(macro_args[0][len("sound_duty"):])
			duty1 = duty_cycle_pattern >> 6 & 0b11
			duty2 = duty_cycle_pattern >> 4 & 0b11
			duty3 = duty_cycle_pattern >> 2 & 0b11
			duty4 = duty_cycle_pattern >> 0 & 0b11
			command = re.sub(sound_duty_pattern_short, "duty_cycle_pattern {}, {}, {}, {}".format(duty4, duty3, duty2, duty1), command, count=1)

	# togglesfx/toggle_sfx
	elif re.match(togglesfx_pattern, command_stripped):
		command = re.sub(togglesfx_pattern, "toggle_sfx", command, count=1)

	# slidepitchto/pitch_slide
	elif re.match(slidepitchto_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		assert(len(macro_args) == 3)
		duration = parse_value(macro_args[0][len("slidepitchto"):])
		octave = 8 - parse_value(macro_args[1])
		pitch = "B_" if macro_args[2].strip() == "__" else macro_args[2].strip()
		command = re.sub(slidepitchto_pattern_full, "pitch_slide {}, {}, {}".format(duration, octave, pitch), command, count=1)

	# vibrato
	elif re.match(vibrato_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		if len(macro_args) == 2:
			delay = parse_value(macro_args[0][len("vibrato"):])
			extent = parse_value(macro_args[1])
			depth = extent >> 4
			rate = extent & 0x0f
			command = re.sub(vibrato_pattern_full, "vibrato {}, {}, {}".format(delay, depth, rate), command, count=1)

	# togglenoise/toggle_noise
	elif re.match(togglenoise_pattern, command_stripped):
		command = re.sub(togglenoise_pattern, "toggle_noise", command, count=1)

	# panning/force_stereo_panning
	elif re.match(panning_pattern, command_stripped):
		panning = parse_value(command_stripped[len("panning"):])
		left = "TRUE" if panning >> 4 else "FALSE"
		right = "TRUE" if panning & 0x0f else "FALSE"
		command = re.sub(panning_pattern_full, "force_stereo_panning {}, {}".format(left, right), command, count=1)

	# volume
	elif re.match(volume_pattern, command_stripped):
		macro_args = command_stripped.split(",")
		if len(macro_args) == 1:
			volume = parse_value(macro_args[0][len("volume"):])
			left = volume >> 4
			right = volume & 0x0f
			command = re.sub(volume_pattern_full, "volume {}, {}".format(left, right), command, count=1)

	# tone/pitch_offset
	elif re.match(tone_pattern, command_stripped):
		command = re.sub(tone_pattern, "pitch_offset ", command, count=1)

	# restartchannel/restart_channel
	elif re.match(restartchannel_pattern, command_stripped):
		command = re.sub(restartchannel_pattern, "restart_channel ", command, count=1)

	# newsong/new_song
	elif re.match(newsong_pattern, command_stripped):
		command = re.sub(newsong_pattern, "new_song ", command, count=1)

	# sfxpriorityon/sfx_priority_on
	elif re.match(sfxpriorityon_pattern, command_stripped):
		command = re.sub(sfxpriorityon_pattern, "sfx_priority_on", command, count=1)

	# sfxpriorityoff/sfx_priority_off
	elif re.match(sfxpriorityoff_pattern, command_stripped):
		command = re.sub(sfxpriorityoff_pattern, "sfx_priority_off", command, count=1)

	# stereopanning/stereo_panning
	elif re.match(stereopanning_pattern, command_stripped):
		panning = parse_value(command_stripped[len("stereopanning"):])
		left = "TRUE" if panning >> 4 else "FALSE"
		right = "TRUE" if panning & 0x0f else "FALSE"
		command = re.sub(stereopanning_pattern_full, "stereo_panning {}, {}".format(left, right), command, count=1)

	# sfxtogglenoise/sfx_toggle_noise
	elif re.match(sfxtogglenoise_pattern, command_stripped):
		command = re.sub(sfxtogglenoise_pattern, "sfx_toggle_noise", command, count=1)

	# setcondition/set_condition
	elif re.match(setcondition_pattern, command_stripped):
		command = re.sub(setcondition_pattern, "set_condition ", command, count=1)

	# jumpif/sound_jump_if
	elif re.match(jumpif_pattern, command_stripped):
		command = re.sub(jumpif_pattern, "sound_jump_if ", command, count=1)

	# jumpchannel/sound_jump
	elif re.match(jumpchannel_pattern, command_stripped):
		command = re.sub(jumpchannel_pattern, "sound_jump ", command, count=1)

	# loopchannel/sound_loop
	elif re.match(loopchannel_pattern, command_stripped):
		command = re.sub(loopchannel_pattern, "sound_loop ", command, count=1)

	# callchannel/sound_call
	elif re.match(callchannel_pattern, command_stripped):
		command = re.sub(callchannel_pattern, "sound_call ", command, count=1)

	# endchannel/sound_ret
	elif re.match(endchannel_pattern, command_stripped):
		command = re.sub(endchannel_pattern, "sound_ret", command, count=1)

	return command

def upgrade_file(file_path):
	global successes
	global failures
	if args.verbose:
		print("Upgrading {}...".format(file_path), end="")

	state = {
		"num_channels": 0,
		"channel_1_label": None,
		"channel_2_label": None,
		"channel_3_label": None,
		"channel_4_label": None,
		"current_channel": None,
	}

	try:
		lines = []
		with open(file_path, "r") as f:
			lines = f.readlines()

		new_lines = []
		for line in lines:
			command = line
			comment = None
			if ";" in line:
				command, comment  = line.split(";", 1)

			for i in range(4):
				if state["channel_{}_label".format(i + 1)] is not None and line.startswith(state["channel_{}_label".format(i + 1)] + ":"):
					state["current_channel"] = i + 1

			if len(command.strip()) and command[0] in "\t ":
				command = upgrade_macro(command, state)

			new_line = command
			if comment is not None:
				new_line += ";" + comment
			new_lines.append(new_line)

		with open(file_path, "w") as f:
			f.writelines(new_lines)
	except:
		failures += 1
		if args.verbose:
			print("failed")
		if args.strict:
			raise
		return

	successes += 1
	if args.verbose:
		print("done")

def upgrade_files(files, root=None):
	for file in files:
		file_path = os.path.join(root, file) if root else file
		if file_path.endswith(".asm"):
			upgrade_file(file_path)
		elif args.verbose:
			print("Skipping file: {}".format(file_path))

if __name__ == "__main__":
	ap = argparse.ArgumentParser(description="Pokemon GSC Audio File Upgrade Script")
	ap.add_argument("-s", "--strict", action="store_true", help="abort on first error")
	ap.add_argument("-v", "--verbose", action="store_true", help="verbose output")
	ap.add_argument("paths", nargs="+", help="files and directories to upgrade")
	args = ap.parse_args()
	for path in args.paths:
		if os.path.isdir(path):
			for root, dirs, files in os.walk(path):
				upgrade_files(files, root)
		else:
			upgrade_files([path])
	if args.verbose:
		print("{} processed ({} succeeded, {} failed)".format(successes + failures, successes, failures))
