/datum/job/roguetown/warden
	title = "Warden"
	flag = BOGGUARD
	department_flag = GARRISON
	faction = "Station"
	total_positions = 6
	spawn_positions = 6
	selection_color = JCOLOR_SOLDIER
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_FEARED_UP
	disallowed_races = list(
		/datum/species/lamia,
	)
	tutorial = "Typically a denizen of the sparsely populated Scarlet Reach woods, you volunteered up with the wardens--a group of ranger types who keep a vigil over the untamed wilderness. \
				While Wardens have no higher authority, operating as a fraternity of rangers, you will be called upon as members of the garrison by the Marshal or the Crown. \
				Serve their will and recieve what a ranger craves the most - freedom and safety."
	display_order = JDO_TOWNGUARD
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/warden
	advclass_cat_rolls = list(CTAG_WARDEN = 20)
	give_bank_account = 50
	min_pq = 0
	max_pq = null
	round_contrib_points = 2
	cmode_music = 'sound/music/combat_warden.ogg'

	job_traits = list(TRAIT_OUTDOORSMAN, TRAIT_WOODSMAN)
	job_subclasses = list(
		/datum/advclass/warden/ranger,
		/datum/advclass/warden/forester
	)

/datum/outfit/job/roguetown/warden
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded/warden
	cloak = /obj/item/clothing/cloak/wardencloak
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	belt = /obj/item/storage/belt/rogue/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	id = /obj/item/scomstone/bad/garrison
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/warden/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/warden/ranger
	name = "Ranger"
	tutorial = "You are a ranger, a hunter who volunteered to become a part of the wardens. You have experience using bows and daggers."
	outfit = /datum/outfit/job/roguetown/warden/ranger
	category_tags = list(CTAG_WARDEN)

	traits_applied = list(TRAIT_DODGEEXPERT)
	subclass_stats = list(
		STATKEY_PER = 2,//7 points weighted, same as MAA. They get temp buffs in the woods instead of in the city.
		STATKEY_SPD = 2,
		STATKEY_END = 1
	)

	subclass_skills = list(
		/datum/skill/combat/bows = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/slings = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/crossbows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/tanning = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/tracking = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
		/datum/skill/labor/butchering = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/carpentry = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE, // This should let them fry meat on fires.
	)

/datum/outfit/job/roguetown/warden/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/coif
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/trou/leather
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve/warden
	beltr = /obj/item/quiver/arrows
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	backpack_contents = list(
		/obj/item/storage/keyring/guard = 1,
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
	)

	H.verbs |= /mob/proc/haltyell
	H.set_blindness(0)

	var/helmets = list(
		"Path of the Woodsman"	= /obj/item/clothing/head/roguetown/helmet/bascinet/antler,
		"Path of the Buck" 		= /obj/item/clothing/head/roguetown/helmet/bascinet/antler/snouted,
		"Path of the Volf"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/wolf,
		"Path of the Ram"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/goat,
		"Path of the Bear"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/bear,
		"Path of the Rous"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/rat,
		"None"
	)
	var/helmchoice = input("Choose your Path.", "HELMET SELECTION") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/hoods = list(
		"Common Shroud" 	= /obj/item/clothing/head/roguetown/roguehood/warden,
		"Antlered Shroud"		= /obj/item/clothing/head/roguetown/roguehood/warden/antler,
		"None"
	)
	var/hoodchoice = input("Choose your Shroud.", "HOOD SELECTION") as anything in hoods
	if(helmchoice != "None")
		mask = hoods[hoodchoice]


/datum/advclass/warden/forester
	name = "Forester"
	tutorial = "You are a forester, a woodsman who volunteered to become a part of the wardens. You have experience using axes and polearms."
	outfit = /datum/outfit/job/roguetown/warden/forester
	category_tags = list(CTAG_WARDEN)

	traits_applied = list(TRAIT_MEDIUMARMOR)
	subclass_stats = list(
		STATKEY_STR = 2,//7 points weighted, same as MAA. They get temp buffs in the woods instead of in the city.
		STATKEY_CON = 1,
		STATKEY_END = 1,
		STATKEY_PER = 1
	)

	subclass_skills = list(
		/datum/skill/combat/axes = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/polearms = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/shields = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/slings = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/bows = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/tanning = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/tracking = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
		/datum/skill/labor/butchering = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/carpentry = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE, // This should let them fry meat on fires.
	)

/datum/outfit/job/roguetown/warden/forester/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut/wardenpick
	beltl = /obj/item/rogueweapon/huntingknife
	r_hand = /obj/item/rogueweapon/spear
	backpack_contents = list(
		/obj/item/storage/keyring/guard = 1,
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
	)

	H.verbs |= /mob/proc/haltyell
	H.set_blindness(0)

	var/helmets = list(
		"Path of the Woodsman"	= /obj/item/clothing/head/roguetown/helmet/bascinet/antler,
		"Path of the Buck" 		= /obj/item/clothing/head/roguetown/helmet/bascinet/antler/snouted,
		"Path of the Volf"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/wolf,
		"Path of the Ram"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/goat,
		"Path of the Bear"		= /obj/item/clothing/head/roguetown/helmet/sallet/warden/bear,
		"None"
	)
	var/helmchoice = input("Choose your Path.", "HELMET SELECTION") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/hoods = list(
		"Common Shroud" 	= /obj/item/clothing/head/roguetown/roguehood/warden,
		"Antlered Shroud"		= /obj/item/clothing/head/roguetown/roguehood/warden/antler,
		"None"
	)
	var/hoodchoice = input("Choose your Shroud.", "HOOD SELECTION") as anything in hoods
	if(helmchoice != "None")
		mask = hoods[hoodchoice]
