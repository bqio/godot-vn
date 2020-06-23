extends Node

class_name EventHandler

var _self

func _init(context):
	_self = context
	
func emit(method: String, args: Array = []):
	callv(method, args)

func bg(name: String):
	_self._background.rect.texture = _self._textures["bg_" + name]

func sprite(name: String, pos: float = 0.0, is_flip: bool = false):
	var character = Character.new(name, pos, _self._textures["char_" + name], is_flip)
	if _self._char_stack.has(character._name):
		_self.remove_child(_self._char_stack[character._name])
		_self._char_stack.erase(character._name)
	_self._char_stack[character._name] = character
	_self._self.add_child(character)

func text(how: String, text: String):
	var color
	if (_self._character_name_colors.has(how)):
		color = _self._character_name_colors[how]
	else:
		color = "#FFFFFF"
	_self._rich._text.clear()
	_self._rich._text.push_color(Color(color))
	_self._rich._text.add_text(how)
	_self._rich._text.pop()
	_self._rich._text.add_text(": " + text)

func end():
	_self._self.get_tree().quit()
