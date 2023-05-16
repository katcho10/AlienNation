extends Resource

#enum SKILL_type {
#	NONE = 0,
#	PROJECTILE = 1,
#	AOE = 2,
#	EXPLOSION = 3
#}

#var ID:int = 0
#var type:int = SKILL_type.NONE
#var cd_max:int = 0
#var damage:int = 0
#var require_energy:int = 0
#var effect:String = "None"
#var sname:String = "None" --> not nessarry
#var description:String = "None" --> not nessarry
#var installation_fee:int = 0

#[0-> ID, 1-> type, 2-> cooldown, 3-> damage, 4-> req_energy,
#5-> effect:String,
#6-> name:String,
#7-> description:String
#8-> installation fee
#],
class_name Addons_Pool

var Addons = [
	[1, 1, 20, 90, 5,
	"res://Scenes/Effects/Energy_Ball.tscn",
	"Energy Ball",
	"A Projectile Energy reducing target Health Points by 90 plus user power attribute",
	1000
	],
	
	[2, 2, 24, 60, 10,
	"res://Scenes/Effects/Flash_Bang.tscn",
	"Flash Bang",
	"Damage near-by Enemies Health Points by 60 + user power attribute",
	1500
	],
	
	[3, 1, 25, 140, 12,
	"res://Scenes/Effects/Lighting_Ball.tscn",
	"Lighting Ball",
	"A Projectile Energy reducing target Health Points by 140 + user power attribute",
	2000
	],
	
	[4, 3, 45, 200, 20,
	"res://Scenes/Effects/Explosion.tscn",
	"Explosion",
	"A energy Explosion in front of user, Dealing 200 damage hp plus user power attribute by double",
	5500
	]
]

func get_addons_count():
	return Addons.size()
