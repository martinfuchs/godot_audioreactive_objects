extends Node3D

@export var index = 0
@export var smoothing = 0.1
@export var _rotate:Vector3 = Vector3(0,0,0)
@export var _rotate_continuous = false
@export var _move:Vector3 = Vector3(0,0,0)
@export var _move_continuous = false
@export var _move_bounds_max:Vector3 = Vector3(0,0,0)
@export var _move_bounds_min:Vector3 = Vector3(0,0,0)
@export var _scale:Vector3 = Vector3(0,0,0)

# fft spectrum helps us identify the different frequencies present in the signal. 
@onready var spectrum = Spectrum.new()

func _ready():
	spectrum.vu_count = 16 # resolution
	spectrum.smoothing = smoothing
	spectrum.init()


func _process(delta):
	spectrum.calculate()
	if _move_continuous:
		position += _move*spectrum.get_energy_at(index)
		if position>_move_bounds_max:
			position = _move_bounds_min
		if position<_move_bounds_min:
			position = _move_bounds_max
	else:
		position = _move*spectrum.get_energy_at(index) #input 0-16 according to defined vu_count, returns value between 0 and 1
	
	if _rotate_continuous:
		rotation += _rotate*spectrum.get_energy_at(index)
	else:
		rotation = _rotate*spectrum.get_energy_at(index)
		
	scale = Vector3(1,1,1)+_scale*spectrum.get_energy_at(index)

