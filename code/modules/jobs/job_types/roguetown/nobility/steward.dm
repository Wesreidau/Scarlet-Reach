/datum/job/roguetown/steward
	title = "Steward"
	flag = STEWARD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_APPOINTED_OUTCASTS_UP
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_STEWARD
	tutorial = "Coin, Coin, Coin! Oh beautiful coin: You're addicted to it, and you hold the position as the Grand Duke's personal treasurer of both coin and information. You know the power silver and gold has on a man's mortal soul, and you know just what lengths they'll go to in order to get even more. Keep your festering economy alive- for it is the only thing you can weigh any trust into anymore."
	outfit = /datum/outfit/job/roguetown/steward
	give_bank_account = 22
	noble_income = 16
	min_pq = 3 //Please don't give the vault keys to somebody that's going to lock themselves in on accident
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/combat_noble.ogg'

	advclass_cat_rolls = list(CTAG_STEWARD = 2)

	virtue_restrictions = list(/datum/virtue/utility/blacksmith)

	job_traits = list(TRAIT_NOBLE, TRAIT_SEEPRICES)
	job_subclasses = list(
		/datum/advclass/steward
	)

/datum/job/roguetown/steward/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/steward
	name = "Steward"
	tutorial = "Coin, Coin, Coin! Oh beautiful coin: You're addicted to it, and you hold the position as the Grand Duke's personal treasurer of both coin and information. You know the power silver and gold has on a man's mortal soul, and you know just what lengths they'll go to in order to get even more. Keep your festering economy alive- for it is the only thing you can weigh any trust into anymore."
	outfit = /datum/outfit/job/roguetown/steward/basic

	category_tags = list(CTAG_STEWARD)
	subclass_stats = list(
		STATKEY_INT = 2,
		STATKEY_PER = 2,
		STATKEY_SPD = -1,
	)

	subclass_skills = list(
		/datum/skill/misc/reading = SKILL_LEVEL_LEGENDARY,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/swords = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/steward
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/roguetown/steward/basic/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	if(should_wear_femme_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/steward
	else if(should_wear_masc_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/silktunic
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquegold/steward
	beltr = /obj/item/storage/keyring/steward
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/scomstone

	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular/pileappraisal)
	H.verbs |= /mob/living/carbon/human/proc/adjust_taxes

GLOBAL_VAR_INIT(steward_tax_cooldown, -50000) // Antispam
/mob/living/carbon/human/proc/adjust_taxes()
	set name = "Adjust Taxes"
	set category = "Stewardry"
	if(stat)
		return
	var/lord = find_lord()
	if(lord)
		to_chat(src, span_warning("You cannot adjust taxes while the [SSticker.rulertype] is present in the realm. Ask your liege."))
		return
	if(world.time < GLOB.steward_tax_cooldown + 600 SECONDS)
		to_chat(src, span_warning("You must wait [round((GLOB.steward_tax_cooldown + 600 SECONDS - world.time)/600, 0.1)] minutes before adjusting taxes again! Think of the realm."))
		return FALSE
	var/newtax = input(src, "Set a new tax percentage (1-99)", src, SStreasury.tax_value*100) as null|num
	if(newtax)
		if(findtext(num2text(newtax), "."))
			return
		newtax = CLAMP(newtax, 1, 99)
		if(stat)
			return
		SStreasury.tax_value = newtax / 100
		priority_announce("The new tax in Scarlet Reach shall be [newtax] percent.", "The Steward Meddles", pick('sound/misc/royal_decree.ogg', 'sound/misc/royal_decree2.ogg'), "Captain")
		GLOB.steward_tax_cooldown = world.time
