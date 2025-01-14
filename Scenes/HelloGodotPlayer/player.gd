extends CharacterBody2D

const BASE_MOVE_SPEED := 750

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	
	# velocity is inherited from CharacterBody2D
	velocity = input_vector * BASE_MOVE_SPEED
	
	# also inherited from CharacterBody2D
	move_and_slide()
