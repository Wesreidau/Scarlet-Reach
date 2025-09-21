/datum/job/roguetown/lunatic
	title = "Lunatic"
	flag = LUNATIC
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	round_contrib_points = 2

	var/list/traits_applied
	traits_applied = list(TRAIT_SCHIZO_AMBIENCE, TRAIT_NOSTINK, TRAIT_MANIAC_AWOKEN) // Maniac_Awoken no longer has any function other than the flavor text and trait

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	outfit = /datum/outfit/job/roguetown/lunatic
	bypass_lastclass = TRUE
	bypass_jobban = FALSE
	min_pq = 100 //the magic of an allowlist server.
	max_pq = null
	tutorial = "The Lunatic, shunned by society and a magnet for misfortune. Your task is simple yet perilous: survive by any means, though your very existence invites danger from every corner. It is said that Scarlet Reach drives those most familiar with it, the most insane."
	display_order = JDO_LUNATIC

	cmode_music = 'sound/music/combat_bum.ogg'

	job_traits = list(TRAIT_JESTERPHOBIA)

	advclass_cat_rolls = list(CTAG_LUNATIC = 2)
	job_subclasses = list(
		/datum/advclass/lunatic
	)

/datum/job/roguetown/lunatic/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/lunatic
	name = "Lunatic"
	tutorial = "The Lunatic, shunned by society and a magnet for misfortune. Your task is simple yet perilous: survive by any means, though your very existence invites danger from every corner. It is said that Azure Peak drives those most familiar with it, the most insane."
	outfit = /datum/outfit/job/roguetown/lunatic/basic
	category_tags = list(CTAG_LUNATIC)

	subclass_stats = list(
		STATKEY_SPD = 2
	)

	subclass_skills = list(
		/datum/skill/misc/sneaking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/stealing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/lunatic/basic/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	H.STALUC = rand(3, 8)
	armor = /obj/item/clothing/suit/roguetown/shirt/rags
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	pants = /obj/item/clothing/under/roguetown/tights/vagrant
	belt  = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/rogueweapon/huntingknife/stoneknife
	beltr = /obj/item/flashlight/flare/torch
