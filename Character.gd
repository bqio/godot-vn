extends Node2D

class_name Character

var rect: TextureRect
var _name: String

func _init(name: String, pos: float, texture: Texture, is_flip: bool):
	z_index = 1
	_name = name
	
	rect = TextureRect.new()
	rect.texture = texture
	rect.flip_h = is_flip
	rect.set_expand(true)
	rect.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT_COVERED)
	rect.set_size(Vector2(OS.get_window_size().x * 0.3333333333, OS.get_window_size().y))
	position.x = OS.get_window_size().x * pos
	
	add_child(rect)
