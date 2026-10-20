@tool
extends Area2D
class_name WaterBody2D;

const WATER_MASK = ~(1 << 32);
const PRIORITY = 2;


@export var current_force: Vector2;
@export var friction: float;

var bodies: Array[PhysicsBody2D];

func _init() -> void:
	if (Engine.is_editor_hint()):
		collision_layer = WATER_MASK;
		collision_mask = WATER_MASK;
		priority = PRIORITY;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_body_entered);
	body_exited.connect(_body_exited);
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	for body: PhysicsBody2D in bodies:
		if body is CharacterBody2D:
			body.velocity += current_force * (1. - friction);
			
		if (body is RigidBody2D):
			body.apply_force(current_force  * (1. - friction));
			

func _body_entered(body:Node2D):
	if ((body is RigidBody2D || body is CharacterBody2D) && !body in bodies):
		#print("body entered: ", body);
		if (body is SwimmingController):
			body.in_water = true;
		bodies.push_back(body);
		print(body);


func _body_exited(body: Node2D):
	if (body is RigidBody2D || body is CharacterBody2D):
		var index:int = bodies.find(body);
		if (index != -1):
			bodies.remove_at(index);
			if (body is SwimmingController):
				body.in_water = false;
