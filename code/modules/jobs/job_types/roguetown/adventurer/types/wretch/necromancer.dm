/datum/advclass/wretch/necromancer
	name = "Necromancer"
	tutorial = "You have been ostracized and hunted by society for your dark magics and perversion of life."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/necromancer
	category_tags = list(CTAG_WRETCH)
	cmode_music = 'sound/music/combat_cult.ogg'
	extra_context = "Only those that worship ZIZO may be necromancers."

	traits_applied = list(TRAIT_MAGEARMOR, TRAIT_GRAVEROBBER, TRAIT_ARCYNE_T3, TRAIT_RITUALIST) // removing zombie immunity cos zizo gives u it by default
	// Necromancer get the most +4 Int, +2 Perception just like Sorc (Adv Mage), and a bit of endurance / speed
	subclass_stats = list(
		STATKEY_INT = 4,
		STATKEY_PER = 2,
		STATKEY_END = 1,
		STATKEY_SPD = 1
	)

	subclass_spellpoints = 18

	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/craft/alchemy = SKILL_LEVEL_EXPERT,
		/datum/skill/magic/arcane = SKILL_LEVEL_EXPERT,
	)

/datum/outfit/job/roguetown/wretch/necromancer/pre_equip(mob/living/carbon/human/H)
	H.mind.current.faction += "[H.name]_faction"
	H.set_patron(/datum/patron/inhumen/zizo)
	head = /obj/item/clothing/head/roguetown/roguehood/black
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	neck = /obj/item/clothing/neck/roguetown/gorget
	beltl = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/woodstaff/ruby
	backpack_contents = list(
		/obj/item/spellbook_unfinished/pre_arcyne = 1,
		/obj/item/roguegem/amethyst = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/ritechalk = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
	)
	H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()

	if(H.age == AGE_OLD)
		H.adjust_skillrank_up_to(/datum/skill/magic/arcane, SKILL_LEVEL_MASTER, TRUE)
		H?.mind.adjust_spellpoints(6)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/eyebite)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/bonechill)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/minion_order)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/gravemark)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_lesser_undead/necromancer)

	wretch_select_bounty(H)
