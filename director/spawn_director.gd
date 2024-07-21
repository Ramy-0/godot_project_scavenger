extends Node2D

@export_group("Stats")
@export var credits: float = 50
@export var credit_gain_delay : float = 1.0
@export var credit_gain : int = 5
@export var credit_threshold : int = 100
@export var waves_number : int = 5
@export var wave_delay : float = 1.0

@export_group("Nodes")
@export var player : CharacterBody2D
@export var world : Node2D

@export_group("Enemy Pool")
@export var enemy_pool : Array = [
	[preload("res://enemy/enemy_basic.tscn"), 5, 100],
	[preload("res://enemy/enemy_charger.tscn"), 15, 25]
]

@onready var stateChart = $StateChart

var waves_credits : Array

func _ready():
	$CreditGain_Timer.wait_time = credit_gain_delay
	
	world = get_parent()
	player = MyFuncs.get_children_in_group(world, "Player")[0]
	print(world)
	print(player)
	
	#print(enemy_pool[0][0].spawn_price)

func _process(delta):
	$VBoxContainer/Label.text = "credits =" + str(credits)

func _on_credit_gain_timer_timeout():
	credits += credit_gain
	#print(credits)


func _on_save_state_processing(delta):
	if credits >= credit_threshold:
		stateChart.send_event("start_assault")

func _on_assault_state_entered():
	print("assult started")
	waves_credits.resize(waves_number - 1)
	waves_credits.fill(floor(credits/waves_number))
	waves_credits.append(credits - floor(credits/waves_number) * (waves_number - 1))
	#print(waves_credits)

func _on_wait_state_entered():
	await get_tree().create_timer(wave_delay).timeout
	stateChart.send_event("spawn")

func _on_spawn_state_entered():
	if waves_credits.size() == 0:
		stateChart.send_event("stop_assault")
	else:
		var current_wave_credit = waves_credits.pop_front()
		credits -= current_wave_credit
		#waves_credits.remove_at(0)
		#print(current_wave_credit)
		
		spawn_random_using_credits(current_wave_credit)
		
		stateChart.send_event("wait")

func spawn_random_using_credits(crd):
	var credits_to_use = crd
	var enemy_prices : Array = []
	for i in enemy_pool:
		enemy_prices.append(i[1])
	var enemy_weights : Array = []
	for i in enemy_pool:
		enemy_weights.append(i[2])
	
	#print(enemy_prices, enemy_weights)
	
	#print(enemy_prices.min())
	var enemies_total_weight = 0
	for i in enemy_weights:
		enemies_total_weight += i
	print(enemies_total_weight)
	while credits_to_use >= enemy_prices.min():
		
	
		var rand_num = randi_range(0, enemies_total_weight)
		
		for x in range(enemy_pool.size()):
			if rand_num <= enemy_weights[x] and credits_to_use >= enemy_prices[x]:
				print(enemy_pool[x])
				spawn_enemy(enemy_pool[x][0])
				credits_to_use -= enemy_prices[x]
				break
			else :
				rand_num -= enemy_weights[x]

func spawn_enemy(enemy):
	var enemy_inst = enemy.instantiate()
	enemy_inst.global_position = Vector2(player.global_position.x + randi_range(-2500,2500),
	 player.global_position.y + randi_range(-2500,2500))
	print(enemy_inst, " had spawned")
	world.add_child(enemy_inst)
