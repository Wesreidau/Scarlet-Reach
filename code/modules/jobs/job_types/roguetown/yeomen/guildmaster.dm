/datum/job/roguetown/guildmaster
	title = "Guildmaster"
	flag = GUILDMASTER
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	selection_color = JCOLOR_YEOMAN

	allowed_races = RACES_ALL_KINDS
	disallowed_races = list(
		/datum/species/lamia,
	)
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "You are the leader of the Scarlet Reach Guild of Crafts. You represents the interests of all of the craftsmen underneath you - including the Tailor\
	the Blacksmiths, the Artificers and the Architects. Other townspeople may look to you for guidance, but they are not under your control. You are an experienced smith and artificer, and can do their work easily. Protect the craftsmen's interests."  

	outfit = /datum/outfit/job/roguetown/guildmaster
	selection_color = JCOLOR_YEOMAN
	display_order = JDO_GUILDMASTER
	give_bank_account = 25
	min_pq = 5 // Higher PQ requirement as it is a leadership role. Not for total newbie.
	max_pq = null
	round_contrib_points = 3
	advclass_cat_rolls = list(CTAG_GUILDMASTER = 2)

	job_traits = list(TRAIT_TRAINED_SMITH, TRAIT_SEEPRICES)
	job_subclasses = list(
		/datum/advclass/guildmaster
	)

/datum/advclass/guildmaster
	name = "Guildmaster"
	tutorial = "You are the leader of the Scarlet Reach Guild of Crafts. You represents the interests of all of the craftsmen underneath you - including the Tailor\
	the Blacksmiths, the Artificers and the Architects. Other townspeople may look to you for guidance, but they are not under your control. You are an experienced smith and artificer, and can do their work easily. Protect the craftsmen's interests."  
	outfit = /datum/outfit/job/roguetown/guildmaster/basic
	category_tags = list(CTAG_GUILDMASTER)

	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_CON = 2,
		STATKEY_END = 2,
		STATKEY_INT = 1
	)

	subclass_skills = list(
		/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/labor/lumberjacking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/labor/mining = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/crafting = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/carpentry = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/masonry = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/blacksmithing = SKILL_LEVEL_MASTER,
		/datum/skill/craft/armorsmithing = SKILL_LEVEL_MASTER,
		/datum/skill/craft/weaponsmithing = SKILL_LEVEL_MASTER,
		/datum/skill/craft/smelting = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/engineering = SKILL_LEVEL_JOURNEYMAN, // 2 Engineering, let them make more artificers stuffs
		/datum/skill/misc/sewing = SKILL_LEVEL_APPRENTICE, // Worse than the real tailor, so can't steal their job right away 
		/datum/skill/craft/tanning = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/ceramics = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/traps = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/guildmaster
	has_loadout = TRUE

/datum/job/roguetown/guildmaster/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/outfit/job/roguetown/guildmaster/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE) // Worse than the real tailor, so can't steal their job right away 
		H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)

/datum/outfit/job/roguetown/guildmaster/basic/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	head = /obj/item/clothing/head/roguetown/chaperon/noble/guildmaster
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves/blacksmith

	if(H.mind)
		// Skillset is a combo of Artificer + Blacksmith with Labor Skills. 
		// And Tailor / Leathercrafting
		H.verbs += /mob/living/carbon/human/proc/guild_announcement

		armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket
		pants = /obj/item/clothing/under/roguetown/trou/artipants
		shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/artificer
		backl = /obj/item/storage/backpack/rogue/backpack
		backpack_contents = list(/obj/item/rogueweapon/hammer/iron = 1, /obj/item/rogueweapon/tongs = 1, /obj/item/recipe_book/blacksmithing = 1)
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/rich
		beltr = /obj/item/storage/keyring/guildmaster

GLOBAL_VAR_INIT(last_guildmaster_announcement, -50000) // Inits variable for later

/mob/living/carbon/human/proc/guild_announcement()
	set name = "Announcement"
	set category = "GUILDMASTER"
	if(stat)
		return
	var/announcementinput = input("Bellow to the Peaks", "Make an Announcement") as text|null
	if(announcementinput)
		if(!src.can_speak_vocal())
			to_chat(src,span_warning("I can't speak!"))
			return FALSE
		if(world.time < GLOB.last_guildmaster_announcement + 600 SECONDS)
			to_chat(src, span_warning("You must wait [round((GLOB.last_guildmaster_announcement + 600 SECONDS - world.time)/600, 0.1)] minutes before making another announcement!"))
			return FALSE
		visible_message(span_warning("[src] takes a deep breath, preparing to make an announcement.."))
		if(do_after(src, 15 SECONDS, target = src)) // Reduced to 15 seconds from 30 on the original Herald PR. 15 is well enough time for sm1 to shove you.
			say(announcementinput)
			priority_announce("[announcementinput]", "The Guildmaster Heralds", 'sound/misc/bell.ogg', sender = src)
			GLOB.last_guildmaster_announcement = world.time
		else
			to_chat(src, span_warning("Your announcement was interrupted!"))
			return FALSE

