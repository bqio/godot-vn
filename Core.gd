extends Node2D

class_name Core

var _self
var _event_handler: EventHandler
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
	_event_handler = EventHandler.new(self)
	
	_self.add_child(_background)
	_self.add_child(_textbox)
	_self.add_child(_rich)

func event_listener(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		emit_signal("mouse_click")

func load_vne_file(file_path: String):
	var file = File.new()
	file.open("res://" + file_path, file.READ)
	var text = file.get_as_text()
	file.close()
	return text.split("\n", true)

func parse_middlewares(middlewares: Array):
	var mws: Array = []
	for mw in middlewares:
		var typed_arr = System.string_arr_to_typed(mw.split(" ", true))
		mws.append(typed_arr)
	return mws

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

func render(string_middlewares: Array):
	var middlewares: Array = parse_middlewares(string_middlewares)
	for middleware in middlewares:
		match middleware[0]:
			"bg":
				middleware.pop_front()
				_event_handler.emit("bg", middleware)
			"sprite":
				middleware.pop_front()
				_event_handler.emit("sprite", middleware)
			"text":
				middleware.pop_front()
				_event_handler.emit("text", middleware)
				yield(self, "mouse_click")
			"end":
				_event_handler.emit("end")
