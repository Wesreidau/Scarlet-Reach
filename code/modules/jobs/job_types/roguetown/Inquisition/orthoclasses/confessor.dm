/datum/advclass/confessor
	name = "Confessor"
	tutorial = "Psydonite hunters, unmatched in the fields of subterfuge and investigation. There is no suspect too powerful to investigate, no room too guarded to infiltrate, and no weakness too hidden to exploit."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/confessor
	category_tags = list(CTAG_INQUISITION)
	cmode_music = 'sound/music/combat_deadlyshadows.ogg'

	subclass_languages = list(/datum/language/otavan)

	traits_applied = list(
		TRAIT_STEELHEARTED,
		TRAIT_DODGEEXPERT,
		TRAIT_BLACKBAGGER,
		TRAIT_INQUISITION,
		TRAIT_PERFECT_TRACKER,
		TRAIT_PSYDONITE,
		TRAIT_OUTLANDER
	)
	subclass_stats = list(
		STATKEY_SPD = 3,
		STATKEY_END = 3,
		STATKEY_PER = 2,
		STATKEY_STR = -1//weazel
	)

	subclass_skills = list(
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT, // Quick
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/medicine = SKILL_LEVEL_JOURNEYMAN, // Stitch up your prey
		/datum/skill/misc/sneaking = SKILL_LEVEL_MASTER,
		/datum/skill/misc/stealing = SKILL_LEVEL_MASTER,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_MASTER,
		/datum/skill/misc/tracking = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/crossbows = SKILL_LEVEL_EXPERT,
	)

/datum/outfit/job/roguetown/confessor
	job_bitflag = BITFLAG_CHURCH

/datum/outfit/job/roguetown/confessor/pre_equip(mob/living/carbon/human/H)
	..()
	has_loadout = TRUE
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	gloves = /obj/item/clothing/gloves/roguetown/otavan/psygloves
	beltr = /obj/item/quiver/bolts
	neck = /obj/item/clothing/neck/roguetown/gorget
	backr = /obj/item/storage/backpack/rogue/satchel/otavan
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow/slurbow
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/psydon
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/confessor
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/inq
	shoes = /obj/item/clothing/shoes/roguetown/boots/psydonboots
	mask = /obj/item/clothing/mask/rogue/facemask/steel/confessor
	head = /obj/item/clothing/head/roguetown/roguehood/psydon/confessor
	id = /obj/item/clothing/ring/signet/silver
	backpack_contents = list(
		/obj/item/roguekey/inquisition = 1,
		/obj/item/rope/inqarticles/inquirycord = 1,
		/obj/item/lockpickring/mundane = 1,
		/obj/item/clothing/head/inqarticles/blackbag = 1,
		/obj/item/inqarticles/garrote = 1,
		/obj/item/grapplinghook = 1,
		/obj/item/paper/inqslip/arrival/ortho = 1
		)

/datum/outfit/job/roguetown/confessor/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("Shortsword", "Handmace", "Dagger")
	var/weapon_choice = input(H,"Choose your PSYDONIAN weapon.", "TAKE UP PSYDON'S ARMS") as anything in weapons
	switch(weapon_choice)
		if("Shortsword")
			H.put_in_hands(new /obj/item/rogueweapon/sword/short/psy/preblessed(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sword, SLOT_BELT_L, TRUE)
		if("Handmace")
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/mace/cudgel/psy/preblessed, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/maces, 4, TRUE)	
		if("Dagger")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/silver/psydagger(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
