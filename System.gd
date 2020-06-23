extends Node

class_name System

static func is_valid_bool(string: String):
	var ascii = Array(string.to_ascii())
	var bytes_true = [116, 114, 117, 101]
	var bytes_false = [102, 97, 108, 115, 101]
	
	if ascii == bytes_true:
		return true
	elif ascii == bytes_false:
		return true
	else:
		return false
		
static func string_arr_to_typed(string_arr: Array):
	var typed_arr: Array = []
	for i in string_arr:
		if i.is_valid_float():
			typed_arr.append(float(i))
		elif i.is_valid_integer():
			typed_arr.append(int(i))
		elif is_valid_bool(i):
			typed_arr.append(bool(i))
		else:
			typed_arr.append(i)
	return typed_arr
