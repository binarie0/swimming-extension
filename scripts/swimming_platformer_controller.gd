class_name SwimmingController
extends PlatformerController

enum {SWIM = 8}

@export var default_water_gravity: Vector2 = Vector2.ZERO;
@export var swim_speed:float = 0;
var in_water: bool;

func manage_state() -> void:
	
	if (in_water):
		#modulate = Color.GREEN;
		state = SWIM;
		#can_jump = false;
		should_jump = false;
	else:
		#modulate = Color.WHITE;
		super.manage_state();
		
func manage_animations() -> void:
	if (in_water && state == SWIM):
		ANIMATION_PLAYER.play("Swim");
	super.manage_animations();

func physics_tick(delta: float, inputs: Dictionary) -> void:
	handle_swimming(delta, inputs);
	super.physics_tick(delta, inputs);
	
func handle_swimming(delta: float, inputs: Dictionary):
	if (state == SWIM):
		velocity += (inputs.input_direction * swim_speed + default_water_gravity) * delta;
	
	
