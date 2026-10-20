class_name SwimmingController
extends PlatformerController

enum {SWIM = 8}

@export var default_water_gravity: Vector2 = Vector2.ZERO;
@export var swim_speed:float = 0;
var in_water: bool;

var _gravity_store = 0;
var _can_wall_jump_store = false;
var swim_force: Vector2;

func manage_state() -> void:
	
	if (in_water):
		#modulate = Color.GREEN;
		state = SWIM;
		#can_jump = false;
		can_jump = false;
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

func physics_tick(inputs: Dictionary) -> void:
	handle_swimming(inputs);
	super.physics_tick(inputs);
	
func handle_swimming(inputs: Dictionary):
	if (state == SWIM):
		swim_force = (inputs.input_direction * swim_speed + default_water_gravity)
		velocity += swim_force;
		
	
	
