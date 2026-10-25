class_name SwimmingController
extends PlatformerController

enum {SWIM = 8}

@export var max_time_submerged:float = 5.0;
@export var submersion_progressbar: ProgressBar;
@export var default_water_gravity: Vector2 = Vector2.ZERO;
@export var swim_speed:float = 0;
var in_water: bool;
var submerged: bool;
var time_submerged = 0.0:
	get:
		return time_submerged;
	set(v):
		time_submerged = v;
		submersion_progressbar.value = submersion_progressbar.max_value * (time_submerged / max_time_submerged);
var _gravity_store = 0;
var _can_wall_jump_store = false;
var swim_force: Vector2;

var current_water_area: WaterBody2D;

func set_water_area(area: Area2D):
	if (area is WaterBody2D):
		current_water_area = area;
func unset_water_area(area: Area2D):
	if (area is WaterBody2D && area == current_water_area):
		current_water_area = null;
func detect_water(area: Area2D):
	if (area is WaterBody2D):
		submerged = true;
		

func undetect_water(area: Area2D):
	if (area is WaterBody2D):
		submerged = false
		time_submerged = 0.0;

func manage_state() -> void:
	if (in_water):
		#modulate = Color.GREEN;
		state = SWIM;
		#can_jump = false;
		can_jump = false;
		#can_sprint = false;
		#_gravity_store = GRAVITY;
		GRAVITY = 0;
		can_wall_jump = false;
		#floor_max_angle = PI * 0.25;
	else:
		GRAVITY = _gravity_store;
		#floor_max_angle = _max_angle_store;
		can_wall_jump = _can_wall_jump_store;
		#modulate = Color.WHITE;
		super.manage_state();

func _ready() -> void:
	_gravity_store = GRAVITY;
	_can_wall_jump_store = can_wall_jump;

	
func check_collisions():
	if (state != SWIM):
		return;
	
	var l := velocity.length();
	if (l > MAX_SPEED):
		velocity = velocity.normalized() * MAX_SPEED;


func manage_animations() -> void:
	if (state == SWIM):
		play_animation("Swim");
	super.manage_animations();

func physics_tick(delta:float, inputs: Dictionary) -> void:
	handle_swimming(inputs);
	handle_time_submerged(delta);
	super.physics_tick(delta, inputs);

func handle_time_submerged(delta:float) -> void:
	if (submerged):
		time_submerged += delta;
func handle_swimming(inputs: Dictionary):
	if (state == SWIM):
		swim_force = (inputs.input_direction * swim_speed + default_water_gravity * (1.0 if submerged else 0.5))
		swim_force += Vector2.ZERO if current_water_area == null else current_water_area.current_force;
		swim_force += Vector2.ZERO if not inputs.crouching else default_water_gravity * 4.0;
		velocity += swim_force;
		
		
	
	
