/datum/emote/living/carbon/human
	mob_type_allowed_typecache = list(/mob/living/carbon/human)

/datum/emote/living/carbon/human/cry
	key = "cry"
	key_third_person = "cries"
	message = "cries."
	emote_type = EMOTE_AUDIBLE

/mob/living/carbon/human/verb/emote_cry()
	set name = "Cry"
	set category = "Noises"

	emote("cry", intentional = TRUE)

/datum/emote/living/carbon/human/cry/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.silent || !C.can_speak())
			message = "makes a noise. Tears stream down their face."


/datum/emote/living/carbon/human/sexmoanlight
	key = "sexmoanlight"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE

/datum/emote/living/carbon/human/sexmoanlight/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.silent || !C.can_speak())
			message = "makes a noise."

/datum/emote/living/carbon/human/sexmoanhvy
	key = "sexmoanhvy"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE

/datum/emote/living/carbon/human/sexmoanhvy/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.silent || !C.can_speak())
			message = "makes a noise."

/datum/emote/living/carbon/human/eyebrow
	key = "eyebrow"
	message = "raises an eyebrow."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_eyebrow()
	set name = "Raise Eyebrow"
	set category = "Emotes"

	emote("eyebrow", intentional = TRUE)

/datum/emote/living/carbon/human/psst
	key = "psst"
	key_third_person = "pssts"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE

/mob/living/carbon/human/verb/emote_psst()
	set name = "Psst"
	set category = "Noises"

	emote("psst", intentional = TRUE)

/datum/emote/living/carbon/human/grumble
	key = "grumble"
	key_third_person = "grumbles"
	message = "grumbles."
	message_muffled = "makes a grumbling noise."
	emote_type = EMOTE_AUDIBLE

/mob/living/carbon/human/verb/emote_grumble()
	set name = "Grumble"
	set category = "Noises"

	emote("grumble", intentional = TRUE)

/datum/emote/living/carbon/human/handshake
	key = "handshake"
	message = "shakes their own hands."
	message_param = "shakes hands with %t."
	restraint_check = TRUE
	emote_type = EMOTE_AUDIBLE


/datum/emote/living/carbon/human/mumble
	key = "mumble"
	key_third_person = "mumbles"
	message = "mumbles."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/pale
	key = "pale"
	message = "goes pale for a second."

/datum/emote/living/carbon/human/raise
	key = "raise"
	key_third_person = "raises"
	message = "raises a hand."
	restraint_check = TRUE

/datum/emote/living/carbon/human/salute
	key = "salute"
	key_third_person = "salutes"
	message = "salutes."
	message_param = "salutes to %t."
	restraint_check = TRUE

/datum/emote/living/carbon/human/shrug
	key = "shrug"
	key_third_person = "shrugs"
	message = "shrugs."

/datum/emote/living/carbon/human/wag
	key = "wag"

/datum/emote/living/carbon/human/wag/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = user
	if(!H.dna.species.is_wagging_tail(H))
		H.visible_message(span_biginfo("<span style='color:#[H.voice_color];text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'><b>[H]</b></span><span style='color: #c9c1ba;text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'> wags [H.p_their()] tail.</span>"), runechat_message = "wags [H.p_their()] tail")
		H.dna.species.start_wagging_tail(H)
	else
		H.visible_message(span_biginfo("<span style='color:#[H.voice_color];text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'><b>[H]</b></span></span><span style='color: #c9c1ba;text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'> stops wagging [H.p_their()] tail.</span>"), runechat_message = "stops wagging [H.p_their()] tail")
		H.dna.species.stop_wagging_tail(H)

/datum/emote/living/carbon/human/wag/can_run_emote(mob/user, status_check = TRUE , intentional)
	if(!..())
		return FALSE
	var/mob/living/carbon/human/H = user
	return H.dna && H.dna.species && H.dna.species.can_wag_tail(user)

/datum/emote/living/carbon/human/wag/select_message_type(mob/user, intentional)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(H.dna.species.is_wagging_tail(H))
		. = null

/datum/emote/living/carbon/human/wing
	key = "wing"
	key_third_person = "wings"
	message = "flaps their wings."

/mob/living/carbon/human/proc/OpenWings()
	return

/mob/living/carbon/human/proc/CloseWings()
	return

// FEEL EMOTE VERB
/mob/living/carbon/human/verb/emote_feel()
	set name = "Feel (Desire/Dread)"
	set category = "Emotes"

	var/list/options = list("Desire", "Dread")
	var/choice = input(src, "What feeling do you want to express?", "Feel") as null|anything in options
	if(!choice) return

	var/list/degrees = list("mild", "moderate", "strong")
	var/degree = input(src, "Select degree:", "Degree") as null|anything in degrees
	if(!degree) return

	if(choice == "Desire")
		var/desire = input(src, "What is the desire?", "Desire") as null|text
		if(isnull(desire)) return
		var/message = "You [degree == "mild" ? "slightly" : degree == "moderate" ? "moderately" : "strongly"] want to help [src.real_name] fulfil their wish to [desire]"
		if(!length(message) || copytext(message, length(message)) != ".")
			message += "."
		for(var/mob/living/carbon/human/H in viewers(src, null))
			if(HAS_TRAIT(H, TRAIT_EMPATH))
				to_chat(H, "<span style='color: white; font-style: italic; text-shadow: 0 0 6px #fff, 0 0 12px #fff;'>[message]</span>")
		to_chat(src, "You desire [desire].")
		return

	if(choice == "Dread")
		var/dread = input(src, "What are you dreading?", "Dread") as null|text
		if(isnull(dread)) return
		var/message = "You feel [degree]ly negatively preoccupied with the prospect of [dread]."
		if(!length(message) || copytext(message, length(message)) != ".")
			message += "."
		for(var/mob/living/carbon/human/H in viewers(src, null))
			if(HAS_TRAIT(H, TRAIT_EMPATH))
				to_chat(H, "<span style='color: #ff4444; font-weight: bold;'>[message]</span>")
		to_chat(src, "You become preoccupied with [dread].")
		return
