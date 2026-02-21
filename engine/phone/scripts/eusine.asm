EusinePhoneScript1:
; Player calls Eusine
	checkevent EVENT_EUSINE_SAW_HO_OH
	iftruefwd .PostHoOh
	checkevent EVENT_FOUGHT_SUICUNE
	iftruefwd .PostSuicune
	; Before Suicune battle (shouldn't normally happen)
	farwritetext EusinePhonePreSuicuneText
	end

.PostSuicune:
	farwritetext EusinePhonePostSuicuneText
	end

.PostHoOh:
	farwritetext EusinePhonePostHoOhText
	end

EusinePhoneScript2:
; Eusine calls the player (Ho-Oh special call)
	farwritetext EusinePhoneHoOhCallerText
	setevent EVENT_EUSINE_SAW_HO_OH
	clearevent EVENT_EUSINES_HOUSE_EUSINE
	specialphonecall SPECIALCALL_NONE
	end
