extends PathFollow3D
@export var speed = 10
var run = false
var drop = false
func _process(delta):
	if($TricksterAlien/AnimationPlayer.current_animation == "Idle" && run):
		$TricksterAlien/AnimationPlayer.play("Walking")
		if (drop):
			$TricksterAlien/Dropped.play("Dropped")
	if(run):
		if (progress_ratio <= 0.9):
			progress += (speed * delta)
		else:
			queue_free()
		
