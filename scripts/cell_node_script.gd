class_name GameboardCell
extends PanelContainer

# set true in editor to enable debug logic
@export var debug_scene: bool = false

# outline is used to higlight selected cells 
@onready var cell_outline: ColorRect = $Outline
# center is colored per the cells type; green, yellow or red
@onready var cell_center: ColorRect = $Center
# color settings for outline and center nodes ^
var _my_outline_color: Color = Color.GRAY
var _my_center_color: Color = Color.FUCHSIA
var _my_row: int = -1
var _my_column: int = -1
# a single character string representing the cells type/color; "g"reen, "y"ellow or "r"ed
var _my_cell_type: String = ""
var _my_selected_status: bool = false

signal cell_clicked(cell: GameboardCell)

### private functions ###
func _ready() -> void:
	if cell_outline:
		_set_my_outline()
	if cell_center:
		_set_my_color()

# set this cells center color
func _set_my_color() -> void:
	if cell_center:
		cell_center.color = _my_center_color
	
# set this cells outline color when highlighted, reset otherwise
func _set_my_outline() -> void:
	if cell_outline:
		if _my_selected_status:
			cell_outline.color = Color.FUCHSIA
		else:
			cell_outline.color = _my_outline_color

# handle input(mouse) events
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if debug_scene:
			print_debug("cell clicked at coords: " + str(get_cell_coords()))
		#if not _my_highlight_status:
		_my_selected_status = not _my_selected_status
		_set_my_outline()
		emit_signal("cell_clicked")

# initialize this cell
func init_cell(row: int, column: int, cell_type: String) -> void:
	_my_row = row
	_my_column = column
	set_cell_type(cell_type)
	_set_my_color()
	_set_my_outline()

### public functions ###
# get this cell's coords on the gameboard
func get_cell_coords() -> Vector2:
	return Vector2(_my_column, _my_row)

# set this cells type; "g"reen, "y"ellow or "r"ed. defaults to "g"reen
func set_cell_type(cell_type: String = "g") -> void:
	_my_cell_type = cell_type
	if _my_cell_type not in ["g", "y", "r"]:
		_my_cell_type = "g"
	if _my_cell_type == "g":
		_my_center_color = Color.WEB_GREEN
		_my_outline_color = Color.GREEN
	elif _my_cell_type == "y":
		_my_center_color = Color.GOLD
		_my_outline_color = Color.YELLOW
	elif _my_cell_type == "r":
		_my_center_color = Color.FIREBRICK
		_my_outline_color = Color.RED
	_set_my_color()

# get this cells "type" aka color indicator string
func get_cell_type() -> String:
	return _my_cell_type

# deselect this cell
func deselect_cell() -> void:
	_my_selected_status = false
	_set_my_outline()
