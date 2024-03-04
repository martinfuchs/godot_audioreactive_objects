extends Node
class_name Spectrum

const FREQ_MAX = 11050.0

@export var vu_count = 16
@export var min_db = 60
@export var smoothing = 0.1


var spectrum
var energy_array = []


func init():
	spectrum = AudioServer.get_bus_effect_instance(0,0)

	for i in range(0, vu_count+1):
		energy_array.append(0)


func calculate():
	var prev_hz = 0
	
	var index_pos = 0
	for i in range(0, vu_count+1):
		var hz = i * FREQ_MAX / vu_count
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((min_db + linear_to_db(magnitude)) / min_db, 0.0, 1.0)
		energy_array[index_pos] += (energy-energy_array[index_pos])*smoothing
		
		index_pos+=1
		prev_hz = hz


func get_energy_at(index):
	if index>=0 and index<energy_array.size():
		return energy_array[index]
	else:
		print("energy array index error!")
		return 0
