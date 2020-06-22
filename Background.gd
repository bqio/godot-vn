extends Node2D

class_name Background

var rect: TextureRect

func _init():
	z_index = 0
	
	rect = TextureRect.new()
	rect.set_expand(true)
	rect.set_stretch_mode(TextureRect.STRETCH_SCALE)
	rect.set_size(Vector2(OS.get_window_size().x, OS.get_window_size().y))
	
	add_child(rect)
	
