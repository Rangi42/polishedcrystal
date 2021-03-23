NatureNames:
	table_width 2, NatureNames
	dw .Hardy
	dw .Lonely
	dw .Brave
	dw .Adamant
	dw .Naughty
	dw .Bold
	dw .Docile
	dw .Relaxed
	dw .Impish
	dw .Lax
	dw .Timid
	dw .Hasty
	dw .Serious
	dw .Jolly
	dw .Naive
	dw .Modest
	dw .Mild
	dw .Quiet
	dw .Bashful
	dw .Rash
	dw .Calm
	dw .Gentle
	dw .Sassy
	dw .Careful
	dw .Quirky
	dw .NoNature
	assert_table_length NUM_NATURES + 1

.Hardy:    db "Hardy@"
.Lonely:   db "Lonely@"
.Brave:    db "Brave@"
.Adamant:  db "Adamant@"
.Naughty:  db "Naughty@"
.Bold:     db "Bold@"
.Docile:   db "Docile@"
.Relaxed:  db "Relaxed@"
.Impish:   db "Impish@"
.Lax:      db "Lax@"
.Timid:    db "Timid@"
.Hasty:    db "Hasty@"
.Serious:  db "Serious@"
.Jolly:    db "Jolly@"
.Naive:    db "Naive@"
.Modest:   db "Modest@"
.Mild:     db "Mild@"
.Quiet:    db "Quiet@"
.Bashful:  db "Bashful@"
.Rash:     db "Rash@"
.Calm:     db "Calm@"
.Gentle:   db "Gentle@"
.Sassy:    db "Sassy@"
.Careful:  db "Careful@"
.Quirky:   db "Quirky@"
.NoNature: db "---@"

NatureIndicators:
	dw .HardyInd
	dw .LonelyInd
	dw .BraveInd
	dw .AdamantInd
	dw .NaughtyInd
	dw .BoldInd
	dw .DocileInd
	dw .RelaxedInd
	dw .ImpishInd
	dw .LaxInd
	dw .TimidInd
	dw .HastyInd
	dw .SeriousInd
	dw .JollyInd
	dw .NaiveInd
	dw .ModestInd
	dw .MildInd
	dw .QuietInd
	dw .BashfulInd
	dw .RashInd
	dw .CalmInd
	dw .GentleInd
	dw .SassyInd
	dw .CarefulInd
	dw .QuirkyInd
	dw .NoNatureInd

.SassyInd:   db "<NEXT>" ; fallthrough
.RashInd:    db "<NEXT>" ; fallthrough
.ImpishInd:  db "<NEXT>" ; fallthrough
.LonelyInd:  db "↑<NEXT>↓@"
.NaiveInd:   db "<NEXT>" ; fallthrough
.CarefulInd: db "<NEXT>" ; fallthrough
.MildInd:    db "<NEXT>" ; fallthrough
.BoldInd:    db "↓<NEXT>↑@"
.QuietInd:   db "<NEXT>" ; fallthrough
.LaxInd:     db "<NEXT>" ; fallthrough
.AdamantInd: db "↑<NEXT><NEXT>↓@"
.JollyInd:   db "<NEXT>" ; fallthrough
.GentleInd:  db "<NEXT>" ; fallthrough
.ModestInd:  db "↓<NEXT><NEXT>↑@"
.RelaxedInd: db "<NEXT>" ; fallthrough
.NaughtyInd: db "↑<NEXT><NEXT><NEXT>↓@"
.HastyInd:   db "<NEXT>" ; fallthrough
.CalmInd:    db "↓<NEXT><NEXT><NEXT>↑@"
.BraveInd:   db "↑<NEXT><NEXT><NEXT><NEXT>↓@"
.TimidInd:   db "↓<NEXT><NEXT><NEXT><NEXT>↑" ; fallthrough
.HardyInd:
.DocileInd:
.SeriousInd:
.BashfulInd:
.QuirkyInd:
.NoNatureInd: db "@"
