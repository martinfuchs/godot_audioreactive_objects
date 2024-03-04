extends Node3D

@onready var spectrum = Spectrum.new()

func _ready():
	spectrum.vu_count = 16
	spectrum.smoothing = 0.4
	spectrum.init()


func _process(delta):
	spectrum.calculate()
	position.y = spectrum.get_energy_at(0) #input 0-16 according to defined vu_count, returns value between 0 and 1
	rotation.x += spectrum.get_energy_at(2)*0.01

