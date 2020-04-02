NatureNames:
	dw .Hardy,  .Lonely, .Brave,   .Adamant, .Naughty
	dw .Bold,   .Docile, .Relaxed, .Impish,  .Lax
	dw .Timid,  .Hasty,  .Serious, .Jolly,   .Naive
	dw .Modest, .Mild,   .Quiet,   .Bashful, .Rash
	dw .Calm,   .Gentle, .Sassy,   .Careful, .Quirky
	dw .NoNature

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
	dw .HardyInd,  .LonelyInd, .BraveInd,   .AdamantInd, .NaughtyInd
	dw .BoldInd,   .DocileInd, .RelaxedInd, .ImpishInd,  .LaxInd
	dw .TimidInd,  .HastyInd,  .SeriousInd, .JollyInd,   .NaiveInd
	dw .ModestInd, .MildInd,   .QuietInd,   .BashfulInd, .RashInd
	dw .CalmInd,   .GentleInd, .SassyInd,   .CarefulInd, .QuirkyInd
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
