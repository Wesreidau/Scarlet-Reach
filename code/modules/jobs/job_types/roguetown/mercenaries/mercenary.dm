/datum/job/roguetown/mercenary
	title = "Mercenary"
	flag = MERCENARY
	department_flag = MERCENARIES
	faction = "Station"
	total_positions = 8
	spawn_positions = 8
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = "Blood stains your hands and the coins you hold. You are a sell-sword, a mercenary, a contractor of war. Where you come from, what you are, who you serve.. none of it matters. What matters is that the mammon flows to your pocket."
	display_order = JDO_MERCENARY
	selection_color = JCOLOR_MERCENARY
	min_pq = 2		//Will be handled by classes if PQ limiting is needed. --But Until then, learn escalation, mercs.
	max_pq = null
	round_contrib_points = 1
	outfit = null	//Handled by classes
	outfit_female = null
	advclass_cat_rolls = list(CTAG_MERCENARY = 20)
	job_traits = list(TRAIT_OUTLANDER, TRAIT_STEELHEARTED)
	always_show_on_latechoices = TRUE
	class_categories = TRUE

	job_subclasses = list(
		/datum/advclass/mercenary/atgervi,
		/datum/advclass/mercenary/atgervi/shaman,
		/datum/advclass/mercenary/condottiero,
		/datum/advclass/mercenary/desert_rider,
		/datum/advclass/mercenary/desert_rider/zeybek,
		/datum/advclass/mercenary/desert_rider/almah,
		/datum/advclass/mercenary/forlorn,
		/datum/advclass/mercenary/vaquero,
		/datum/advclass/mercenary/freelancer,
		/datum/advclass/mercenary/freelancer/lancer,
		/datum/advclass/mercenary/grenzelhoft,
		/datum/advclass/mercenary/grenzelhoft/halberdier,
		/datum/advclass/mercenary/grenzelhoft/crossbowman,
		/datum/advclass/mercenary/routier,
		/datum/advclass/mercenary/rumaclan,
		/datum/advclass/mercenary/rumaclan/ishu,
		/datum/advclass/mercenary/kashira,
		/datum/advclass/mercenary/steppesman,
		/datum/advclass/mercenary/warscholar,
		/datum/advclass/mercenary/warscholar/pontifex,
		/datum/advclass/mercenary/warscholar/vizier,
		/datum/advclass/mercenary/blackoak,
		/datum/advclass/mercenary/blackoak/ranger,
		/datum/advclass/mercenary/underdweller,
		/datum/advclass/mercenary/grudgebearer,
		/datum/advclass/mercenary/grudgebearer/soldier
	)

/datum/job/roguetown/mercenary/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
