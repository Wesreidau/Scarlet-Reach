/datum/advclass/hedgeknight //heavy knight class - just like black knight adventurer class. starts with heavy armor training and plate, but less weapon skills than brigand, sellsword and knave
	name = "Hedge Knight"
	tutorial = "A noble fallen from grace, your tarnished armor sits upon your shoulders as a heavy reminder of the life you've lost. Take back what is rightfully yours."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NO_GOLEM
	outfit = /datum/outfit/job/roguetown/bandit/hedgeknight
	category_tags = list(CTAG_BANDIT)
	maximum_possible_slots = 1
	cmode_music = 'sound/music/combat_bandit.ogg'

	traits_applied = list(
		TRAIT_MEDIUMARMOR,
		TRAIT_HEAVYARMOR,
		TRAIT_DISGRACED_NOBLE,
	)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_END = 2,
		STATKEY_CON = 3, //dark souls 3 dual greatshield moment
		STATKEY_INT = 1,
		STATKEY_SPD = 1,
		STATKEY_LCK = 2,
	)

	subclass_skills = list(
	/datum/skill/combat/polearms = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/combat/swords = SKILL_LEVEL_MASTER,
	/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
	/datum/skill/misc/swimming = SKILL_LEVEL_NOVICE,
	/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
	/datum/skill/misc/riding = SKILL_LEVEL_EXPERT,
	/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
	/datum/skill/labor/butchering = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/bandit/hedgeknight/pre_equip(mob/living/carbon/human/H)
	..()
	if (!(istype(H.patron, /datum/patron/inhumen/zizo) || istype(H.patron, /datum/patron/inhumen/matthios) || istype(H.patron, /datum/patron/inhumen/graggar) || istype(H.patron, /datum/patron/inhumen/baotha)))
		to_chat(H, span_warning("My former deity has abandoned me.. Matthios is my new master."))
		H.set_patron(/datum/patron/inhumen/matthios)	//We allow other heretics into the cool-kids club, but if you are a tennite/psydonian it sets you to matthiosan.
	head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/black
	gloves = /obj/item/clothing/gloves/roguetown/chain/blk
	pants = /obj/item/clothing/under/roguetown/chainlegs/blk
	cloak = /obj/item/clothing/cloak/tabard/blkknight
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	armor = /obj/item/clothing/suit/roguetown/armor/plate/blkknight
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/blkknight
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/sword/long/death // ow the edge. it's just spraypainted. no weapon choice you MUST use a sword
	beltl = /obj/item/rogueweapon/scabbard/sword
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backl = /obj/item/rogueweapon/shield/tower/metal
	id = /obj/item/scomstone/mattcoin
	backpack_contents = list(
					/obj/item/rogueweapon/huntingknife/idagger = 1,
					/obj/item/flashlight/flare/torch = 1,
					/obj/item/rogueweapon/scabbard/sheath = 1
					)

	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()	
