extends KinematicBody2D

var jump_sound_player = null
var jump_sound = preload("res://jump_sound2.mp3")
var sound_playing = false

func _ready():
	jump_sound_player = AudioStreamPlayer.new()
	jump_sound_player.stream = jump_sound
	add_child(jump_sound_player)

func _input(event):
	if event.is_action_pressed("jump") and not sound_playing:
		jump_sound_player.play()
		sound_playing = true
	elif event.is_action_released("jump"):
		jump_sound_player.stop()
		sound_playing = false

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
 
onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
 
var y_velo = 0
var facing_right = false
 
func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
 
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
 
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
 
	if grounded:
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")
 
func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h
 
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	VisualServer.set_default_clear_color(Color.lightblue)
	
	
	
	

