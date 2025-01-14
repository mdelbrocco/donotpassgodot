extends CharacterBody2D

const BASE_MOVE_SPEED := 35
const BOUNCE_STRENGTH := 500

var is_facing_left := true

func _physics_process(delta: float)-> void:
	if is_on_wall() or not isRayCastColliding():
		turn_around()

	velocity.x = -BASE_MOVE_SPEED if is_facing_left else BASE_MOVE_SPEED
	velocity.y += Globals.GRAVITY
	
	move_and_slide()
	
	if velocity.x != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

func isRayCastColliding() -> bool:
	if is_facing_left:
		return $RayCastLeft.is_colliding();
	else:
		return $RayCastRight.is_colliding();

func turn_around() -> void:
	$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	is_facing_left = !is_facing_left


func _on_bounce_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is CharacterBody2D:
		$BounceAudioStream.play()
		body.velocity.y = -BOUNCE_STRENGTH
