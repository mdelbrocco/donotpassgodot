extends CharacterBody2D

const BASE_MOVE_SPEED := 750

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	
	# velocity is inherited from CharacterBody2D
	velocity = input_vector * BASE_MOVE_SPEED
	
	# also inherited from CharacterBody2D
	move_and_slide()
	
	# flip sprite horizontally
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	# play jump animation if moving up
	if velocity.y < 0:
		$AnimatedSprite2D.play("jump")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("fall")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
