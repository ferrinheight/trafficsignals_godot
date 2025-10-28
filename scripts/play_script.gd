extends Control

# set true in editor to enable debug logic
@export var debug_scene: bool = false

#var GameboardRowScene: PackedScene = preload("res://scenes/cell_row_scene.tscn")
@onready var game_board: GridContainer = $CanvasLayer/GameBoard
var grid: String = ""
var last_clicked_cell: GameboardCell = null

func _ready() -> void:
	if debug_scene:
		var rows: Array = ["ggtestgg",
			"gggggggg",
			"rryggyrr",
			"ggyrrygg",
			"ggyrrygg",
			"rryggyrr",
			"gggggggg",
			"gggggggg"]
		for n in range(len(rows)):
			grid += rows[n]
	else:
		for i in range(64):
			grid += GameboardRow.random_cell_type()
	# Connect cell signals after children are ready
	for child_row in game_board.get_children():
		if child_row is GameboardRow:
			var cell_row: int = int(str(child_row.name)[-1])
			for child_cell in child_row.get_children():
				if child_cell is GameboardCell:
					var cell_column: int = int(str(child_cell.name)[-1])
					var cell_color: String = str(grid[cell_row * 8 + cell_column])
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
	
func _on_cell_clicked(clicked_cell: GameboardCell) -> void:
	if last_clicked_cell and last_clicked_cell != clicked_cell:
		#var last_coords: Vector2 = last_clicked_cell.get_cell_coords()
		#var new_coords: Vector2 = clicked_cell.get_cell_coords()
		#var diff: Vector2 = new_coords - last_coords
		# Check if bordering (adjacent horizontally or vertically)
		#var is_bordering: bool = (abs(diff.x) == 1 and diff.y == 0) or (abs(diff.y) == 1 and diff.x == 0)
		# perform swap of cells by simply changing each type to that of the other
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
