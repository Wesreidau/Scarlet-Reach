/datum/surgery/rogue_revival
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/infuse_lux,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/infuse_lux
	name = "Infuse Lux"
	implements = list(
		/obj/item/reagent_containers/lux = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 10 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_EXPERT
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/infuse_lux/validate_target(mob/user, mob/living/carbon/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat < DEAD)
		to_chat(user, "They're not dead!")
		return FALSE
	var/obj/item/organ/heart/H = target.getorganslot(ORGAN_SLOT_HEART)
	if(!H)
		to_chat(user, "[target] is missing their heart!")
		return FALSE
	if(!target.mind)
		to_chat(user, "[target]'s heart is inert.")
		return FALSE
	if(HAS_TRAIT(target, TRAIT_NECRAS_VOW))
		to_chat(user, "[target] has pledged a vow to Necra. This will not work.")
		return FALSE

/datum/surgery_step/infuse_lux/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to revive [target]... will their heart respond?"),
		span_notice("[user] begins to work lux into [target]'s heart."),
		span_notice("[user] begins to work lux into [target]'s heart."))
	return TRUE

/datum/surgery_step/infuse_lux/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if (HAS_TRAIT(target, TRAIT_CURSE_NECRA))
		display_results(user, target,
			span_warning("The lux recoils! [target]'s soul belongs to Necra."),
			"[user] tries to infuse [target] with lux, but it refuses to take.",
			"[user] tries to infuse [target] with lux, but it refuses to take.")
		target.visible_message(span_danger("[target]'s body convulses violently, rejecting the light!"), span_warning("Something is terribly wrong..."))
		return FALSE
	var/revive_pq = PQ_GAIN_REVIVE
	if((target.mob_biotypes & MOB_UNDEAD) && !HAS_TRAIT(target, TRAIT_HOLLOW_LIFE))
		display_results(user, target, span_notice("You cannot infuse life into the undead! The rot must be cured first."),
			"[user] works the lux into [target]'s innards.",
			"[user] works the lux into [target]'s innards.")
		return FALSE
	if(istype(user, /mob/living)) 
		var/mob/living/LU = user
		var/excomm_found = FALSE
		for(var/excomm_name in GLOB.excommunicated_players)
			var/clean_excomm = lowertext(trim(excomm_name))
			var/clean_target = lowertext(trim(target.real_name))
			if(clean_excomm == clean_target)
				excomm_found = TRUE
				break
		if(ispath(LU.patron?.type, /datum/patron/divine) && excomm_found)
			display_results(user, target,
				span_warning("The lux recoils! Necra is not willing to return [target]'s soul."),
				"[user] tries to infuse [target] with lux, but it refuses to take.",
				"[user] tries to infuse [target] with lux, but it refuses to take.")
			target.visible_message(span_danger("[target]'s body convulses violently, rejecting the light!"), span_warning("Something is terribly wrong..."))
			return FALSE
	if(!target.revive(full_heal = FALSE))
		display_results(user, target, span_notice("The lux refuses to meld with [target]'s heart. Their damage must be too severe still."),
			"[user] works the lux into [target]'s innards, but nothing happens.",
			"[user] works the lux into [target]'s innards, but nothing happens.")
		return FALSE
	var/mob/dead/observer/spirit = target.get_spirit()
	//GET OVER HERE!
	if(spirit)
		var/mob/dead/observer/ghost = spirit.ghostize()
		qdel(spirit)
		ghost.mind.transfer_to(target, TRUE)
	target.grab_ghost(force = FALSE)
	if (!target.mind.active)
		display_results(user, target, span_notice("[target]'s heart refuses the lux. They're only in sweet dreams, now."),
			"[user] works the lux into [target]'s innards, but nothing happens.",
			"[user] works the lux into [target]'s innards, but nothing happens.")
		return FALSE
	target.adjustOxyLoss(-target.getOxyLoss()) //Ye Olde CPR
	display_results(user, target, span_notice("You succeed in restarting [target]'s heart with the infusion of lux."),
		"[user] works the lux into [target]'s innards.",
		"[user] works the lux into [target]'s innards.")
	target.emote("breathgasp")
	target.Jitter(100)
	GLOB.scarlet_round_stats[STATS_LUX_REVIVALS]++
	target.update_body()
	target.visible_message(span_notice("[target] is dragged back from Necra's hold!"), span_green("I awake from the void."))
	qdel(tool)
	if(target.mind)
		if(revive_pq && !HAS_TRAIT(target, TRAIT_IWASREVIVED) && user?.ckey)
			adjust_playerquality(revive_pq, user.ckey)
			ADD_TRAIT(target, TRAIT_IWASREVIVED, "[type]")
	target.remove_status_effect(/datum/status_effect/debuff/rotted_zombie)	//Removes the rotted-zombie debuff if they have it - Failsafe for it.
	target.apply_status_effect(/datum/status_effect/debuff/revived)	//Temp debuff on revive, your stats get hit temporarily. Doubly so if having rotted.
	return TRUE

/datum/surgery_step/infuse_lux/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, success_prob)
	display_results(user, target, span_warning("I screwed up!"),
		span_warning("[user] screws up!"),
		span_notice("[user] works the lux into [target]'s innards."), TRUE)
	return TRUE
