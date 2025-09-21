// Guildsman. Replacement class for the Blacksmith, Artificer, and Smithy Apprentice.
// But also includes a Mason-Architect.
/datum/job/roguetown/guildsman
	title = "Guildsman"
	flag = GUILDSMAN
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	advclass_cat_rolls = list(CTAG_GUILDSMEN = 20)
	allowed_races = RACES_ALL_KINDS
	tutorial = "You are a member of the Scarlet Reach Guild of Crafts, a massive guild formed to represent the interests of all craftsmen in the township of Scarlet Reach.\
	As a Guildsman, you hail from the three most important constituent guilds: The Smith's Guild, the Artificer's Guild, and the Architect's Guild. The Guildsmaster has sway over you, but it is not absolute."
	outfit = /datum/outfit/job/roguetown/guildsman
	selection_color = JCOLOR_YEOMAN
	display_order = JDO_GUILDSMAN
	give_bank_account = 15
	min_pq = 0
	max_pq = null
	round_contrib_points = 3
	advjob_examine = TRUE // So that everyone know which subjob they have picked

	job_subclasses = list(
		/datum/advclass/guildsman/artificer,
		/datum/advclass/guildsman/blacksmith,
		/datum/advclass/guildsman/architect
	)

/datum/job/roguetown/guildsman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/guildsman/blacksmith
	name = "Guild Blacksmith"
	tutorial = "You've studied for many yils under quite a number of master smiths. Whether it's cookware or tools of war, you're unmatched at the art of bending metal to your will."
	outfit = /datum/outfit/job/roguetown/guildsman/blacksmith

	category_tags = list(CTAG_GUILDSMEN)

	traits_applied = list(TRAIT_TRAINED_SMITH)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_END = 2,
		STATKEY_CON = 2,
		STATKEY_INT = 1
	)

	subclass_skills = list(
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/blacksmithing = SKILL_LEVEL_MASTER,
		/datum/skill/craft/armorsmithing = SKILL_LEVEL_MASTER,
		/datum/skill/craft/weaponsmithing = SKILL_LEVEL_MASTER,
		/datum/skill/craft/smelting = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/engineering = SKILL_LEVEL_NOVICE, // 1 Engineering to allow them to sub for Artificer role occaisonally
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/guildsman/blacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/hatfur
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves/blacksmith
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu

	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
	if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(/obj/item/rogueweapon/hammer/iron = 1, /obj/item/rogueweapon/tongs = 1, /obj/item/recipe_book/blacksmithing = 1)
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		cloak = /obj/item/clothing/cloak/apron/blacksmith
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/roguekey/crafterguild
	else if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(/obj/item/rogueweapon/hammer/iron = 1, /obj/item/rogueweapon/tongs = 1, /obj/item/recipe_book/blacksmithing = 1)
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/roguekey/crafterguild
		cloak = /obj/item/clothing/cloak/apron/blacksmith

/datum/advclass/guildsman/artificer
	name = "Guild Artificer"
	tutorial = "You are an Artificer, oft known by the longer name of Artificer-Enchanter. You have basic training in the arts of smithing, and can substitute for a blacksmith's work if needed.\
	But your true calling is the creation and enchantment of magical items, alongside feats of engineering, creating mechanical and magical wonders whose art of creation has been passed down\
	from a certain elven Artificer..."
	outfit = /datum/outfit/job/roguetown/guildsman/artificer
	category_tags = list(CTAG_GUILDSMEN)

	traits_applied = list(TRAIT_ARCYNE_T1)
	subclass_stats = list(
		STATKEY_INT = 3,
		STATKEY_END = 2,
		STATKEY_STR = 1,
		STATKEY_CON = 1,
		STATKEY_PER = 1
	)

	subclass_skills = list(
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/engineering = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/blacksmithing = SKILL_LEVEL_APPRENTICE, // Artificer makes for a crappy substitute blacksmith but have the same spread
		/datum/skill/craft/armorsmithing = SKILL_LEVEL_APPRENTICE, 
		/datum/skill/craft/weaponsmithing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/magic/arcane = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/smelting = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/traps = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/ceramics = SKILL_LEVEL_JOURNEYMAN,	//Just for basic pottery/glass stuff.
	)

/datum/outfit/job/roguetown/guildsman/artificer/pre_equip(mob/living/carbon/human/H)
	..()

	head = /obj/item/clothing/head/roguetown/articap
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket
	cloak = /obj/item/clothing/cloak/apron/waist/brown
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves/blacksmith
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/artificer
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/roguekey/crafterguild
	mask = /obj/item/clothing/mask/rogue/spectacles/golden
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
						/obj/item/rogueweapon/hammer/steel = 1,
						/obj/item/lockpickring/mundane = 1,
						/obj/item/recipe_book/blacksmithing = 1,
						/obj/item/recipe_book/engineering = 1,
						/obj/item/recipe_book/ceramics = 1,
						/obj/item/recipe_book/builder = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/recipe_book/magic = 1,
						/obj/item/chalk = 1,
						)
	// Not a real mage, no free spell point. Take Arcyne Potential if you want it.
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/enchant_weapon)

/datum/advclass/guildsman/architect
	name = "Guild Architect"
	tutorial = "You are a Guild Architect, a master of the art of building and construction. You build castles, fortifications and entire cities with your own hands. And you know how to source those materials yourself too.\
	When there is no construction work around, your fellow Guildsmen appreciate your help with gathering materials."
	outfit = /datum/outfit/job/roguetown/guildsman/architect
	category_tags = list(CTAG_GUILDSMEN)

	traits_applied = list()
	subclass_stats = list(
		STATKEY_INT = 2,
		STATKEY_END = 2,
		STATKEY_LCK = 2,
		STATKEY_STR = 1,
		STATKEY_CON = 1,
	)

	subclass_skills = list(
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/labor/lumberjacking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/labor/mining = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT, 
		/datum/skill/craft/crafting = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/carpentry = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/masonry = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/engineering = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/traps = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/ceramics = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/guildsman/architect/pre_equip(mob/living/carbon/human/H)
	..()

	head = /obj/item/clothing/head/roguetown/hatblu
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	cloak = /obj/item/clothing/cloak/apron/waist/bar
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/flashlight/flare/torch/lantern
	beltl = /obj/item/rogueweapon/pick/steel
	backr = /obj/item/rogueweapon/stoneaxe/woodcut/steel/woodcutter
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
						/obj/item/rogueweapon/hammer/steel = 1,
						/obj/item/rogueweapon/handsaw = 1,
						/obj/item/storage/belt/rogue/pouch/coins/mid = 1,
						/obj/item/rogueweapon/chisel = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/flint = 1,
						/obj/item/rogueweapon/huntingknife = 1,
						/obj/item/rogueweapon/handsaw = 1,
						/obj/item/dye_brush = 1,
						/obj/item/recipe_book/engineering = 1,
						/obj/item/recipe_book/builder = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/roguekey/crafterguild = 1
						)
