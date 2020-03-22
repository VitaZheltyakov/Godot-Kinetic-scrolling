extends ScrollContainer
# The script adds the ability to kinetic scroll for ScrollContainer
# It is necessary to check the state of the scroll when working with internal controls

# The variable determines the direction of the scroll
export(String, "Horizontal", "Vertical") var scrollDirection = "Horizontal"
# Variable specifies how long it will continue scrolling
export var kineticScrollTime = 0.3
# The variable determines the kinetic scroll length
export var kineticScrollBias = 0.5
# The variable determines which offset to consider as a swipe
export var swipeTolerance = 50

# The variable shows the state of the scroll. Used to organize the work of internal controls
var swiping = false

var _swipePoint = null


func _input(event):
	# Check that the cursor is over the scroll area
	if (!self.get_rect().has_point(event.position)):
		swiping = false
		_swipePoint = null
		return
	# By pressing set the necessary variables
	if (event is InputEventMouseButton) and (event.pressed == true): 
		swiping = true
		if ((event.button_index == BUTTON_LEFT) or (event.button_index == BUTTON_RIGHT)):
			_swipePoint = event.position
		if ((event.button_index == BUTTON_WHEEL_UP) or (event.button_index == BUTTON_WHEEL_DOWN)):
			_swipePoint = Vector2(self.get_h_scroll(), self.get_v_scroll())
	if (swiping) and (event is InputEventMouseButton) and (event.pressed == false):
		# Swipe off if the cursor position has not changed
		if ((_swipePoint - event.position).length() < swipeTolerance):
			swiping = false
			_swipePoint = null
			return
		# Create a tween responsible for kinetic scrolling
		var tween = Tween.new()
		add_child(tween)
		if ((event.button_index == BUTTON_LEFT) or (event.button_index == BUTTON_RIGHT)):
			if (scrollDirection == "Horizontal"):
				tween.interpolate_method(self, "set_h_scroll", self.get_h_scroll(), 
					self.get_h_scroll() - kineticScrollBias*(event.position.x - _swipePoint.x), kineticScrollTime, 
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			if (scrollDirection == "Vertical"):
				tween.interpolate_method(self, "set_v_scroll", self.get_v_scroll(), 
					self.get_v_scroll() - kineticScrollBias*(event.position.y - _swipePoint.y), kineticScrollTime, 
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		if ((event.button_index == BUTTON_WHEEL_UP) or (event.button_index == BUTTON_WHEEL_DOWN)):
			if (scrollDirection == "Horizontal"):
				tween.interpolate_method(self, "set_h_scroll", self.get_h_scroll(), 
					self.get_h_scroll() + kineticScrollBias*(self.get_h_scroll() - _swipePoint.x), kineticScrollTime, 
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			if (scrollDirection == "Vertical"):
				tween.interpolate_method(self, "set_v_scroll", self.get_v_scroll(), 
					self.get_v_scroll() + kineticScrollBias*(self.get_v_scroll() - _swipePoint.y), kineticScrollTime, 
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.interpolate_callback(self, kineticScrollTime, "set", "swiping", false)
		tween.interpolate_callback(tween, kineticScrollTime, "queue_free")
		tween.start()
		_swipePoint = null
	# Scrolling while moving the cursor
	if (_swipePoint != null) and (event is InputEventMouseMotion):
		if (scrollDirection == "Horizontal"):
			self.set_h_scroll(self.get_h_scroll() - event.position.x + _swipePoint.x)
		if (scrollDirection == "Vertical"):
			self.set_v_scroll(self.get_v_scroll() - event.position.y + _swipePoint.y)
