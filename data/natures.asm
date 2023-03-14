NatureNames:
	table_width 1, NatureNames
	dr .Hardy
	dr .Lonely
	dr .Brave
	dr .Adamant
	dr .Naughty
	dr .Bold
	dr .Docile
	dr .Relaxed
	dr .Impish
	dr .Lax
	dr .Timid
	dr .Hasty
	dr .Serious
	dr .Jolly
	dr .Naive
	dr .Modest
	dr .Mild
	dr .Quiet
	dr .Bashful
	dr .Rash
	dr .Calm
	dr .Gentle
	dr .Sassy
	dr .Careful
	dr .Quirky
	dr .NoNature
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
	table_width 1, NatureIndicators
	dr .HardyInd
	dr .LonelyInd
	dr .BraveInd
	dr .AdamantInd
	dr .NaughtyInd
	dr .BoldInd
	dr .DocileInd
	dr .RelaxedInd
	dr .ImpishInd
	dr .LaxInd
	dr .TimidInd
	dr .HastyInd
	dr .SeriousInd
	dr .JollyInd
	dr .NaiveInd
	dr .ModestInd
	dr .MildInd
	dr .QuietInd
	dr .BashfulInd
	dr .RashInd
	dr .CalmInd
	dr .GentleInd
	dr .SassyInd
	dr .CarefulInd
	dr .QuirkyInd
	dr .NoNatureInd
	assert_table_length NUM_NATURES + 1

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
