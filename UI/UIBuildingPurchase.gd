extends TextureButton

onready var _label := $Label

var cost = 0

func _ready() -> void:
	cost = GameData.buildings[get_name()]["cost"]
	_label.text = "Cost: %s" % cost
	

