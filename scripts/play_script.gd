extends Control

# set true in editor to enable debug logic
@export var debug_scene: bool = false
@export var default_grid: String = ""
#var GameboardRowScene: PackedScene = preload("res://scenes/cell_row_scene.tscn")
@onready var game_board: GridContainer = $CanvasLayer/GameBoard

var last_clicked_cell: GameboardCell = null

func _ready() -> void:
	if debug_scene:
		var debug_rows: Array = [
			"RGYGRGGR",
			"GYRGGGYG",
			"RGGGRGGG",
			"GGYRYRYR",
			"RGGGGYGY",
			"GGRYGGRG",
			"RRRGGRYR",
			"GGYGRGGG",
		]
		default_grid = get_grid_string(debug_rows)
	else:
		default_grid = generate_random_grid()
	# Connect cell signals after children are ready
	for child_row in game_board.get_children():
		if child_row is GameboardRow:
			var cell_row: int = int(str(child_row.name)[-1])
			for child_cell in child_row.get_children():
				if child_cell is GameboardCell:
					var cell_column: int = int(str(child_cell.name)[-1])
					var cell_color: String = str(default_grid[cell_row * 8 + cell_column]).to_lower()
					if cell_color not in ["g", "y", "r"]:
						cell_color = GameboardRow.random_cell_type()
					child_cell.init_cell(cell_row, cell_column, cell_color)
					child_cell.connect("cell_clicked", Callable(self, "_on_cell_clicked").bind(child_cell))

func contiguos_cells(cella: GameboardCell, cellb: GameboardCell) -> bool:
	var diff: Vector2 = cella.get_cell_coords() - cellb.get_cell_coords()
	if debug_scene:
		print_debug(cella)
		print_debug(cellb)
		print_debug(diff)
	if abs(diff.x) == 1 and diff.y == 0:
		return true
	if abs(diff.y) == 1 and diff.x == 0:
		return true
	return false

func generate_random_grid() -> String:
	var random_grid: String = ""
	for i in range(64):
		random_grid += GameboardRow.random_cell_type()
	return random_grid

func get_grid_string(grid_rows: Variant = null) -> String:
	var grid_string: String = ""
	if grid_rows is Array:
		for n in range(len(grid_rows)):
			grid_string += str(grid_rows[n])
	elif grid_rows is String:
		grid_string = grid_rows
	else:
		grid_string = generate_random_grid()
	return grid_string
	
func _on_cell_clicked(clicked_cell: GameboardCell) -> void:
	if last_clicked_cell and last_clicked_cell != clicked_cell:
		if contiguos_cells(clicked_cell, last_clicked_cell):
			var ab: String = clicked_cell.get_cell_type()
			var ba: String = last_clicked_cell.get_cell_type()
			clicked_cell.set_cell_type(ba)
			last_clicked_cell.set_cell_type(ab)
			clicked_cell.deselect_cell()
			last_clicked_cell.deselect_cell()
			clicked_cell = null
			last_clicked_cell = null
		else:
			last_clicked_cell.deselect_cell()
	last_clicked_cell = clicked_cell
