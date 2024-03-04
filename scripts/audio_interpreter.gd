extends Node3D

@export var index = 0
@export var smoothing = 0.1
@export var c_rotate:Vector3 = Vector3(0,0,0)
@export var c_move:Vector3 = Vector3(0,0,0)
@export var c_scale:Vector3 = Vector3(0,0,0)

# fft spectrum helps us identify the different frequencies present in the signal. 
@onready var spectrum = Spectrum.new()

func _ready():
	spectrum.vu_count = 16 # resolution
	spectrum.smoothing = smoothing
	spectrum.init()


func _process(delta):
	spectrum.calculate()
	position = c_move*spectrum.get_energy_at(index) #input 0-16 according to defined vu_count, returns value between 0 and 1
	rotation = c_rotate*spectrum.get_energy_at(index)
	scale = Vector3(1,1,1)+c_scale*spectrum.get_energy_at(index)

