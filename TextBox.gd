extends Node2D

class_name TextBox

var rect: TextureRect

func _init():
	z_index = 2
	
	rect = TextureRect.new()
	rect.texture = load("res://res/img/textbox.png")
	rect.set_expand(true)
	rect.set_stretch_mode(TextureRect.STRETCH_SCALE)
	rect.set_size(Vector2(OS.get_window_size().x - 80, rect.texture.get_size().y))
	rect.set_position(Vector2(40, OS.get_window_size().y - rect.texture.get_size().y - 40))
	
	add_child(rect)
