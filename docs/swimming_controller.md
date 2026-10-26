# Swimming Controller // PlatformerController Extension
A swimming controller builds off the platformer controller to be able to swim

## Enums
### SWIM = 8
- The swim state

## Signals
### player_lose_oxygen()
- When time_submerged > max_time_submerged. Called every time time_submerged is set and the previous condition is met.

## Exports
### max_time_submerged:float
- The maximum time submerged before player should start taking damage.

### submersion_progressbar: ProgressBar
- The progress bar associated with this swimming controller. This shows how much oxygen has been used up in-game.

### default_water_gravity: Vector2
- The default gravity applied to the player every physics tick. If crouching in the water, this force is applied four-fold. (In future versions, this will be as a parameterized value).

### swim_speed: float
- The speed of the character when moving in the water.

## Members

### _gravity_store: float
- An on-ready value for gravity. Used for when the player enters/exits swim mode.

### _can_wall_jump_store: bool
An on-ready value for can_wall_jump. Used for when the player enters/exits swim mode.

### submerged: bool
- Set when the player controller's head has gone underwater (via an area collision).

### in_water:bool
- Set when the player first enters water.

### swim_force: Vector2
- The force applied to the player during the most recent physics tick.

### current_water_area: WaterBody2D
- The area that the player is currently in. If this is not null, it is safe to assume in_water = true

### time_submerged: float
- the amount of time the player has had their head underwater.

## Functions
### set_water_area(area: Area2D) -> void
- Sets current_water_area

### unset_water_area(area: Area2D) -> void
- Unsets current_water_area if area is equivalent.

### detect_water(area: Area2D) -> void
- called by a child Area2D when an area enters it.
- sets submerged.

### undetect_water(area: Area2D) -> void
- called by a child Area2D when an area exits it.
- set submerged and resets time_submerged.

### manage_state() -> void
- handles this object's state.
- if the player is not swimming, then it calls super.manage_state()

### _ready() -> void
- sets defaults for stores.

### manage_animations() -> void
- if swimming, plays swimming animations. Otherwise, calls super

### physics_tick(delta:float, inputs: Dictionary) -> void
- handles swimming and time submerged.
- called super.physics_tick.

### handle_time_submerged(delta:float) -> void
- adds delta to time_submerged if submerged.

### handle_swimming(inputs: Dictionary):
- adds swim_forces to velocity if swimming.
