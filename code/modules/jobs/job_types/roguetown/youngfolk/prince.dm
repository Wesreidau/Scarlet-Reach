/datum/job/roguetown/prince
	title = "Prince"
	f_title = "Princess"
	flag = PRINCE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	f_title = "Princess"
	allowed_races = RACES_NOBILITY_ELIGIBLE_UP //Maybe a system to force-pick lineage based on king and queen should be implemented. (No it shouldn't.)
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)
	advclass_cat_rolls = list(CTAG_HEIR = 20)

	tutorial = "You've never felt the gnawing of the winter, never known the bite of hunger and certainly have never known a honest day's work. You are as free as any bird in the sky, and you may revel in your debauchery for as long as your parents remain upon the throne: But someday you'll have to grow up, and that will be the day your carelessness will cost you more than a few mammons."

	display_order = JDO_PRINCE
	give_bank_account = 30
	noble_income = 20
	min_pq = 1
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/combat_noble.ogg'

	job_traits = list(TRAIT_NOBLE)
	job_subclasses = list(
		/datum/advclass/heir/daring,
		/datum/advclass/heir/bookworm,
		/datum/advclass/heir/aristocrat,
		/datum/advclass/heir/inbred,
	)

/datum/job/roguetown/prince/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	if(ishuman(H))
		var/mob/living/carbon/human/Q = H
		Q.advsetup = 1
		Q.invisibility = INVISIBILITY_MAXIMUM
		Q.become_blind("advsetup")


