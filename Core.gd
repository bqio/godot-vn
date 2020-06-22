extends Node2D

class_name Core

var _self
var _background: Background
var _textbox: TextBox
var _rich: Text
var _normal_font: DynamicFont
var _textures: Dictionary
var _char_stack: Dictionary
var _character_name_colors: Dictionary

signal mouse_click

func _init(context):
	_self = context
	_background = Background.new()
	_textbox = TextBox.new()
	_rich = Text.new()
	_normal_font = DynamicFont.new()
	
	_self.add_child(_background)
	_self.add_child(_textbox)
	_self.add_child(_rich)
	
func event_listener(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		emit_signal("mouse_click")
	
func define_texture_bg(name: String, texture_path: String):
	_textures["bg_" + name] = load("res://" + texture_path)

func define_normal_font(font_path: String, size: int = 16):
	_normal_font.font_data = load("res://" + font_path)
	_normal_font.size = size
	_rich._text.add_font_override("normal_font", _normal_font)
	
func define_texture_character(name: String, texture_path: String):
	_textures["char_" + name] = load("res://" + texture_path)
	
func define_character_name_color(name: String, color_name_hex: String):
	_character_name_colors[name] = color_name_hex
	
func bg(name: String):
	return ["bg", _textures["bg_" + name]]
	
func sprite(name: String, pos: float, is_flip: bool = false):
	return ["sprite", Character.new(name, pos, _textures["char_" + name], is_flip)]
	
func text(how: String, text: String):
	var color
	if (_character_name_colors.has(how)):
		color = _character_name_colors[how]
	else:
		color = "#FFFFFF"
	return ["text", how, text, color]
	
func end():
	return ["end"]
	
func render(middlewares: Array):
	for middleware in middlewares:
		print(middleware)
		match middleware[0]:
			"bg":
				bg_event_handler(middleware)
			"sprite":
				char_event_handler(middleware)
			"text":
				text_event_handler(middleware)
				yield(self, "mouse_click")
				_rich._text.clear()
			"end":
				end_game_event_handler()
			
func bg_event_handler(middleware):
	_background.rect.texture = middleware[1]

func char_event_handler(middleware):
	if _char_stack.has(middleware[1]._name):
		_self.remove_child(_char_stack[middleware[1]._name])
# warning-ignore:return_value_discarded
		_char_stack.erase(middleware[1]._name)
	_char_stack[middleware[1]._name] = middleware[1]
	_self.add_child(middleware[1])
	
func text_event_handler(middleware):
	_rich._text.push_color(Color(middleware[3]))
	_rich._text.add_text(middleware[1])
	_rich._text.pop()
	_rich._text.add_text(": " + middleware[2])

func end_game_event_handler():
	_self.get_tree().quit()
