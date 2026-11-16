Music_Printer:
	channel_count 1
	channel 3, Music_Printer_Ch3

Music_Printer_Ch3:
	tempo 256
	note_type 12, 2, 0
	octave 4
	note B_, 6
	octave 5
	note C#, 1
	rest 1
	octave 4
	note B_, 6
	octave 5
	note C#, 1
	rest 1
	octave 4
	note B_, 1
	rest 1
	octave 5
	note E_, 1
	rest 1
	note D#, 1
	rest 1
	note C#, 1
	rest 1
	octave 4
	note B_, 1
	rest 1
	note A_, 1
	rest 1
	note G#, 1
	rest 1
	note F#, 1
	rest 1
.mainloop:
	sound_call Music_Printer_Ch3_ditty2
	sound_call Music_Printer_Ch3_ditty2
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	note F#, 1
	rest 1
	octave 5
	note C#, 1
	note C_, 1
	note C#, 1
	rest 1
	octave 4
	note F#, 1
	rest 1
	note E_, 1
	rest 1
	note G#, 1
	rest 1
	note E_, 1
	rest 1
	note G#, 1
	rest 1
	note E_, 1
	rest 1
	octave 5
	note E_, 1
	note D#, 1
	note E_, 1
	rest 1
	octave 4
	note D#, 1
	rest 1
	sound_call Music_Printer_Ch3_ditty2
	sound_call Music_Printer_Ch3_ditty2
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	note B_, 1
	rest 1
	note A_, 1
	rest 1
	note G#, 1
	rest 1
	note F#, 1
	rest 1
	note E_, 1
	rest 1
	note B_, 1
	rest 1
	note E_, 1
	rest 1
	note B_, 1
	rest 1
	note E_, 1
	sound_call Music_Printer_Ch3_ditty1
	note C#, 1
	rest 1
	note A_, 1
	rest 1
	note B_, 1
	note A#, 1
	note B_, 1
	rest 1
	note E_, 1
	rest 1
	note F#, 1
	rest 1
	note G#, 1
	sound_call Music_Printer_Ch3_ditty1
	note F#, 1
	rest 1
	note D#, 1
	rest 1
	note B_, 1
	rest 1
	note B_, 1
	rest 1
	note A_, 1
	rest 1
	note A_, 1
	rest 1
	note G#, 1
	rest 1
	octave 3
	note B_, 1
	rest 1
	octave 4
	note C#, 1
	rest 1
	note D#, 1
	rest 1
	sound_jump .mainloop

Music_Printer_Ch3_ditty1:
	rest 1
	octave 3
	note B_, 1
	rest 1
	octave 4
	note C#, 1
	rest 1
	note D_, 1
	rest 1
	note D#, 1
	rest 1
	note F#, 1
	rest 1
	octave 3
	note B_, 1
	rest 1
	octave 4
	note F#, 1
	rest 1
	note D#, 1
	rest 1
	note F#, 1
	rest 1
	octave 3
	note B_, 1
	rest 1
	octave 4
	note F#, 1
	rest 1
	note E_, 1
	rest 1
	note G#, 1
	rest 1
	octave 3
	note B_, 1
	rest 1
	octave 4
	note G#, 1
	rest 1
	note E_, 1
	rest 1
	note G#, 1
	rest 1
	octave 3
	note B_, 1
	rest 1
	octave 4
	note G#, 1
	rest 1
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	note C#, 1
	rest 1
	note A_, 1
	rest 1
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	sound_ret

Music_Printer_Ch3_ditty2:
	note E_, 1
	rest 1
	note B_, 1
	rest 1
	note E_, 1
	rest 1
	note B_, 1
	rest 1
	note E_, 1
	rest 1
	note B_, 1
	rest 1
	note E_, 1
	rest 1
	note B_, 1
	rest 1
	sound_ret
