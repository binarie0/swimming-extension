# WaterBody2D // Area2D Extension
### Tool Script
A water body applies physics forces to each RigidBody2D or CharacterBody2D inside its area.

## Constants
### WATER_MASK: int = ~(1 << 32)
- the collision layers that are checked by the water body. As an inverse, Layer 32 is designated as the layer where water is not detected.
- this is automatically applied to each water body on initialization, but can be manually overridden in editor.

### PRIORITY: int = 2
- the default priority of the water body. This is pushed higher in the priority hierarchy so that velocity is applied before other object's physics calculations.

## Exports
### current_force: Vector2
- the force of the "current" as a constant vector.

### friction: float
-the friction applied to every object's current. This removes velocity for movement.

## Members
bodies: Array[PhysicsBody2D]
- All bodies currently in the water body. This is only comprised of RigidBody2D and CharacterBody2D nodes.

## Functions
### _init() -> void
- sets collision layers and masks in-engine

### _ready() -> void
- connects signals for body_entered and body_exited

### _physics_process(_delta:float) -> void
- applies the current force to all character bodies and rigidbodies inside the area.

### _body_entered(body: Node2D) -> void
- adds a physics body to bodies if the body is not already added.
- if the body added is the SwimmingController then body.in_water is set to true

### _body_exited(body:Node2D) -> void
-removes a physics body from bodies
- if the body is a SwimmingController then body.in_water is set to false
