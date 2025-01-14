extends CharacterBody2D

const BASE_MOVE_SPEED := 250
const GRAVITY := 35
const JUMP_FORCE := GRAVITY * 14

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_axis("left", "right")
	
	# velocity is inherited from CharacterBody2D
	velocity.x = input_vector * BASE_MOVE_SPEED
	velocity.y += GRAVITY
	
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
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_FORCE
		$JumpSound.play()