/datum/outfit/job/roguetown/heir/pre_equip(mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/declarechampion

/datum/advclass/heir/daring
	name = "Daring Twit"
	tutorial = "You're a somebody, someone important. It only makes sense you want to make a name for yourself, to gain your own glory so people see how great you really are beyond your bloodline. Plus, if you're beloved by the people for your exploits you'll be chosen! Probably. Shame you're as useful and talented as a squire, despite your delusions to the contrary."
	outfit = /datum/outfit/job/roguetown/heir/daring
	category_tags = list(CTAG_HEIR)

	traits_applied = list(TRAIT_MEDIUMARMOR)
	subclass_stats = list(
		STATKEY_STR = 1,
		STATKEY_PER = 1,
		STATKEY_CON = 1,
		STATKEY_SPD = 1,
		STATKEY_LCK = 1,
	)

	subclass_skills = list(
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/polearms = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/whipsflails = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/bows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/shields = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/slings = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/heir/daring/pre_equip(mob/living/carbon/human/H)
	..()

	// Equipment choice - only affects clothing/gear, not skills
	var/equipment_choice = input(H, "Choose your equipment style", "Equipment Choice") as anything in list("Wartime Outfit", "Traditional Dress")

	if(equipment_choice == "Wartime Outfit")
		// Original daring twit equipment
		head = /obj/item/clothing/head/roguetown/circlet
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/royal
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
		shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
		belt = /obj/item/storage/belt/rogue/leather
		l_hand = /obj/item/rogueweapon/sword/sabre
		beltl = /obj/item/rogueweapon/scabbard/sword
		beltr = /obj/item/storage/keyring/heir
		neck = /obj/item/storage/belt/rogue/pouch/coins/rich
		backr = /obj/item/storage/backpack/rogue/satchel
	else
		// Bookworm clothing/equipment only
		if(should_wear_masc_clothes(H))
			pants = /obj/item/clothing/under/roguetown/tights/random
			armor = /obj/item/clothing/suit/roguetown/armor/longcoat
			shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/prince
		if(should_wear_femme_clothes(H))
			shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/princess
		head = /obj/item/clothing/head/roguetown/circlet
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		beltr = /obj/item/storage/keyring/heir
		beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
		backr = /obj/item/storage/backpack/rogue/satchel
		shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
		mask = /obj/item/clothing/mask/rogue/spectacles
		neck = /obj/item/storage/belt/rogue/pouch/coins/rich

/datum/advclass/heir/bookworm
	name = "Introverted Bookworm"
	tutorial = "Despite your standing, sociability is not your strong suit, and you have kept mostly to yourself and your books. This hardly makes you a favourite among the lords and ladies of the court, and an exit from your room is often met with amusement from nobility and servants alike. But maybe... just maybe, some of your reading interests may be bearing fruit."
	outfit = /datum/outfit/job/roguetown/heir/bookworm
	category_tags = list(CTAG_HEIR)

	traits_applied = list(TRAIT_ARCYNE_T2, TRAIT_MAGEARMOR)
	subclass_stats = list(
		STATKEY_STR = -1,
		STATKEY_INT = 2,
		STATKEY_SPD = 1,
		STATKEY_CON = -1,
		STATKEY_LCK = 1,
	)

	subclass_spellpoints = 9

	subclass_skills = list(
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/magic/arcane = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/alchemy = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/heir/bookworm/pre_equip(mob/living/carbon/human/H)
	..()
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/armor/longcoat
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/prince
	if(should_wear_femme_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/princess
	head = /obj/item/clothing/head/roguetown/circlet
	belt = /obj/item/storage/belt/rogue/leather/cloth/lady
	beltr = /obj/item/storage/keyring/heir
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
	backr = /obj/item/storage/backpack/rogue/satchel
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	mask = /obj/item/clothing/mask/rogue/spectacles
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich

/datum/advclass/heir/aristocrat
	name = "Sheltered Aristocrat"
	tutorial = "Life has been kind to you; you've an entire keep at your disposal, servants to wait on you, and a whole retinue of guards to guard you. You've nothing to prove; just live the good life and you'll be a lord someday, too. A lack of ambition translates into a lacking skillset beyond schooling, though, and your breaks from boredom consist of being a damsel or court gossip."
	outfit = /datum/outfit/job/roguetown/heir/aristocrat
	category_tags = list(CTAG_HEIR)

	traits_applied = list(TRAIT_SEEPRICES_SHITTY, TRAIT_GOODLOVER)
	subclass_stats = list(
		STATKEY_PER = 2,
		STATKEY_STR = -1,
		STATKEY_INT = 2,
		STATKEY_LCK = 1,
		STATKEY_SPD = 1
	)

	subclass_skills = list(
		/datum/skill/combat/bows = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/knives = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/sewing = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/heir/aristocrat/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/circlet
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/heir
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/prince
		belt = /obj/item/storage/belt/rogue/leather
		shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	if(should_wear_femme_clothes(H))
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		head = /obj/item/clothing/head/roguetown/hennin
		armor = /obj/item/clothing/suit/roguetown/armor/silkcoat
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/princess
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
	H.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1), TRUE)

/datum/advclass/heir/inbred
	name = "Inbred wastrel"
	tutorial = "Your bloodline ensures Psydon smiles upon you by divine right, the blessing of nobility... until you were born, anyway. You are a child forsaken, and even though your body boils as you go about your day, your spine creaks, and your drooling form needs to be waited on tirelessly you are still considered more important then the peasant that keeps the town fed and warm. Remind them of that fact when your lungs are particularly pus free."
	outfit = /datum/outfit/job/roguetown/heir/inbred
	category_tags = list(CTAG_HEIR)

	traits_applied = list(TRAIT_CRITICAL_WEAKNESS, TRAIT_NORUN)
	subclass_stats = list(
		STATKEY_STR = -2,
		STATKEY_PER = -2,
		STATKEY_INT = -2,
		STATKEY_CON = -2,
		STATKEY_END = -2,
		STATKEY_LCK = -2
	)

	subclass_skills = list(
		/datum/skill/combat/bows = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/knives = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/sewing = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/heir/inbred/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/circlet
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/heir
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/prince
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	if(should_wear_femme_clothes(H))
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		head = /obj/item/clothing/head/roguetown/hennin
		armor = /obj/item/clothing/suit/roguetown/armor/silkcoat
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/princess
		shoes = /obj/item/clothing/shoes/roguetown/shortboots

	H.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, pick(0,0,1), TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1), TRUE)

/mob/living/carbon/human/proc/declarechampion()
	set name = "Declare Champion"
	set category = "Noble"


	if(stat)
		return
	if(!mind)
		return

	if(!src.mind.champion)
		var/list/folksnearby = list()
		for(var/mob/living/carbon/human/newchampionpotential in (view(1)))
			folksnearby += newchampionpotential
		var/target = input(src, "Choose a champion") as null|anything in folksnearby
		if(istype(target, /mob/living/carbon))
			var/mob/living/carbon/guy = target
			if(!guy)
				return
			if(guy == src)
				return
			if(!guy.mind)
				return
			src.say("Be my Champion, [guy]!")
			var/prompt = alert(guy, "Do wish to be [src]'s Champion?", "Champion", "Yes", "No")
			if(prompt == "No")
				return

			guy.say("I serve you, [src]!")
			src.visible_message(span_warning("[src] begins tying the golden ribbon to [guy]'s wrist."))
			if(do_after(src, 10 SECONDS))
				src.visible_message(span_warning("[src] ties a golden ribbon to [guy]'s wrist."))
				guy.mind.ward = src
				src.mind.champion = guy
				var/datum/status_effect/buff/champion/new_champion = guy.apply_status_effect(/datum/status_effect/buff/champion)
				var/datum/status_effect/buff/ward/new_ward = src.apply_status_effect(/datum/status_effect/buff/ward)
				new_champion.ward = src
				new_ward.champion = guy

	else
		var/list/folksnearby = list()
		for(var/mob/living/carbon/human/championremoval in (view(1)))
			if(championremoval == src.mind.champion)
				folksnearby += championremoval
		var/mob/living/target = input(src, "Choose a champion") as null|anything in folksnearby
		if(!target)
			return

		else
			src.visible_message(span_warning("[src] begins untying the golden ribbon from [src.mind.champion]'s wrist."))
			if(do_after(src, 10 SECONDS))
				src.visible_message(span_warning("[src] unties a golden ribbon from [src.mind.champion]'s wrist."))
				src.say("I revoke your championship, [target]!")
				src.mind.champion = null
				if(target.has_status_effect(/datum/status_effect/buff/champion))
					target.remove_status_effect(/datum/status_effect/buff/champion)
				if(src.has_status_effect(/datum/status_effect/buff/ward))
					src.remove_status_effect(/datum/status_effect/buff/ward)


/datum/status_effect/buff/champion
	alert_type = /atom/movable/screen/alert/status_effect/buff/champion
	var/mob/living/carbon/ward = null
	effectedstats = list(STATKEY_CON = 1, STATKEY_END = 1)
	duration = -1

/atom/movable/screen/alert/status_effect/buff/champion
	name = "Champion"
	desc = "I am a Chosen by a Heir!"
	icon_state = "buff"


/datum/status_effect/buff/champion/on_creation()
	spawn(5) // sob doesnt work without this??
		examine_text = "<font color='yellow'>SUBJECTPRONOUN is the Champion Of [owner.mind.ward.real_name]!"
	return ..()

/datum/status_effect/buff/champion/tick()
	for (var/mob/living/carbon/H in view(5, owner))
		if(H == ward)
			if (!owner.has_stress_event(/datum/stressevent/champion))
				owner.add_stress(/datum/stressevent/champion)

/datum/status_effect/buff/champion/on_remove()
	ward.add_stress(/datum/stressevent/lostchampion)
	owner.mind.ward = null
	owner.remove_status_effect(/datum/status_effect/buff/champion)
	if(ward && ward.mind)
		ward.mind.champion = null
		ward.remove_status_effect(/datum/status_effect/buff/ward)


/datum/status_effect/buff/ward
	alert_type = /atom/movable/screen/alert/status_effect/buff/ward
	var/mob/living/carbon/champion = null
	effectedstats = list(STATKEY_LCK = 1, STATKEY_WIL = 1)
	duration = -1

/atom/movable/screen/alert/status_effect/buff/ward
	name = "Ward"
	desc = "I have declared a champion."
	icon_state = "buff"

/datum/status_effect/buff/ward/tick()
	for (var/mob/living/carbon/H in view(5, owner))
		if(H == champion)
			if(!owner.has_stress_event(/datum/stressevent/ward))
				owner.add_stress(/datum/stressevent/ward)

/datum/status_effect/buff/ward/on_remove()
	champion.add_stress(/datum/stressevent/lostward)
	owner.mind.champion = null
	owner.remove_status_effect(/datum/status_effect/buff/ward)
	if(champion && champion.mind)
		champion.mind.ward = null
		champion.remove_status_effect(/datum/status_effect/buff/champion)
