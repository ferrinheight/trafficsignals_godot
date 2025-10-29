class_name GameboardRow
extends HBoxContainer

# set true in editor to enable debug logic
@export var debug_scene: bool = false

var _debug_last_clicked_cell: GameboardCell = null

static func random_cell_type() -> String:
	return "gyr"[randi() % 3]

func _ready() -> void:
	if debug_scene:
		var _debug_this_row: GameboardRow = $"."
		for _debug_child in _debug_this_row.get_children():
			if _debug_child is GameboardCell:
				_debug_child.init_cell(0, int(str(_debug_child.name)[-1]), random_cell_type())
				_debug_child.connect("cell_clicked", Callable(self, "_debug_on_cell_clicked").bind(_debug_child))

func _debug_contiguos_cells(_debug_cella: GameboardCell, _debug_cellb: GameboardCell) -> bool:
	var _debug_diff: int = _debug_cella.get_cell_coords().x - _debug_cellb.get_cell_coords().x
	if abs(_debug_diff) == 1:
		return true
	return false
	
func _debug_on_cell_clicked(_debug_clicked_cell: GameboardCell) -> void:
	if _debug_last_clicked_cell and _debug_last_clicked_cell != _debug_clicked_cell:
		if _debug_contiguos_cells(_debug_clicked_cell, _debug_last_clicked_cell):
			# perform swap of cells by simply changing each type to that of the other
			var _debug_ab: String = _debug_clicked_cell.get_cell_type()
			var _debug_ba: String = _debug_last_clicked_cell.get_cell_type()
			_debug_clicked_cell.set_cell_type(_debug_ba)
			_debug_last_clicked_cell.set_cell_type(_debug_ab)
			_debug_clicked_cell.deselect_cell()
			_debug_last_clicked_cell.deselect_cell()
			_debug_clicked_cell = null
			_debug_last_clicked_cell = null
		else:
			_debug_last_clicked_cell.deselect_cell()
	_debug_last_clicked_cell = _debug_clicked_cell
