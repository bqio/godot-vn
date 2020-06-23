extends Node2D

var vn

# init event listener (required)
func _input(ev):
	vn.event_listener(ev)

func _ready():
	# init
	vn = Core.new(self)
	
	# defines
	vn.define_texture_bg("Default", "res/img/bg0.jpg")
	vn.define_texture_bg("Main", "res/img/bg1.jpg")
	vn.define_texture_character("Alisa", "res/img/Dv.png")
	vn.define_texture_character("Lena", "res/img/Lena.png")
	vn.define_character_name_color("Alisa", "#FF0000")
	vn.define_character_name_color("Lena", "#0000FF")
	vn.define_normal_font("res/fonts/BalsamiqSans-Regular.ttf", 20)
	
#	var vne = vn.load_vne_file("res/scripts/script.vne")
#	vn.render(vne)

	vn.render([
		"bg Main",
		"sprite Alisa 0.5",
		"text Alisa Hello!",
		"end"
	])
