extends Node2D

class_name Text

var _text: RichTextLabel

func _init():
	z_index = 3
		
	_text = RichTextLabel.new()
	_text.set_size(Vector2(1160, 100))
	_text.set_position(Vector2(80, 500))
	
	add_child(_text)
