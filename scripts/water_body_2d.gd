extends Area2D
class_name WaterBody2D;

@export var current_force: Vector2;
@export var friction: float;

var bodies: Array[PhysicsBody2D];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_body_entered);
	body_exited.connect(_body_exited);
	pass # Replace with function body.

func _body_entered(body:Node2D):
	if (body is PhysicsBody2D && body is not StaticBody2D && !body in bodies):
		print("body entered: ", body);
		bodies.push_back(body);

func _body_exited(body: Node2D):
	if (body is PhysicsBody2D&& body is not StaticBody2D):
		var index:int = bodies.find(body);
		if (index != -1):
			bodies.remove_at(index);
