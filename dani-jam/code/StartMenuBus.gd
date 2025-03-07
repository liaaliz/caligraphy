extends Control 
@export var options_swipe : Node2D
@export var start_swipe : Node2D
@export var exit_swipe : Node2D

@onready var game_resource : GameResource = preload("res://code/resources/GameResource.tres")
var selected_buttons: Array = []  # Track selected buttons
var is_processing: bool = false   # Prevent re-entrancy

func _ready() -> void:
	# Connect swipe buttons with error checking
	if start_swipe and start_swipe.has_signal("on_end_swipe"):
		start_swipe.connect("on_end_swipe", Callable(self, "_on_button_selected").bind(start_swipe))
	if options_swipe and options_swipe.has_signal("on_end_swipe"):
		options_swipe.connect("on_end_swipe", Callable(self, "_on_button_selected").bind(options_swipe))
	if exit_swipe and exit_swipe.has_signal("on_end_swipe"):
		exit_swipe.connect("on_end_swipe", Callable(self, "_on_button_selected").bind(exit_swipe))

func _on_button_selected(button: Node2D) -> void:
	if is_processing:
		return  # Prevent re-entrancy
		
	is_processing = true
	if not button:
		push_error("Received null button selection")
		is_processing = false
		return
		
	selected_buttons.append(button)
	print("Button selected: ", button.name)
	print("Current selected buttons: ", selected_buttons.map(func(b): return b.name))
		
	# Check for multiple selections
	if selected_buttons.size() > 1:
		_check_multiple_selections()
	else:
		_handle_button_action(button)
		_clear_selection()
	
	is_processing = false

func _check_multiple_selections() -> void:
	print("Checking multiple selections...")
	print("Selected buttons: ", selected_buttons.map(func(b): return b.name))
	
	# Check if all selected buttons are the same
	var first_button = selected_buttons[0]
	if selected_buttons.all(func(btn): return btn == first_button):
		print("Multiple selections of the same button: ", first_button.name)
		_handle_button_action(first_button)
	else:
		print("Multiple different buttons selected:")
		for button in selected_buttons:
			print("- ", button.name)
	_clear_selection()

func _handle_button_action(button: Node2D) -> void:
	print("Handling button action: ", button.name)
	if button == start_swipe:
		print("Start button activated")
		game_resource.change_state(game_resource.GAME_STATE.IN_GAME)
	elif button == options_swipe:
		print("Options button activated")
		# Add options menu logic here
	elif button == exit_swipe:
		print("Exit button activated")
		# Add exit logic here

func _clear_selection() -> void:
	print("Clearing selection")
	selected_buttons.clear()
	# Reset all buttons
	for button in [start_swipe, options_swipe, exit_swipe]:
		if button and button.has_method("reset"):
			button.call("reset")
