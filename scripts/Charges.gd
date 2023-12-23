extends BoxContainer

@export var max_pips: int
@export var fill_color: Color

var pips: int

func set_pips(pips):
	self.pips = pips
	
	for i in max_pips:
		get_child(i).modulate = Color.DIM_GRAY
	
	for i in pips:
		get_child(i).modulate = fill_color
	
