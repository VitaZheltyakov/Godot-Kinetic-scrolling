extends Node


# To ensure the operation of internal objects, you need to check the status of the scroll container
func _on_Button1_button_up():
	if (!get_node("ScrollContainer1").swiping):
		print("You pressed the button 1")


func _on_Button2_button_up():
	if (!get_node("ScrollContainer1").swiping):
		print("You pressed the button 2")


func _on_Button3_button_up():
	if (!get_node("ScrollContainer1").swiping):
		print("You pressed the button 3")


func _on_Button4_button_up():
	if (!get_node("ScrollContainer1").swiping):
		print("You pressed the button 4")


func _on_Button5_button_up():
	if (!get_node("ScrollContainer2").swiping):
		print("You pressed the button 5")


func _on_Button6_button_up():
	if (!get_node("ScrollContainer2").swiping):
		print("You pressed the button 6")


func _on_Button7_button_up():
	if (!get_node("ScrollContainer2").swiping):
		print("You pressed the button 7")


func _on_Button8_button_up():
	if (!get_node("ScrollContainer2").swiping):
		print("You pressed the button 8")


# Kinetic scroll uses the `_input` function. 
# Therefore, in some cases, it is desirable to disable it.
# You can disable kinetic scrolling using the function `setKineticScrollEnable`
func _on_CheckButton1_toggled(button_pressed):
	get_node("ScrollContainer1").setKineticScrollEnable(button_pressed)


func _on_CheckButton2_toggled(button_pressed):
	get_node("ScrollContainer2").setKineticScrollEnable(button_pressed)
